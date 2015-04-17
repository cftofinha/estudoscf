<cfcomponent output="false">

	<!---<cffunction name="init" access="public" returntype="utils.Utils">
		<cfscript>
			return this;
		</cfscript>
	</cffunction>--->

	<cffunction name="dump" access="public" returntype="any">
		<cfargument name="variavel" type="any" required="true" />
		<cfdump var="#arguments.variavel#">
		<cfabort>
	</cffunction>

	<cfscript>
		public Boolean function validarEmail( String value ) {
			local.isValidEmail = IsValid( "mail" , arguments.value );
		}
	</cfscript>


  <!---
        =================================================================================================
		Função.......: converterHtmlParaTexto
		=================================================================================================
  --->
  <cffunction name="converterHTMLParaTexto" access="public" output="false" returntype="string" hint="Converter as entidades HTML para &<> e aspas duplas para texto">
  	<cfargument name="texto"				  type="string"  required="true"  hint="String a ser convertida">
	<cfargument name="converterQuebraDeLinha" type="boolean" required="false" default="true" />

	<cfscript>
	var sListaCaracteresHTML  = "&amp;,&lt;,&gt;,&quot;";
	var sListaCaracteresASCII = "&,<,>," & Chr(34);
	var sRetorno			  = "";

	sRetorno = ReplaceList( arguments.texto, sListaCaracteresHTML, sListaCaracteresASCII );

	if ( arguments.converterQuebraDeLinha )	 {
		sRetorno = Replace( sRetorno, "<br>", Chr(10), "all" );
	}

	return sRetorno;
	</cfscript>

  </cffunction>


  <!---
        =================================================================================================
		Função.......: converterTextoParaHtml
		=================================================================================================
  --->
  <cffunction name="converterTextoParaHTML" access="public" output="false" returntype="string" hint="Converter os caracteres &<> e aspas duplas para seus devidos códigos HTML">
  	<cfargument name="texto"				  type="string"  required="true"  hint="String a ser convertida">
	<cfargument name="converterQuebraDeLinha" type="boolean" required="false" default="true" />

	<cfscript>
	var sRetorno = HTMLEditFormat(arguments.texto);

	if ( arguments.converterQuebraDeLinha )	 {
		sRetorno = Replace( sRetorno, Chr(10), "<br>", "all" );
	}

	return sRetorno;
	</cfscript>

  </cffunction>


  <!---
        =================================================================================================
		Função.......: filtrarNumeros
		Data.........: 25/03/2009
		=================================================================================================
  --->
  <cffunction name="filtrarNumeros" access="public" output="false" returntype="string" hint="Função que retorna somente os números de uma string">
	<cfargument name="texto" type="string" required="true" hint="String a ser filtrada" />

	<cfreturn REReplace( arguments.texto, "[^[:digit:]]", "", "all" ) />
  </cffunction>



  <!---
        =================================================================================================
		Função.......: getIPCliente
		=================================================================================================
  --->
  <cffunction name="getIPCliente" access="public" output="false" returntype="string"
			  hint="Retorna o ip real do cliente" >

	<cfset var IPCliente = "" />

	<cftry>
	  <cfif StructKeyExists(GetHttpRequestData().headers, "X-FORWARDED-FOR")>
	    <cfset IPCliente = GetHttpRequestData().headers["X-FORWARDED-FOR"] />

		<!--- Se houver mais de um IP, no caso de usar um proxy o IP público é sempre o último valor --->
	    <cfif ListLen( IPCliente ) gt 1 >
		  <cfset IPCliente = ListGetAt( IPCliente, ListLen( IPCliente ) ) />
		</cfif>

		<cfset IPCliente = Trim(IPCliente) />
	  <cfelse>
	    <cfset IPCliente = CGI.REMOTE_ADDR />
	  </cfif>

	  <cfcatch type="any">
		<cfreturn "" />
	  </cfcatch>
	</cftry>

	<cfreturn IPCliente />
  </cffunction>




  <!---
    texto = string variable
        String que será verificada

    acao = "preservar" or "remover"
        Esta função verifica e limpa tags especificadas por argumento numa lista de tags (tagList).
		A função tem duas ações, Remover e Preservar.
		remover:   remove da string as tags que foram passadas na tagList;
		preservar: remove da string as tags que não foram passadas na tagList, preservandos as que foram passadas.
		Por padrão a ação da função é "preservar";
    tagList = string variable
        Este argumento contém uma lista de tags separada por virgulas.

    EXAMPLE
    filtrarTags(myString,"preservar","b,i")

    A implementação acima removerá todas as tags html diferente de:
    <b></b> e <i></i>
  --->
  <cffunction name="filtrarTags" access="public" output="no" returntype="string">

    <cfargument name="texto"   required="yes" type="string" />
    <cfargument name="acao"    required="no"  type="string" default="preservar" />
    <cfargument name="tagList" required="no"  type="string" default="" />

    <cfscript>

    var strVerificada 		  = arguments.texto;
	var sListaCaracteresHTML  = "&amp;,&lt;,&gt;,&quot;";
    var sListaCaracteresASCII = "&,<,>," & Chr(34);
    var tag			  		  = "";
    var idx 		  		  = 1;

	strVerificada = ReplaceList( strVerificada, sListaCaracteresHTML, sListaCaracteresASCII );

	tagArray = ListToarray(arguments.tagList);

    if ( Trim(Lcase(arguments.acao)) == "remover" ) {

        // exclusão de tags
        for ( idx=1;idx <= ArrayLen(tagArray); idx++ ) {
            tag						= tagArray[idx];
            regExpTagComParametros	= "</?#tag# [a-zA-Z0-9 =:/.;" & Chr(34) & Chr(39) & "]*>";

            // Remove tags com espaco: <b >, <br />
            strVerificada = REReplaceNoCase( strVerificada, "</?#tag# */?>", "", "ALL" );

            // Remove tags com parametros: <a href="page.js">, <script type="text/javascript"
            strVerificada = REReplaceNoCase( strVerificada, regExpTagComParametros, "", "ALL" );

            // Remove tags sem espacos, nem parametros: <b>, <br>
            strVerificada = REReplaceNoCase( strVerificada, "</?#tag#>", "", "ALL" );
        }

    }
    else if( Trim(Lcase(acao)) == "preservar" ) {

        // marca as tags que serão preservadas com a palavra chave NOSTRIP
       	for ( idx=1;idx <= ArrayLen(tagArray); idx++ ) {
            tag = tagArray[idx];
            strVerificada = REReplaceNoCase( strVerificada, "<(/?#tag#)>", "___TEMP___NOSTRIP___\1___TEMP___ENDNOSTRIP___", "ALL" );
        }

        strVerificada = reReplaceNoCase( strVerificada, "</?[A-Z].*?>", "", "ALL" );
        // converter tags preservadas ao normal
        strVerificada = replace( strVerificada, "___TEMP___NOSTRIP___"   , "<", "ALL" );
        strVerificada = replace( strVerificada, "___TEMP___ENDNOSTRIP___", ">", "ALL" );

    }

    return strVerificada;

    </cfscript>

  </cffunction>


  <cffunction name="converterQuebraDeLinhaParaHTML" access="public" output="false" returntype="string">
	<cfargument name="texto" type="string" required="true" hint="Texto para trocar os /n por <br />">

	<cfreturn ( Trim(Replace( arguments.texto, Chr(10), "<br />", "all" )) ) />

  </cffunction>


  <!---
        =================================================================================================
        Função.......: enviarEmail
        =================================================================================================
  --->
  <cffunction name="enviarEmail" access="public" output="false" returntype="String" hint="envia um email">
    <cfargument name="destinatario"      type="string"  required="true"                                     hint="Destinatario da mensagem" />
    <cfargument name="responder_para"    type="string"  required="false" default=""                         hint="Email para resposta" />
    <cfargument name="nomeRemetente"     type="string"  required="false" default=""                         hint="Remetente da mensagem" />
    <cfargument name="remetente"         type="string"  required="false" default="inove@inovece.com.br" 	hint="Nome do remetente da mensagem" />
    <cfargument name="assunto"           type="string"  required="true"                                     hint="Assunto da mensagem" />
	<cfargument name="copiaOculta"       type="string"  required="false" default="" 						hint="Enviar com cópia oculta para" />
    <cfargument name="mensagem"          type="string"  required="true"                                     hint="Corpo da mensagem" />

    <cfset var sRetorno					= "" />
	<cfset var conteudoMensagem			= arguments.mensagem />
	<cfset var nomeRemetenteSemVirgula	= Replace(arguments.nomeRemetente, ",", "", "all") />

	<!--- Informações do envio para adicionar no header do email  --->
	<cfset var IPCliente = this.getIPCliente() />
    <cfset var dateValue = dateFormat(Now(), "ddd, dd mmm yyyy") & " " & timeFormat(Now(), "HH:mm:ss") />

    <cftry>

	  <!--- o atributo from da tag cfmail não aceita esses caracteres abaixo --->
	  <cfset arguments.nomeRemetente = ReplaceList( arguments.nomeRemetente, ":,;,<,>", "") />

      <cfmail from="""#arguments.nomeRemetente#"" <#arguments.remetente#>"
              replyto="#arguments.responder_para#"
              to="#arguments.destinatario#"
			  bcc="#copiaOculta#"
			  subject="#arguments.assunto#"
              type="html"
              charset="utf-8"
              spoolenable="false">
        <cfmailparam name="X-Originating-IP" value="#IPCliente#">
        <cfmailparam name="X-Originating-Date" value="#dateValue#">
        #arguments.mensagem#
      </cfmail>

      <cfcatch>

		<!--- Se o erro é de timeout --->
		<cfif FindNoCase( "timeout", cfcatch.Message ) gt 0 >

		  <!--- Tenta enviar o e-mail com o spool ativado --->
	      <cfmail from="""#arguments.nomeRemetente#"" <#arguments.remetente#>"
	              replyto="#arguments.responder_para#"
	              to="#arguments.destinatario#"
				  bcc="#copiaOculta#"
				  subject="#arguments.assunto#"
	              type="html"
	              charset="utf-8"
	              spoolenable="true">
	        <cfmailparam name="X-Originating-IP" value="#IPCliente#">
	        <cfmailparam name="X-Originating-Date" value="#dateValue#">
	        #arguments.mensagem#
	      </cfmail>

		<cfelse>

          <cfset sRetorno = this.getMensagemDeErroAmigavel( sErro: cfcatch.Message ) />

		  <!--- Se o erro for InterruptedException não precisa enviar o e-mail de erro, pois o Railo envia o mesmo posteriormente --->
		  <cfif FindNoCase( "java.lang.InterruptedException", cfcatch.Message ) is 0 >

