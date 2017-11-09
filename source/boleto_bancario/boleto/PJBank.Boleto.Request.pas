unit PJBank.Boleto.Request;

interface

type
  TBoletoRequest = class
  public
    vencimento: string;
    valor: currency;
    juros: currency;
    multa: currency;
    desconto: currency;
    nome_cliente: string;
    cpf_cliente: string;
    endereco_cliente: string;
    numero_cliente: string;
    complemento_cliente: string;
    bairro_cliente: string;
    cidade_cliente: string;
    estado_cliente: string;
    cep_cliente: string;
    logo_url: string;
    texto: string;
    grupo: string;
    pedido_numero: string;
  end;

implementation

end.
