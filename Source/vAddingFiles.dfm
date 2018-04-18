inherited ViewAddingFiles: TViewAddingFiles
  Caption = 'ViewAddingFiles'
  ClientHeight = 331
  ClientWidth = 559
  OnShow = FormShow
  ExplicitWidth = 575
  ExplicitHeight = 369
  PixelsPerInch = 96
  TextHeight = 13
  object vstFiles: TVirtualStringTree
    Left = 8
    Top = 64
    Width = 201
    Height = 259
    Header.AutoSizeIndex = 0
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -11
    Header.Font.Name = 'Tahoma'
    Header.Font.Style = []
    Header.MainColumn = -1
    TabOrder = 0
    OnGetText = vstFilesGetText
    OnGetNodeDataSize = vstFilesGetNodeDataSize
    Columns = <>
  end
end
