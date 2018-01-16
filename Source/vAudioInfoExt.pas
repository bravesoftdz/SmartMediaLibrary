unit vAudioInfoExt;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, API_MVC_VCL, Vcl.StdCtrls;

type
  TViewAudioInfoExt = class(TViewVCLBase)
    mmo1: TMemo;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure RenderDropedFiles(aDropedFiles: TArray<string>);
  end;

var
  ViewAudioInfoExt: TViewAudioInfoExt;

implementation

{$R *.dfm}

procedure TViewAudioInfoExt.RenderDropedFiles(aDropedFiles: TArray<string>);
var
  FileName: string;
begin
  for FileName in aDropedFiles do
    mmo1.Lines.Add(FileName);
end;

end.
