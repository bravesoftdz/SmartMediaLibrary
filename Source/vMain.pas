unit vMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  API_DragDrop,
  API_MVC_VCL;

type
  TViewMain = class(TViewVCLBase)
    btnParseAudioInfo: TButton;
    procedure btnParseAudioInfoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FDragDropEngine: TDragDropEngine;
    FDropedFiles: TArray<string>;
    procedure InitMVC; override;
    procedure WMDropFiles(var Msg: TWMDropFiles); message WM_DROPFILES;
  public
    { Public declarations }
    property DropedFiles: TArray<string> read FDropedFiles;
  end;

var
  ViewMain: TViewMain;

implementation

{$R *.dfm}

uses
  cController;

procedure TViewMain.WMDropFiles(var Msg: TWMDropFiles);
begin
  FDropedFiles := FDragDropEngine.GetDropedFiles(Msg);
  SendMessage('PullExternalAudioInfo');
end;

procedure TViewMain.btnParseAudioInfoClick(Sender: TObject);
begin
  inherited;

  SendMessage('PullExternalAudioInfo');
end;

procedure TViewMain.FormCreate(Sender: TObject);
begin
  inherited;

  FDragDropEngine := TDragDropEngine.Create(Self);
end;

procedure TViewMain.FormDestroy(Sender: TObject);
begin
  inherited;

  FDragDropEngine.Free;
end;

procedure TViewMain.InitMVC;
begin
  FControllerClass := TController;
  ViewMain := Self;
end;

end.
