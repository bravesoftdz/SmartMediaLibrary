unit vAddingFiles;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VirtualTrees, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdCtrls,
  API_Files,
  API_MVC_VCL,
  eMediaFile;

type
  TFileNode = record
    FileName: WideString;
    Hash: WideString;
    Path: WideString;
  end;

  TViewAddingFiles = class(TViewVCLBase)
    pnlButtons: TPanel;
    pnlTrees: TPanel;
    vstFiles: TVirtualStringTree;
    splHorizontal: TSplitter;
    vstLibrary: TVirtualStringTree;
    splVertical: TSplitter;
    pnlPages: TPanel;
    pgcPages: TPageControl;
    tsTagID3v1: TTabSheet;
    sbxTagID3v1: TScrollBox;
    leTrack: TLabeledEdit;
    leGenre: TLabeledEdit;
    leComment: TLabeledEdit;
    leYear: TLabeledEdit;
    leAlbum: TLabeledEdit;
    leArtist: TLabeledEdit;
    leTitle: TLabeledEdit;
    procedure FormShow(Sender: TObject);
    procedure vstFilesGetNodeDataSize(Sender: TBaseVirtualTree;
      var NodeDataSize: Integer);
    procedure vstFilesGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure FormCreate(Sender: TObject);
    procedure vstFilesFocusChanged(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex);
  private
    { Private declarations }
    FMediaFileArr: TArray<TMediaFile>;
    procedure DoRenderMediaFile(const aHash: string);
  public
    { Public declarations }
    procedure RenderMediaFile(const aMediaFile: TMediaFile);
  end;

var
  ViewAddingFiles: TViewAddingFiles;

implementation

{$R *.dfm}

procedure TViewAddingFiles.DoRenderMediaFile(const aHash: string);
var
  MediaFile: TMediaFile;
begin
  MediaFile := FMediaFileArr.FindByHash(aHash);

  leTrack.Text := MediaFile.ID3v1.Track;
  leTitle.Text := MediaFile.ID3v1.Title;
  leArtist.Text := MediaFile.ID3v1.Artist;
  leAlbum.Text := MediaFile.ID3v1.Album;
  leYear.Text := MediaFile.ID3v1.Year.ToString;
  leGenre.Text := MediaFile.ID3v1.Genre;
  leComment.Text := MediaFile.ID3v1.Comment;
end;

procedure TViewAddingFiles.RenderMediaFile(const aMediaFile: TMediaFile);
var
  FileNode: TFileNode;
  VirtualNode: PVirtualNode;
begin
  FMediaFileArr := FMediaFileArr + [aMediaFile];

  FileNode.FileName := aMediaFile.FileInfo.FileName;
  FileNode.Hash := aMediaFile.Hash;
  FileNode.Path := aMediaFile.FileInfo.FullPath;

  VirtualNode := vstFiles.AddChild(nil);
  VirtualNode.SetData<TFileNode>(FileNode);
end;

procedure TViewAddingFiles.vstFilesFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  FileNode: TFileNode;
begin
  inherited;

  if Sender.FocusedNode <> nil then
    begin
      FileNode := Sender.GetNodeData<TFileNode>(Sender.FocusedNode);

      DoRenderMediaFile(FileNode.Hash);
    end;
end;

procedure TViewAddingFiles.vstFilesGetNodeDataSize(Sender: TBaseVirtualTree;
  var NodeDataSize: Integer);
begin
  inherited;

  NodeDataSize := SizeOf(TFileNode);
end;

procedure TViewAddingFiles.vstFilesGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  FileNode: TFileNode;
begin
  inherited;

  FileNode := Sender.GetNodeData<TFileNode>(Node);
  case Column of
    0: CellText := FileNode.FileName;
    1: CellText := FileNode.Path;
  end;
end;

procedure TViewAddingFiles.FormCreate(Sender: TObject);
begin
  inherited;

  FMediaFileArr := [];
end;

procedure TViewAddingFiles.FormShow(Sender: TObject);
begin
  inherited;

  SendMessage('PullFiles');
end;

end.
