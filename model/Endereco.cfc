<cfcomponent displayname="Endereco" hint="Objeto Model" output="false" extends="estudoscf.model.ModelBase">

	<!---
	* Funcao: Construtor
	* @name init
	* @return void
	* @author Francisco Paulino - Tofinha [Inove STI] - francisco@inovesti.com.br | tofinha@gmail.com
	--->
	<cffunction name="init" access="public" returntype="estudoscf.model.Endereco">
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
			select e.id, e.id_contato, e.id_municipio, e.ds_logradouro, e.no_bairro, e.nu_cep
					,c.no_contato, m.no_municipio, uf.no_estado, uf.id as id_estado, uf.id_regiao_brasil
			from tb_endereco e
			inner join tb_contato c on c.id = e.id_contato
			inner join tb_municipio m on m.id = e.id_municipio
			inner join tb_estado uf on uf.id = m.id_estado
			where e.id = <cfqueryparam cfsqltype="cf_sql_numeric" value="#arguments.id#" maxlength="11" />
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
			select e.id, e.id_contato, e.id_municipio, e.ds_logradouro, e.no_bairro, e.nu_cep
					,c.no_contato, m.no_municipio, uf.no_estado, uf.id, uf.id_regiao_brasil
			from tb_endereco e
			inner join tb_contato c on c.id = e.id_contato
			inner join tb_municipio m on m.id = e.id_municipio
			inner join tb_estado uf on uf.id = m.id_estado
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
		<cfargument name="id_contato" type="numeric" />
		<cfargument name="id_municipio" type="numeric" />
		<cfargument name="ds_logradouro" type="string" />
		<cfargument name="no_bairro" type="string" />
		<cfargument name="nu_cep" type="string" />

		<cfset strRetorno = {} />

		<cftry>
			<cfquery datasource="#variables.datasource#" result="daoResult">
				insert into tb_endereco (
					id_contato
					,id_municipio
					,ds_logradouro
					,no_bairro
					,nu_cep
				)
				values(
					<cfqueryparam value="#arguments.id_contato#" cfsqltype="cf_sql_integer" maxlength="11" />
					,<cfqueryparam value="#arguments.id_municipio#" cfsqltype="cf_sql_integer" maxlength="11" />
					,<cfqueryparam value="#arguments.ds_logradouro#" cfsqltype="cf_sql_varchar" maxlength="255" />
					,<cfqueryparam value="#arguments.no_bairro#" cfsqltype="cf_sql_varchar" maxlength="100" />
					,<cfqueryparam value="#arguments.nu_cep#" cfsqltype="cf_sql_varchar" maxlength="10" />
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
		<cfargument name="id_contato" type="numeric" />
		<cfargument name="id_municipio" type="numeric" />
		<cfargument name="ds_logradouro" type="string" />
		<cfargument name="no_bairro" type="string" />
		<cfargument name="nu_cep" type="string" />
		<cfargument name="id" type="numeric" />

		<cfset strRetorno = {} />
		<cftry>
			<cfquery datasource="#variables.datasource#" result="daoResult">
				update tb_endereco set
					id_contato = <cfqueryparam value="#arguments.id_contato#" cfsqltype="cf_sql_integer" maxlength="11" />
					,id_municipio = <cfqueryparam value="#arguments.id_municipio#" cfsqltype="cf_sql_integer" maxlength="11" />
					,ds_logradouro = <cfqueryparam value="#arguments.ds_logradouro#" cfsqltype="cf_sql_varchar" maxlength="255" />
					,no_bairro = <cfqueryparam value="#arguments.no_bairro#" cfsqltype="cf_sql_varchar" maxlength="100" />
					,nu_cep = <cfqueryparam value="#arguments.nu_cep#" cfsqltype="cf_sql_varchar" maxlength="10" />
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
				delete from tb_endereco
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
		<cfargument name="id_contato" type="numeric" />
		<cfargument name="id_municipio" type="numeric" />
		<cfargument name="ds_logradouro" type="string" />
		<cfargument name="no_bairro" type="string" />
		<cfargument name="nu_cep" type="string" />
		<cfargument name="id" type="numeric" />

		<cfscript>
			strRetorno = {};

			if(not compareNoCase(arguments.acao, "novo")){
				this.setCadastrar(
					arguments.id_contato
					,arguments.id_municipio
					,arguments.ds_logradouro
					,arguments.no_bairro
					,arguments.nu_cep
				);
				//retorno da mensagem do metodo cadastrar
				strRetorno.retorno 	= strRetorno.retorno;
				strRetorno.mensagem	= strRetorno.mensagem;
			}
			else if(not compareNoCase(arguments.acao, "alterar")){
				this.setAlterar(
					arguments.id_contato
					,arguments.id_municipio
					,arguments.ds_logradouro
					,arguments.no_bairro
					,arguments.nu_cep
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