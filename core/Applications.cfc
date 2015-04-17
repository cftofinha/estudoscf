component {

	this.name 				= 'ESTUDOS_CF';
	this.sessionManagement 	= true;
	this.applicationTimeout	= CreateTimeSpan(2,0,0,0);
	this.sessionTimeout 	= createTimeSpan(0,1,0,0);
	this.setClientCookies 	= true;

	setlocale("Portuguese (Brazilian)");
	setEncoding("URL", "UTF-8");
	setEncoding("FORM", "UTF-8");

	this.datasource 					= "estudoscf";
	this.datasources.banco_principal	= this.datasource;

	this.Mappings = {'/components' : '#expandPath(".")#/componentes'};


	public function onApplicationStart() {
		this.configApp();

		return true;
	}

	package function configApp(){

		application.config 										= structNew();
		application.config.datasource 							= this.datasources.banco_principal;
		application.config.pastaRoot							= expandPath("/");
		application.config.nomePasta	 						= "estudoscf";
		application.config.tituloSite							= "FISTI - Framework Inove Soluções em Tecnologia da Informação";
		application.config.sigla								= "FISTI";
		application.config.tituloSite							= "Framework Inove Soluções em Tecnologia da Informação";
		application.config.nomeSistema							= "Framework";
		application.config.devBy								= "Inove STI";
		application.config.versao								= "1.0";
		application.config.totalRegistrosPorPagina				= 300;

		if(not compareNoCase(cgi.http_host, "local.#application.config.nomePasta#")){
			application.config.rootUrl							= "http://" & cgi.HTTP_HOST;
			application.config.componentes						= "componentes";
			application.config.ambiente							= "Desenvolvimento";
			application.config.server							= server.coldFusion.productname &" local";
			application.config.factory 							= createObject( "component", "core.Factory" ).init();
		}
		else if(not compareNoCase(cgi.http_host, "localhost")){
			application.config.rootUrl							= "http://" & cgi.HTTP_HOST &"/"& application.config.nomePasta;
			application.config.componentes						= "componentes";
			application.config.ambiente							= "Desenvolvimento";
			application.config.server							= server.coldFusion.productname &" local";
			application.config.factory 							= createObject( "component", "core.Factory" ).init();
		}
		else {
			application.config.rootUrl							= "http://" & cgi.HTTP_HOST;
			application.config.componentes						= "componentes";
			application.config.ambiente							= "Producao";
			application.config.server							= server.coldFusion.productname & " Producao";
			application.config.factory 							= createObject( "component", "core.Factory" ).init();
		}

		return true;
	}

}