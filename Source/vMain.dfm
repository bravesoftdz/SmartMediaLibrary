inherited ViewMain: TViewMain
  Caption = 'Smart Media Library'
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pgcLibrary: TPageControl
    Left = 0
    Top = 0
    Width = 313
    Height = 290
    ActivePage = tsAudioLib
    Align = alLeft
    TabOrder = 0
    object tsVideoLib: TTabSheet
      Caption = 'tsVideoLib'
      ExplicitWidth = 225
      ExplicitHeight = 246
    end
    object tsAudioLib: TTabSheet
      Caption = 'tsAudioLib'
      ImageIndex = 1
      ExplicitLeft = -60
      ExplicitWidth = 225
      ExplicitHeight = 246
      object vstLibrary: TVirtualStringTree
        Left = 0
        Top = 0
        Width = 305
        Height = 262
        Align = alClient
        Header.AutoSizeIndex = 0
        Header.Font.Charset = DEFAULT_CHARSET
        Header.Font.Color = clWindowText
        Header.Font.Height = -11
        Header.Font.Name = 'Tahoma'
        Header.Font.Style = []
        Header.MainColumn = -1
        TabOrder = 0
        OnGetText = vstLibraryGetText
        ExplicitLeft = -56
        ExplicitTop = -44
        ExplicitWidth = 281
        ExplicitHeight = 290
        Columns = <>
      end
    end
  end
end
