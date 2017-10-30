unit PJBank.Empresa.Response;

interface

type
  TEmpresaResponse = class
  private
    Fagencia_virtual: string;
    Fchave: string;
    Fconta_virtual: string;
    Fcredencial: string;
    Fmsg: string;
    Fstatus: string;
  public
    property status: string read Fstatus write Fstatus;
    property msg: string read Fmsg write Fmsg;
    property credencial: string read Fcredencial write Fcredencial;
    property chave: string read Fchave write Fchave;
    property conta_virtual: string read Fconta_virtual write Fconta_virtual;
    property agencia_virtual: string read Fagencia_virtual write Fagencia_virtual;
  end;

implementation

end.
