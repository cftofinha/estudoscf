var urlUtils = urlSistema + "/model/Utils.cfc";
	
$(document).ready(function() { 
	//carregar as regioes com json
	$.getJSON(urlUtils + '?method=getRegiao&returnformat=json', function (result) {
		$("select#id_regiao").attr("disabled","disabled");
		$("select#id_regiao").html("<option>aguarde...</option>");
		
		var options = '<option value="0">Selecione</option>';
		$.each(result.DATA, function () {
			options += '<option value="' + this[0] + '">' + this[1] + '</option>';
		});
		$("select#id_regiao").removeAttr("disabled");
		$("#id_regiao").html(options);
	});
	
	//carregar estados conforme a regiao
	$("#id_regiao").change(function(e) {
		var idRegiao = $("#id_regiao").val();
	
		$.getJSON(urlUtils + '?method=getUF&returnformat=json&id_regiao_brasil='+ idRegiao, function (result) {
			$("#id_municipio").html('');
			$("select#id_estado").attr("disabled","disabled");
			$("select#id_estado").html("<option>aguarde...</option>");
			
			var options = '<option value="0">Selecione</option>';
			$.each(result.DATA, function () {
				options += '<option value="' + this[0] + '">' + this[1] + '</option>';
			});
			$("select#id_estado").removeAttr("disabled");
			$("#id_estado").html(options);
		});
	});
	
	//carregar municipios conforme estado
	$("#id_estado").change(function(e) {
		var idEstado = $("#id_estado").val();
	
		$.getJSON(urlUtils + '?method=getMunicipio&returnformat=json&id_estado='+ idEstado, function (result) {
			$("select#id_municipio").attr("disabled","disabled");
			$("select#id_municipio").html("<option>aguarde...</option>");
			
			var options = '<option value="0">Selecione</option>';
			$.each(result.DATA, function () {
				options += '<option value="' + this[0] + '">' + this[1] + '</option>';
			});
			$("select#id_municipio").removeAttr("disabled");
			$("#id_municipio").html(options);
		});
	});
});

function salvarRegistro(){
	var urlAcao = urlSistema + "/controller/endereco.cfm";
	
	if (document.getElementById('id_contato').value == '0'){
		alert('Digite o Nome do Contato');
		document.getElementById('id_contato').focus();
		return false;
	}
	
	if (document.getElementById('ds_logradouro').value == ''){
		alert('Digite o Endereço do Contato');
		document.getElementById('ds_logradouro').focus();
		return false;
	}
	if (document.getElementById('no_bairro').value == ''){
		alert('Digite o Bairro');
		document.getElementById('no_bairro').focus();
		return false;
	}
	if (document.getElementById('nu_cep').value == ''){
		alert('Digite o CEP');
		document.getElementById('nu_cep').focus();
		return false;
	}
	if (document.getElementById('id_regiao').value == '0'){
		alert('Selecione a Região do seu Estado');
		document.getElementById('id_regiao').focus();
		return false;
	}
	if (document.getElementById('id_estado').value == '0'){
		alert('Selecione o seu Estado');
		document.getElementById('id_estado').focus();
		return false;
	}
	if (document.getElementById('id_municipio').value == '0'){
		alert('Selecione o seu Município');
		document.getElementById('id_municipio').focus();
		return false;
	}
	else{
		dataString = $("#formRegistro").serialize();
		$.ajax({
			type: "post",
			url: urlAcao,
			data: dataString,
			dataType: "json",
			success: function(data) {
				if(data.MENSAGEM == "sucesso"){
					alert('Registro salvo com sucesso!');
					window.location.href = urlSistema + "?gerenciador=endereco.gerenciar";
				}
				else{
					alert('Erro ao salvar o registro!');
					console.log(data);
					//window.location.href = urlSistema + "?gerenciador=endereco.gerenciar";
				}
			}
		});
	}
}
function confirmarExclusao(id){
	var urlAcao = urlSistema + "/controller/contato.cfm";
	if (confirm('Deseja realmente excluir este Registro?')) {
		document.getElementById('codRegistro').value = id;
		//alert(document.getElementById('codRegistro').value);
		//dataString = $("#formRegistro").serialize();
		$.ajax({
			type: "post",
			url: urlAcao,
			data: ({
					acao: 'excluir'
					,coduuid: ''
					,no_contato: ''
					,ds_email: ''
					,st_registro: ''
					,codRegistro: id
				}),
			dataType: "json",
			success: function(data) {
				console.log(data);
				if(data.MENSAGEM == "sucesso"){
					alert('Registro Excluído com sucesso!');
					window.location.href = urlSistema + "?gerenciador=contato.gerenciar";
				}
				else{
					alert('Erro ao salvar o registro!');
					window.location.href = urlSistema + "?gerenciador=contato.gerenciar";
				}
			}
		});
	}
}