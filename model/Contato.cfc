<cfcomponent displayname="Contatos" hint="Objeto Model" output="false" extends="estudoscf.model.ModelBase">

	<!---
	* Funcao: Construtor
	* @name init
	* @return void
	* @author Francisco Paulino - Tofinha [Inove STI] - francisco@inovesti.com.br | tofinha@gmail.com
	--->
	<cffunction name="init" access="public" returntype="estudoscf.model.Contato">
		<cfscript>
			super.init();

			return this;
		</cfscript>
	</cffunction>

	<!---
	* Funcao: consulta um registro em especifico
	* @name getRegistro
	* @return query
	--->
	<cffunction name="getRegistro" access="public" output="false" returntype="query">
		<cfargument name="id" type="numeric" required="true" default="" />

		<cfset var resultadoConsulta = "" />

		<cfquery name="resultadoConsulta" datasource="#variables.datasource#">
			select id, co_uuid, no_contato, ds_email, st_registro, dt_registro, dt_alteracao
			from tb_contato
			where id = <cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.id#" maxlength="11" />
		</cfquery>

		<cfreturn resultadoConsulta />
	</cffunction>

	<!---
	* Funcao: lista todos os dados ou um definido para edicao
	* @name getListar
	* @return query
	--->
	<cffunction name="getListar" access="remote" output="false" returntype="query">
		<cfargument name="condicaoFiltros" 	type="string" required="false">

		<cfset var resultadoConsulta = "" />

		<cfquery name="resultadoConsulta" datasource="#variables.datasource#">
			select id, co_uuid, no_contato, ds_email, st_registro, dt_registro, dt_alteracao
			from tb_contato
			<cfif isDefined("arguments.condicaoFiltros")>
				where #preserveSingleQuotes(arguments.condicaoFiltros)#
			</cfif>
			order by no_contato asc
		</cfquery>

		<cfreturn resultadoConsulta />
	</cffunction>

	<!--- CRUD --->
	<!---
	* Funcao: salva os dados de um novo registro
	* @name setCadastrar
	* @return struct
	--->
	<cffunction name="setCadastrar" access="package" output="false" returntype="struct">
		<cfargument name="co_uuid" type="string" />
		<cfargument name="no_contato" type="string" />
		<cfargument name="ds_email" type="string" />
		<cfargument name="st_registro" type="string" />

		<cfset strRetorno = {} />

		<cftry>
			<cfquery datasource="#variables.datasource#" result="daoResult">
				insert into tb_contato (
					co_uuid
					,no_contato
					,ds_email
					,st_registro
				)
				values(
					<cfqueryparam value="#arguments.co_uuid#" cfsqltype="cf_sql_varchar" maxlength="50" />
					,<cfqueryparam value="#arguments.no_contato#" cfsqltype="cf_sql_varchar" maxlength="50" />
					,<cfqueryparam value="#arguments.ds_email#" cfsqltype="cf_sql_varchar" maxlength="70" />
					,<cfqueryparam value="#arguments.st_registro#" cfsqltype="cf_sql_char" maxlength="1" />
				)
			</cfquery>
			<cfset strRetorno.retorno = "sucesso" />
			<cfset strRetorno.mensagem = "Registro salvo com sucesso" />

			<cfcatch type="any">
				<cfif not compareNocase(variables.ambiente, "desenvolvimento")>
					<cfdump var="#cfcatch#">
				<cfelse>
					<cfset strRetorno.retorno = "erro" />
					<cfset strRetorno.mensagem = cfcatch.message />
					<cfset strRetorno.mensagemCompleta = cfcatch.detail />
				</cfif>

			</cfcatch>
		</cftry>

		<cfreturn strRetorno />
	</cffunction>

	<!---
	* Funcao: Alterar os dados
	* @name setAlterar
	* @return struct
	--->
	<cffunction name="setAlterar" access="package" output="false" returntype="struct">
		<cfargument name="co_uuid" type="string" />
		<cfargument name="no_contato" type="string" />
		<cfargument name="ds_email" type="string" />
		<cfargument name="st_registro" type="string" />
		<cfargument name="id" type="numeric" />

		<cfset strRetorno = {} />
		<cftry>
			<cfquery datasource="#variables.datasource#" result="daoResult">
				update tb_contato set
					no_contato = <cfqueryparam value="#arguments.no_contato#" cfsqltype="cf_sql_varchar" maxlength="50" />
					,ds_email = <cfqueryparam value="#arguments.ds_email#" cfsqltype="cf_sql_varchar" maxlength="70" />
					,st_registro = <cfqueryparam value="#arguments.st_registro#" cfsqltype="cf_sql_char" maxlength="1" />
				WHERE
					id = <cfqueryparam cfsqltype="cf_sql_int" value="#arguments.id#" maxlength="10" />
			</cfquery>

			<cfset strRetorno.retorno = "sucesso" />
			<cfset strRetorno.mensagem = "Registro salvo com sucesso!" />


			<cfcatch type="any">
				<cfset strRetorno.retorno = "erro" />
				<cfset strRetorno.mensagem = cfcatch.message />
				<cfset strRetorno.mensagemCompleta = cfcatch />
			</cfcatch>
		</cftry>

		<cfreturn strRetorno />
	</cffunction>

	<!---
	* Funcao: base para delete (modo fisico, definitivamente) no banco de dados seguindo o modelo de arquitetura DAO
	* @name setExcluir
	* @return struct
	--->
	<cffunction name="setExcluir" access="package" output="false" returntype="struct">
		<cfargument name="id" type="numeric" required="true" />

		<cfset strRetorno = {} />
		<cftry>
			<cfquery datasource="#variables.datasource#">
				delete from tb_contato
				where id = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_integer" />
			</cfquery>

			<cfset strRetorno.retorno = "sucesso" />
			<cfset strRetorno.mensagem = "Registro salvo com sucesso!" />

			<cfcatch type="any">
				<cfset strRetorno.retorno = "erro" />
				<cfset strRetorno.mensagem = cfcatch.message />
				<cfset strRetorno.mensagemCompleta = cfcatch />
			</cfcatch>
		</cftry>

		<cfreturn strRetorno />

	</cffunction>

	<!---
	* Funcao: base para salvar o registro, seja cadatro ou alteração
	* @name setSalvarRegistro
	* @return void
	--->
	<cffunction name="setSalvarRegistro" access="remote" output="false" returntype="struct">
		<cfargument name="acao" type="string" required="true" />
		<cfargument name="co_uuid" type="string" />
		<cfargument name="no_contato" type="string" />
		<cfargument name="ds_email" type="string" />
		<cfargument name="st_registro" type="string" />
		<cfargument name="id" type="numeric" />

		<cfscript>
			strRetorno = {};

			if(not compareNoCase(arguments.acao, "novo")){
				this.setCadastrar(
					arguments.co_uuid
					,arguments.no_contato
					,arguments.ds_email
					,arguments.st_registro
				);
				//retorno da mensagem do metodo cadastrar
				strRetorno.retorno 	= strRetorno.retorno;
				strRetorno.mensagem	= strRetorno.mensagem;
			}
			else if(not compareNoCase(arguments.acao, "alterar")){
				this.setAlterar(
					arguments.co_uuid
					,arguments.no_contato
					,arguments.ds_email
					,arguments.st_registro
					,arguments.id
				);
				//retorno da mensagem do metodo alterar
				strRetorno.retorno 	= strRetorno.retorno;
				strRetorno.mensagem	= strRetorno.mensagem;
			}
			else if(not compareNoCase(arguments.acao, "excluir")){
				this.setExcluir(arguments.id);
				//retorno da mensagem do metodo excluir
				strRetorno.retorno 	= strRetorno.retorno;
				strRetorno.mensagem	= strRetorno.mensagem;
			}
		</cfscript>
		<cfreturn strRetorno>
	</cffunction>


</cfcomponent>