inherited ViewMain: TViewMain
  Caption = 'My Media Library'
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object btnParseAudioInfo: TButton
    Left = 8
    Top = 8
    Width = 113
    Height = 25
    Caption = 'btnParseAudioInfo'
    TabOrder = 0
    OnClick = btnParseAudioInfoClick
  end
end
