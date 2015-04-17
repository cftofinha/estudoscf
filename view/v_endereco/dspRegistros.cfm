<cfoutput>
	<script src="#application.config.rootUrl#/js/enderecos.js" type="text/javascript"></script>
</cfoutput>
<cfset qCons = application.config.factory.getModel("Endereco").getListar() />
<script type="text/javascript">
	$(document).ready(function() {
		$('#gridRegistros').DataTable();
	});
</script>
<h1>Gerenciar Endereços</h1><br>
<span class="formee">
	<div class="grid-6-12 clear"></div>
	<div class="grid-6-12">
		<label><a href="?gerenciador=endereco.novo">Novo registro</a></label>
	</div>
</span>

	<table id="gridRegistros" class="display" cellspacing="0" width="100%">
		<thead>
			<tr>
				<th>ID</th>
				<th>Nome do Contato</th>
				<th>Endereço</th>
				<th>UF</th>
				<th>Muncípio</th>
				<th>Ações</th>
			</tr>
		</thead>

		<tbody>
			<cfoutput query="qCons">
				<tr>
					<td>#qCons.id#</td>
					<td>#qCons.no_contato#</td>
					<td>#qCons.ds_logradouro#</td>
					<td>#qCons.no_estado#</td>
					<td>#qCons.no_municipio#</td>
					<td>
						<a href="?gerenciador=endereco.editar&codregistro=#qCons.id#">Editar</a> |
						<a href="##" onclick="confirmarExclusao(#qCons.id#)">Excluir</a>
					</td>
				</tr>
			</cfoutput>
		</tbody>
	</table>