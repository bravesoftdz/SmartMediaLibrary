unit vMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  API_DragDrop,
  API_MVC,
  API_MVC_VCL, Vcl.StdCtrls, Vcl.Buttons;

type
  TViewMain = class(TViewVCLBase)
    btn1: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn1Click(Sender: TObject);
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
  API_Files,
  cController,
  ePics;

procedure TViewMain.WMDropFiles(var Msg: TWMDropFiles);
begin
  FDropedFiles := FDragDropEngine.GetDropedFiles(Msg);

  SendMessage('AddFiles');
end;

procedure TViewMain.btn1Click(Sender: TObject);
var

  AlbumPicRel: TAlbumPicRel;
  FileStream: TFileStream;
  Buffer: TBytes;
  Size: Integer;
begin
  inherited;

  FileStream := TFilesEngine.GetFileStream('D:\temp\Bäst när det gäller.jpg');
  Size := FileStream.Size;
  SetLength(Buffer, Size);
  FileStream.Read(Buffer, Size);

  AlbumPicRel := TAlbumPicRel.Create(1);

  AlbumPicRel.Pic.Pic := Buffer;

  AlbumPicRel.StoreAll;
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
