unit PJBank.Empresa.Request;

interface

type
  TEmpresaRequest = class
  private
    Fagencia: string;
    Fagencia_repasse: string;
    Fbanco_repasse: string;
    Fcnpj: integer;
    Fconta_repasse: string;
    Fddd: integer;
    Femail: string;
    Fnome_empresa: string;
    Ftelefone: integer;
  public
    property nome_empresa: string read Fnome_empresa write Fnome_empresa;
    property conta_repasse: string read Fconta_repasse write Fconta_repasse;
    property agencia_repasse: string read Fagencia_repasse write Fagencia_repasse;
    property banco_repasse: string read Fbanco_repasse write Fbanco_repasse;
    property cnpj: integer read Fcnpj write Fcnpj;
    property ddd: integer read Fddd write Fddd;
    property telefone: integer read Ftelefone write Ftelefone;
    property email: string read Femail write Femail;
    property agencia: string read Fagencia write Fagencia;
  end;

implementation

end.
