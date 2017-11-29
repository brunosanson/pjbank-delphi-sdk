program Exemplo;

uses
  Vcl.Forms,
  Principal in 'Principal.pas' {FormPrincipal},
  PJBank.Consts in '..\source\PJBank.Consts.pas',
  PJBank.Empresa.Request in '..\source\boleto_bancario\credenciamento\PJBank.Empresa.Request.pas',
  PJBank.Empresa.Response in '..\source\boleto_bancario\credenciamento\PJBank.Empresa.Response.pas',
  PJBank.Boleto.Request in '..\source\boleto_bancario\boleto\PJBank.Boleto.Request.pas',
  PJBank.Boleto.Response in '..\source\boleto_bancario\boleto\PJBank.Boleto.Response.pas',
  PJBank.Boleto.Impressao.Request in '..\source\boleto_bancario\boleto\PJBank.Boleto.Impressao.Request.pas',
  PJBank.Boleto.Impressao.Response in '..\source\boleto_bancario\boleto\PJBank.Boleto.Impressao.Response.pas',
  PJBank.Boleto.Extrato.Response in '..\source\boleto_bancario\boleto\PJBank.Boleto.Extrato.Response.pas',
  RestClient in 'RestClient.pas',
  StringUtils in 'StringUtils.pas',
  RestClientConfig in 'RestClientConfig.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.Run;
end.
