unit vAudioAppend;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, VirtualTrees, Vcl.Graphics,
  Vcl.ExtCtrls, Vcl.ComCtrls,
  API_MVC_VCL,
  API_ORM_VCLBind,
  eAlbum,
  eArtist,
  eTrack,
  eTrackFile;

type
  TNodeData = record
    FileName: WideString;
    ID: ShortString;
    Path: WideString;
  end;

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
    bcArtistTitle: TLabeledEdit;
    bcAlbumTitle: TLabeledEdit;
    bcTrackTitle: TLabeledEdit;
    leNewFileName: TLabeledEdit;
    leNewPath: TLabeledEdit;
    procedure FormShow(Sender: TObject);
    procedure vstTrackFilesGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure vstTrackFilesGetNodeDataSize(Sender: TBaseVirtualTree;
      var NodeDataSize: Integer);
    procedure vstTrackFilesFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure vstLibTreeGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure vstLibTreeFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FArtistList: TArtistList;
    FBind: TORMBind;
    FTrackFileArr: TArray<TTrackFile>;
    procedure DoRenderTrackFile(aTrackFile: TTrackFile);
    procedure RenderAlbum(aArtist: TArtist; aAlbum: TAlbum);
    procedure RenderAlbumDetail(aAlbum: TAlbum);
    procedure RenderArtist(aArtist: TArtist);
    procedure RenderArtistDetail(aArtist: TArtist);
    procedure RenderTrackDetail(const aTrackFileID: string);
    procedure RenderTrackFileDetail(const aTrackFileID: string);
    procedure SetAllPagesInvisible;
    procedure SetPagesVisible(aPages: TArray<TTabSheet>);
  public
    { Public declarations }
    procedure RenderTrackFile(aTrackFile: TTrackFile);
    property ArtistList: TArtistList read FArtistList write FArtistList;
  end;

  TVSTreeHelper = class helper for TVirtualStringTree
  private
    function DoFindNode<T: class>(aParentNode: PVirtualNode; aObject: T): PVirtualNode;
  public
    function FindNode<T: class>(aObject: T): PVirtualNode;
  end;

var
  ViewAudioAppend: TViewAudioAppend;

implementation

{$R *.dfm}

procedure TViewAudioAppend.SetPagesVisible(aPages: TArray<TTabSheet>);
var
  TabSheet: TTabSheet;
begin
  SetAllPagesInvisible;

  for TabSheet in aPages do
    TabSheet.TabVisible := True;
end;

procedure TViewAudioAppend.SetAllPagesInvisible;
var
  i: Integer;
begin
  for i := 0 to pgcPages.PageCount - 1 do
    pgcPages.Pages[i].TabVisible := False;
end;

procedure TViewAudioAppend.RenderTrackDetail(const aTrackFileID: string);
var
  Track: TTrack;
begin
  Track := FTrackFileArr.FindByID(aTrackFileID).Track;
  FBind.BindEntity(Track, 'Track');
end;

procedure TViewAudioAppend.RenderAlbumDetail(aAlbum: TAlbum);
begin
  FBind.BindEntity(aAlbum, 'Album');
end;

procedure TViewAudioAppend.RenderArtistDetail(aArtist: TArtist);
begin
  FBind.BindEntity(aArtist, 'Artist');
end;

procedure TViewAudioAppend.DoRenderTrackFile(aTrackFile: TTrackFile);
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

procedure TViewAudioAppend.RenderAlbum(aArtist: TArtist; aAlbum: TAlbum);
var
  AlbumNode: PVirtualNode;
  ArtistNode: PVirtualNode;
begin
  AlbumNode := vstLibTree.FindNode<TAlbum>(aAlbum);

  if AlbumNode = nil then
    begin
      ArtistNode := vstLibTree.FindNode<TArtist>(aArtist);
      AlbumNode := vstLibTree.AddChild(ArtistNode, aAlbum);
      vstLibTree.Expanded[ArtistNode] := True;
    end;
end;

function TVSTreeHelper.DoFindNode<T>(aParentNode: PVirtualNode; aObject: T): PVirtualNode;
var
  NodeObject: T;
  VirtualNode: PVirtualNode;
begin
  Result := nil;

  for VirtualNode in ChildNodes(aParentNode) do
    begin
      NodeObject := GetNodeData<T>(VirtualNode);

      if NodeObject = aObject then
        Exit(VirtualNode);

      Result := DoFindNode<T>(VirtualNode, aObject);
    end;
end;

function TVSTreeHelper.FindNode<T>(aObject: T): PVirtualNode;
begin
  Result := DoFindNode<T>(Self.RootNode, aObject);
end;

procedure TViewAudioAppend.RenderArtist(aArtist: TArtist);
var
  VirtualNode: PVirtualNode;
begin
  VirtualNode := vstLibTree.FindNode<TArtist>(aArtist);

  if VirtualNode = nil then
    begin
      VirtualNode := vstLibTree.AddChild(nil, aArtist);
    end;
end;

procedure TViewAudioAppend.RenderTrackFileDetail(const aTrackFileID: string);
var
  TrackFile: TTrackFile;
begin
  TrackFile := FTrackFileArr.FindByID(aTrackFileID);

  leFileName.Text := TrackFile.FileInfo.FileName;
  leFullPath.Text := TrackFile.FileInfo.FullPath;
  leNewFileName.Text := TrackFile.NewFileName;
  leNewPath.Text := TrackFile.NewPath;

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

procedure TViewAudioAppend.vstLibTreeFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Album: TAlbum;
  Artist: TArtist;
  Level: Integer;
  TrackFile: TTrackFile;
begin
  inherited;

  vstTrackFiles.Clear;
  Level := Sender.GetNodeLevel(Node);

  case Level of
    0:
      begin
        Artist := Sender.GetNodeData<TArtist>(Node);

        RenderArtistDetail(Artist);
        SetPagesVisible([tsArtist]);

        for TrackFile in FTrackFileArr do
          if TrackFile.Artist = Artist then
            DoRenderTrackFile(TrackFile);
      end;
    1:
      begin
        Album := Sender.GetNodeData<TAlbum>(Node);

        RenderAlbumDetail(Album);
        SetPagesVisible([tsAlbum]);

        for TrackFile in FTrackFileArr do
          if TrackFile.Album = Album then
            DoRenderTrackFile(TrackFile);
      end;
  end;
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

      RenderTrackDetail(NodeData.ID);
      RenderTrackFileDetail(NodeData.ID);
      SetPagesVisible([tsTrack, tsFile, tsID3v1, tsID3v2]);
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
begin
  FTrackFileArr := FTrackFileArr + [aTrackFile];

  RenderArtist(aTrackFile.Artist);
  RenderAlbum(aTrackFile.Artist, aTrackFile.Album);

  DoRenderTrackFile(aTrackFile);
end;

procedure TViewAudioAppend.FormCreate(Sender: TObject);
begin
  inherited;

  FBind := TORMBind.Create(Self);
end;

procedure TViewAudioAppend.FormDestroy(Sender: TObject);
begin
  inherited;

  FBind.Free;
end;

procedure TViewAudioAppend.FormShow(Sender: TObject);
begin
  inherited;

  SetAllPagesInvisible;

  FTrackFileArr := [];
  SendMessage('PullTrackFiles');
end;

end.
