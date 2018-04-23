inherited ViewAddingFiles: TViewAddingFiles
  Caption = 'ViewAddingFiles'
  ClientHeight = 374
  ClientWidth = 565
  OnCreate = FormCreate
  OnShow = FormShow
  ExplicitWidth = 581
  ExplicitHeight = 412
  PixelsPerInch = 96
  TextHeight = 13
  object splVertical: TSplitter
    Left = 283
    Top = 0
    Height = 333
    Align = alRight
    Color = clHighlight
    ParentColor = False
    ExplicitLeft = 343
    ExplicitTop = -6
  end
  object pnlButtons: TPanel
    Left = 0
    Top = 333
    Width = 565
    Height = 41
    Align = alBottom
    Caption = 'pnlButtons'
    TabOrder = 0
    ExplicitLeft = 256
    ExplicitTop = 304
    ExplicitWidth = 185
  end
  object pnlTrees: TPanel
    Left = 0
    Top = 0
    Width = 283
    Height = 333
    Align = alClient
    Caption = 'pnlTrees'
    TabOrder = 1
    ExplicitLeft = 141
    object splHorizontal: TSplitter
      Left = 1
      Top = 164
      Width = 281
      Height = 3
      Cursor = crVSplit
      Align = alTop
      Color = clHighlight
      ParentColor = False
      ExplicitLeft = -1
      ExplicitTop = 155
      ExplicitWidth = 277
    end
    object vstFiles: TVirtualStringTree
      Left = 1
      Top = 167
      Width = 281
      Height = 165
      Align = alClient
      Header.AutoSizeIndex = 0
      Header.Font.Charset = DEFAULT_CHARSET
      Header.Font.Color = clWindowText
      Header.Font.Height = -11
      Header.Font.Name = 'Tahoma'
      Header.Font.Style = []
      Header.Options = [hoColumnResize, hoDrag, hoShowSortGlyphs, hoVisible, hoAutoSpring]
      TabOrder = 0
      TreeOptions.MiscOptions = [toAcceptOLEDrop, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning, toEditOnClick]
      TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowTreeLines, toThemeAware, toUseBlendedImages, toFullVertGridLines]
      TreeOptions.SelectionOptions = [toFullRowSelect]
      OnFocusChanged = vstFilesFocusChanged
      OnGetText = vstFilesGetText
      OnGetNodeDataSize = vstFilesGetNodeDataSize
      Columns = <
        item
          CaptionAlignment = taCenter
          Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAutoSpring, coAllowFocus, coUseCaptionAlignment, coEditable]
          Position = 0
          Width = 140
          WideText = 'File'
        end
        item
          CaptionAlignment = taCenter
          Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAutoSpring, coAllowFocus, coUseCaptionAlignment, coEditable]
          Position = 1
          Width = 135
          WideText = 'Path'
        end>
    end
    object vstLibrary: TVirtualStringTree
      Left = 1
      Top = 1
      Width = 281
      Height = 163
      Align = alTop
      Header.AutoSizeIndex = 0
      Header.Font.Charset = DEFAULT_CHARSET
      Header.Font.Color = clWindowText
      Header.Font.Height = -11
      Header.Font.Name = 'Tahoma'
      Header.Font.Style = []
      Header.MainColumn = -1
      TabOrder = 1
      ExplicitLeft = -23
      ExplicitTop = 76
      ExplicitWidth = 265
      ExplicitHeight = 120
      Columns = <>
    end
  end
  object pnlPages: TPanel
    Left = 286
    Top = 0
    Width = 279
    Height = 333
    Align = alRight
    Caption = 'pnlPages'
    TabOrder = 2
    ExplicitLeft = 143
    object pgcPages: TPageControl
      Left = 1
      Top = 1
      Width = 277
      Height = 331
      ActivePage = tsTagID3v1
      Align = alClient
      TabOrder = 0
      object tsTagID3v1: TTabSheet
        Caption = 'Tag ID3v1'
        object sbxTagID3v1: TScrollBox
          Left = 0
          Top = 0
          Width = 269
          Height = 303
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          Color = clWindow
          ParentColor = False
          TabOrder = 0
          ExplicitLeft = 72
          ExplicitTop = -3
          object leTrack: TLabeledEdit
            Left = 64
            Top = 22
            Width = 192
            Height = 21
            EditLabel.Width = 26
            EditLabel.Height = 13
            EditLabel.Caption = 'Track'
            LabelPosition = lpLeft
            TabOrder = 0
          end
          object leGenre: TLabeledEdit
            Left = 64
            Top = 47
            Width = 192
            Height = 21
            EditLabel.Width = 29
            EditLabel.Height = 13
            EditLabel.Caption = 'Genre'
            LabelPosition = lpLeft
            TabOrder = 1
          end
          object leComment: TLabeledEdit
            Left = 64
            Top = 72
            Width = 192
            Height = 21
            EditLabel.Width = 45
            EditLabel.Height = 13
            EditLabel.Caption = 'Comment'
            LabelPosition = lpLeft
            TabOrder = 2
          end
          object leYear: TLabeledEdit
            Left = 64
            Top = 97
            Width = 192
            Height = 21
            EditLabel.Width = 22
            EditLabel.Height = 13
            EditLabel.Caption = 'Year'
            LabelPosition = lpLeft
            TabOrder = 3
          end
          object leAlbum: TLabeledEdit
            Left = 64
            Top = 122
            Width = 192
            Height = 21
            EditLabel.Width = 29
            EditLabel.Height = 13
            EditLabel.Caption = 'Album'
            LabelPosition = lpLeft
            TabOrder = 4
          end
          object leArtist: TLabeledEdit
            Left = 64
            Top = 147
            Width = 192
            Height = 21
            EditLabel.Width = 26
            EditLabel.Height = 13
            EditLabel.Caption = 'Artist'
            LabelPosition = lpLeft
            TabOrder = 5
          end
          object leTitle: TLabeledEdit
            Left = 64
            Top = 172
            Width = 192
            Height = 21
            EditLabel.Width = 20
            EditLabel.Height = 13
            EditLabel.Caption = 'Title'
            LabelPosition = lpLeft
            TabOrder = 6
          end
        end
      end
    end
  end
end
