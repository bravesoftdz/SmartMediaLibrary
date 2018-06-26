unit vMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, VirtualTrees,
  API_DragDrop,
  API_MVC,
  API_MVC_VCL,
  eAlbum,
  eArtist, Vcl.ComCtrls;

type
  TViewMain = class(TViewVCLBase)
    pgcLibrary: TPageControl;
    tsVideoLib: TTabSheet;
    tsAudioLib: TTabSheet;
    vstLibrary: TVirtualStringTree;
    btnDBService: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure vstLibraryGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure btnDBServiceClick(Sender: TObject);
  private
    { Private declarations }
    FDragDropEngine: TDragDropEngine;
    FDropedFiles: TArray<string>;
    procedure InitMVC(var aControllerClass: TControllerClass); override;
    procedure RenderAlbumList(aAlbumList: TAlbumList; aArtistNode: PVirtualNode);
    procedure WMDropFiles(var Msg: TWMDropFiles); message WM_DROPFILES;
  public
    { Public declarations }
    procedure RenderLibrary(aAudioList: TAudioList);
    property DropedFiles: TArray<string> read FDropedFiles;
  end;

var
  ViewMain: TViewMain;

implementation

{$R *.dfm}

uses
  cController;

procedure TViewMain.RenderAlbumList(aAlbumList: TAlbumList; aArtistNode: PVirtualNode);
var
  Album: TAlbum;
begin
  for Album in aAlbumList do
    vstLibrary.AddChild(aArtistNode, Album);
end;

procedure TViewMain.RenderLibrary(aAudioList: TAudioList);
var
  Artist: TArtist;
  VirtualNode: PVirtualNode;
begin
  for Artist in aAudioList do
    begin
      VirtualNode := vstLibrary.AddChild(nil, Artist);
      RenderAlbumList(Artist.AlbumList, VirtualNode);
    end;
end;

procedure TViewMain.vstLibraryGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  Album: TAlbum;
  Artist: TArtist;
  Level: Integer;
begin
  inherited;

  Level := Sender.GetNodeLevel(Node);

  case Level of
    0:
      begin
        Artist := Sender.GetNodeData<TArtist>(Node);
        CellText := Artist.Title;
      end;
    1:
      begin
        Album := Sender.GetNodeData<TAlbum>(Node);
        CellText := Album.Title;
      end;
  end;
end;

procedure TViewMain.WMDropFiles(var Msg: TWMDropFiles);
begin
  FDropedFiles := FDragDropEngine.GetDropedFiles(Msg);

  SendMessage('AddFiles');
end;

procedure TViewMain.btnDBServiceClick(Sender: TObject);
begin
  inherited;

  SendMessage('DBService');
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

procedure TViewMain.FormShow(Sender: TObject);
begin
  inherited;

  SendMessage('PullLibrary');
end;

procedure TViewMain.InitMVC(var aControllerClass: TControllerClass);
begin
  aControllerClass := TController;
  ViewMain := Self;
end;

end.
