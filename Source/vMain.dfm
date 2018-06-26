inherited ViewMain: TViewMain
  Caption = 'Smart Media Library'
  ClientHeight = 352
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  ExplicitHeight = 390
  PixelsPerInch = 96
  TextHeight = 13
  object pgcLibrary: TPageControl
    Left = 0
    Top = 0
    Width = 313
    Height = 352
    ActivePage = tsAudioLib
    Align = alLeft
    TabOrder = 0
    ExplicitHeight = 290
    object tsVideoLib: TTabSheet
      Caption = 'tsVideoLib'
      ExplicitHeight = 262
    end
    object tsAudioLib: TTabSheet
      Caption = 'tsAudioLib'
      ImageIndex = 1
      ExplicitHeight = 262
      object vstLibrary: TVirtualStringTree
        Left = 0
        Top = 0
        Width = 305
        Height = 169
        Align = alTop
        Header.AutoSizeIndex = 0
        Header.Font.Charset = DEFAULT_CHARSET
        Header.Font.Color = clWindowText
        Header.Font.Height = -11
        Header.Font.Name = 'Tahoma'
        Header.Font.Style = []
        Header.MainColumn = -1
        TabOrder = 0
        OnGetText = vstLibraryGetText
        Columns = <>
      end
    end
  end
  object btnDBService: TBitBtn
    Left = 471
    Top = 8
    Width = 75
    Height = 25
    Caption = 'btnDBService'
    TabOrder = 1
    OnClick = btnDBServiceClick
  end
end
