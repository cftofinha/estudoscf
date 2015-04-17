<cfoutput>
	<script src="#application.config.rootUrl#/js/contatos.js" type="text/javascript"></script>
</cfoutput>
<cfset qCons = application.config.factory.getModel("Contato").getListar() />
<script type="text/javascript">
	$(document).ready(function() {
		$('#gridRegistros').DataTable();
	});
</script>
<h1>Gerenciar Contatos</h1><br>
<span class="formee">
	<div class="grid-6-12 clear"></div>
	<div class="grid-6-12">
		<label><a href="?gerenciador=contato.novo">Novo registro</a></label>
	</div>
</span>
<form name="formRegistro" id="formRegistro" action="" method="post">
	<input type="hidden" name="codRegistro" id="codRegistro" value="">
	<input type="hidden" name="codUUID" id="codUUID" value="">
	<input type="hidden" name="no_contato" id="no_contato" value="">
	<input type="hidden" name="ds_email" id="ds_email" value="">
	<input type="hidden" name="st_registro" id="st_registro" value="">

	<table id="gridRegistros" class="display" cellspacing="0" width="100%">
		<thead>
			<tr>
				<th>ID</th>
				<th>Nome do Contato</th>
				<th>E-mail</th>
				<th>Data Registro</th>
				<th>Status</th>
				<th>Ações</th>
			</tr>
		</thead>

		<tbody>
			<cfoutput query="qCons">
				<tr>
					<td>#qCons.id#</td>
					<td>#qCons.no_contato#</td>
					<td>#qCons.ds_email#</td>
					<td>#lsDateFormat(qCons.dt_registro, "dd/mm/yyyy")#</td>
					<td>#qCons.st_registro#</td>
					<td>
						<a href="?gerenciador=contato.editar&codregistro=#qCons.id#">Editar</a> |
						<a href="##" onclick="confirmarExclusao(#qCons.id#)">Excluir</a>
					</td>
				</tr>
			</cfoutput>
		</tbody>
	</table>
</form>