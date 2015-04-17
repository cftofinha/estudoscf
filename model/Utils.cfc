<cfcomponent displayname="Utils" hint="Objeto Model" output="false" extends="estudoscf.model.ModelBase">

	<!---
	* Funcao: Construtor
	* @name init
	* @return void
	* @author Francisco Paulino - Tofinha [Inove STI] - francisco@inovesti.com.br | tofinha@gmail.com
	--->
	<cffunction name="init" access="public" returntype="estudoscf.model.Utils">
		<cfscript>
			super.init();

			return this;
		</cfscript>
	</cffunction>

	<!---
	* Funcao: consulta um registro em especifico
	* @name geRegiao
	* @return query
	--->
	<cffunction name="getRegiao" access="remote" output="false" returntype="query">

		<cfset var resultadoConsulta = "" />

		<cfquery name="resultadoConsulta" datasource="#variables.datasource#">
			select id, no_regiao
			from tb_regiao_brasil
			order by no_regiao asc
		</cfquery>

		<cfreturn resultadoConsulta />
	</cffunction>
	
	<!---
	* Funcao: consulta um registro em especifico
	* @name getUF
	* @return query
	--->
	<cffunction name="getUF" access="remote" output="false" returntype="query">
		<cfargument name="id_regiao_brasil" type="numeric" required="true" default="0" />
		
		<cfset var resultadoConsulta = "" />

		<cfquery name="resultadoConsulta" datasource="#variables.datasource#">
			select id, no_estado
			from tb_estado
			where id_regiao_brasil = <cfqueryparam value="#arguments.id_regiao_brasil#" cfsqltype="cf_sql_numeric" maxlength="11">
			order by no_estado asc
		</cfquery>

		<cfreturn resultadoConsulta />
	</cffunction>

	<cffunction name="getMunicipio" access="remote" output="false" returntype="query">
		<cfargument name="id_estado" type="numeric" required="true" default="0" />

		<cfset var resultadoConsulta = "" />

		<cfquery name="resultadoConsulta" datasource="#variables.datasource#">
			select m.id, m.no_municipio
			from tb_municipio m
			inner join tb_estado e on e.id = m.id_estado
			where m.id_estado = <cfqueryparam value="#arguments.id_estado#" cfsqltype="cf_sql_numeric" maxlength="11">
			order by m.no_municipio asc
		</cfquery>

		<cfreturn resultadoConsulta />
	</cffunction>

</cfcomponent>