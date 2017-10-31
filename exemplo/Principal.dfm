object FormPrincipal: TFormPrincipal
  Left = 0
  Top = 0
  Caption = 'PJBank - Exemplo'
  ClientHeight = 669
  ClientWidth = 957
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  WindowState = wsMaximized
  DesignSize = (
    957
    669)
  PixelsPerInch = 96
  TextHeight = 13
  object LabelLog: TLabel
    Left = 8
    Top = 216
    Width = 21
    Height = 13
    Caption = 'Log:'
  end
  object ButtonCredenciar: TButton
    Left = 8
    Top = 8
    Width = 393
    Height = 25
    Caption = 'Credenciar uma conta banc'#225'ria para recebimento com boletos'
    TabOrder = 0
    OnClick = ButtonCredenciarClick
  end
  object MemoLog: TMemo
    Left = 8
    Top = 240
    Width = 941
    Height = 421
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object ButtonEmitirBoleto: TButton
    Left = 8
    Top = 135
    Width = 393
    Height = 25
    Caption = 'Emitir Boleto'
    Enabled = False
    TabOrder = 2
  end
  object Button1: TButton
    Left = 8
    Top = 166
    Width = 393
    Height = 25
    Caption = 'Imprimir Boleto'
    Enabled = False
    TabOrder = 3
  end
  object MemoEmpresa: TMemo
    Left = 8
    Top = 39
    Width = 393
    Height = 82
    Enabled = False
    ScrollBars = ssVertical
    TabOrder = 4
  end
end
