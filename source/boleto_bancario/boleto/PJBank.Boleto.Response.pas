unit PJBank.Boleto.Response;

interface

type
  TBoletoResponse = class
  private
    Fbanco_numero: string;
    Fcredencial: string;
    Fid_unico: string;
    FlinhaDigitavel: string;
    FlinkBoleto: string;
    FlinkGrupo: string;
    Fmsg: string;
    Fnossonumero: string;
    Fstatus: string;
    Ftoken_facilitador: string;
  public
    property status: string read Fstatus write Fstatus;
    property msg: string read Fmsg write Fmsg;
    property nossonumero: string read Fnossonumero write Fnossonumero;
    property id_unico: string read Fid_unico write Fid_unico;
    property banco_numero: string read Fbanco_numero write Fbanco_numero;
    property token_facilitador: string read Ftoken_facilitador write Ftoken_facilitador;
    property credencial: string read Fcredencial write Fcredencial;
    property linkBoleto: string read FlinkBoleto write FlinkBoleto;
    property linkGrupo: string read FlinkGrupo write FlinkGrupo;
    property linhaDigitavel: string read FlinhaDigitavel write FlinhaDigitavel;
  end;

implementation

end.
