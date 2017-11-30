object FormPrincipal: TFormPrincipal
  Left = 0
  Top = 0
  Caption = 'PJBank - Exemplo'
  ClientHeight = 590
  ClientWidth = 751
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  DesignSize = (
    751
    590)
  PixelsPerInch = 96
  TextHeight = 13
  object MemoLog: TMemo
    Left = 8
    Top = 415
    Width = 735
    Height = 167
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Consolas'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object PageControl: TPageControl
    Left = 8
    Top = 8
    Width = 735
    Height = 401
    ActivePage = tabEmitirBoleto
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
    object tbaCredenciar: TTabSheet
      Caption = 'Credenciar'
      DesignSize = (
        727
        373)
      object GroupBox3: TGroupBox
        Left = 3
        Top = 3
        Width = 513
        Height = 193
        Caption = 'Dados da Empresa'
        TabOrder = 0
        object EditCredencial_RazaoSocial: TLabeledEdit
          Left = 11
          Top = 40
          Width = 486
          Height = 21
          EditLabel.Width = 60
          EditLabel.Height = 13
          EditLabel.Caption = 'Raz'#227'o Social'
          TabOrder = 0
          Text = 'Empresa do seu cliente'
        end
        object EditCredencial_CNPJ: TLabeledEdit
          Left = 11
          Top = 80
          Width = 486
          Height = 21
          EditLabel.Width = 25
          EditLabel.Height = 13
          EditLabel.Caption = 'CNPJ'
          TabOrder = 1
          Text = '93764999000126'
        end
        object EditCredencial_DDD: TLabeledEdit
          Left = 11
          Top = 120
          Width = 22
          Height = 21
          EditLabel.Width = 21
          EditLabel.Height = 13
          EditLabel.Caption = 'DDD'
          TabOrder = 2
          Text = '19'
        end
        object EditCredencial_Telefone: TLabeledEdit
          Left = 39
          Top = 120
          Width = 78
          Height = 21
          EditLabel.Width = 24
          EditLabel.Height = 13
          EditLabel.Caption = 'Fone'
          TabOrder = 3
          Text = '12345678'
        end
        object EditCredencial_Email: TLabeledEdit
          Left = 11
          Top = 160
          Width = 486
          Height = 21
          EditLabel.Width = 28
          EditLabel.Height = 13
          EditLabel.Caption = 'E-mail'
          TabOrder = 4
          Text = 'contato@cliente.com.br'
        end
      end
      object GroupBox4: TGroupBox
        Left = 522
        Top = 3
        Width = 199
        Height = 193
        Caption = 'Repasse do Dinheiro'
        TabOrder = 1
        object EditCredencial_Banco: TLabeledEdit
          Left = 11
          Top = 40
          Width = 174
          Height = 21
          EditLabel.Width = 29
          EditLabel.Height = 13
          EditLabel.Caption = 'Banco'
          TabOrder = 0
          Text = '033'
        end
        object EditCredencial_Agencia: TLabeledEdit
          Left = 11
          Top = 80
          Width = 174
          Height = 21
          EditLabel.Width = 82
          EditLabel.Height = 13
          EditLabel.Caption = 'Ag'#234'ncia Repasse'
          TabOrder = 1
          Text = '1234'
        end
        object EditCredencial_Conta: TLabeledEdit
          Left = 11
          Top = 120
          Width = 174
          Height = 21
          EditLabel.Width = 73
          EditLabel.Height = 13
          EditLabel.Caption = 'Conta Repasse'
          TabOrder = 2
          Text = '123456789-0'
        end
        object ButtonCredenciar: TButton
          Left = 11
          Top = 160
          Width = 126
          Height = 25
          Caption = 'Credenciar Empresa'
          TabOrder = 3
          OnClick = ButtonCredenciarClick
        end
      end
      object GroupBox5: TGroupBox
        Left = 3
        Top = 202
        Width = 718
        Height = 159
        Anchors = [akLeft, akTop, akBottom]
        Caption = 'Dados de Credenciamento'
        TabOrder = 2
        DesignSize = (
          718
          159)
        object MemoEmpresa: TMemo
          Left = 11
          Top = 24
          Width = 693
          Height = 121
          Anchors = [akLeft, akTop, akBottom]
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Consolas'
          Font.Style = []
          ParentFont = False
          ScrollBars = ssVertical
          TabOrder = 0
        end
      end
    end
    object tabEmitirBoleto: TTabSheet
      Caption = 'Emitir Boleto'
      ImageIndex = 1
      DesignSize = (
        727
        373)
      object GroupBox1: TGroupBox
        Left = 3
        Top = 3
        Width = 465
        Height = 201
        Caption = 'Dados do Pagador'
        TabOrder = 0
        object EditBoleto_NomeCliente: TLabeledEdit
          Left = 16
          Top = 36
          Width = 217
          Height = 21
          EditLabel.Width = 33
          EditLabel.Height = 13
          EditLabel.BiDiMode = bdLeftToRight
          EditLabel.Caption = 'Cliente'
          EditLabel.ParentBiDiMode = False
          TabOrder = 0
          Text = 'Raz'#227'o Social do Cliente'
        end
        object EditBoleto_EnderecoCliente: TLabeledEdit
          Left = 16
          Top = 76
          Width = 217
          Height = 21
          EditLabel.Width = 45
          EditLabel.Height = 13
          EditLabel.BiDiMode = bdLeftToRight
          EditLabel.Caption = 'Endere'#231'o'
          EditLabel.ParentBiDiMode = False
          TabOrder = 1
          Text = 'Endere'#231'o do Cliente'
        end
        object EditBoleto_ComplementoCliente: TLabeledEdit
          Left = 16
          Top = 116
          Width = 217
          Height = 21
          EditLabel.Width = 65
          EditLabel.Height = 13
          EditLabel.BiDiMode = bdLeftToRight
          EditLabel.Caption = 'Complemento'
          EditLabel.ParentBiDiMode = False
          TabOrder = 2
          Text = 'Bloco 1 - Apartamento 2'
        end
        object EditBoleto_CidadeCliente: TLabeledEdit
          Left = 16
          Top = 161
          Width = 217
          Height = 21
          EditLabel.Width = 33
          EditLabel.Height = 13
          EditLabel.BiDiMode = bdLeftToRight
          EditLabel.Caption = 'Cidade'
          EditLabel.ParentBiDiMode = False
          TabOrder = 3
          Text = 'Campinas'
        end
        object EditBoleto_CNPJCliente: TLabeledEdit
          Left = 239
          Top = 36
          Width = 210
          Height = 21
          EditLabel.Width = 54
          EditLabel.Height = 13
          EditLabel.BiDiMode = bdLeftToRight
          EditLabel.Caption = 'CNPJ / CPF'
          EditLabel.ParentBiDiMode = False
          TabOrder = 4
          Text = '07197852000160'
        end
        object EditBoleto_NumeroCliente: TLabeledEdit
          Left = 239
          Top = 76
          Width = 210
          Height = 21
          EditLabel.Width = 37
          EditLabel.Height = 13
          EditLabel.BiDiMode = bdLeftToRight
          EditLabel.Caption = 'N'#250'mero'
          EditLabel.ParentBiDiMode = False
          TabOrder = 5
          Text = '12345'
        end
        object EditBoleto_BairroCliente: TLabeledEdit
          Left = 239
          Top = 116
          Width = 210
          Height = 21
          EditLabel.Width = 28
          EditLabel.Height = 13
          EditLabel.BiDiMode = bdLeftToRight
          EditLabel.Caption = 'Bairro'
          EditLabel.ParentBiDiMode = False
          TabOrder = 6
          Text = 'Bairro'
        end
        object EditBoleto_UFCliente: TLabeledEdit
          Left = 239
          Top = 161
          Width = 82
          Height = 21
          EditLabel.Width = 13
          EditLabel.Height = 13
          EditLabel.BiDiMode = bdLeftToRight
          EditLabel.Caption = 'UF'
          EditLabel.ParentBiDiMode = False
          TabOrder = 7
          Text = 'SP'
        end
        object EditBoleto_CEPCliente: TLabeledEdit
          Left = 327
          Top = 161
          Width = 122
          Height = 21
          EditLabel.Width = 19
          EditLabel.Height = 13
          EditLabel.BiDiMode = bdLeftToRight
          EditLabel.Caption = 'CEP'
          EditLabel.ParentBiDiMode = False
          TabOrder = 8
          Text = '12345123'
        end
      end
      object GroupBox2: TGroupBox
        Left = 474
        Top = 3
        Width = 247
        Height = 201
        Caption = 'Dados de Cobran'#231'a'
        TabOrder = 1
        object EditBoleto_Vencimento: TLabeledEdit
          Left = 16
          Top = 36
          Width = 217
          Height = 21
          EditLabel.Width = 55
          EditLabel.Height = 13
          EditLabel.BiDiMode = bdLeftToRight
          EditLabel.Caption = 'Vencimento'
          EditLabel.ParentBiDiMode = False
          TabOrder = 0
          Text = '01/28/2018'
        end
        object EditBoleto_Valor: TLabeledEdit
          Left = 16
          Top = 76
          Width = 217
          Height = 21
          EditLabel.Width = 24
          EditLabel.Height = 13
          EditLabel.BiDiMode = bdLeftToRight
          EditLabel.Caption = 'Valor'
          EditLabel.ParentBiDiMode = False
          TabOrder = 1
          Text = '100.98'
        end
        object EditBoleto_Multa: TLabeledEdit
          Left = 16
          Top = 116
          Width = 105
          Height = 21
          EditLabel.Width = 26
          EditLabel.Height = 13
          EditLabel.BiDiMode = bdLeftToRight
          EditLabel.Caption = 'Multa'
          EditLabel.ParentBiDiMode = False
          TabOrder = 2
          Text = '2'
        end
        object EditBoleto_Juros: TLabeledEdit
          Left = 127
          Top = 116
          Width = 106
          Height = 21
          EditLabel.Width = 26
          EditLabel.Height = 13
          EditLabel.BiDiMode = bdLeftToRight
          EditLabel.Caption = 'Juros'
          EditLabel.ParentBiDiMode = False
          TabOrder = 3
          Text = '1'
        end
        object EditBoleto_Desconto: TLabeledEdit
          Left = 16
          Top = 161
          Width = 217
          Height = 21
          EditLabel.Width = 45
          EditLabel.Height = 13
          EditLabel.BiDiMode = bdLeftToRight
          EditLabel.Caption = 'Desconto'
          EditLabel.ParentBiDiMode = False
          TabOrder = 4
          Text = '0'
        end
      end
      object GroupBox6: TGroupBox
        Left = 3
        Top = 210
        Width = 718
        Height = 119
        Anchors = [akLeft, akTop, akBottom]
        Caption = 'Dados da Venda'
        TabOrder = 2
        object EditBoleto_PedidoNumero: TLabeledEdit
          Left = 16
          Top = 44
          Width = 217
          Height = 21
          Hint = 'Mantenha o mesmo n'#250'mero para edi'#231#227'o do boleto.'
          EditLabel.Width = 72
          EditLabel.Height = 13
          EditLabel.Hint = 'Mantenha o mesmo n'#250'mero para edi'#231#227'o do boleto.'
          EditLabel.BiDiMode = bdLeftToRight
          EditLabel.Caption = 'Pedido N'#250'mero'
          EditLabel.ParentBiDiMode = False
          TabOrder = 0
          Text = '123'
        end
        object EditBoleto_Texto: TLabeledEdit
          Left = 16
          Top = 89
          Width = 688
          Height = 21
          EditLabel.Width = 28
          EditLabel.Height = 13
          EditLabel.BiDiMode = bdLeftToRight
          EditLabel.Caption = 'Texto'
          EditLabel.ParentBiDiMode = False
          TabOrder = 1
          Text = 'Descri'#231#227'o dos produtos ou servi'#231'os'
        end
        object EditBoleto_Logo: TLabeledEdit
          Left = 239
          Top = 44
          Width = 465
          Height = 21
          EditLabel.Width = 45
          EditLabel.Height = 13
          EditLabel.BiDiMode = bdLeftToRight
          EditLabel.Caption = 'URL Logo'
          EditLabel.ParentBiDiMode = False
          TabOrder = 2
          Text = 'https://wallpapercave.com/wp/wp2239995.jpg'
        end
      end
      object ButtonEmitirBoleto: TButton
        Left = 3
        Top = 343
        Width = 110
        Height = 25
        Caption = 'Emitir Boleto'
        Enabled = False
        TabOrder = 3
        OnClick = ButtonEmitirBoletoClick
      end
      object ButtonImprimirBoleto: TButton
        Left = 451
        Top = 343
        Width = 110
        Height = 25
        Caption = 'Imprimir Boleto'
        Enabled = False
        TabOrder = 4
        OnClick = ButtonImprimirBoletoClick
      end
      object ButtonImprimirTodosBoletosEmitidos: TButton
        Left = 567
        Top = 343
        Width = 154
        Height = 25
        Caption = 'Imprimir Todos os Boletos'
        Enabled = False
        TabOrder = 5
        OnClick = ButtonImprimirTodosBoletosEmitidosClick
      end
    end
    object tabExtratoPagamentoBoleto: TTabSheet
      Caption = 'Consultar Extrato'
      ImageIndex = 2
      DesignSize = (
        727
        373)
      object Label1: TLabel
        Left = 3
        Top = 18
        Width = 40
        Height = 13
        Caption = 'Per'#237'odo:'
      end
      object DBGrid1: TDBGrid
        Left = 3
        Top = 49
        Width = 721
        Height = 321
        Anchors = [akLeft, akTop, akRight, akBottom]
        DataSource = ds
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
      object ButtonObterExtratoPagamento: TButton
        Left = 223
        Top = 13
        Width = 174
        Height = 25
        Caption = 'Consultar Extrato Pagamento'
        TabOrder = 1
        OnClick = ButtonObterExtratoPagamentoClick
      end
      object EditExtrato_DataFim: TDateTimePicker
        Left = 136
        Top = 15
        Width = 81
        Height = 21
        Date = 43069.556322939820000000
        Time = 43069.556322939820000000
        TabOrder = 2
      end
      object EditExtrato_DataInicio: TDateTimePicker
        Left = 49
        Top = 15
        Width = 81
        Height = 21
        Date = 43040.556322939820000000
        Time = 43040.556322939820000000
        TabOrder = 3
      end
    end
  end
  object ds: TDataSource
    DataSet = cds
    Left = 896
    Top = 16
  end
  object cds: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 800
    Top = 16
    object cdsPAGADOR: TStringField
      DisplayLabel = 'Pagador'
      FieldName = 'PAGADOR'
      Size = 30
    end
    object cdsVALOR: TCurrencyField
      DisplayLabel = 'Valor'
      FieldName = 'VALOR'
    end
    object cdsVALOR_LIQUIDO: TCurrencyField
      DisplayLabel = 'Valor Liquido'
      FieldName = 'VALOR_LIQUIDO'
    end
    object cdsDATA_VENCIMENTO: TDateField
      DisplayLabel = 'Vencimento'
      FieldName = 'DATA_VENCIMENTO'
    end
    object cdsDATA_PAGAMENTO: TDateField
      DisplayLabel = 'Pagamento'
      FieldName = 'DATA_PAGAMENTO'
    end
    object cdsDATA_CREDITO: TDateField
      DisplayLabel = 'Cr'#233'dido'
      FieldName = 'DATA_CREDITO'
    end
    object cdsNOSSO_NUMERO: TStringField
      DisplayLabel = 'Nosso N'#250'mero'
      DisplayWidth = 10
      FieldName = 'NOSSO_NUMERO'
      Size = 15
    end
    object cdsBANCO_NUMERO: TStringField
      DisplayLabel = 'Banco N'#250'mero'
      DisplayWidth = 12
      FieldName = 'BANCO_NUMERO'
      Size = 15
    end
    object cdsID_UNICO: TStringField
      DisplayLabel = 'Id '#218'nico'
      DisplayWidth = 36
      FieldName = 'ID_UNICO'
      Size = 38
    end
    object cdsTOKEN_FACILITADOR: TStringField
      DisplayLabel = 'Token Facilitador'
      FieldName = 'TOKEN_FACILITADOR'
      Size = 38
    end
    object cdsNOSSO_NUMERO_ORIGINAL: TStringField
      DisplayLabel = 'Nosso N'#250'mero Original'
      DisplayWidth = 10
      FieldName = 'NOSSO_NUMERO_ORIGINAL'
      Size = 15
    end
    object cdsID_UNICO_ORIGINAL: TStringField
      DisplayLabel = 'Id '#218'nico Original'
      DisplayWidth = 36
      FieldName = 'ID_UNICO_ORIGINAL'
      Size = 38
    end
  end
end
