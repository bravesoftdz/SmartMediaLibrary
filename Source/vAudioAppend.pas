unit vAudioAppend;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, VirtualTrees, Vcl.Graphics,
  Vcl.ExtCtrls, Vcl.ComCtrls,
  API_MVC_VCL,
  eAlbum,
  eArtist,
  eTrack,
  eTrackFile;

type
  TViewAudioAppend = class(TViewVCLBase)
    splVertical: TSplitter;
    pgcPages: TPageControl;
    tsFile: TTabSheet;
    tsID3v1: TTabSheet;
    tsID3v2: TTabSheet;
    leFileName: TLabeledEdit;
    leFullPath: TLabeledEdit;
    sbxTagID3v1: TScrollBox;
    leTrack: TLabeledEdit;
    leGenre: TLabeledEdit;
    leComment: TLabeledEdit;
    leYear: TLabeledEdit;
    leAlbum: TLabeledEdit;
    leArtist: TLabeledEdit;
    leTitle: TLabeledEdit;
    sbxTagID3v2: TScrollBox;
    leT2Album: TLabeledEdit;
    leT2Track: TLabeledEdit;
    leT2Disc: TLabeledEdit;
    leT2Title: TLabeledEdit;
    leT2Artist: TLabeledEdit;
    leT2Year: TLabeledEdit;
    leT2Genre: TLabeledEdit;
    leT2Comment: TLabeledEdit;
    leT2AlbumArtist: TLabeledEdit;
    leT2Composer: TLabeledEdit;
    leT2Publisher: TLabeledEdit;
    leT2OrigArtist: TLabeledEdit;
    leT2Copyright: TLabeledEdit;
    leT2URL: TLabeledEdit;
    leT2Encoded: TLabeledEdit;
    leT2BPM: TLabeledEdit;
    pnlButtons: TPanel;
    btnOk: TButton;
    btnCancel: TButton;
    pnlTreeViews: TPanel;
    vstLibTree: TVirtualStringTree;
    vstTrackFiles: TVirtualStringTree;
    splHorizontal: TSplitter;
    tsArtist: TTabSheet;
    tsAlbum: TTabSheet;
    tsTrack: TTabSheet;
    procedure FormShow(Sender: TObject);
    procedure vstTrackFilesGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure vstTrackFilesGetNodeDataSize(Sender: TBaseVirtualTree;
      var NodeDataSize: Integer);
    procedure vstTrackFilesFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure vstLibTreeGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
  private
    { Private declarations }
    FArtistList: TArtistList;
    FTrackFileArr: TArray<TTrackFile>;
    procedure RenderAlbumList(aParentNode: PVirtualNode; aAlbumList: TAlbumList);
    procedure RenderTrackFileDetail(aTrackFileID: string);
  public
    { Public declarations }
    procedure RenderArtistList(aArtistList: TArtistList);
    procedure RenderTrackFile(aTrackFile: TTrackFile);
    procedure RenderTrackFiles(aTrackFileArr: TArray<TTrackFile>);
    property ArtistList: TArtistList read FArtistList write FArtistList;
  end;

  TNodeData = record
    FileName: WideString;
    ID: ShortString;
    Path: WideString;
  end;

var
  ViewAudioAppend: TViewAudioAppend;

implementation

{$R *.dfm}

procedure TViewAudioAppend.RenderAlbumList(aParentNode: PVirtualNode; aAlbumList: TAlbumList);
var
  Album: TAlbum;
  VirtualNode: PVirtualNode;
begin
  for Album in aAlbumList do
    VirtualNode := vstLibTree.AddChild(aParentNode, Album);
end;

procedure TViewAudioAppend.RenderArtistList(aArtistList: TArtistList);
var
  Artist: TArtist;
  VirtualNode: PVirtualNode;
begin
  for Artist in aArtistList do
    begin
      VirtualNode := vstLibTree.AddChild(nil, Artist);

      RenderAlbumList(VirtualNode, Artist.AlbumList);
      vstLibTree.Expanded[VirtualNode] := True;
    end;
