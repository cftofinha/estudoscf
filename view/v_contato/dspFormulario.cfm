<cfoutput>
	<script src="#application.config.rootUrl#/js/contatos.js" type="text/javascript"></script>
</cfoutput>
<cfscript>
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
			location(addtoken="false", url="#application.config.rootUrl#/?gerenciador=contato.gerenciar");
		} else{
			variables.erro = result.mensagem;
		}
	}

	param name="url.codRegistro" default="0";
	if(isDefined("url.codRegistro") and isNumeric(url.codRegistro)){
		qCons	= instModel.getRegistro(url.codRegistro);
	}
	else{
		qCons	= instModel.getRegistro(0);
	}

	if(qCons.recordCount){
		variables.codRegistro 		= qCons.id;
		variables.codUUID 			= qCons.co_uuid;
		variables.tituloForm		= "ALTERAR REGISTRO";
		variales.labelBotao			= "Alterar Registro";
		variables.acaoForm			= "alterar";
	} else{
		variables.codRegistro 		= 0;
		variables.codUUID 			= createUUID();
		variables.tituloForm		= "CADASTRAR NOVO REGISTRO";
		variales.labelBotao			= "Cadastrar Registro";
		variables.acaoForm 			= "novo";
	}
</cfscript>
<cfoutput>
	<cfif isDefined("variables.erro")>
		#variables.erro#
	</cfif>
	<br />
<form name="formRegistro" id="formRegistro" class="formee" action="" method="post">
	<input type="hidden" name="acao" id="acao" value="#variables.acaoForm#">
	<input type="hidden" name="codRegistro" id="codRegistro" value="#variables.codRegistro#">
	<input type="hidden" name="codUUID" id="codUUID" value="#variables.codUUID#">
	<fieldset>
		<legend>#variables.tituloForm#</legend>
		<div class="grid-5-12">
			<label>Nome <em class="formee-req">*</em></label>
			<input name="no_contato" id="no_contato" type="text" value="#qCons.no_contato#" />
		</div>
		<div class="grid-5-12">
			<label>E-mail <em class="formee-req">*</em></label>
			<input name="ds_email" id="ds_email" type="text" value="#qCons.ds_email#" />
		</div>
		<div class="grid-2-12">
			<label>Status <em class="formee-req">*</em></label>
			<select name="st_registro" id="st_registro">
				<option value="0">Selecione</option>
				<option value="A" <cfif not compareNoCase(qCons.st_registro, "A")> selected="selected" </cfif>>Ativo</option>
				<option value="I" <cfif not compareNoCase(qCons.st_registro, "I")> selected="selected" </cfif>>Inativo</option>
			</select>
		</div>

		<div class="grid-6-12 clear"></div>
		<div class="grid-6-12">
			<input class="right" type="button" onclick="salvarRegistro();" value="#variales.labelBotao#" />
		</div>
	</fieldset>
</form>
</cfoutput>