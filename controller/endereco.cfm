<cfsetting showdebugoutput="no">
<cfsilent>
	<cfscript>
		strRetorno = {};
		instModel	= application.config.factory.getModel("Endereco");

		if(isDefined("form.acao")){
			result = instModel.setSalvarRegistro(
				acao: form.acao
				,id_contato: form.id_contato
				,id_municipio: form.id_municipio
				,ds_logradouro: form.ds_logradouro
				,no_bairro: form.no_bairro
				,nu_cep: form.nu_cep
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