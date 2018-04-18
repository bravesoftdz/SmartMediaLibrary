unit vMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  API_DragDrop,
  API_MVC,
  API_MVC_VCL;

type
  TViewMain = class(TViewVCLBase)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FDragDropEngine: TDragDropEngine;
    FDropedFiles: TArray<string>;
    procedure InitMVC(var aControllerClass: TControllerClass); override;
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

  SendMessage('AddFiles');
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

procedure TViewMain.InitMVC(var aControllerClass: TControllerClass);
begin
  aControllerClass := TController;
  ViewMain := Self;
end;

end.
