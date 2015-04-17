<cfoutput>
	<script src="#application.config.rootUrl#/js/enderecos.js" type="text/javascript"></script>
</cfoutput>
<cfscript>
	instModel	= application.config.factory.getModel("Endereco");

	param name="url.codRegistro" default="0";
	if(isDefined("url.codRegistro") and isNumeric(url.codRegistro)){
		qCons	= instModel.getRegistro(url.codRegistro);
	}
	else{
		qCons	= instModel.getRegistro(0);
	}

	qContatos = application.config.factory.getModel("Contato").getListar();
	instUtils = application.config.factory.getModel("Utils"); 
	
	if(qCons.recordCount){
		variables.codRegistro 		= qCons.id;
		variables.idRegiao 			= qCons.id_regiao_brasil;
		variables.idEstado			= qCons.id_estado;
		variables.idMunicipio		= qCons.id_municipio;
		variables.tituloForm		= "ALTERAR REGISTRO";
		variales.labelBotao			= "Alterar Registro";
		variables.acaoForm			= "alterar";
	} else{
		variables.codRegistro 		= 0;
		variables.idRegiao 			= 0;
		variables.idEstado			= 0;
		variables.idMunicipio		= 0;
		variables.tituloForm		= "CADASTRAR NOVO REGISTRO";
		variales.labelBotao			= "Cadastrar Registro";
		variables.acaoForm 			= "novo";
	}
	
	qRegiao = instUtils.getRegiao();
	qUF = instUtils.getUF(variables.idRegiao);
	qMunicipio = instUtils.getMunicipio(variables.idEstado);
</cfscript>
<!---<cfdump var="#qCons#"><cfabort>--->
<cfoutput>
	<cfif isDefined("variables.erro")>
		#variables.erro#
	</cfif>
	<br />
<form name="formRegistro" id="formRegistro" class="formee" action="" method="post">
	<input type="hidden" name="acao" id="acao" value="#variables.acaoForm#">
	<input type="hidden" name="codRegistro" id="codRegistro" value="#variables.codRegistro#">
	<fieldset>
		<legend>#variables.tituloForm#</legend>
		<div class="grid-6-12">
			<label>Nome doContato <em class="formee-req">*</em></label>
			<select name="id_contato" id="id_contato">
				<option value="0">Selecione</option>
				<cfloop query="qContatos">
					<option value="#qContatos.id#" <cfif not compareNoCase(qContatos.id, qCons.id_contato)> selected="selected" </cfif>>#qContatos.no_contato#</option>
				</cfloop>
			</select>
		</div>
		<div class="grid-6-12">
			<label>Endereço <em class="formee-req">*</em></label>
			<input name="ds_logradouro" id="ds_logradouro" type="text" value="#qCons.ds_logradouro#" />
		</div>
		<!--- --->
		<div class="grid-2-12 clear">
			<label>Bairro <em class="formee-req">*</em></label>
			<input name="no_bairro" id="no_bairro" type="text" value="#qCons.no_bairro#" />
		</div>
		<div class="grid-2-12">
			<label>CEP <em class="formee-req">*</em></label>
			<input name="nu_cep" id="nu_cep" type="text" value="#qCons.nu_cep#" />
		</div>
		<div class="grid-2-12 alpha">
			<label>Região <em class="formee-req">*</em></label>
			<select name="id_regiao" id="id_regiao">
				<cfloop query="qRegiao">
					<option value="#qRegiao.id#" <cfif qRegiao.id eq qCons.id_regiao_brasil> selected="selected"</cfif>>#qRegiao.no_regiao#</option>
				</cfloop>
			</select>
		</div>
		<div class="grid-3-12 omega">
			<label>UF <em class="formee-req">*</em></label>
			<select name="id_estado" id="id_estado">
				<cfloop query="qUF">
					<option value="#qUF.id#" <cfif qUF.id eq qCons.id_estado> selected="selected"</cfif>>#qUF.no_estado#</option>
				</cfloop>
			</select>
		</div>
		<div class="grid-3-12 alpha">
			<label>Municipio <em class="formee-req">*</em></label>
			<select name="id_municipio" id="id_municipio">
				<cfloop query="qMunicipio">
					<option value="#qMunicipio.id#" <cfif qMunicipio.id eq qCons.id_municipio> selected="selected"</cfif>>#qMunicipio.no_municipio#</option>
				</cfloop>
			</select>
		</div>
		
		
		<div class="grid-6-12 clear"></div>
		<div class="grid-6-12">
			<input class="right" type="button" onclick="salvarRegistro();" value="#variales.labelBotao#" />
		</div>
	</fieldset>
</form>
</cfoutput>