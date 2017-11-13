object FormPrincipal: TFormPrincipal
  Left = 0
  Top = 0
  Caption = 'PJBank - Exemplo'
  ClientHeight = 528
  ClientWidth = 941
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  DesignSize = (
    941
    528)
  PixelsPerInch = 96
  TextHeight = 13
  object ButtonCredenciar: TButton
    Left = 8
    Top = 8
    Width = 393
    Height = 25
    Caption = '1'#186' - Credenciar uma conta banc'#225'ria para recebimento com boletos'
    TabOrder = 0
    OnClick = ButtonCredenciarClick
  end
  object MemoLog: TMemo
    Left = 8
    Top = 132
    Width = 925
    Height = 388
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Consolas'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object ButtonEmitirBoleto: TButton
    Left = 8
    Top = 39
    Width = 193
    Height = 25
    Caption = '2'#186' - Emitir Boleto'
    Enabled = False
    TabOrder = 2
    OnClick = ButtonEmitirBoletoClick
  end
  object ButtonImprimirBoleto: TButton
    Left = 207
    Top = 39
    Width = 194
    Height = 25
    Caption = '3'#186' - Imprimir Boleto'
    Enabled = False
    TabOrder = 3
    OnClick = ButtonImprimirBoletoClick
  end
  object MemoEmpresa: TMemo
    Left = 407
    Top = 10
    Width = 542
    Height = 116
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Consolas'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 4
  end
  object ButtonImprimirTodosBoletosEmitidos: TButton
    Left = 8
    Top = 70
    Width = 393
    Height = 25
    Caption = '4'#186' - Imprimir Todos os Boletos Emitidos Recentemente'
    Enabled = False
    TabOrder = 5
    OnClick = ButtonImprimirTodosBoletosEmitidosClick
  end
  object ButtonObterExtratoPagamento: TButton
    Left = 8
    Top = 101
    Width = 393
    Height = 25
    Caption = '5'#186' - Obter Extrato Pagamento'
    TabOrder = 6
    OnClick = ButtonObterExtratoPagamentoClick
  end
end
