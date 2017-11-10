unit PJBank.Boleto.Impressao.Request;

interface

uses
  System.Generics.Collections;

type
  TBoletosImpressaoRequest = class
  public
    pedido_numero: TList<string>;
    formato: string;
  end;

implementation

end.
