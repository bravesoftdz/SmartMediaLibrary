inherited ViewAudioInfo: TViewAudioInfo
  Caption = 'ViewAudioInfo'
  ClientHeight = 438
  OnShow = FormShow
  ExplicitHeight = 476
  PixelsPerInch = 96
  TextHeight = 13
  object splHorizont: TSplitter
    Left = 0
    Top = 193
    Width = 554
    Height = 3
    Cursor = crVSplit
    Align = alTop
    Color = clHighlight
    ParentColor = False
    ExplicitWidth = 187
  end
  object vstTrackFiles: TVirtualStringTree
    Left = 0
    Top = 0
    Width = 554
    Height = 193
    Align = alTop
    Header.AutoSizeIndex = 0
    Header.Font.Charset = DEFAULT_CHARSET
    Header.Font.Color = clWindowText
    Header.Font.Height = -11
    Header.Font.Name = 'Tahoma'
    Header.Font.Style = []
    Header.Options = [hoColumnResize, hoDrag, hoShowSortGlyphs, hoVisible, hoAutoSpring]
    LineMode = lmBands
    LineStyle = lsSolid
    TabOrder = 0
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
        Width = 198
        WideText = 'File'
      end
      item
        CaptionAlignment = taCenter
        Options = [coAllowClick, coDraggable, coEnabled, coParentBidiMode, coParentColor, coResizable, coShowDropMark, coVisible, coAutoSpring, coAllowFocus, coUseCaptionAlignment, coEditable]
        Position = 1
        Width = 349
        WideText = 'Path'
      end>
  end
  object pgcPages: TPageControl
    Left = 0
    Top = 196
    Width = 554
    Height = 242
    ActivePage = tsFile
    Align = alClient
    TabOrder = 1
    ExplicitHeight = 184
    object tsFile: TTabSheet
      Caption = 'File'
      ExplicitLeft = 0
      ExplicitTop = 16
      object leFileName: TLabeledEdit
        Left = 24
        Top = 24
        Width = 233
        Height = 21
        EditLabel.Width = 46
        EditLabel.Height = 13
        EditLabel.Caption = 'File Name'
        ReadOnly = True
        TabOrder = 0
      end
      object leFullPath: TLabeledEdit
        Left = 24
        Top = 64
        Width = 233
        Height = 21
        EditLabel.Width = 22
        EditLabel.Height = 13
        EditLabel.Caption = 'Path'
        ReadOnly = True
        TabOrder = 1
      end
    end
    object tsID3v1: TTabSheet
      Caption = 'Tag ID3v1'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 32
      ExplicitHeight = 156
      object sbxTagID3v1: TScrollBox
        Left = 0
        Top = 0
        Width = 546
        Height = 214
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        Color = clWindow
        ParentColor = False
        TabOrder = 0
        object leTrack: TLabeledEdit
          Left = 24
          Top = 22
          Width = 120
          Height = 24
          EditLabel.Width = 26
          EditLabel.Height = 13
          EditLabel.Caption = 'Track'
          TabOrder = 0
        end
        object leGenre: TLabeledEdit
          Left = 24
          Top = 242
          Width = 120
          Height = 24
          EditLabel.Width = 29
          EditLabel.Height = 13
          EditLabel.Caption = 'Genre'
          TabOrder = 1
        end
        object leComment: TLabeledEdit
          Left = 24
          Top = 286
          Width = 120
          Height = 24
          EditLabel.Width = 45
          EditLabel.Height = 13
          EditLabel.Caption = 'Comment'
          TabOrder = 2
        end
        object leYear: TLabeledEdit
          Left = 24
          Top = 198
          Width = 120
          Height = 24
          EditLabel.Width = 22
          EditLabel.Height = 13
          EditLabel.Caption = 'Year'
          TabOrder = 3
        end
        object leAlbum: TLabeledEdit
          Left = 24
          Top = 154
          Width = 120
          Height = 24
          EditLabel.Width = 29
          EditLabel.Height = 13
          EditLabel.Caption = 'Album'
          TabOrder = 4
        end
        object leArtist: TLabeledEdit
          Left = 24
          Top = 110
          Width = 120
          Height = 24
          EditLabel.Width = 26
          EditLabel.Height = 13
          EditLabel.Caption = 'Artist'
          TabOrder = 5
        end
        object leTitle: TLabeledEdit
          Left = 24
          Top = 66
          Width = 120
          Height = 24
          EditLabel.Width = 20
          EditLabel.Height = 13
          EditLabel.Caption = 'Title'
          TabOrder = 6
        end
      end
    end
    object tsID3v2: TTabSheet
      Caption = 'Tag ID3v2'
      ImageIndex = 2
      ExplicitHeight = 156
      object sbxID3v2: TScrollBox
        Left = 0
        Top = 0
        Width = 546
        Height = 214
        Align = alClient
        TabOrder = 0
        ExplicitLeft = 64
        ExplicitTop = 64
        ExplicitWidth = 185
        ExplicitHeight = 41
        object leT2Album: TLabeledEdit
          Left = 24
          Top = 24
          Width = 161
          Height = 21
          EditLabel.Width = 49
          EditLabel.Height = 13
          EditLabel.Caption = 'leT2Album'
          TabOrder = 0
        end
      end
    end
  end
end
