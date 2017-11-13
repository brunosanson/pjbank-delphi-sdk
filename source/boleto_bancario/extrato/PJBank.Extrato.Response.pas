unit PJBank.Extrato.Response;

interface

uses
  System.Generics.Collections;

type
  TPagamento = class
  public
    tid: string;
    valor: string;
    valor_liquido: string;
    pedido_numero: string;
    autorizada: string;
    cancelada: string;
    parcelas: string;
    data_transacao: string;
    data_cancelamento: string;
    motivo_cancelamento: string;
    previsao_credito: string;
    convenio_proprio: string;
    tid_conciliacao: string;
    msg_erro: string;
    msg_erro_estorno: string;
  end;

  TExtrato = TList<TPagamento>;

implementation

end.
