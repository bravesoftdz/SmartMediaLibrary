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
      ActivePage = tsAlbum
      Align = alClient
      TabOrder = 0
      object tsFile: TTabSheet
        Caption = 'File'
        ImageIndex = 1
        OnShow = tsFileShow
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
          end
        end
      end
      object tsArtist: TTabSheet
        Caption = 'Artist'
        ImageIndex = 4
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
        end
      end
      object tsAlbum: TTabSheet
        Caption = 'Album'
        ImageIndex = 5
        ExplicitLeft = -20
        ExplicitTop = 120
        DesignSize = (
          335
          413)
        object lblAlbumCoverSize: TLabel
          Left = 158
          Top = 265
          Width = 58
          Height = 13
          Caption = 'lblCoverSize'
          Visible = False
        end
        object lblAlbumGenre: TLabel
          Left = 32
          Top = 76
          Width = 29
          Height = 13
          Caption = 'Genre'
        end
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
        end
        object bcAlbumYear: TLabeledEdit
          Left = 65
          Top = 47
          Width = 243
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 22
          EditLabel.Height = 13
          EditLabel.Caption = 'Year'
          LabelPosition = lpLeft
          TabOrder = 1
        end
        object pnlAlbumCover: TPanel
          Left = 66
          Top = 109
          Width = 150
          Height = 150
          BevelKind = bkTile
          BevelOuter = bvNone
          Caption = 'pnlCover'
          ShowCaption = False
          TabOrder = 2
          object imgAlbumCover: TImage
            Left = 0
            Top = 0
            Width = 146
            Height = 146
            Align = alClient
            Center = True
            Stretch = True
            ExplicitTop = 2
          end
        end
        object btnAddAlbumCover: TButton
          Left = 66
          Top = 289
          Width = 145
          Height = 25
          Caption = 'Add picture from file...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          OnClick = btnAddAlbumCoverClick
        end
        object Button2: TButton
          Left = 66
          Top = 320
          Width = 145
          Height = 22
          Caption = 'Save picture to file...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
        end
        object Button3: TButton
          Left = 66
          Top = 348
          Width = 145
          Height = 22
          Caption = 'Delete this picture'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
        end
        object bcGenreName: TComboBox
          Left = 65
          Top = 73
          Width = 243
          Height = 21
          TabOrder = 6
        end
      end
      object tsTrack: TTabSheet
        Caption = 'Track'
        ImageIndex = 6
        DesignSize = (
          335
          413)
        object bcTrackTitle: TLabeledEdit
          Left = 65
          Top = 47
          Width = 243
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 20
          EditLabel.Height = 13
          EditLabel.Caption = 'Title'
          LabelPosition = lpLeft
          TabOrder = 0
        end
        object bcTrackOrder: TLabeledEdit
          Left = 65
          Top = 22
          Width = 243
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 26
          EditLabel.Height = 13
          EditLabel.Caption = 'Track'
          LabelPosition = lpLeft
          TabOrder = 1
        end
      end
      object tsTagID3v1: TTabSheet
        Caption = 'Tag ID3v1'
        OnShow = tsTagID3v1Show
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
            TabOrder = 5
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
            TabOrder = 6
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
            TabOrder = 4
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
            TabOrder = 3
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
            TabOrder = 2
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
            TabOrder = 1
          end
        end
      end
      object tsTagID3v2: TTabSheet
        Caption = 'Tag ID3v2'
        ImageIndex = 2
        OnShow = tsTagID3v2Show
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
          DesignSize = (
            318
            413)
          object leT2BPM: TLabeledEdit
            Left = 65
            Top = 297
            Width = 124
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
            Width = 124
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
            Width = 124
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
            Width = 124
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
            Width = 124
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
            Width = 124
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
            Width = 124
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
            Width = 124
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
            Width = 124
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
            Width = 124
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
            Width = 124
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
            Width = 124
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
            Width = 124
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
            Width = 124
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
            Width = 124
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
            Width = 124
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
      object tsWMATag: TTabSheet
        Caption = 'Tag WMA'
        ImageIndex = 7
        DesignSize = (
          335
          413)
        object leWMATrack: TLabeledEdit
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
        end
        object leWMAGenre: TLabeledEdit
          Left = 65
          Top = 170
          Width = 243
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 29
          EditLabel.Height = 13
          EditLabel.Caption = 'Genre'
          LabelPosition = lpLeft
          TabOrder = 6
          OnChange = leWMAGenreChange
        end
        object leWMAComment: TLabeledEdit
          Left = 65
          Top = 197
          Width = 243
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 45
          EditLabel.Height = 13
          EditLabel.Caption = 'Comment'
          LabelPosition = lpLeft
          TabOrder = 7
        end
        object leWMAYear: TLabeledEdit
          Left = 65
          Top = 147
          Width = 243
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 22
          EditLabel.Height = 13
          EditLabel.Caption = 'Year'
          LabelPosition = lpLeft
          TabOrder = 5
        end
        object leWMAAlbum: TLabeledEdit
          Left = 65
          Top = 97
          Width = 243
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 29
          EditLabel.Height = 13
          EditLabel.Caption = 'Album'
          LabelPosition = lpLeft
          TabOrder = 3
        end
        object leWMAArtist: TLabeledEdit
          Left = 65
          Top = 72
          Width = 243
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 26
          EditLabel.Height = 13
          EditLabel.Caption = 'Artist'
          LabelPosition = lpLeft
          TabOrder = 2
        end
        object leWMATitle: TLabeledEdit
          Left = 65
          Top = 47
          Width = 243
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 20
          EditLabel.Height = 13
          EditLabel.Caption = 'Title'
          LabelPosition = lpLeft
          TabOrder = 1
        end
        object leWMAAlbumArtist: TLabeledEdit
          Left = 65
          Top = 122
          Width = 243
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 58
          EditLabel.Height = 13
          EditLabel.Caption = 'Album Artist'
          LabelPosition = lpLeft
          TabOrder = 4
        end
      end
      object tsCover: TTabSheet
        Caption = 'Cover'
        ImageIndex = 3
        object lblCoverSize: TLabel
          Left = 241
          Top = 317
          Width = 58
          Height = 13
          Caption = 'lblCoverSize'
          Visible = False
        end
        object pnlCover: TPanel
          Left = 17
          Top = 15
          Width = 300
          Height = 300
          BevelKind = bkTile
          BevelOuter = bvNone
          Caption = 'pnlCover'
          ShowCaption = False
          TabOrder = 0
          object imgCover: TImage
            Left = 0
            Top = 0
            Width = 296
            Height = 296
            Align = alClient
            Center = True
            Stretch = True
            ExplicitLeft = 80
            ExplicitTop = 38
            ExplicitWidth = 113
            ExplicitHeight = 41
          end
        end
        object btnAddCover: TButton
          Left = 24
          Top = 323
          Width = 145
          Height = 25
          Caption = 'Add picture from file...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = btnAddCoverClick
        end
        object Button11: TButton
          Left = 24
          Top = 354
          Width = 145
          Height = 22
          Caption = 'Save picture to file...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object Button10: TButton
          Left = 24
          Top = 382
          Width = 145
          Height = 22
          Caption = 'Delete this picture'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
      end
    end
  end
  object dpgCoverPicture: TOpenPictureDialog
    Left = 621
    Top = 385
  end
end
