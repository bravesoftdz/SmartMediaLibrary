inherited ViewMain: TViewMain
  Caption = 'Smart Media Library'
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object vstLibrary: TVirtualStringTree
    Left = 0
    Top = 0
    Width = 281
    Height = 290
    Align = alLeft
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
