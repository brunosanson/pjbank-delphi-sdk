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
  PJBank.Boleto.Extrato.Response,
  Vcl.ComCtrls,
  Vcl.ExtCtrls,
  Data.DB,
  Datasnap.DBClient,
  Vcl.Grids,
  Vcl.DBGrids;

type
  TFormPrincipal = class(TForm)
    MemoLog: TMemo;
    PageControl: TPageControl;
    tbaCredenciar: TTabSheet;
    tabEmitirBoleto: TTabSheet;
    tabExtratoPagamentoBoleto: TTabSheet;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    EditBoleto_NomeCliente: TLabeledEdit;
    EditBoleto_EnderecoCliente: TLabeledEdit;
    EditBoleto_ComplementoCliente: TLabeledEdit;
    EditBoleto_CidadeCliente: TLabeledEdit;
    EditBoleto_CNPJCliente: TLabeledEdit;
    EditBoleto_NumeroCliente: TLabeledEdit;
    EditBoleto_BairroCliente: TLabeledEdit;
    EditBoleto_UFCliente: TLabeledEdit;
    EditBoleto_CEPCliente: TLabeledEdit;
    EditBoleto_Vencimento: TLabeledEdit;
    EditBoleto_Valor: TLabeledEdit;
    EditBoleto_Multa: TLabeledEdit;
    EditBoleto_Juros: TLabeledEdit;
    GroupBox3: TGroupBox;
    EditCredencial_RazaoSocial: TLabeledEdit;
    EditCredencial_CNPJ: TLabeledEdit;
    EditCredencial_DDD: TLabeledEdit;
    EditCredencial_Telefone: TLabeledEdit;
    EditCredencial_Email: TLabeledEdit;
    GroupBox4: TGroupBox;
    EditCredencial_Banco: TLabeledEdit;
    EditCredencial_Agencia: TLabeledEdit;
    EditCredencial_Conta: TLabeledEdit;
    ButtonCredenciar: TButton;
    GroupBox5: TGroupBox;
    MemoEmpresa: TMemo;
    EditBoleto_Desconto: TLabeledEdit;
    GroupBox6: TGroupBox;
    EditBoleto_PedidoNumero: TLabeledEdit;
    EditBoleto_Texto: TLabeledEdit;
    EditBoleto_Logo: TLabeledEdit;
    DBGrid1: TDBGrid;
    ds: TDataSource;
    cds: TClientDataSet;
    ButtonEmitirBoleto: TButton;
    ButtonImprimirBoleto: TButton;
    ButtonImprimirTodosBoletosEmitidos: TButton;
    ButtonObterExtratoPagamento: TButton;
    cdsVALOR: TCurrencyField;
    cdsNOSSO_NUMERO: TStringField;
    cdsNOSSO_NUMERO_ORIGINAL: TStringField;
    cdsID_UNICO: TStringField;
    cdsID_UNICO_ORIGINAL: TStringField;
    cdsBANCO_NUMERO: TStringField;
    cdsTOKEN_FACILITADOR: TStringField;
    cdsVALOR_LIQUIDO: TCurrencyField;
    cdsDATA_VENCIMENTO: TDateField;
    cdsDATA_PAGAMENTO: TDateField;
    cdsDATA_CREDITO: TDateField;
    cdsPAGADOR: TStringField;
    EditExtrato_DataFim: TDateTimePicker;
    EditExtrato_DataInicio: TDateTimePicker;
    Label1: TLabel;
    procedure ButtonObterExtratoPagamentoClick(Sender: TObject);
    procedure ButtonImprimirTodosBoletosEmitidosClick(Sender: TObject);
    procedure ButtonCredenciarClick(Sender: TObject);
    procedure ButtonEmitirBoletoClick(Sender: TObject);
    procedure ButtonImprimirBoletoClick(Sender: TObject);
  private
    FFS: TFormatSettings;
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
  FFS := TFormatSettings.Create;
  FFS.ThousandSeparator := ',';
  FFS.DecimalSeparator := '.';
  FFS.ShortDateFormat := 'mm/dd/yyyy';

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
  URL, DataInicio, DataFim: string;
