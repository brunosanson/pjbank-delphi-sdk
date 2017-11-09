unit PJBank.Boleto.Response;

interface

type
  TBoletoResponse = class
  public
    status: string;
    msg: string;
    nossonumero: string;
    id_unico: string;
    banco_numero: string;
    token_facilitador: string;
    credencial: string;
    linkBoleto: string;
    linkGrupo: string;
    linhaDigitavel: string;
  end;

implementation

end.
