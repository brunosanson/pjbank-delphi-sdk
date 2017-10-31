unit PJBank.Consts;

interface

const
{$IFDEF DEBUG}
  PJBank_URLAPI_Sandbox = 'https://sandbox.pjbank.com.br'; // Debug
{$ELSE}
  PJBank_URLAPI_Producao = 'https://api.pjbank.com.br'; // Produ��o
{$ENDIF}

const
  PJBank_Endpoint_CredenciarConta = '/recebimentos';
  PJBank_Endpoint_EmitirBoleto = '/recebimentos/%s/transacoes';
  PJBank_Endpoint_ImpressaoBoleto = '/recebimentos/%s/transacoes/lotes';

implementation

end.