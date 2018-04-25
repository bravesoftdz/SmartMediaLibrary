inherited ViewAddingFiles: TViewAddingFiles
  Caption = 'Add Media Files'
  ClientHeight = 484
  ClientWidth = 697
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  ExplicitWidth = 713
  ExplicitHeight = 522
  PixelsPerInch = 96
  TextHeight = 13
  object splVertical: TSplitter
    Left = 349
    Top = 0
    Height = 443
    Align = alRight
    Color = clHighlight
    ParentColor = False
    ExplicitLeft = 402
  end
  object pnlButtons: TPanel
    Left = 0
    Top = 443
    Width = 697
    Height = 41
    Align = alBottom
    Caption = 'pnlControls'
    ShowCaption = False
    TabOrder = 0
    ExplicitTop = 333
    ExplicitWidth = 582
    DesignSize = (
      697
      41)
    object btnOK: TButton
      Left = 515
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'btnOK'
      ModalResult = 1
      TabOrder = 0
      ExplicitLeft = 400
    end
    object btnCancel: TButton
      Left = 602
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'btnCancel'
      ModalResult = 2
      TabOrder = 1
      ExplicitLeft = 487
    end
  end
  object pnlTrees: TPanel
    Left = 0
    Top = 0
    Width = 349
    Height = 443
    Align = alClient
    Caption = 'pnlTrees'
    TabOrder = 1
    ExplicitWidth = 285
    ExplicitHeight = 333
    object splHorizontal: TSplitter
      Left = 1
      Top = 164
      Width = 347
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
      Width = 347
      Height = 275
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
      OnEnter = vstFilesEnter
      OnFocusChanged = vstFilesFocusChanged
      OnGetText = vstFilesGetText
      OnGetNodeDataSize = vstFilesGetNodeDataSize
      ExplicitWidth = 283
      ExplicitHeight = 165
      Columns = <
        item
          CaptionAlignment = taCenter
          Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAutoSpring, coAllowFocus, coUseCaptionAlignment, coEditable]
          Position = 0
          Width = 172
          WideText = 'File'
        end
        item
          CaptionAlignment = taCenter
          Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAutoSpring, coAllowFocus, coUseCaptionAlignment, coEditable]
          Position = 1
          Width = 167
          WideText = 'Path'
        end>
    end
    object vstLibrary: TVirtualStringTree
      Left = 1
      Top = 1
      Width = 347
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
      OnFocusChanged = vstLibraryFocusChanged
      OnGetText = vstLibraryGetText
      ExplicitWidth = 283
      Columns = <>
    end
  end
  object pnlPages: TPanel
    Left = 352
    Top = 0
    Width = 345
    Height = 443
    Align = alRight
    Caption = 'pnlPages'
    TabOrder = 2
    object pgcPages: TPageControl
      Left = 1
      Top = 1
      Width = 343
      Height = 441
      ActivePage = tsFile
      Align = alClient
      TabOrder = 0
      object tsFile: TTabSheet
        Caption = 'File'
        ImageIndex = 1
        ExplicitWidth = 284
        ExplicitHeight = 303
        DesignSize = (
          335
          413)
        object grpFileSource: TGroupBox
          Left = 6
          Top = 3
          Width = 322
          Height = 94
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Source'
          TabOrder = 0
          ExplicitWidth = 271
          DesignSize = (
            322
            94)
          object leFileName: TLabeledEdit
            Left = 64
            Top = 24
            Width = 251
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            EditLabel.Width = 46
            EditLabel.Height = 13
            EditLabel.Caption = 'File Name'
            LabelPosition = lpLeft
            ReadOnly = True
            TabOrder = 0
            ExplicitWidth = 200
          end
          object leFullPath: TLabeledEdit
            Left = 64
            Top = 49
            Width = 251
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            EditLabel.Width = 22
            EditLabel.Height = 13
            EditLabel.Caption = 'Path'
            LabelPosition = lpLeft
            ReadOnly = True
            TabOrder = 1
            ExplicitWidth = 200
          end
        end
        object grpFileDestination: TGroupBox
          Left = 6
          Top = 108
          Width = 322
          Height = 94
          Anchors = [akLeft, akTop, akRight]
          Caption = 'Destination'
          TabOrder = 1
          ExplicitWidth = 271
          DesignSize = (
            322
            94)
          object leDestFileName: TLabeledEdit
            Left = 64
            Top = 24
            Width = 251
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            EditLabel.Width = 46
            EditLabel.Height = 13
            EditLabel.Caption = 'File Name'
            LabelPosition = lpLeft
            ReadOnly = True
            TabOrder = 0
            ExplicitWidth = 200
          end
          object leDestFullPath: TLabeledEdit
            Left = 64
            Top = 49
            Width = 251
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            EditLabel.Width = 22
            EditLabel.Height = 13
            EditLabel.Caption = 'Path'
            LabelPosition = lpLeft
            ReadOnly = True
            TabOrder = 1
            ExplicitWidth = 200
          end
        end
      end
      object tsArtist: TTabSheet
        Caption = 'Artist'
        ImageIndex = 4
        ExplicitWidth = 284
        ExplicitHeight = 303
        DesignSize = (
          335
          413)
        object bcArtistTitle: TLabeledEdit
          Left = 65
          Top = 22
          Width = 243
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 20
          EditLabel.Height = 13
          EditLabel.Caption = 'Title'
          LabelPosition = lpLeft
          TabOrder = 0
          ExplicitWidth = 192
        end
      end
      object tsAlbum: TTabSheet
        Caption = 'Album'
        ImageIndex = 5
        ExplicitWidth = 284
        ExplicitHeight = 303
        DesignSize = (
          335
          413)
        object bcAlbumTitle: TLabeledEdit
          Left = 65
          Top = 22
          Width = 243
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 20
          EditLabel.Height = 13
          EditLabel.Caption = 'Title'
          LabelPosition = lpLeft
          TabOrder = 0
          ExplicitWidth = 192
        end
      end
      object tsTrack: TTabSheet
        Caption = 'Track'
        ImageIndex = 6
        ExplicitWidth = 284
        ExplicitHeight = 303
        DesignSize = (
          335
          413)
        object bcTrackTitle: TLabeledEdit
          Left = 65
          Top = 22
          Width = 243
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 20
          EditLabel.Height = 13
          EditLabel.Caption = 'Title'
          LabelPosition = lpLeft
          TabOrder = 0
          ExplicitWidth = 192
        end
      end
      object tsTagID3v1: TTabSheet
        Caption = 'Tag ID3v1'
        ExplicitWidth = 284
        ExplicitHeight = 303
        object sbxTagID3v1: TScrollBox
          Left = 0
          Top = 0
          Width = 335
          Height = 413
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          Color = clWindow
          ParentColor = False
          TabOrder = 0
          ExplicitWidth = 284
          ExplicitHeight = 303
          DesignSize = (
            335
            413)
          object leTrack: TLabeledEdit
            Left = 65
            Top = 22
            Width = 243
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            EditLabel.Width = 26
            EditLabel.Height = 13
            EditLabel.Caption = 'Track'
            LabelPosition = lpLeft
            TabOrder = 0
            ExplicitWidth = 192
          end
          object leGenre: TLabeledEdit
            Left = 65
            Top = 147
            Width = 243
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            EditLabel.Width = 29
            EditLabel.Height = 13
            EditLabel.Caption = 'Genre'
            LabelPosition = lpLeft
            TabOrder = 1
            ExplicitWidth = 192
          end
          object leComment: TLabeledEdit
            Left = 65
            Top = 172
            Width = 243
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            EditLabel.Width = 45
            EditLabel.Height = 13
            EditLabel.Caption = 'Comment'
            LabelPosition = lpLeft
            TabOrder = 2
            ExplicitWidth = 192
          end
          object leYear: TLabeledEdit
            Left = 65
            Top = 122
            Width = 243
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            EditLabel.Width = 22
            EditLabel.Height = 13
            EditLabel.Caption = 'Year'
            LabelPosition = lpLeft
            TabOrder = 3
            ExplicitWidth = 192
          end
          object leAlbum: TLabeledEdit
            Left = 65
            Top = 97
            Width = 243
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            EditLabel.Width = 29
            EditLabel.Height = 13
            EditLabel.Caption = 'Album'
            LabelPosition = lpLeft
            TabOrder = 4
            ExplicitWidth = 192
          end
          object leArtist: TLabeledEdit
            Left = 65
            Top = 72
            Width = 243
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            EditLabel.Width = 26
            EditLabel.Height = 13
            EditLabel.Caption = 'Artist'
            LabelPosition = lpLeft
            TabOrder = 5
            ExplicitWidth = 192
          end
          object leTitle: TLabeledEdit
            Left = 65
            Top = 47
            Width = 243
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            EditLabel.Width = 20
            EditLabel.Height = 13
            EditLabel.Caption = 'Title'
            LabelPosition = lpLeft
            TabOrder = 6
            ExplicitWidth = 192
          end
        end
      end
      object tsTagID3v2: TTabSheet
        Caption = 'Tag ID3v2'
        ImageIndex = 2
        ExplicitWidth = 284
        ExplicitHeight = 303
        object sbxTagID3v2: TScrollBox
          Left = 0
          Top = 0
          Width = 335
          Height = 413
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          Color = clWindow
          ParentColor = False
          TabOrder = 0
          ExplicitWidth = 284
          ExplicitHeight = 303
          DesignSize = (
            318
            413)
          object leT2BPM: TLabeledEdit
            Left = 65
            Top = 297
            Width = 209
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            EditLabel.Width = 20
            EditLabel.Height = 13
            EditLabel.Caption = 'BPM'
            LabelPosition = lpLeft
            TabOrder = 11
            ExplicitWidth = 158
          end
          object leT2Encoded: TLabeledEdit
            Left = 65
            Top = 272
            Width = 209
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            EditLabel.Width = 41
            EditLabel.Height = 13
            EditLabel.Caption = 'Encoded'
            LabelPosition = lpLeft
            TabOrder = 10
            ExplicitWidth = 158
          end
          object leT2URL: TLabeledEdit
            Left = 65
            Top = 247
            Width = 209
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            EditLabel.Width = 19
            EditLabel.Height = 13
            EditLabel.Caption = 'URL'
            LabelPosition = lpLeft
            TabOrder = 9
            ExplicitWidth = 158
          end
          object leT2Copyright: TLabeledEdit
            Left = 65
            Top = 322
            Width = 209
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            EditLabel.Width = 47
            EditLabel.Height = 13
            EditLabel.Caption = 'Copyright'
            LabelPosition = lpLeft
            TabOrder = 12
            ExplicitWidth = 158
          end
          object leT2OrigArtist: TLabeledEdit
            Left = 65
            Top = 397
            Width = 209
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            EditLabel.Width = 50
            EditLabel.Height = 13
            EditLabel.Caption = 'Orig.Artist'
            LabelPosition = lpLeft
            TabOrder = 15
            ExplicitWidth = 158
          end
          object leT2Publisher: TLabeledEdit
            Left = 65
            Top = 372
            Width = 209
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            EditLabel.Width = 43
            EditLabel.Height = 13
            EditLabel.Caption = 'Publisher'
            LabelPosition = lpLeft
            TabOrder = 14
            ExplicitWidth = 158
          end
          object leT2Composer: TLabeledEdit
            Left = 65
            Top = 347
            Width = 209
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            EditLabel.Width = 48
            EditLabel.Height = 13
            EditLabel.Caption = 'Composer'
            LabelPosition = lpLeft
            TabOrder = 13
            ExplicitWidth = 158
          end
          object leT2AlbumArtist: TLabeledEdit
            Left = 65
            Top = 222
            Width = 209
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            EditLabel.Width = 58
            EditLabel.Height = 13
            EditLabel.Caption = 'Album Artist'
            LabelPosition = lpLeft
            TabOrder = 8
            ExplicitWidth = 158
          end
          object leT2Comment: TLabeledEdit
            Left = 65
            Top = 197
            Width = 209
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            EditLabel.Width = 45
            EditLabel.Height = 13
            EditLabel.Caption = 'Comment'
            LabelPosition = lpLeft
            TabOrder = 7
            ExplicitWidth = 158
          end
          object leT2Genre: TLabeledEdit
            Left = 65
            Top = 172
            Width = 209
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            EditLabel.Width = 29
            EditLabel.Height = 13
            EditLabel.Caption = 'Genre'
            LabelPosition = lpLeft
            TabOrder = 6
            ExplicitWidth = 158
          end
          object leT2Year: TLabeledEdit
            Left = 65
            Top = 147
            Width = 209
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            EditLabel.Width = 22
            EditLabel.Height = 13
            EditLabel.Caption = 'Year'
            LabelPosition = lpLeft
            TabOrder = 5
            ExplicitWidth = 158
          end
          object leT2Album: TLabeledEdit
            Left = 65
            Top = 122
            Width = 209
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            EditLabel.Width = 29
            EditLabel.Height = 13
            EditLabel.Caption = 'Album'
            LabelPosition = lpLeft
            TabOrder = 4
            ExplicitWidth = 158
          end
          object leT2Artist: TLabeledEdit
            Left = 65
            Top = 97
            Width = 209
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            EditLabel.Width = 26
            EditLabel.Height = 13
            EditLabel.Caption = 'Artist'
            LabelPosition = lpLeft
            TabOrder = 3
            ExplicitWidth = 158
          end
          object leT2Title: TLabeledEdit
            Left = 65
            Top = 72
            Width = 209
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            EditLabel.Width = 20
            EditLabel.Height = 13
            EditLabel.Caption = 'Title'
            LabelPosition = lpLeft
            TabOrder = 2
            ExplicitWidth = 158
          end
          object leT2Disc: TLabeledEdit
            Left = 65
            Top = 47
            Width = 209
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            EditLabel.Width = 19
            EditLabel.Height = 13
            EditLabel.Caption = 'Disc'
            LabelPosition = lpLeft
            TabOrder = 1
            ExplicitWidth = 158
          end
          object leT2Track: TLabeledEdit
            Left = 65
            Top = 22
            Width = 209
            Height = 21
            Anchors = [akLeft, akTop, akRight]
            EditLabel.Width = 26
            EditLabel.Height = 13
            EditLabel.Caption = 'Track'
            LabelPosition = lpLeft
            TabOrder = 0
            ExplicitWidth = 158
          end
        end
      end
      object tsCover: TTabSheet
        Caption = 'Cover'
        ImageIndex = 3
        ExplicitWidth = 284
        ExplicitHeight = 303
      end
    end
  end
end
