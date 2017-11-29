unit PJBank.Boleto.Extrato.Response;

interface

uses
  System.Generics.Collections;

type
  TBoletoPagamento = class
  public
    valor: string;
    nosso_numero: string;
    nosso_numero_original: string;
    id_unico: string;
    id_unico_original: string;
    banco_numero: string;
    token_facilitador: string;
    valor_liquido: string;
    data_vencimento: string;
    data_pagamento: string;
    data_credito: string;
    pagador: string;
  end;

  TBoletoExtrato = TList<TBoletoPagamento>;

implementation

end.
