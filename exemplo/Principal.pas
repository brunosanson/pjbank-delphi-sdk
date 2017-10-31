unit Principal;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  RestClient,
  HttpConnection,
  PJBank.Empresa.Request,
  PJBank.Empresa.Response;

type
  TFormPrincipal = class(TForm)
    ButtonCredenciar: TButton;
    MemoLog: TMemo;
    ButtonEmitirBoleto: TButton;
    Button1: TButton;
    MemoEmpresa: TMemo;
    LabelLog: TLabel;
    procedure ButtonCredenciarClick(Sender: TObject);
  private
    FRestClient: TRestClient;
    FCredencial: string;
    FChave: string;
    function NovaEmpresa: TEmpresaRequest;
    procedure AtualizarMemoEmpresa;
    procedure ValidarCredenciamentoEmpresa(EmpresaResponse: TEmpresaResponse);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  FormPrincipal: TFormPrincipal;

implementation

uses
  PJBank.Consts,
  RestClientConfig,
  RestUtils;

{$R *.dfm}


procedure TFormPrincipal.ButtonCredenciarClick(Sender: TObject);
var
  EmpresaRequest: TEmpresaRequest;
  EmpresaResponse: TEmpresaResponse;
  URL: string;
begin
  URL := PJBank_URLAPI_Sandbox + PJBank_Endpoint_CredenciarConta;

  EmpresaRequest := NovaEmpresa;
  EmpresaResponse := nil;
  try
    EmpresaResponse :=
      FRestClient
      .Resource(URL)
      .ContentType(RestUtils.MediaType_Json)
      .Post<TEmpresaResponse>(EmpresaRequest);

    ValidarCredenciamentoEmpresa(EmpresaResponse);
  finally
    EmpresaResponse.Free;
  end;
end;

constructor TFormPrincipal.Create(AOwner: TComponent);
begin
  inherited;
  FRestClient := TRestClientConfig.Novo(MemoLog.Lines);
end;

destructor TFormPrincipal.Destroy;
begin
  FRestClient.Free;
  inherited;
end;

procedure TFormPrincipal.AtualizarMemoEmpresa;
begin
  MemoEmpresa.Lines.Add('Credencial: ' + FCredencial);
  MemoEmpresa.Lines.Add('Chave: ' + FChave);
end;

function TFormPrincipal.NovaEmpresa: TEmpresaRequest;
begin
  Result := TEmpresaRequest.Create;
  Result.nome_empresa := 'Empresa de Exemplo';
  Result.conta_repasse := '99999-9';
  Result.agencia_repasse := '0001';
  Result.banco_repasse := '001';
  Result.cnpj := '85981931000170';
  Result.ddd := '19';
  Result.telefone := '40096830';
  Result.email := 'atendimento@pjbank.com.br';
end;

procedure TFormPrincipal.ValidarCredenciamentoEmpresa(EmpresaResponse:
  TEmpresaResponse);
begin
  if EmpresaResponse.status = IntToStr(TStatusCode.CREATED.StatusCode) then
  begin
    FCredencial := EmpresaResponse.credencial;
    FChave := EmpresaResponse.chave;
    AtualizarMemoEmpresa;
    ButtonEmitirBoleto.Enabled := True;
  end
  else
  begin
    FCredencial := '';
    FChave := '';
    AtualizarMemoEmpresa;
    raise Exception.Create('ERRO ' + EmpresaResponse.status + ': ' + EmpresaResponse.msg);
  end;
end;

end.
