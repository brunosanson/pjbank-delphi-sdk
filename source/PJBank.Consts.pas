unit PJBank.Consts;

interface

const
{$IFDEF DEBUG}
  PJBank_URLAPI = 'https://sandbox.pjbank.com.br'; // Debug
{$ELSE}
  PJBank_URLAPI = 'https://api.pjbank.com.br'; // Produção
{$ENDIF}

const
  PJBank_Endpoint_CredenciarConta = '/recebimentos';
  PJBank_Endpoint_EmitirBoleto = '/recebimentos/%s/transacoes';
  PJBank_Endpoint_ImpressaoBoleto = '/recebimentos/%s/transacoes/lotes';

implementation

end.
