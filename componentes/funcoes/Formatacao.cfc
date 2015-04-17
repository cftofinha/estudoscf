<cfcomponent displayname="Função para limpar textos com acentuação.">

	<cffunction name="LimpaTexto" displayname="Função para limpar textos com acentuação" access="remote" returntype="string">
		<cfargument name="texto" required="true" type="string" />

		<cfscript>
			texto = rereplaceNoCase(texto,'[áàâãª]','a','All');
			texto = rereplaceNoCase(texto,'[éèê]','e','All');
			texto = rereplaceNoCase(texto,'[íìî]','i','All');
			texto = rereplaceNoCase(texto,'[óòôõº]','o','All');
			texto = rereplaceNoCase(texto,'[úùûü]','u','All');
			texto = rereplaceNoCase(texto,'[ç]','c','All');
			texto = rereplaceNoCase(texto,'[-]','_','All');
			texto = rereplaceNoCase(texto,'[,]','','All');
		</cfscript>

		<cfreturn texto />

	</cffunction>

	<cffunction name="TextoAcentuado" displayname="Função para limpar textos com acentuação" access="remote" returntype="string">
		<cfargument name="texto" required="true" type="string" />

		<cfscript>
			texto = rereplaceNoCase(texto,'[á]','&aacute;','All');
			texto = rereplaceNoCase(texto,'[à]','&agrave','All');
			texto = rereplaceNoCase(texto,'[â]','&acirc;','All');
			texto = rereplaceNoCase(texto,'[ã]','&atilde;','All');
			texto = rereplaceNoCase(texto,'[ª]','&ordf;','All');

			texto = rereplaceNoCase(texto,'[é]','&eacute;','All');
			texto = rereplaceNoCase(texto,'[è]','&egrave;','All');
			texto = rereplaceNoCase(texto,'[ê]','&ecirc;','All');

			texto = rereplaceNoCase(texto,'[í]','&iacute;','All');
			texto = rereplaceNoCase(texto,'[ì]','&igrave;','All');
			texto = rereplaceNoCase(texto,'[î]','&icirc;','All');

			texto = rereplaceNoCase(texto,'[ó]','&oacute;','All');
			texto = rereplaceNoCase(texto,'[ò]','&ograve;','All');
			texto = rereplaceNoCase(texto,'[ô]','&ocirc;','All');
			texto = rereplaceNoCase(texto,'[õ]','&otilde;','All');
			texto = rereplaceNoCase(texto,'[º]','&ordm;','All');

			texto = rereplaceNoCase(texto,'[ú]','&uacute;','All');
			texto = rereplaceNoCase(texto,'[ù]','&ugrave;','All');
			texto = rereplaceNoCase(texto,'[û]','&ucirc;','All');
			texto = rereplaceNoCase(texto,'[ü]','&uuml;','All');

			texto = rereplaceNoCase(texto,'[ç]','&ccedil;','All');

		</cfscript>

		<cfreturn texto />

	</cffunction>

	<cffunction name="TiraEspaco" displayname="Função para tirar os espaços em branco" access="remote" returntype="string">
		<cfargument name="texto" required="true" type="string" />

		<cfscript>
			texto = rereplaceNoCase(texto,'[[:space:]]','','All');
		</cfscript>

		<cfreturn texto />

	</cffunction>

	<cffunction name="URLAmigavel" displayname="Função para tirar os espaços em branco" access="remote" returntype="string">
		<cfargument name="texto" required="true" type="string" />

		<cfscript>
			texto = rereplaceNoCase(texto,'[áàâãª]','a','All');
			texto = rereplaceNoCase(texto,'[éèê]','e','All');
			texto = rereplaceNoCase(texto,'[íìî]','i','All');
			texto = rereplaceNoCase(texto,'[óòôõº]','o','All');
			texto = rereplaceNoCase(texto,'[úùûü]','u','All');
			texto = rereplaceNoCase(texto,'[ç]','c','All');
			texto = rereplaceNoCase(texto,'[[:punct:]]','','All');
			texto = rereplaceNoCase(texto,'[[:space:]]','-','All');
		</cfscript>

		<cfreturn texto />

	</cffunction>
	<cffunction name="setNomeAmigavel" displayname="Função para tirar os espaços em branco e trocar por traços" access="remote" returntype="string">
		<cfargument name="texto" required="true" type="string" />

		<cfscript>
			texto = rereplaceNoCase(texto,'[áàâãª]','a','All');
			texto = rereplaceNoCase(texto,'[éèê]','e','All');
			texto = rereplaceNoCase(texto,'[íìî]','i','All');
			texto = rereplaceNoCase(texto,'[óòôõº]','o','All');
			texto = rereplaceNoCase(texto,'[úùûü]','u','All');
			texto = rereplaceNoCase(texto,'[ç]','c','All');
			texto = rereplaceNoCase(texto,'[[:punct:]]','','All');
			texto = rereplaceNoCase(texto,'[[:space:]]','-','All');
		</cfscript>

		<cfreturn texto />

	</cffunction>

</cfcomponent>