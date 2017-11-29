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
  PJBank.Boleto.Response,
  System.Generics.Collections,
  PJBank.Boleto.Impressao.Response,
  PJBank.Boleto.Extrato.Response;

type
  TFormPrincipal = class(TForm)
    ButtonCredenciar: TButton;
    MemoLog: TMemo;
    ButtonEmitirBoleto: TButton;
    ButtonImprimirBoleto: TButton;
    MemoEmpresa: TMemo;
    ButtonImprimirTodosBoletosEmitidos: TButton;
    ButtonObterExtratoPagamento: TButton;
    procedure ButtonObterExtratoPagamentoClick(Sender: TObject);
    procedure ButtonImprimirTodosBoletosEmitidosClick(Sender: TObject);
    procedure ButtonCredenciarClick(Sender: TObject);
    procedure ButtonEmitirBoletoClick(Sender: TObject);
    procedure ButtonImprimirBoletoClick(Sender: TObject);
  private
    FRestClient: TRestClient;
    FCredencial: string;
    FChave: string;
    FLinkBoleto: string;
    FListaPedidoNumero: TList<string>;
    function NovaEmpresa: TEmpresaRequest;
    function NovoBoleto: TBoletoRequest;
    procedure AtualizarMemoEmpresa;
    procedure ValidarCredenciamentoEmpresa(EmpresaResponse: TEmpresaResponse);
    procedure ValidarEmissaoBoleto(BoletoResponse: TBoletoResponse);
    procedure AbrirLinkNoBrowser;
    procedure ApresentarOsPagamentos(const Extrato: TBoletoExtrato);
    procedure SalvarDadosCredenciamento(EmpresaResponse: TEmpresaResponse);
    procedure LerDadosCredenciamento;
    procedure ValidarImpressaoEmLote(BoletosImpressaoResponse: TBoletosImpressaoResponse);
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
  RestUtils,
  PJBank.Boleto.Impressao.Request,
  Winapi.ShellAPI,
  System.IniFiles;

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
    SalvarDadosCredenciamento(EmpresaResponse);
  finally
    EmpresaResponse.Free;
  end;
end;

constructor TFormPrincipal.Create(AOwner: TComponent);
begin
  inherited;
  FRestClient := TRestClientConfig.Novo(MemoLog.Lines);
  FListaPedidoNumero := TList<string>.Create;
  LerDadosCredenciamento;
  AtualizarMemoEmpresa;
  ButtonEmitirBoleto.Enabled := FCredencial <> '';
end;

destructor TFormPrincipal.Destroy;
begin
  FListaPedidoNumero.Free;
  FRestClient.Free;
  inherited;
end;

procedure TFormPrincipal.AbrirLinkNoBrowser;
begin
  MemoLog.Lines.Add('Link do Boleto: ' + FLinkBoleto + sLineBreak);
  ShellExecute(0, 'open', PChar(FLinkBoleto), nil, nil, SW_SHOWNORMAL);
end;

procedure TFormPrincipal.AtualizarMemoEmpresa;
begin
  MemoEmpresa.Lines.Add('Credencial: ' + FCredencial);
  MemoEmpresa.Lines.Add('X-Chave   : ' + FChave);
end;

procedure TFormPrincipal.ButtonObterExtratoPagamentoClick(Sender: TObject);
var
  Extrato: TBoletoExtrato;
  URL: string;
begin
  URL := PJBank_URLAPI_Sandbox + PJBank_Endpoint_ExtratoRecebimentoPago;
  URL := StringReplace(URL, '{{credencial-boleto}}', FCredencial, [rfIgnoreCase]);
  URL := StringReplace(URL, '{{inicio}}', '10/05/2017', [rfIgnoreCase]);
  URL := StringReplace(URL, '{{fim}}', '10/05/2017', [rfIgnoreCase]);

  Extrato := nil;
  try
    Extrato :=
      FRestClient
      .Resource(URL)
      .ContentType(RestUtils.MediaType_Json)
      .Header('X-CHAVE', FChave)
      .Get<TBoletoExtrato>;

    ApresentarOsPagamentos(Extrato);
  finally
    Extrato.Free;
  end;
end;

procedure TFormPrincipal.ApresentarOsPagamentos(const Extrato: TExtrato);
var
  P: TBoletoPagamento;
  Total: Currency;
  TotalLiquido: Currency;
  FS: TFormatSettings;
  I: Integer;
begin
  FS := TFormatSettings.Create;
  FS.ThousandSeparator := ',';
  FS.DecimalSeparator := '.';

  I := 0;
  Total := 0;
  TotalLiquido := 0;
  for P in Extrato do
  begin
    Inc(I);

    MemoLog.Lines.Add('Id Único: ' + P.id_unico);
    MemoLog.Lines.Add('Nosso Número: ' + P.nosso_numero);
    MemoLog.Lines.Add('Banco: ' + P.banco_numero);
    MemoLog.Lines.Add('Token Facilitador: ' + P.token_facilitador);
    MemoLog.Lines.Add('Valor: R$ ' + P.valor);
    MemoLog.Lines.Add('Valor Liquido: R$ ' + P.valor_liquido);
    MemoLog.Lines.Add('Vencimento: ' + P.data_vencimento);
    MemoLog.Lines.Add('Pagamento: ' + P.data_pagamento);
    MemoLog.Lines.Add('Crédito: ' + P.data_credito);
    MemoLog.Lines.Add('Pagador: ' + P.pagador + sLineBreak);

    Total := Total + StrToFloat(P.valor, FS);
    TotalLiquido := TotalLiquido + StrToFloat(P.valor_liquido, FS);
  end;
  MemoLog.Lines.Add(' -- -- -- -- -- Resumo -- -- -- -- --' + sLineBreak);
  MemoLog.Lines.Add('Total Recebido                       : ' + FloatToStrF(Total, ffCurrency, 10, 2));
  MemoLog.Lines.Add('Total Liquido Recebido               : ' + FloatToStrF(TotalLiquido, ffCurrency, 10, 2));
  MemoLog.Lines.Add('Diferença Recebida (Bruto - Liquido) : ' + FloatToStrF(Total - TotalLiquido, ffCurrency, 10, 2));
  MemoLog.Lines.Add('Quantidade de Pagamentos             : ' + IntToStr(I));
