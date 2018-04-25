unit vAddingFiles;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VirtualTrees, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdCtrls,
  API_Files,
  API_MVC_VCL,
  API_ORM_BindVCL,
  eAlbum,
  eArtist,
  eMediaFile,
  eTrack;

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
    grpFileDestination: TGroupBox;
    leDestFileName: TLabeledEdit;
    leDestFullPath: TLabeledEdit;
    tsArtist: TTabSheet;
    bcArtistTitle: TLabeledEdit;
    tsAlbum: TTabSheet;
    bcAlbumTitle: TLabeledEdit;
    tsTrack: TTabSheet;
    bcTrackTitle: TLabeledEdit;
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
    procedure FormDestroy(Sender: TObject);
    procedure vstLibraryFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
    procedure vstFilesEnter(Sender: TObject);
  private
    { Private declarations }
    FBind: TORMBind;
    FMediaFileArr: TArray<TMediaFile>;
    procedure RenderAlbumDetail(aAlbum: TAlbum);
    procedure RenderAlbumTree(aArtist: TArtist; aAlbum: TAlbum);
    procedure RenderArtistDetail(aArtist: TArtist);
    procedure RenderArtistTree(aArtist: TArtist);
    procedure RenderMediaFileDetail(const aMediaFile: TMediaFile);
    procedure RenderMediaFileGrid(const aMediaFile: TMediaFile);
    procedure RenderTrackDetail(aTrack: TTrack);
    procedure ShowPages(aTabSheetArr: TArray<TTabSheet>);
  public
    { Public declarations }
    procedure RenderMediaFile(const aMediaFile: TMediaFile);
    property MediaFileArr: TArray<TMediaFile> read FMediaFileArr;
  end;

var
  ViewAddingFiles: TViewAddingFiles;

implementation

{$R *.dfm}

uses
  API_VCL_UIExt;

procedure TViewAddingFiles.ShowPages(aTabSheetArr: TArray<TTabSheet>);
var
  Hidden: Boolean;
  i: Integer;
  j: Integer;
begin
  for i := 0 to pgcPages.PageCount - 1 do
    begin
      Hidden := True;

      for j := 0 to Length(aTabSheetArr) - 1 do
        if pgcPages.Pages[i] = aTabSheetArr[j] then
          begin
            Hidden := False;
            Break;
          end;

      if Hidden then
        pgcPages.Pages[i].TabVisible := False
      else
        pgcPages.Pages[i].TabVisible := True;
    end;
end;

procedure TViewAddingFiles.RenderAlbumDetail(aAlbum: TAlbum);
begin
  FBind.BindEntity(aAlbum, 'Album');
end;

procedure TViewAddingFiles.RenderMediaFileGrid(const aMediaFile: TMediaFile);
var
  FileNode: TFileNode;
  VirtualNode: PVirtualNode;
begin
  FileNode.FileName := aMediaFile.FileInfo.FileName;
  FileNode.Hash := aMediaFile.Hash;
  FileNode.Path := aMediaFile.FileInfo.FullPath;

  VirtualNode := vstFiles.AddChild(nil);
  VirtualNode.SetData<TFileNode>(FileNode);
end;

procedure TViewAddingFiles.RenderArtistDetail(aArtist: TArtist);
begin
  FBind.BindEntity(aArtist, 'Artist');
end;

procedure TViewAddingFiles.RenderTrackDetail(aTrack: TTrack);
begin
  FBind.BindEntity(aTrack, 'Track');
end;

procedure TViewAddingFiles.RenderAlbumTree(aArtist: TArtist; aAlbum: TAlbum);
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

procedure TViewAddingFiles.RenderArtistTree(aArtist: TArtist);
var
  VirtualNode: PVirtualNode;
begin
  VirtualNode := vstLibrary.FindNode<TArtist>(aArtist);

  if VirtualNode = nil then
    begin
      VirtualNode := vstLibrary.AddChild(nil, aArtist);
    end;
end;

