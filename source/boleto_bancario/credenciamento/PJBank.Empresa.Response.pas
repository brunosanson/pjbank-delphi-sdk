unit PJBank.Empresa.Response;

interface

type
  TEmpresaResponse = class
  public
    status: string;
    msg: string;
    credencial: string;
    chave: string;
    conta_virtual: string;
    agencia_virtual: string;
  end;

implementation

end.
