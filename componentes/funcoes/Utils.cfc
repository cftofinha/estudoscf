<!--- *******************************************************************************************************************
*	Data de Criação do Arquivo: 01/10/2011																				*
*	Autor : Francisco Paulino [Tofinha] <tofinha@gmail.com> <tofinha@tofinha.com.br>									*
*	Modificações																										*
*	Data					Autor								Modificação												*
*	==========				================================	========================================================*
*																														*
*********************************************************************************************************************--->
<cfcomponent displayname="Componente com funcoes uteis.">

	<cffunction name="validaCPF" access="remote" output="true" returntype="string">
		<cfargument name="cpf" type="numeric" required="">
			<cfset var s1 = 0>
			<cfset var s2 = 0>
			<cfset var x = "">
			<cfset var d1 = 0>
			<cfset var d2 = 0>
			<cfset var z =1>
			
			<cfoutput>
				<cfloop index="i" from="#z#" to="9">
					<cfset x = mid(cpf,z,1)>
					<cfset s1 = s1 + x * (11-z)>
					<cfset s2 = s2 + x * (12-z)>
					<cfset z = z + 1>
				</cfloop>
			</cfoutput>
			
			<cfset  var d1 = 11 - (s1 mod 11)>
			<cfif d1 gt 9>
				<cfset d1 = 0>
			</cfif>
			<cfset var d2 = 11-((s2+d1*2)mod 11)>
			<cfif  d2 gt 9>
				<cfset d2 = 0>
			</cfif>
			<cfset dig1 = mid(cpf,10,1)>
			<cfset dig2 = mid(cpf,11,1)>
			<cfif (dig1 eq d1) and (dig2 eq d2)>
				<h1>
					<cfset variables.validacao = "CPF VALIDO">
				</h1>
			<cfelse>
				<h1>
					<cfset variables.validacao = "CPF INVALIDO">
				</h1>
			</cfif>
		<cfreturn variables.validacao>
	</cffunction>
	
	<!---****************************************************************************************************************
	*	Criado por: Francisco Paulino - Tofinha - tofinha@gmail.com														*
	*	criar captchas com a cfimage e com suporte a refresh com ajax													*
	*	13/10/2011																										*
	*****************************************************************************************************************--->
	
	<cffunction name="createCaptcha" returntype="struct" hint="Retorna uma struct contendo as propriedades para o captcha." access="remote">
		<cfargument name="minLength" default="6">
		<cfargument name="maxLength" default="6">
		<cfargument name="id" default="captchaImg" displayname="Setando um ID para usar na tag da imagem.">
		<cfargument name="difficulty" default="low" hint="low | medium | high">

		<cfset var local = {}>
		<cfset local.retVal = {}>

		<!--- DECLARANDOS AS KEYS. ASSIM O JAVASCRIPT AS RECEBE CORRETAMENTE E EM MINUSCULAS --->
		<cfset local.retval["imgSrc"] = "">
		<cfset local.retval["captcha_id"] = "">
		<cfset local.retval["imgTag"] = "">
		<cfset local.retval["txtImgTag"] = "">

		<!--- INSTANCIANDO O METODO QUE CRIA O TEXTO PARA O CAPTCHA --->
		<cfset local.captchaText = makeCaptchaString(ARGUMENTS.minLength,ARGUMENTS.maxlength)>


		<!--- SETANDO O ID COMO RETORNO PARA A TAG IMAGEM. --->
		<cfset local.retval.captcha_id = randRange(1, 999)>
		
		<!--- SETANDO O TEXTO PARA VALIDAR DO LADO DO CLIENTE --->
		<cfset local.retVal.txtImgTag = local.captchaText />
		
		<cfsavecontent variable="local.retVal.imgTag">
			<cfimage action="captcha" text="#local.captchaText#" difficulty="#ARGUMENTS.difficulty#">
		</cfsavecontent>

		<!--- TRATANDO O CAMINHO DA IMAGEM. PODE SER UTILIZADO PARA ATUALIZAR O CAPTCHA COM AJAX --->
		<cfset local.regExResult = reFind("src=""([^""]*)",local.retVal.imgTag,1,1)>
		<cfset local.retVal.imgSrc = mid(local.retVal.imgTag,local.regExResult.pos[2],local.regExResult.len[2])>

		<!--- RETORNANDO UM ID PARA MANIPULAR O JAVASCRIPT --->
		<cfset local.retVal.imgTag = replace(local.retVal.imgTag,"<img","<img id=""#ARGUMENTS.id#""","one")>

		<cfreturn local.retVal>

	</cffunction>

	<!--- FUNCAO PARA GERAR O TEXTO PARA A IMAGEM DO CAPTCHA --->
	<cffunction name="makeCaptchaString" returnType="string" output="false" access="private">
		<cfargument name="minLength">
		<cfargument name="maxLength">

		<!--- Don't use any characters that can be confused with each other --->
		<cfset var chars = "23456789ABCDEFGHJKMNPQRS">
		<cfset var length = randRange(ARGUMENTS.minLength,ARGUMENTS.maxLength)>
		<cfset var result = "">
		<cfset var i = "">
		<cfset var char = "">

		<cfscript>
		for(i=1; i <= length; i++) {
			char = mid(chars, randRange(1, len(chars)),1);
			result&=char;
		}
		</cfscript>

		<cfreturn result>
	</cffunction>

</cfcomponent>