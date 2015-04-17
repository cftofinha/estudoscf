<cfcomponent>

	<cfscript>
		variables.datasource 							= application.config.datasource;
		
		variables.factory								= application.config.factory;
		variables.result								= "";
		variables.queryParam 							= "";
	</cfscript>

	<!---
	* Função: Construtor
	* @name init
	* @return void
	--->
	<cffunction name="init" access="package" returntype="void">
		<cfargument name="datasource" type="string" required="false" default="" />

		<cfscript>

			variables.datasource							= ( Len( arguments.datasource ) == 0 ) ? application.config.datasource : arguments.datasource;
			
			variables.factory								= application.config.factory;
			variables.result								= "";
			variables.queryParam							= "";

		</cfscript>
	</cffunction>

</cfcomponent>