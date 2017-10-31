unit PJBank.Empresa.Request;

interface

type
  TEmpresaRequest = class
  public
    nome_empresa: string;
    conta_repasse: string;
    agencia_repasse: string;
    banco_repasse: string;
    cnpj: string;
    ddd: string;
    telefone: string;
    email: string;
    agencia: string;
  end;

implementation

end.
