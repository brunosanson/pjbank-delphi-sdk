program Exemplo;

uses
  Vcl.Forms,
  Principal in 'Principal.pas' {FormPrincipal},
  PJBank.Boleto.Request in '..\source\boleto_bancario\boleto\PJBank.Boleto.Request.pas',
  PJBank.Boleto.Response in '..\source\boleto_bancario\boleto\PJBank.Boleto.Response.pas',
  PJBank.Consts in '..\source\PJBank.Consts.pas',
  PJBank.Empresa.Request in '..\source\boleto_bancario\credenciamento\PJBank.Empresa.Request.pas',
  PJBank.Empresa.Response in '..\source\boleto_bancario\credenciamento\PJBank.Empresa.Response.pas',
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