end;

procedure TFormPrincipal.ButtonImprimirTodosBoletosEmitidosClick(Sender: TObject);
var
  BoletosImpressaoRequest: TBoletosImpressaoRequest;
  BoletosImpressaoResponse: TBoletosImpressaoResponse;
  URL: string;
begin
  URL :=
    PJBank_URLAPI_Sandbox +
    StringReplace(PJBank_Endpoint_ImpressaoBoleto, '{{credencial-boleto}}', FCredencial, [rfIgnoreCase]);

  BoletosImpressaoRequest := TBoletosImpressaoRequest.Create;
  // BoletosImpressaoRequest.formato := 'carne';
  BoletosImpressaoRequest.pedido_numero := FListaPedidoNumero;
  BoletosImpressaoResponse := nil;
  try
    BoletosImpressaoResponse :=
      FRestClient
      .Resource(URL)
      .ContentType(RestUtils.MediaType_Json)
      .Header('X-CHAVE', FChave)
      .Post<TBoletosImpressaoResponse>(BoletosImpressaoRequest);

    ValidarImpressaoEmLote(BoletosImpressaoResponse);
    AbrirLinkNoBrowser;
  finally
    BoletosImpressaoResponse.Free;
  end;
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
    FListaPedidoNumero.Add(BoletoRequest.pedido_numero);

    if FListaPedidoNumero.Count >= 1 then
    begin
      ButtonImprimirBoleto.Enabled := True;
      ButtonImprimirTodosBoletosEmitidos.Enabled := True;
    end;
  finally
    BoletoResponse.Free;
  end;
end;

procedure TFormPrincipal.ButtonImprimirBoletoClick(Sender: TObject);
begin
  AbrirLinkNoBrowser;
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
  Result.nome_cliente := 'Nome do Pagador';
  Result.cpf_cliente := '46801303694';
  Result.endereco_cliente := 'Endereço do Pagador';
  Result.numero_cliente := '12345';
  Result.complemento_cliente := 'Bloco 1 - Apto 2';
  Result.bairro_cliente := 'Bairro do Pagador';
  Result.cidade_cliente := 'Cidade do Pagador';
  Result.estado_cliente := 'SP';
  Result.cep_cliente := '13301510';
  Result.logo_url := 'https://wallpapercave.com/wp/wp2239995.jpg';
  Result.texto := 'Descrição dos produtos ou serviços';
  Result.grupo := '';
  Result.pedido_numero := InputBox('Número do Pedido', 'Mantenha o mesmo número para edição do boleto. ', '1');
end;

procedure TFormPrincipal.SalvarDadosCredenciamento(EmpresaResponse: TEmpresaResponse);
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
  try
    Ini.WriteString('Empresa', 'Credencial', EmpresaResponse.credencial);
    Ini.WriteString('Empresa', 'X-Chave', EmpresaResponse.chave);
  finally
    Ini.Free;
  end;
end;

procedure TFormPrincipal.LerDadosCredenciamento;
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(ChangeFileExt(Application.ExeName, '.ini'));
  try
    FCredencial := Ini.ReadString('Empresa', 'Credencial', '');
    FChave := Ini.ReadString('Empresa', 'X-Chave', '');
  finally
    Ini.Free;
  end;
end;

procedure TFormPrincipal.ValidarCredenciamentoEmpresa(EmpresaResponse: TEmpresaResponse);
begin
  if EmpresaResponse.status = IntToStr(TStatusCode.CREATED.StatusCode) then
  begin
    MemoEmpresa.Clear;
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

procedure TFormPrincipal.ValidarEmissaoBoleto(BoletoResponse: TBoletoResponse);
begin
  if StrToInt(BoletoResponse.status) in [TStatusCode.OK.StatusCode, TStatusCode.CREATED.StatusCode] then
    FLinkBoleto := BoletoResponse.linkBoleto
  else
  begin
    FLinkBoleto := '';
    ButtonImprimirBoleto.Enabled := False;
    raise Exception.Create('ERRO ' + BoletoResponse.status + ': ' + BoletoResponse.msg);
  end;
end;

procedure TFormPrincipal.ValidarImpressaoEmLote(BoletosImpressaoResponse:
  TBoletosImpressaoResponse);
begin
  if BoletosImpressaoResponse.status = IntToStr(TStatusCode.OK.StatusCode) then
    FLinkBoleto := BoletosImpressaoResponse.linkBoleto
  else
  begin
    FLinkBoleto := '';
    raise Exception.Create('ERRO ' + BoletosImpressaoResponse.status + ': ');
  end;
end;

end.
