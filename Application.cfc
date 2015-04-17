/**
@title "Application.cfc Base"
@description "Componente base com as configuracoes do ambiente"
@author "Francisco Paulino - Tofinha - Inove Soluções em Tecnologia da Informação"
@email "francisco@inovesti.com.br | tofinha@gmail.com"
@dateCreated "15/03/2014"
@licence "Todos os direitos pretencem ao detentor do sistema, mas os créditos ao desenvolvedor devem ser mantidos"
@hint "Metodos implementados por Tofinha - Inove STI"
*/
component extends="core.Applications" {

	// os metodos onApplicationStart e configApp estao no arquivo Applications.cfc dentro da pasta core por serem padroes

	public void function onRequest(String targetPage){
		include arguments.targetPage;

		setLocale("Portuguese (Brazilian)");

		//evitar ataque por DOS e/ou bots
		if( FindNoCase("libwww-perl", CGI.HTTP_USER_AGENT) neq 0 or FindNoCase("LWP::Simple", CGI.HTTP_USER_AGENT) neq 0 ){
			abort;
		}

		//validando starts --->
		if(not isDefined("application.config.factory")){
			this.configApp();
		}

		//chamadas para restartar parametros
		if(structKeyExists(URL, "reloadConfigApp")){
			//reinitialise the application scope
			structClear(Session);
			onApplicationStart();
			this.configApp();
		}

		if(not StructKeyExists(URL, "gerenciador")){
			param name="url.gerenciador" default="";
		}
		session.RequestStartTime = now();
		//numero de segundos to timeout da sessao
		session.timeoutLength = 14400;
	}

	function OnSessionStart(){

	}
}