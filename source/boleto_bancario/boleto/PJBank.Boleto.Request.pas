unit PJBank.Boleto.Request;

interface

type
  TBoletoRequest = class
  private
    Fbairro_cliente: string;
    Fcep_cliente: string;
    Fcidade_cliente: string;
    Fcomplemento_cliente: string;
    Fcpf_cliente: string;
    Fdesconto: currency;
    Fendereco_cliente: string;
    Festado_cliente: string;
    Fgrupo: string;
    Fjuros: single;
    Flogo_url: string;
    Fmulta: single;
    Fnome_cliente: string;
    Fnumero_cliente: string;
    Fpedido_numero: string;
    Ftexto: string;
    Fvalor: currency;
    Fvencimento: string;
  public
    property vencimento: string read Fvencimento write Fvencimento;
    property valor: currency read Fvalor write Fvalor;
    property juros: single read Fjuros write Fjuros;
    property multa: single read Fmulta write Fmulta;
    property desconto: currency read Fdesconto write Fdesconto;
    property nome_cliente: string read Fnome_cliente write Fnome_cliente;
    property cpf_cliente: string read Fcpf_cliente write Fcpf_cliente;
    property endereco_cliente: string read Fendereco_cliente write Fendereco_cliente;
    property numero_cliente: string read Fnumero_cliente write Fnumero_cliente;
    property complemento_cliente: string read Fcomplemento_cliente write Fcomplemento_cliente;
    property bairro_cliente: string read Fbairro_cliente write Fbairro_cliente;
    property cidade_cliente: string read Fcidade_cliente write Fcidade_cliente;
    property estado_cliente: string read Festado_cliente write Festado_cliente;
    property cep_cliente: string read Fcep_cliente write Fcep_cliente;
    property logo_url: string read Flogo_url write Flogo_url;
    property texto: string read Ftexto write Ftexto;
    property grupo: string read Fgrupo write Fgrupo;
    property pedido_numero: string read Fpedido_numero write Fpedido_numero;
  end;

implementation

end.

