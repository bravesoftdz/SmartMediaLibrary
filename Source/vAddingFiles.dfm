inherited ViewAddingFiles: TViewAddingFiles
  Caption = 'ViewAddingFiles'
  ClientHeight = 374
  ClientWidth = 582
  OnCreate = FormCreate
  OnShow = FormShow
  ExplicitWidth = 598
  ExplicitHeight = 412
  PixelsPerInch = 96
  TextHeight = 13
  object splVertical: TSplitter
    Left = 285
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
    Width = 582
    Height = 41
    Align = alBottom
    Caption = 'pnlButtons'
    TabOrder = 0
    ExplicitWidth = 565
    object btnOK: TButton
      Left = 400
      Top = 8
      Width = 75
      Height = 25
      Caption = 'btnOK'
      ModalResult = 1
      TabOrder = 0
    end
    object btnCancel: TButton
      Left = 487
      Top = 8
      Width = 75
      Height = 25
      Caption = 'btnCancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object pnlTrees: TPanel
    Left = 0
    Top = 0
    Width = 285
    Height = 333
    Align = alClient
    Caption = 'pnlTrees'
    TabOrder = 1
    ExplicitWidth = 283
    object splHorizontal: TSplitter
      Left = 1
      Top = 164
      Width = 283
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
      Width = 283
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
      ExplicitWidth = 281
      Columns = <
        item
          CaptionAlignment = taCenter
          Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAutoSpring, coAllowFocus, coUseCaptionAlignment, coEditable]
          Position = 0
          Width = 138
          WideText = 'File'
        end
        item
          CaptionAlignment = taCenter
          Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAutoSpring, coAllowFocus, coUseCaptionAlignment, coEditable]
          Position = 1
          Width = 133
          WideText = 'Path'
        end>
    end
    object vstLibrary: TVirtualStringTree
      Left = 1
      Top = 1
      Width = 283
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
      OnGetText = vstLibraryGetText
      ExplicitWidth = 281
      Columns = <>
    end
  end
  object pnlPages: TPanel
    Left = 288
    Top = 0
    Width = 294
    Height = 333
    Align = alRight
    Caption = 'pnlPages'
    TabOrder = 2
    object pgcPages: TPageControl
      Left = 1
      Top = 1
      Width = 292
      Height = 331
      ActivePage = tsFile
      Align = alClient
      TabOrder = 0
      object tsFile: TTabSheet
        Caption = 'File'
        ImageIndex = 1
        ExplicitLeft = 5
        ExplicitTop = 23
        ExplicitWidth = 269
        DesignSize = (
          284
          303)
        object grpFileSource: TGroupBox
          Left = 6
          Top = 3
          Width = 271
          Height = 94
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Source'
          TabOrder = 0
          ExplicitWidth = 256
          DesignSize = (
            271
            94)
          object leFileName: TLabeledEdit
            Left = 64
            Top = 24
            Width = 200
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            EditLabel.Width = 46
            EditLabel.Height = 13
            EditLabel.Caption = 'File Name'
            LabelPosition = lpLeft
            ReadOnly = True
            TabOrder = 0
            ExplicitWidth = 185
          end
          object leFullPath: TLabeledEdit
            Left = 64
            Top = 49
            Width = 200
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            EditLabel.Width = 22
            EditLabel.Height = 13
            EditLabel.Caption = 'Path'
            LabelPosition = lpLeft
            ReadOnly = True
            TabOrder = 1
            ExplicitWidth = 185
          end
        end
      end
      object tsTagID3v1: TTabSheet
        Caption = 'Tag ID3v1'
        ExplicitWidth = 269
        object sbxTagID3v1: TScrollBox
          Left = 0
          Top = 0
          Width = 284
          Height = 303
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          Color = clWindow
          ParentColor = False
          TabOrder = 0
          ExplicitWidth = 269
          DesignSize = (
            284
            303)
          object leTrack: TLabeledEdit
            Left = 65
            Top = 22
            Width = 192
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            EditLabel.Width = 26
            EditLabel.Height = 13
            EditLabel.Caption = 'Track'
            LabelPosition = lpLeft
            TabOrder = 0
          end
          object leGenre: TLabeledEdit
            Left = 65
            Top = 147
            Width = 192
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            EditLabel.Width = 29
            EditLabel.Height = 13
            EditLabel.Caption = 'Genre'
            LabelPosition = lpLeft
            TabOrder = 1
          end
          object leComment: TLabeledEdit
            Left = 65
            Top = 172
            Width = 192
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            EditLabel.Width = 45
            EditLabel.Height = 13
            EditLabel.Caption = 'Comment'
            LabelPosition = lpLeft
            TabOrder = 2
          end
          object leYear: TLabeledEdit
            Left = 65
            Top = 122
            Width = 192
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            EditLabel.Width = 22
            EditLabel.Height = 13
            EditLabel.Caption = 'Year'
            LabelPosition = lpLeft
            TabOrder = 3
          end
          object leAlbum: TLabeledEdit
            Left = 65
            Top = 97
            Width = 192
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            EditLabel.Width = 29
            EditLabel.Height = 13
            EditLabel.Caption = 'Album'
            LabelPosition = lpLeft
            TabOrder = 4
          end
          object leArtist: TLabeledEdit
            Left = 65
            Top = 72
            Width = 192
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            EditLabel.Width = 26
            EditLabel.Height = 13
            EditLabel.Caption = 'Artist'
            LabelPosition = lpLeft
            TabOrder = 5
          end
          object leTitle: TLabeledEdit
            Left = 65
            Top = 47
            Width = 192
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            EditLabel.Width = 20
            EditLabel.Height = 13
            EditLabel.Caption = 'Title'
            LabelPosition = lpLeft
            TabOrder = 6
          end
        end
      end
      object tsTagID3v2: TTabSheet
        Caption = 'Tag ID3v2'
        ImageIndex = 2
        ExplicitWidth = 269
        object sbxTagID3v2: TScrollBox
          Left = 0
          Top = 0
          Width = 284
          Height = 303
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          Color = clWindow
          ParentColor = False
          TabOrder = 0
          ExplicitWidth = 269
          DesignSize = (
            267
            303)
          object leT2BPM: TLabeledEdit
            Left = 65
            Top = 297
            Width = 192
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            EditLabel.Width = 20
            EditLabel.Height = 13
            EditLabel.Caption = 'BPM'
            LabelPosition = lpLeft
            TabOrder = 11
          end
          object leT2Encoded: TLabeledEdit
            Left = 65
            Top = 272
            Width = 192
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            EditLabel.Width = 41
            EditLabel.Height = 13
            EditLabel.Caption = 'Encoded'
            LabelPosition = lpLeft
            TabOrder = 10
          end
          object leT2URL: TLabeledEdit
            Left = 65
            Top = 247
            Width = 192
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            EditLabel.Width = 19
            EditLabel.Height = 13
            EditLabel.Caption = 'URL'
            LabelPosition = lpLeft
            TabOrder = 9
          end
          object leT2Copyright: TLabeledEdit
            Left = 65
            Top = 322
            Width = 192
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            EditLabel.Width = 47
            EditLabel.Height = 13
            EditLabel.Caption = 'Copyright'
            LabelPosition = lpLeft
            TabOrder = 12
          end
          object leT2OrigArtist: TLabeledEdit
            Left = 65
            Top = 397
            Width = 192
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            EditLabel.Width = 50
            EditLabel.Height = 13
            EditLabel.Caption = 'Orig.Artist'
            LabelPosition = lpLeft
            TabOrder = 15
          end
          object leT2Publisher: TLabeledEdit
            Left = 65
            Top = 372
            Width = 192
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            EditLabel.Width = 43
            EditLabel.Height = 13
            EditLabel.Caption = 'Publisher'
            LabelPosition = lpLeft
            TabOrder = 14
          end
          object leT2Composer: TLabeledEdit
            Left = 65
            Top = 347
            Width = 192
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            EditLabel.Width = 48
            EditLabel.Height = 13
            EditLabel.Caption = 'Composer'
            LabelPosition = lpLeft
            TabOrder = 13
          end
          object leT2AlbumArtist: TLabeledEdit
            Left = 65
            Top = 222
            Width = 192
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            EditLabel.Width = 58
            EditLabel.Height = 13
            EditLabel.Caption = 'Album Artist'
            LabelPosition = lpLeft
            TabOrder = 8
          end
          object leT2Comment: TLabeledEdit
            Left = 65
            Top = 197
            Width = 192
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            EditLabel.Width = 45
            EditLabel.Height = 13
            EditLabel.Caption = 'Comment'
            LabelPosition = lpLeft
            TabOrder = 7
          end
          object leT2Genre: TLabeledEdit
            Left = 65
            Top = 172
            Width = 192
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            EditLabel.Width = 29
            EditLabel.Height = 13
            EditLabel.Caption = 'Genre'
            LabelPosition = lpLeft
            TabOrder = 6
          end
          object leT2Year: TLabeledEdit
            Left = 65
            Top = 147
            Width = 192
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            EditLabel.Width = 22
            EditLabel.Height = 13
            EditLabel.Caption = 'Year'
            LabelPosition = lpLeft
            TabOrder = 5
          end
          object leT2Album: TLabeledEdit
            Left = 65
            Top = 122
            Width = 192
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            EditLabel.Width = 29
            EditLabel.Height = 13
            EditLabel.Caption = 'Album'
            LabelPosition = lpLeft
            TabOrder = 4
          end
          object leT2Artist: TLabeledEdit
            Left = 65
            Top = 97
            Width = 192
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            EditLabel.Width = 26
            EditLabel.Height = 13
            EditLabel.Caption = 'Artist'
            LabelPosition = lpLeft
            TabOrder = 3
          end
          object leT2Title: TLabeledEdit
            Left = 65
            Top = 72
            Width = 192
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            EditLabel.Width = 20
            EditLabel.Height = 13
            EditLabel.Caption = 'Title'
            LabelPosition = lpLeft
            TabOrder = 2
          end
          object leT2Disc: TLabeledEdit
            Left = 65
            Top = 47
            Width = 192
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            EditLabel.Width = 19
            EditLabel.Height = 13
            EditLabel.Caption = 'Disc'
            LabelPosition = lpLeft
            TabOrder = 1
          end
          object leT2Track: TLabeledEdit
            Left = 65
            Top = 22
            Width = 192
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            EditLabel.Width = 26
            EditLabel.Height = 13
            EditLabel.Caption = 'Track'
            LabelPosition = lpLeft
            TabOrder = 0
          end
        end
      end
      object tsCover: TTabSheet
        Caption = 'Cover'
        ImageIndex = 3
      end
    end
  end
end
