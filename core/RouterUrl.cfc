component{

	public struct function init(){

		variables.rotas = {
			pagina = {
				entrada = "v_entrada/dspEntrada.cfm"
				,sobre = "v_entrada/dspSobre.cfm"
			}
			,contato = {
				gerenciar = "v_contato/dspRegistros.cfm"
				,novo = "v_contato/dspFormulario.cfm"
				,editar = "v_contato/dspFormulario.cfm"
			}
			,endereco = {
				gerenciar = "v_endereco/dspRegistros.cfm"
				,novo = "v_endereco/dspFormulario.cfm"
				,editar = "v_endereco/dspFormulario.cfm"
			}
		};

		return this;

	}

	private string function routerUrl(string param='pagina.entrada'){

		var prefixo = "../../view/";
		var rota = prefixo & "v_entrada/dspEntrada.cfm";

		/*var controle = ListGetAt(arguments.param,1,".");
		var urlParam 	 = ListGetAt(arguments.param,2,".");*/
		var controle = listFirst(arguments.param, '.');
		var urlParam 	 = listLast(arguments.param, '.');
		//[delimiters:string, [includeEmptyFields:boolean]]

		if( StructkeyExists( variables.rotas , controle ) == true && StructKeyExists( variables.rotas[ controle ] , urlParam ) == true ) {
			rota = prefixo & variables.rotas[ controle ][ urlParam ];
		}

		return rota;

	}

	public string function getRoute(required string param){

		return routerUrl( arguments.param );

	}

}