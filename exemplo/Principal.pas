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
  PJBank.Empresa.Response,
  PJBank.Boleto.Request,
  PJBank.Boleto.Response;

type
  TFormPrincipal = class(TForm)
    ButtonCredenciar: TButton;
    MemoLog: TMemo;
    ButtonEmitirBoleto: TButton;
    ButtonImprimirBoleto: TButton;
    MemoEmpresa: TMemo;
    LabelLog: TLabel;
    procedure ButtonCredenciarClick(Sender: TObject);
    procedure ButtonEmitirBoletoClick(Sender: TObject);
    procedure ButtonImprimirBoletoClick(Sender: TObject);
  private
    FRestClient: TRestClient;
    FCredencial: string;
    FLinkBoleto: string;
    function NovaEmpresa: TEmpresaRequest;
    function NovoBoleto: TBoletoRequest;
    procedure AtualizarMemoEmpresa;
    procedure ValidarCredenciamentoEmpresa(EmpresaResponse: TEmpresaResponse);
    procedure ValidarEmissaoBoleto(BoletoResponse: TBoletoResponse);
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

  FCredencial := '46e3133afaf429cc0b06ff003c5be878eb642a0a';
  AtualizarMemoEmpresa;
  ButtonEmitirBoleto.Enabled := True;
end;

destructor TFormPrincipal.Destroy;
begin
  FRestClient.Free;
  inherited;
end;

procedure TFormPrincipal.AtualizarMemoEmpresa;
begin
  MemoEmpresa.Lines.Add('Credencial: ' + FCredencial);
end;

procedure TFormPrincipal.ButtonEmitirBoletoClick(Sender: TObject);
var
  BoletoRequest: TBoletoRequest;
  BoletoResponse: TBoletoResponse;
  URL: string;
begin
  URL :=
    PJBank_URLAPI_Sandbox +
    StringReplace(PJBank_Endpoint_EmitirBoleto, '{{credencial-boleto}}', FCredencial, [rfIgnoreCase]);

  BoletoRequest := NovoBoleto;
  BoletoResponse := nil;
  try
    BoletoResponse :=
      FRestClient
      .Resource(URL)
      .ContentType(RestUtils.MediaType_Json)
      .Post<TBoletoResponse>(BoletoRequest);

    ValidarEmissaoBoleto(BoletoResponse);
  finally
    BoletoResponse.Free;
  end;
end;

procedure TFormPrincipal.ButtonImprimirBoletoClick(Sender: TObject);
begin
  MemoLog.Lines.Add('Link do Boleto: ' + FLinkBoleto + sLineBreak);
end;

function TFormPrincipal.NovaEmpresa: TEmpresaRequest;
begin
  Result := TEmpresaRequest.Create;
  Result.nome_empresa := 'Empresa de Exemplo';
  Result.conta_repasse := '99999-9';
  Result.agencia_repasse := '0001';
  Result.banco_repasse := '001';
  Result.cnpj := InputBox('CNPJ', 'Informe um CNPJ válido para credenciamento da empresa', '93764999000126');
  Result.ddd := '19';
  Result.telefone := '40096830';
  Result.email := 'atendimento@pjbank.com.br';
end;

function TFormPrincipal.NovoBoleto: TBoletoRequest;
begin
  Result := TBoletoRequest.Create;
  Result.vencimento := '11/28/2017';
  Result.valor := 100.00;
  Result.juros := 1;
  Result.multa := 2;
  Result.desconto := 0;
  Result.nome_cliente := 'Cliente Sem Multa, Juros e Desconto';
  Result.cpf_cliente := '46801303694';
  Result.endereco_cliente := 'Endereço do Pagador';
  Result.numero_cliente := '';
  Result.complemento_cliente := 'Bloco 1 - Apto 2';
  Result.bairro_cliente := 'Bairro';
  Result.cidade_cliente := 'Campinas 2';
  Result.estado_cliente := 'SP';
  Result.cep_cliente := '13301510';
  Result.logo_url := 'https://wallpapercave.com/wp/wp2239995.jpg';
  Result.texto := 'Descrição dos produtos ou serviços';
  Result.grupo := '';
  Result.pedido_numero := '1';
end;

procedure TFormPrincipal.ValidarCredenciamentoEmpresa(EmpresaResponse: TEmpresaResponse);
begin
  if EmpresaResponse.status = IntToStr(TStatusCode.CREATED.StatusCode) then
  begin
    FCredencial := EmpresaResponse.credencial;
    AtualizarMemoEmpresa;
    ButtonEmitirBoleto.Enabled := True;
  end
  else
  begin
    FCredencial := '';
    AtualizarMemoEmpresa;
    raise Exception.Create('ERRO ' + EmpresaResponse.status + ': ' + EmpresaResponse.msg);
  end;
end;

procedure TFormPrincipal.ValidarEmissaoBoleto(BoletoResponse: TBoletoResponse);
begin
  if StrToInt(BoletoResponse.status) in [TStatusCode.OK.StatusCode, TStatusCode.CREATED.StatusCode] then
  begin
    FLinkBoleto := BoletoResponse.linkBoleto;
    ButtonImprimirBoleto.Enabled := True;
  end
  else
  begin
    FLinkBoleto := '';
    ButtonImprimirBoleto.Enabled := False;
    raise Exception.Create('ERRO ' + BoletoResponse.status + ': ' + BoletoResponse.msg);
  end;
end;

end.
