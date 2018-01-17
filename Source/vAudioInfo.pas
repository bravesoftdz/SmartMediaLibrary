unit vAudioInfo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, API_MVC_VCL, Vcl.StdCtrls;

type
  TViewAudioInfo = class(TViewVCLBase)
    mmo1: TMemo;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure RenderDropedFiles(aDropedFiles: TArray<string>);
  end;

var
  ViewAudioInfo: TViewAudioInfo;

implementation

{$R *.dfm}

procedure TViewAudioInfo.FormShow(Sender: TObject);
begin
  inherited;

  SendMessage('PullTrackFiles');
end;

procedure TViewAudioInfo.RenderDropedFiles(aDropedFiles: TArray<string>);
var
  FileName: string;
begin
  for FileName in aDropedFiles do
    mmo1.Lines.Add(FileName);
end;

end.