end;

procedure TViewAudioAppend.RenderTrackFileDetail(aTrackFileID: string);
var
  TrackFile: TTrackFile;
begin
  TrackFile := FTrackFileArr.FindByID(aTrackFileID);

  leFileName.Text := TrackFile.FileInfo.FileName;
  leFullPath.Text := TrackFile.FileInfo.FullPath;

  leTrack.Text := TrackFile.ID3v1.Track;
  leTitle.Text := TrackFile.ID3v1.Title;
  leArtist.Text := TrackFile.ID3v1.Artist;
  leAlbum.Text := TrackFile.ID3v1.Album;
  leYear.Text := TrackFile.ID3v1.Year.ToString;
  leGenre.Text := TrackFile.ID3v1.Genre;
  leComment.Text := TrackFile.ID3v1.Comment;

  leT2Track.Text := TrackFile.ID3v2.Track;
  leT2Disc.Text := TrackFile.ID3v2.Disc;
  leT2Title.Text := TrackFile.ID3v2.Title;
  leT2Artist.Text := TrackFile.ID3v2.Artist;
  leT2Album.Text := TrackFile.ID3v2.Album;
  if TrackFile.ID3v2.Year > 0 then
    leT2Year.Text := TrackFile.ID3v2.Year.ToString;
  leT2Genre.Text := TrackFile.ID3v2.Genre;
  leT2Comment.Text := TrackFile.ID3v2.Comment;
  leT2AlbumArtist.Text := TrackFile.ID3v2.AlbumArtist;
  leT2Composer.Text := TrackFile.ID3v2.Composer;
  leT2Publisher.Text := TrackFile.ID3v2.Publisher;
  leT2OrigArtist.Text := TrackFile.ID3v2.OrigArtist;
  leT2Copyright.Text := TrackFile.ID3v2.Copyright;
  leT2URL.Text := TrackFile.ID3v2.URL;
  leT2Encoded.Text := TrackFile.ID3v2.Encoded;
  leT2BPM.Text := TrackFile.ID3v2.BPM;
end;

procedure TViewAudioAppend.RenderTrackFiles(aTrackFileArr: TArray<TTrackFile>);
var
  TrackFile: TTrackFile;
begin
  FTrackFileArr := aTrackFileArr;

  for TrackFile in FTrackFileArr do
    RenderTrackFile(TrackFile);
end;

procedure TViewAudioAppend.vstLibTreeGetText(Sender: TBaseVirtualTree;
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

procedure TViewAudioAppend.vstTrackFilesFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  NodeData: TNodeData;
begin
  inherited;

  if Sender.FocusedNode <> nil then
    begin
      NodeData := Sender.GetNodeData<TNodeData>(Sender.FocusedNode);

      RenderTrackFileDetail(NodeData.ID);
    end;
end;

procedure TViewAudioAppend.vstTrackFilesGetNodeDataSize(Sender: TBaseVirtualTree;
  var NodeDataSize: Integer);
begin
  inherited;

  NodeDataSize := SizeOf(TNodeData);
end;

procedure TViewAudioAppend.vstTrackFilesGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  NodeData: TNodeData;
begin
  inherited;

  NodeData := Sender.GetNodeData<TNodeData>(Node);

  case Column of
    0: CellText := NodeData.FileName;
    1: CellText := NodeData.Path;
  end;
end;

procedure TViewAudioAppend.RenderTrackFile(aTrackFile: TTrackFile);
var
  NodeData: TNodeData;
  VirtualNode: PVirtualNode;
begin
  NodeData.ID := aTrackFile.ID;
  NodeData.FileName := aTrackFile.FileInfo.FileName;
  NodeData.Path := aTrackFile.FileInfo.FullPath;

  VirtualNode := vstTrackFiles.AddChild(nil);
  VirtualNode.SetData<TNodeData>(NodeData);
end;

procedure TViewAudioAppend.FormShow(Sender: TObject);
begin
  inherited;

  SendMessage('PullTrackFiles');
end;

end.
