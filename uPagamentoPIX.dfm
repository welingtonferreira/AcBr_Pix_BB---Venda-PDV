object frmPagamentoPIX: TfrmPagamentoPIX
  Left = 394
  Top = 158
  AutoSize = True
  ClientHeight = 492
  ClientWidth = 589
  Color = 16510433
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  TextHeight = 13
  object pnBody: TPanel
    Left = 0
    Top = 0
    Width = 589
    Height = 427
    Align = alClient
    AutoSize = True
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 64
    ExplicitWidth = 585
    object pnConsultarErro: TPanel
      Left = 0
      Top = 0
      Width = 589
      Height = 427
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      Visible = False
      ExplicitWidth = 585
      object btTentarNovamente: TSpeedButton
        Left = 30
        Top = 80
        Width = 529
        Height = 85
        Action = aTentarNovamente
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 5197647
        Font.Height = -20
        Font.Name = 'Noto Sans'
        Font.Style = [fsBold]
        ParentFont = False
        Spacing = 15
      end
      object bt: TSpeedButton
        Left = 30
        Top = 215
        Width = 529
        Height = 85
        Action = aCancelarCobranca
        Flat = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 5197647
        Font.Height = -20
        Font.Name = 'Noto Sans'
        Font.Style = [fsBold]
        ParentFont = False
        Spacing = 15
      end
    end
    object pnCobrancaInfo: TPanel
      Left = 0
      Top = 0
      Width = 585
      Height = 427
      BevelOuter = bvNone
      TabOrder = 0
      object imQRCodePIX: TImage
        Left = 0
        Top = 0
        Width = 585
        Height = 338
        Align = alClient
        Center = True
        Constraints.MinHeight = 280
        Proportional = True
        Stretch = True
        ExplicitTop = -6
        ExplicitWidth = 589
        ExplicitHeight = 339
      end
      object pnCopiaECola: TPanel
        Left = 0
        Top = 338
        Width = 585
        Height = 89
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 0
        DesignSize = (
          585
          89)
        object lbCopiaECola: TLabel
          Left = 25
          Top = 17
          Width = 88
          Height = 14
          Anchors = [akLeft, akBottom]
          Caption = 'PIX Copia e Cola'
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
        end
        object btCopiaECola: TSpeedButton
          Left = 536
          Top = 32
          Width = 27
          Height = 27
          Flat = True
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000064000000640000000000000000000000000000000000
            0000000000000000000000000016000000570000005B0000005B0000005B0000
            005B0000005B0000005B00000058000000370000000000000000000000000000
            0000000000000000000B000000D4000000E8000000DC000000DC000000DC0000
            00DC000000DC000000DC000000E8000000FF0000001800000000000000000000
            0000000000000000001C000000E3000000550000000000000000000000000000
            0000000000000000000000000058000000FC0000002300000000000000000000
            0000000000000000001C000000E3000000550000000000000000000000000000
            0000000000000000000000000058000000FC0000002300000000000000000000
            00370000003D0000001C000000E3000000550000000000000000000000000000
            0000000000000000000000000058000000FC0000002300000000000000000000
            009C000000AF0000001C000000E3000000550000000000000000000000000000
            0000000000000000000000000058000000FC0000002300000000000000000000
            009C000000AF0000001C000000E3000000550000000000000000000000000000
            0000000000000000000000000058000000FC0000002300000000000000000000
            009C000000AF0000001C000000E3000000550000000000000000000000000000
            0000000000000000000000000058000000FC0000002300000000000000000000
            009C000000AF0000001C000000E3000000550000000000000000000000000000
            0000000000000000000000000058000000FC0000002300000000000000000000
            009C000000AF0000001C000000E3000000550000000000000000000000000000
            0000000000000000000000000058000000FC0000002300000000000000000000
            009C000000AF0000001C000000E3000000550000000000000000000000000000
            0000000000000000000000000058000000FC0000002300000000000000000000
            009C000000AF00000010000000D5000000ED000000E4000000E4000000E40000
            00E4000000E4000000E4000000EE000000FD0000001B00000000000000000000
            009C000000AF0000000000000044000000A2000000A6000000A6000000A60000
            00A6000000A6000000A6000000A3000000770000000300000000000000000000
            009B000000BA0000002300000023000000230000002300000023000000230000
            0023000000230000000000000000000000000000000000000000000000000000
            0058000000F4000000FA000000FA000000FA000000FA000000FA000000FA0000
            00FA000000FA0000000000000000000000000000000000000000000000000000
            00030000004E0000005B0000005B0000005B0000005B0000005B0000005B0000
            005B0000005B0000000000000000000000000000000000000000}
          OnClick = btCopiaEColaClick
        end
        object edCopiaECola: TEdit
          Left = 25
          Top = 32
          Width = 511
          Height = 27
          Anchors = [akLeft, akBottom]
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -17
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
      end
      object pbAguardarPagto: TProgressBar
        Left = 60
        Top = 339
        Width = 469
        Height = 4
        TabOrder = 1
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 427
    Width = 589
    Height = 65
    Align = alBottom
    Caption = 'AGUARDANDO PAGAMENTO...'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Noto Sans'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    ExplicitTop = 363
  end
  object ACBrPixCD1: TACBrPixCD
    Recebedor.CodCategoriaComerciante = 0
    PSP = ACBrPSPBancoDoBrasil1
    ArqLOG = '_Log.txt'
    NivelLog = 4
    Left = 40
    Top = 80
  end
  object ACBrPSPBancoDoBrasil1: TACBrPSPBancoDoBrasil
    ACBrPixCD = ACBrPixCD1
    Scopes = [scCobWrite, scCobRead, scPixWrite, scPixRead]
    BBAPIVersao = apiVersao2
    Left = 400
    Top = 272
  end
  object alPagamentoPIX: TActionList
    Left = 48
    Top = 160
    object aFechar: TAction
      ShortCut = 27
      OnExecute = aFecharExecute
    end
    object aTentarNovamente: TAction
      Caption = 'F5 - TENTAR NOVAMENTE'
      ImageIndex = 4
      ShortCut = 116
      OnExecute = aTentarNovamenteExecute
    end
    object aCancelarCobranca: TAction
      Caption = 'F4 - CANCELAR COBRAN'#199'A'
      ImageIndex = 5
      ShortCut = 115
      OnExecute = aCancelarCobrancaExecute
    end
  end
  object tmConsultarCobranca: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = tmConsultarCobrancaTimer
    Left = 152
    Top = 160
  end
end
