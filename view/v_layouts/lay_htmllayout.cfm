<cfparam name="url.gerenciador" default="">
<cfsilent>
	<cfset variables.routerObject = application.config.factory.getUtils("RouterUrl") />
</cfsilent>
<cfcontent reset="true">
<!DOCTYPE html>
<html lang="en-us">
	<head>
		<cfoutput>
		<meta charset="utf-8">
		<!--<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">-->

		<title>#application.config.tituloSite#</title>
		<meta name="description" content="">
		<meta name="author" content="Inove Soluções em Tecnologia da Informação">

		<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">

		<link href="#application.config.rootUrl#/css/formee-structure.css" rel="stylesheet" type="text/css" media="screen" />
		<link href="#application.config.rootUrl#/css/formee-style.css" rel="stylesheet" type="text/css" media="screen" />
		<link href="#application.config.rootUrl#/css/styles.css" rel="stylesheet" type="text/css" media="screen" />
		<link href="#application.config.rootUrl#/css/jquery.dataTables.css" rel="stylesheet" type="text/css" media="screen" />

		<script src="#application.config.rootUrl#/js/jquery.js" type="text/javascript"></script>
		<script src="#application.config.rootUrl#/js/jquery.dataTables.js" type="text/javascript"></script>
		<script src="#application.config.rootUrl#/js/formee.js" type="text/javascript"></script>
		<script type="text/javascript">var urlSistema = '#application.config.rootUrl#';</script>
	</cfoutput>
	</head>

	<body>
		<div class="topbar">
			<a class="left" href="http://www.brmultimidia.com.br" target="_blank" title="BR Multimidia"><strong>www.brmultimidia.com.br</strong></a>
			<a class="right" href="http://www.twitter.com/brmultimidia" title="@brmultimidia">@brmultimidia</a>
		</div>
		<div class="formeebar">
			<h1><a href="http://www.inovesti.com.br" target="_blank" title="Inove Soluções em Tecnologia da Informação">www.inovesti.com.br</a></h1>
			<h2><strong>Estudos CF</strong> / ColdFusion 11!</h2>
		</div>
		<div class="container">
			<!---<cfdump var="#url#" label="url">--->
			<!---<cfdump var="#cgi#">--->

			<!--- start: PAGE CONTENT --->
			<cfinclude template="#variables.routerObject.getRoute( URL.gerenciador )#">
			<!--- end: PAGE CONTENT--->
		</div>

		<div class="footer">
			<div class="container">
				<p><a href="http://www.inovesti.com.br/" target="_blank" title="Inove Soluções em Tecnologia da Informação">Inove STI</a></p>
			</div>
		</div>
	</body>
</html>