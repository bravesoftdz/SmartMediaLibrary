unit vAddingFiles;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VirtualTrees, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdCtrls,
  API_Files,
  API_MVC_VCL,
  eAlbum,
  eArtist,
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
    tsFile: TTabSheet;
    grpFileSource: TGroupBox;
    leFileName: TLabeledEdit;
    leFullPath: TLabeledEdit;
    tsTagID3v2: TTabSheet;
    sbxTagID3v2: TScrollBox;
    leT2BPM: TLabeledEdit;
    leT2Encoded: TLabeledEdit;
    leT2URL: TLabeledEdit;
    leT2Copyright: TLabeledEdit;
    leT2OrigArtist: TLabeledEdit;
    leT2Publisher: TLabeledEdit;
    leT2Composer: TLabeledEdit;
    leT2AlbumArtist: TLabeledEdit;
    leT2Comment: TLabeledEdit;
    leT2Genre: TLabeledEdit;
    leT2Year: TLabeledEdit;
    leT2Album: TLabeledEdit;
    leT2Artist: TLabeledEdit;
    leT2Title: TLabeledEdit;
    leT2Disc: TLabeledEdit;
    leT2Track: TLabeledEdit;
    tsCover: TTabSheet;
    btnOK: TButton;
    btnCancel: TButton;
    procedure FormShow(Sender: TObject);
    procedure vstFilesGetNodeDataSize(Sender: TBaseVirtualTree;
      var NodeDataSize: Integer);
    procedure vstFilesGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure FormCreate(Sender: TObject);
    procedure vstFilesFocusChanged(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex);
    procedure vstLibraryGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
  private
    { Private declarations }
    FMediaFileArr: TArray<TMediaFile>;
    procedure DoRenderMediaFile(const aHash: string);
    procedure RenderAlbum(aArtist: TArtist; aAlbum: TAlbum);
    procedure RenderArtist(aArtist: TArtist);
  public
    { Public declarations }
    procedure RenderMediaFile(const aMediaFile: TMediaFile);
  end;

var
  ViewAddingFiles: TViewAddingFiles;

implementation

{$R *.dfm}

uses
  API_VCL_UIExt;

procedure TViewAddingFiles.RenderAlbum(aArtist: TArtist; aAlbum: TAlbum);
var
  AlbumNode: PVirtualNode;
  ArtistNode: PVirtualNode;
begin
  AlbumNode := vstLibrary.FindNode<TAlbum>(aAlbum);

  if AlbumNode = nil then
    begin
      ArtistNode := vstLibrary.FindNode<TArtist>(aArtist);
      AlbumNode := vstLibrary.AddChild(ArtistNode, aAlbum);
      vstLibrary.Expanded[ArtistNode] := True;
    end;
end;

procedure TViewAddingFiles.RenderArtist(aArtist: TArtist);
var
  VirtualNode: PVirtualNode;
begin
  VirtualNode := vstLibrary.FindNode<TArtist>(aArtist);

  if VirtualNode = nil then
    begin
      VirtualNode := vstLibrary.AddChild(nil, aArtist);
    end;
end;

procedure TViewAddingFiles.DoRenderMediaFile(const aHash: string);
var
  MediaFile: TMediaFile;
begin
  MediaFile := FMediaFileArr.FindByHash(aHash);

  leFileName.Text := MediaFile.FileInfo.FileName;
  leFullPath.Text := MediaFile.FileInfo.FullPath;

  leTrack.Text := MediaFile.ID3v1.Track;
  leTitle.Text := MediaFile.ID3v1.Title;
  leArtist.Text := MediaFile.ID3v1.Artist;
  leAlbum.Text := MediaFile.ID3v1.Album;
  leYear.Text := MediaFile.ID3v1.Year.ToString;
  leGenre.Text := MediaFile.ID3v1.Genre;
  leComment.Text := MediaFile.ID3v1.Comment;

  leT2Track.Text := MediaFile.ID3v2.Track;
  leT2Disc.Text := MediaFile.ID3v2.Disc;
  leT2Title.Text := MediaFile.ID3v2.Title;
  leT2Artist.Text := MediaFile.ID3v2.Artist;
  leT2Album.Text := MediaFile.ID3v2.Album;
  if MediaFile.ID3v2.Year > 0 then
    leT2Year.Text := MediaFile.ID3v2.Year.ToString;
  leT2Genre.Text := MediaFile.ID3v2.Genre;
  leT2Comment.Text := MediaFile.ID3v2.Comment;
  leT2AlbumArtist.Text := MediaFile.ID3v2.AlbumArtist;
  leT2Composer.Text := MediaFile.ID3v2.Composer;
  leT2Publisher.Text := MediaFile.ID3v2.Publisher;
  leT2OrigArtist.Text := MediaFile.ID3v2.OrigArtist;
  leT2Copyright.Text := MediaFile.ID3v2.Copyright;
  leT2URL.Text := MediaFile.ID3v2.URL;
  leT2Encoded.Text := MediaFile.ID3v2.Encoded;
  leT2BPM.Text := MediaFile.ID3v2.BPM;
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

  RenderArtist(aMediaFile.Artist);
  RenderAlbum(aMediaFile.Artist, aMediaFile.Album);
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

procedure TViewAddingFiles.vstLibraryGetText(Sender: TBaseVirtualTree;
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