procedure TViewAddingFiles.RenderMediaFileDetail(const aMediaFile: TMediaFile);
begin
  leFileName.Text := aMediaFile.FileInfo.FileName;
  leFullPath.Text := aMediaFile.FileInfo.FullPath;

  leDestFileName.Text := aMediaFile.Destination.FileName;
  leDestFullPath.Text := aMediaFile.Destination.FullPath;

  leTrack.Text := aMediaFile.ID3v1.Track;
  leTitle.Text := aMediaFile.ID3v1.Title;
  leArtist.Text := aMediaFile.ID3v1.Artist;
  leAlbum.Text := aMediaFile.ID3v1.Album;
  leYear.Text := aMediaFile.ID3v1.Year.ToString;
  leGenre.Text := aMediaFile.ID3v1.Genre;
  leComment.Text := aMediaFile.ID3v1.Comment;

  leT2Track.Text := aMediaFile.ID3v2.Track;
  leT2Disc.Text := aMediaFile.ID3v2.Disc;
  leT2Title.Text := aMediaFile.ID3v2.Title;
  leT2Artist.Text := aMediaFile.ID3v2.Artist;
  leT2Album.Text := aMediaFile.ID3v2.Album;
  if aMediaFile.ID3v2.Year > 0 then
    leT2Year.Text := aMediaFile.ID3v2.Year.ToString;
  leT2Genre.Text := aMediaFile.ID3v2.Genre;
  leT2Comment.Text := aMediaFile.ID3v2.Comment;
  leT2AlbumArtist.Text := aMediaFile.ID3v2.AlbumArtist;
  leT2Composer.Text := aMediaFile.ID3v2.Composer;
  leT2Publisher.Text := aMediaFile.ID3v2.Publisher;
  leT2OrigArtist.Text := aMediaFile.ID3v2.OrigArtist;
  leT2Copyright.Text := aMediaFile.ID3v2.Copyright;
  leT2URL.Text := aMediaFile.ID3v2.URL;
  leT2Encoded.Text := aMediaFile.ID3v2.Encoded;
  leT2BPM.Text := aMediaFile.ID3v2.BPM;
end;

procedure TViewAddingFiles.RenderMediaFile(const aMediaFile: TMediaFile);
begin
  FMediaFileArr := FMediaFileArr + [aMediaFile];
  RenderMediaFileGrid(aMediaFile);

  RenderArtistTree(aMediaFile.Artist);
  RenderAlbumTree(aMediaFile.Artist, aMediaFile.Album);
end;

procedure TViewAddingFiles.vstFilesEnter(Sender: TObject);
begin
  inherited;

  pgcPages.ActivePage := tsFile;
end;

procedure TViewAddingFiles.vstFilesFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  FileNode: TFileNode;
  MediaFile: TMediaFile;
  Track: TTrack;
begin
  inherited;

  if Sender.FocusedNode <> nil then
    begin
      FileNode := Sender.GetNodeData<TFileNode>(Sender.FocusedNode);
      MediaFile := FMediaFileArr.FindByHash(FileNode.Hash);

      if MediaFile.MediaFormat = mfMP3 then
        ShowPages([tsFile, tsArtist, tsAlbum, tsTrack, tsTagID3v1, tsTagID3v2, tsCover]);


      RenderMediaFileDetail(MediaFile);

      Track := MediaFile.Track;
      RenderTrackDetail(Track);
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

procedure TViewAddingFiles.vstLibraryFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  Album: TAlbum;
  Artist: TArtist;
  Level: Integer;
  MediaFile: TMediaFile;
begin
  inherited;

  vstFiles.Clear;
  Level := Sender.GetNodeLevel(Node);

  case Level of
    0:
      begin
        ShowPages([tsArtist]);
        pgcPages.ActivePage := tsArtist;

        Artist := Sender.GetNodeData<TArtist>(Node);

        RenderArtistDetail(Artist);

        for MediaFile in FMediaFileArr do
          if MediaFile.Artist = Artist then
            RenderMediaFileGrid(MediaFile);
      end;
    1:
      begin
        ShowPages([tsArtist, tsAlbum]);
        pgcPages.ActivePage := tsAlbum;

        Album := Sender.GetNodeData<TAlbum>(Node);

        RenderAlbumDetail(Album);

        for MediaFile in FMediaFileArr do
          if MediaFile.Album = Album then
            RenderMediaFileGrid(MediaFile);
      end;
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
  FBind := TORMBind.Create(Self);
end;

procedure TViewAddingFiles.FormDestroy(Sender: TObject);
begin
  inherited;

  FBind.Free;
end;

procedure TViewAddingFiles.FormShow(Sender: TObject);
begin
  inherited;

  tsFile.TabVisible := False;
  tsArtist.TabVisible := False;
  tsAlbum.TabVisible := False;
  tsTrack.TabVisible := False;
  tsTagID3v1.TabVisible := False;
  tsTagID3v2.TabVisible := False;
  tsCover.TabVisible := False;

  SendMessage('PullFiles');
end;

end.
