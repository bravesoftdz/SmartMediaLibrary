inherited ViewAudioAppend: TViewAudioAppend
  Caption = 'ViewAudioAppend'
  ClientHeight = 452
  ClientWidth = 729
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  ExplicitWidth = 745
  ExplicitHeight = 490
  PixelsPerInch = 96
  TextHeight = 13
  object splVertical: TSplitter
    Left = 421
    Top = 0
    Height = 411
    Align = alRight
    Color = clHighlight
    ParentColor = False
    ExplicitLeft = 350
  end
  object pgcPages: TPageControl
    Left = 424
    Top = 0
    Width = 305
    Height = 411
    ActivePage = tsID3v2
    Align = alRight
    TabOrder = 0
    object tsArtist: TTabSheet
      Caption = 'Artist'
      ImageIndex = 3
      object bcArtistTitle: TLabeledEdit
        Left = 64
        Top = 24
        Width = 185
        Height = 21
        EditLabel.Width = 20
        EditLabel.Height = 13
        EditLabel.Caption = 'Title'
        LabelPosition = lpLeft
        TabOrder = 0
      end
    end
    object tsAlbum: TTabSheet
      Caption = 'Album'
      ImageIndex = 4
      object bcAlbumTitle: TLabeledEdit
        Left = 56
        Top = 24
        Width = 177
        Height = 21
        EditLabel.Width = 20
        EditLabel.Height = 13
        EditLabel.Caption = 'Title'
        LabelPosition = lpLeft
        TabOrder = 0
      end
    end
    object tsTrack: TTabSheet
      Caption = 'Track'
      ImageIndex = 5
      object bcTrackTitle: TLabeledEdit
        Left = 37
        Top = 32
        Width = 233
        Height = 21
        EditLabel.Width = 20
        EditLabel.Height = 13
        EditLabel.Caption = 'Title'
        LabelPosition = lpLeft
        TabOrder = 0
      end
    end
    object tsFile: TTabSheet
      Caption = 'File'
      object leFileName: TLabeledEdit
        Left = 56
        Top = 24
        Width = 233
        Height = 21
        EditLabel.Width = 46
        EditLabel.Height = 13
        EditLabel.Caption = 'File Name'
        LabelPosition = lpLeft
        ReadOnly = True
        TabOrder = 0
      end
      object leFullPath: TLabeledEdit
        Left = 56
        Top = 51
        Width = 233
        Height = 21
        EditLabel.Width = 22
        EditLabel.Height = 13
        EditLabel.Caption = 'Path'
        LabelPosition = lpLeft
        ReadOnly = True
        TabOrder = 1
      end
      object leNewFileName: TLabeledEdit
        Left = 56
        Top = 112
        Width = 233
        Height = 21
        EditLabel.Width = 46
        EditLabel.Height = 13
        EditLabel.Caption = 'File Name'
        LabelPosition = lpLeft
        ReadOnly = True
        TabOrder = 2
      end
      object leNewPath: TLabeledEdit
        Left = 56
        Top = 139
        Width = 233
        Height = 21
        EditLabel.Width = 22
        EditLabel.Height = 13
        EditLabel.Caption = 'Path'
        LabelPosition = lpLeft
        ReadOnly = True
        TabOrder = 3
      end
    end
    object tsID3v1: TTabSheet
      Caption = 'Tag ID3v1'
      ImageIndex = 1
      object sbxTagID3v1: TScrollBox
        Left = 0
        Top = 0
        Width = 297
        Height = 383
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        Color = clWindow
        ParentColor = False
        TabOrder = 0
        object leTrack: TLabeledEdit
          Left = 64
          Top = 14
          Width = 120
          Height = 21
          EditLabel.Width = 26
          EditLabel.Height = 13
          EditLabel.Caption = 'Track'
          LabelPosition = lpLeft
          TabOrder = 0
        end
        object leGenre: TLabeledEdit
          Left = 64
          Top = 169
          Width = 120
          Height = 21
          EditLabel.Width = 29
          EditLabel.Height = 13
          EditLabel.Caption = 'Genre'
          LabelPosition = lpLeft
          TabOrder = 1
        end
        object leComment: TLabeledEdit
          Left = 64
          Top = 200
          Width = 120
          Height = 21
          EditLabel.Width = 45
          EditLabel.Height = 13
          EditLabel.Caption = 'Comment'
          LabelPosition = lpLeft
          TabOrder = 2
        end
        object leYear: TLabeledEdit
          Left = 64
          Top = 138
          Width = 120
          Height = 21
          EditLabel.Width = 22
          EditLabel.Height = 13
          EditLabel.Caption = 'Year'
          LabelPosition = lpLeft
          TabOrder = 3
        end
        object leAlbum: TLabeledEdit
          Left = 64
          Top = 107
          Width = 120
          Height = 21
          EditLabel.Width = 29
          EditLabel.Height = 13
          EditLabel.Caption = 'Album'
          LabelPosition = lpLeft
          TabOrder = 4
        end
        object leArtist: TLabeledEdit
          Left = 64
          Top = 76
          Width = 120
          Height = 21
          EditLabel.Width = 26
          EditLabel.Height = 13
          EditLabel.Caption = 'Artist'
          LabelPosition = lpLeft
          TabOrder = 5
        end
        object leTitle: TLabeledEdit
          Left = 64
          Top = 45
          Width = 120
          Height = 21
          EditLabel.Width = 20
          EditLabel.Height = 13
          EditLabel.Caption = 'Title'
          LabelPosition = lpLeft
          TabOrder = 6
        end
      end
    end
    object tsID3v2: TTabSheet
      Caption = 'Tag ID3v2'
      ImageIndex = 2
      object sbxTagID3v2: TScrollBox
        Left = 0
        Top = 0
        Width = 297
        Height = 383
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        Color = clWindow
        ParentColor = False
        TabOrder = 0
        object leT2Album: TLabeledEdit
          Left = 72
          Top = 137
          Width = 121
          Height = 21
          EditLabel.Width = 29
          EditLabel.Height = 13
          EditLabel.Caption = 'Album'
          LabelPosition = lpLeft
          TabOrder = 0
        end
        object leT2Track: TLabeledEdit
          Left = 72
          Top = 13
          Width = 121
          Height = 21
          EditLabel.Width = 26
          EditLabel.Height = 13
          EditLabel.Caption = 'Track'
          LabelPosition = lpLeft
          TabOrder = 1
        end
        object leT2Disc: TLabeledEdit
          Left = 72
          Top = 44
          Width = 121
          Height = 21
          EditLabel.Width = 19
          EditLabel.Height = 13
          EditLabel.Caption = 'Disc'
          LabelPosition = lpLeft
          TabOrder = 2
        end
        object leT2Title: TLabeledEdit
          Left = 72
          Top = 75
          Width = 121
          Height = 21
          EditLabel.Width = 20
          EditLabel.Height = 13
          EditLabel.Caption = 'Title'
          LabelPosition = lpLeft
          TabOrder = 3
        end
        object leT2Artist: TLabeledEdit
          Left = 72
          Top = 106
          Width = 121
          Height = 21
          EditLabel.Width = 26
          EditLabel.Height = 13
          EditLabel.Caption = 'Artist'
          LabelPosition = lpLeft
          TabOrder = 4
        end
        object leT2Year: TLabeledEdit
          Left = 72
          Top = 168
          Width = 121
          Height = 21
          EditLabel.Width = 22
          EditLabel.Height = 13
          EditLabel.Caption = 'Year'
          LabelPosition = lpLeft
          TabOrder = 5
        end
        object leT2Genre: TLabeledEdit
          Left = 72
          Top = 199
          Width = 121
          Height = 21
          EditLabel.Width = 29
          EditLabel.Height = 13
          EditLabel.Caption = 'Genre'
          LabelPosition = lpLeft
          TabOrder = 6
        end
        object leT2Comment: TLabeledEdit
          Left = 72
          Top = 230
          Width = 121
          Height = 21
          EditLabel.Width = 45
          EditLabel.Height = 13
          EditLabel.Caption = 'Comment'
          LabelPosition = lpLeft
          TabOrder = 7
        end
        object leT2AlbumArtist: TLabeledEdit
          Left = 72
          Top = 261
          Width = 121
          Height = 21
          EditLabel.Width = 58
          EditLabel.Height = 13
          EditLabel.Caption = 'Album Artist'
          LabelPosition = lpLeft
          TabOrder = 8
        end
        object leT2Composer: TLabeledEdit
          Left = 72
          Top = 292
          Width = 121
          Height = 21
          EditLabel.Width = 48
          EditLabel.Height = 13
          EditLabel.Caption = 'Composer'
          LabelPosition = lpLeft
          TabOrder = 9
        end
        object leT2Publisher: TLabeledEdit
          Left = 72
          Top = 323
          Width = 121
          Height = 21
          EditLabel.Width = 43
          EditLabel.Height = 13
          EditLabel.Caption = 'Publisher'
          LabelPosition = lpLeft
          TabOrder = 10
        end
        object leT2OrigArtist: TLabeledEdit
          Left = 72
          Top = 354
          Width = 121
          Height = 21
          EditLabel.Width = 50
          EditLabel.Height = 13
          EditLabel.Caption = 'Orig.Artist'
          LabelPosition = lpLeft
          TabOrder = 11
        end
        object leT2Copyright: TLabeledEdit
          Left = 72
          Top = 385
          Width = 121
          Height = 21
          EditLabel.Width = 47
          EditLabel.Height = 13
          EditLabel.Caption = 'Copyright'
          LabelPosition = lpLeft
          TabOrder = 12
        end
        object leT2URL: TLabeledEdit
          Left = 72
          Top = 416
          Width = 121
          Height = 21
          EditLabel.Width = 19
          EditLabel.Height = 13
          EditLabel.Caption = 'URL'
          LabelPosition = lpLeft
          TabOrder = 13
        end
        object leT2Encoded: TLabeledEdit
          Left = 72
          Top = 447
          Width = 121
          Height = 21
          EditLabel.Width = 41
          EditLabel.Height = 13
          EditLabel.Caption = 'Encoded'
          LabelPosition = lpLeft
          TabOrder = 14
        end
        object leT2BPM: TLabeledEdit
          Left = 72
          Top = 478
          Width = 121
          Height = 21
          EditLabel.Width = 20
          EditLabel.Height = 13
          EditLabel.Caption = 'BPM'
          LabelPosition = lpLeft
          TabOrder = 15
        end
      end
    end
  end
  object pnlButtons: TPanel
    Left = 0
    Top = 411
    Width = 729
    Height = 41
    Align = alBottom
    Caption = 'pnlButtons'
    ShowCaption = False
    TabOrder = 1
    object btnOk: TButton
      Left = 567
      Top = 8
      Width = 75
      Height = 25
      Caption = 'btnOk'
      ModalResult = 1
      TabOrder = 0
    end
    object btnCancel: TButton
      Left = 648
      Top = 8
      Width = 75
      Height = 25
      Caption = 'btnCancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object pnlTreeViews: TPanel
    Left = 0
    Top = 0
    Width = 421
    Height = 411
    Align = alClient
    Caption = 'pnlTreeViews'
    TabOrder = 2
    object splHorizontal: TSplitter
      Left = 1
      Top = 138
      Width = 419
      Height = 3
      Cursor = crVSplit
      Align = alTop
      Color = clHighlight
      ParentColor = False
      ExplicitWidth = 272
    end
    object vstLibTree: TVirtualStringTree
      Left = 1
      Top = 1
      Width = 419
      Height = 137
      Align = alTop
      Header.AutoSizeIndex = 0
      Header.Font.Charset = DEFAULT_CHARSET
      Header.Font.Color = clWindowText
      Header.Font.Height = -11
      Header.Font.Name = 'Tahoma'
      Header.Font.Style = []
      Header.MainColumn = -1
      TabOrder = 0
      OnFocusChanged = vstLibTreeFocusChanged
      OnGetText = vstLibTreeGetText
      Columns = <>
    end
    object vstTrackFiles: TVirtualStringTree
      Left = 1
      Top = 141
      Width = 419
      Height = 269
      Align = alClient
      Header.AutoSizeIndex = 0
      Header.Font.Charset = DEFAULT_CHARSET
      Header.Font.Color = clWindowText
      Header.Font.Height = -11
      Header.Font.Name = 'Tahoma'
      Header.Font.Style = []
      Header.Options = [hoColumnResize, hoDrag, hoShowSortGlyphs, hoVisible, hoAutoSpring]
      LineMode = lmBands
      LineStyle = lsSolid
      TabOrder = 1
      TreeOptions.MiscOptions = [toAcceptOLEDrop, toFullRepaintOnResize, toGridExtensions, toInitOnSave, toToggleOnDblClick, toWheelPanning, toEditOnClick]
      TreeOptions.PaintOptions = [toShowButtons, toShowDropmark, toShowHorzGridLines, toShowRoot, toShowTreeLines, toThemeAware, toUseBlendedImages, toFullVertGridLines]
      TreeOptions.SelectionOptions = [toFullRowSelect]
      OnFocusChanged = vstTrackFilesFocusChanged
      OnGetText = vstTrackFilesGetText
      OnGetNodeDataSize = vstTrackFilesGetNodeDataSize
      Columns = <
        item
          CaptionAlignment = taCenter
          Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAutoSpring, coAllowFocus, coUseCaptionAlignment, coEditable]
          Position = 0
          Width = 200
          WideText = 'File'
        end
        item
          CaptionAlignment = taCenter
          Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAutoSpring, coAllowFocus, coUseCaptionAlignment, coEditable]
          Position = 1
          Width = 212
          WideText = 'Path'
        end>
    end
  end
end