<!---
            <cfmail from="Inovece <sistema@inovece.com.br>"
                  to="Erros <programacao@inovece.com.br>"
                  replyto="Equipe de Programação <programacao@inovece.com.br>"
                  subject="Erro ao enviar e-mail"
                  type="html"
                  charset="utf-8"
                  spoolenable="true">

		      Erro ao enviar o e-mail.<br /><br />
		      Mensagem de erro: #cfcatch.Message#<br /><br />
		      Remetente: #arguments.nomeRemetente# (#arguments.remetente#)<br /><br />
		      Destinatário: #arguments.destinatario#<br /><br />
		      Servidor: #CGI.LOCAL_HOST#<br /><br />
		      IP: #this.getIPCliente()#<br /><br />
		      Pagina de origem: #CGI.HTTP_REFERER#
            </cfmail>
--->
		  </cfif>
		</cfif>

      </cfcatch>

    </cftry>

    <cfreturn sRetorno >
  </cffunction>


  <!---
        =================================================================================================
        Função.......: getMensagemDeErroAmigavel
        =================================================================================================
  --->
  <cffunction name="getMensagemDeErroAmigavel" access="public" output="false" returntype="String" hint="Transforma mensagens de erro em mensagem amigaveis">
    <cfargument name="sErro" type="string" required="true" hint="Mensagem de erro" />

    <cfscript>
      if( FindNoCase( "timeout", arguments.sErro ) gt 0 ){

        return "Ocorreu um erro na tentativa de enviar o e-mail. Por favor tente novamente.";

      } else if( FindNoCase( "Invalid Addresses", arguments.sErro ) gt 0 ){

        return "O endereço de e-mail informado é inválido. Não é possível enviar o e-mail para este destinatário.";

      } else if( FindNoCase( "you have do define the to for the mail",arguments.sErro ) gt 0 ){

        return "Não foi possível enviar o e-mail devido ao destinatário ser inválido. Por favor verifique as informações do destinatário da mensagem.";

      } else {

        return "Não foi possivel enviar o email, favor entrar em contato com nosso suporte técnico.<br />Resposta do servidor: " & arguments.sErro;

      }
    </cfscript>

  </cffunction>


</cfcomponent>