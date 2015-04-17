function salvarRegistro(){
	var urlAcao = urlSistema + "/controller/contato.cfm";
	
	if (document.getElementById('no_contato').value == ''){
		alert('Digite o Nome do Contato');
		document.getElementById('no_contato').focus();
		return false;
	}
	
	if (document.getElementById('ds_email').value == ''){
		alert('Digite o E-mail do Contato');
		document.getElementById('ds_email').focus();
		return false;
	}
	if (document.getElementById('st_registro').value == '0'){
		alert('Selecione o Status do Registro');
		document.getElementById('st_registro').focus();
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
				console.log(data);
				if(data.MENSAGEM == "sucesso"){
					alert('Registro salvo com sucesso!');
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