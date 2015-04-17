<cfsetting showdebugoutput="no">
<cfsilent>
	<cfscript>
		strRetorno = {};
		instModel	= application.config.factory.getModel("Contato");

		if(isDefined("form.acao")){
			result = instModel.setSalvarRegistro(
				acao: form.acao
				,co_uuid: form.codUUID
				,no_contato: form.no_contato
				,ds_email: form.ds_email
				,st_registro: form.st_registro
				,id: form.codRegistro
			);

			if (not compareNoCase(result.retorno, "sucesso")){
				strRetorno.mensagem = "sucesso";
			} else{
				strRetorno.mensagem = "erro";
			}
		} else{
			strRetorno.mensagem = "erro FORM não definido";
		}
	</cfscript>

	<!--- serialize --->
	<cfset data = serializeJSON(strRetorno)>
</cfsilent>
<cfoutput>#data#</cfoutput>
<cfabort>