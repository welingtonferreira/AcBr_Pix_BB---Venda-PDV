object frmConsultaPagamentos: TfrmConsultaPagamentos
  Left = 437
  Top = 174
  ClientHeight = 510
  ClientWidth = 801
  Color = 16510433
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poScreenCenter
  OnShow = FormShow
  TextHeight = 13
  object pnBackground: TPanel
    Left = 0
    Top = 0
    Width = 801
    Height = 510
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 797
    ExplicitHeight = 509
    object pgTestesPix: TPageControl
      Left = 0
      Top = 0
      Width = 801
      Height = 510
      ActivePage = tsConsultarPixRecebidos
      Align = alClient
      TabOrder = 0
      object tsConsultarPixRecebidos: TTabSheet
        Caption = 'ConsultarPixRecebidos'
        object pConsultarPixRecebidos: TPanel
          Left = 0
          Top = 0
          Width = 793
          Height = 128
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          ExplicitWidth = 789
          DesignSize = (
            793
            128)
          object lE2eid: TLabel
            Left = 8
            Top = 56
            Width = 157
            Height = 13
            Caption = 'Identificador da Transa'#231#227'o (TxId)'
            Visible = False
          end
          object lInicio: TLabel
            Left = 8
            Top = 8
            Width = 27
            Height = 13
            Caption = 'In'#237'cio'
          end
          object lFim: TLabel
            Left = 168
            Top = 8
            Width = 16
            Height = 13
            Caption = 'Fim'
          end
          object lCPFCPNJ: TLabel
            Left = 513
            Top = 56
            Width = 58
            Height = 13
            Anchors = [akTop, akRight]
            Caption = 'CPF / CNPJ'
            Visible = False
            ExplicitLeft = 328
          end
          object lPagina: TLabel
            Left = 680
            Top = 8
            Width = 33
            Height = 13
            Anchors = [akTop, akRight]
            Caption = 'P'#225'gina'
            ExplicitLeft = 495
          end
          object lPagina1: TLabel
            Left = 513
            Top = 5
            Width = 63
            Height = 13
            Anchors = [akTop, akRight]
            Caption = 'Itens por P'#225'g'
            ExplicitLeft = 328
          end
          object edtConsultarPixRecebidosTxId: TEdit
            Left = 8
            Top = 75
            Width = 482
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            TabOrder = 2
            Visible = False
            ExplicitWidth = 478
          end
          object btConsultarPixRecebidos: TBitBtn
            Left = 680
            Top = 72
            Width = 97
            Height = 26
            Anchors = [akTop, akRight]
            Caption = 'Consultar'
            TabOrder = 6
            OnClick = btConsultarPixRecebidosClick
            ExplicitLeft = 676
          end
          object dtConsultarPixRecebidosInicio: TDateTimePicker
            Left = 8
            Top = 24
            Width = 137
            Height = 23
            Date = 44568.000000000000000000
            Time = 44568.000000000000000000
            MaxDate = 2958465.999988426000000000
            MinDate = -53780.000000000000000000
            TabOrder = 0
          end
          object dtConsultarPixRecebidosFim: TDateTimePicker
            Left = 168
            Top = 24
            Width = 137
            Height = 23
            Date = 44568.000000000000000000
            Time = 44568.000000000000000000
            MaxDate = 2958465.999988426000000000
            MinDate = -53780.000000000000000000
            TabOrder = 1
          end
          object edtConsultarPixRecebidosCPFCNPJ: TEdit
            Left = 513
            Top = 75
            Width = 145
            Height = 21
            Anchors = [akTop, akRight]
            TabOrder = 3
            Visible = False
            ExplicitLeft = 509
          end
          object seConsultarPixRecebidosPagina: TSpinEdit
            Left = 680
            Top = 27
            Width = 97
            Height = 22
            Anchors = [akTop, akRight]
            MaxValue = 9999
            MinValue = 0
            TabOrder = 5
            Value = 1
            ExplicitLeft = 676
          end
          object seConsultarPixRecebidosItensPagina: TSpinEdit
            Left = 513
            Top = 24
            Width = 145
            Height = 22
            Anchors = [akTop, akRight]
            MaxValue = 100
            MinValue = 0
            TabOrder = 4
            Value = 10
            ExplicitLeft = 509
          end
        end
        object mConsultarPixRecebidos: TMemo
          Left = 0
          Top = 128
          Width = 793
          Height = 325
          Align = alClient
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Noto Sans'
          Font.Style = []
          ParentFont = False
          ScrollBars = ssBoth
          TabOrder = 1
          ExplicitWidth = 789
          ExplicitHeight = 324
        end
        object Panel4: TPanel
          Left = 0
          Top = 453
          Width = 793
          Height = 29
          Align = alBottom
          TabOrder = 2
          ExplicitTop = 452
          ExplicitWidth = 789
          DesignSize = (
            793
            29)
          object btLimparConsultarPixRecebidos: TBitBtn
            Left = 696
            Top = 1
            Width = 97
            Height = 26
            Anchors = [akTop]
            Caption = 'Limpar'
            TabOrder = 0
            OnClick = btLimparConsultarPixRecebidosClick
            ExplicitLeft = 692
          end
        end
      end
    end
  end
  object ACBrPixCD1: TACBrPixCD
    Recebedor.UF = 'SP'
    Recebedor.CEP = '18272230'
    Recebedor.CodCategoriaComerciante = 0
    DadosAutomacao.NomeSoftwareHouse = 'Projeto ACBr'
    DadosAutomacao.CNPJSoftwareHouse = '18760540000139'
    DadosAutomacao.NomeAplicacao = 'ACBrPIXCDTeste'
    DadosAutomacao.VersaoAplicacao = '1.0'
    PSP = ACBrPSPBancoDoBrasil1
    Left = 232
    Top = 451
  end
  object ACBrPSPBancoDoBrasil1: TACBrPSPBancoDoBrasil
    ACBrPixCD = ACBrPixCD1
    Scopes = [scCobWrite, scCobRead, scPixWrite, scPixRead]
    BBAPIVersao = apiVersao2
    Left = 312
    Top = 456
  end
end
