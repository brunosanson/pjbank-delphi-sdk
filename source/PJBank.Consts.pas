unit PJBank.Consts;

interface

const
{$IFDEF DEBUG}
  PJBank_URLAPI_Sandbox = 'https://sandbox.pjbank.com.br'; // Debug
{$ELSE}
  PJBank_URLAPI_Producao = 'https://api.pjbank.com.br'; // Produção
{$ENDIF}

const
  PJBank_Endpoint_CredenciarConta = '/recebimentos';
  PJBank_Endpoint_EmitirBoleto = '/recebimentos/{{credencial-boleto}}/transacoes';
  PJBank_Endpoint_ImpressaoBoleto = '/recebimentos/{{credencial-boleto}}/transacoes/lotes';

implementation

end.