begin
  DataInicio := FormatDateTime(FFS.ShortDateFormat, EditExtrato_DataInicio.Date);
  DataFim := FormatDateTime(FFS.ShortDateFormat, EditExtrato_DataFim.Date);

  URL := PJBank_URLAPI_Sandbox + PJBank_Endpoint_ExtratoRecebimentoPago;
  URL := StringReplace(URL, '{{credencial-boleto}}', FCredencial, [rfIgnoreCase]);
  URL := StringReplace(URL, '{{inicio}}', DataInicio, [rfIgnoreCase]);
  URL := StringReplace(URL, '{{fim}}', DataFim, [rfIgnoreCase]);

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

procedure TFormPrincipal.ApresentarOsPagamentos(const Extrato: TBoletoExtrato);
var
  P: TBoletoPagamento;
begin
  cds.DisableControls;
  try
    cds.CreateDataSet;
    for P in Extrato do
    begin
      cds.Append;
      cdsID_UNICO.AsString := P.id_unico;
      cdsID_UNICO_ORIGINAL.AsString := P.id_unico_original;
      cdsNOSSO_NUMERO.AsString := P.nosso_numero;
      cdsNOSSO_NUMERO_ORIGINAL.AsString := P.nosso_numero_original;
      cdsBANCO_NUMERO.AsString := P.banco_numero;
      cdsTOKEN_FACILITADOR.AsString := P.token_facilitador;
      cdsVALOR.AsCurrency := StrToFloat(P.valor, FFS);
      cdsVALOR_LIQUIDO.AsCurrency := StrToFloat(P.valor_liquido, FFS);
      cdsDATA_VENCIMENTO.AsDateTime := StrToDate(P.data_vencimento, FFS);
      cdsDATA_PAGAMENTO.AsDateTime := StrToDate(P.data_pagamento, FFS);
      cdsDATA_CREDITO.AsDateTime := StrToDate(P.data_credito, FFS);
      cdsPAGADOR.AsString := P.pagador;
      cds.Post;
    end;
  finally
    cds.EnableControls;
  end;
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
  Result.nome_empresa := EditCredencial_RazaoSocial.Text;
  Result.cnpj := EditCredencial_CNPJ.Text;
  Result.ddd := EditCredencial_DDD.Text;
  Result.telefone := EditCredencial_Telefone.Text;
  Result.email := EditCredencial_Email.Text;
  Result.banco_repasse := EditCredencial_Banco.Text;
  Result.agencia_repasse := EditCredencial_Agencia.Text;
  Result.conta_repasse := EditCredencial_Conta.Text;
end;

function TFormPrincipal.NovoBoleto: TBoletoRequest;
begin
  Result := TBoletoRequest.Create;
  Result.vencimento := EditBoleto_Vencimento.Text;
  Result.valor := StrToFloat(EditBoleto_Valor.Text, FFS);
  Result.juros := StrToFloat(EditBoleto_Juros.Text, FFS);
  Result.multa := StrToFloat(EditBoleto_Multa.Text, FFS);
  Result.desconto := StrToFloat(EditBoleto_Desconto.Text, FFS);
  Result.nome_cliente := EditBoleto_NomeCliente.Text;
  Result.cpf_cliente := EditBoleto_CNPJCliente.Text;
  Result.endereco_cliente := EditBoleto_EnderecoCliente.Text;
  Result.numero_cliente := EditBoleto_NumeroCliente.Text;
  Result.complemento_cliente := EditBoleto_ComplementoCliente.Text;
  Result.bairro_cliente := EditBoleto_BairroCliente.Text;
  Result.cidade_cliente := EditBoleto_CidadeCliente.Text;
  Result.estado_cliente := EditBoleto_UFCliente.Text;
  Result.cep_cliente := EditBoleto_CEPCliente.Text;
  Result.logo_url := EditBoleto_Logo.Text;
  Result.texto := EditBoleto_Texto.Text;
  Result.grupo := '';
  Result.pedido_numero := EditBoleto_PedidoNumero.Text;
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
