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
  eTrack, Vcl.ExtDlgs;

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
    bcAlbumYear: TLabeledEdit;
    bcTrackOrder: TLabeledEdit;
    tsWMATag: TTabSheet;
    leWMATrack: TLabeledEdit;
    leWMAGenre: TLabeledEdit;
    leWMAComment: TLabeledEdit;
    leWMAYear: TLabeledEdit;
    leWMAAlbum: TLabeledEdit;
    leWMAArtist: TLabeledEdit;
    leWMATitle: TLabeledEdit;
    leWMAAlbumArtist: TLabeledEdit;
    pnlCover: TPanel;
    imgCover: TImage;
    btnAddCover: TButton;
    Button11: TButton;
    Button10: TButton;
    dpgCoverPicture: TOpenPictureDialog;
    lblCoverSize: TLabel;
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
    procedure leWMAGenreChange(Sender: TObject);
    procedure btnAddCoverClick(Sender: TObject);
  private
    { Private declarations }
    FBind: TORMBind;
    FMediaFileArr: TArray<TMediaFile>;
    function GetActiveMediaFile: PMediaFile;
    function LoadCoverPictureFromFile(const aPath: string): Boolean;
    function LoadCoverPictureFromStream(aCoverPictureStream: TStream; const aMIMEType: string): Boolean;
    procedure RenderAlbumDetail(aAlbum: TAlbum);
    procedure RenderAlbumTree(aArtist: TArtist; aAlbum: TAlbum);
    procedure RenderArtistDetail(aArtist: TArtist);
    procedure RenderArtistTree(aArtist: TArtist);
    procedure RenderMediaFileDetail(const aMediaFile: TMediaFile);
    procedure RenderMediaFileGrid(const aMediaFile: TMediaFile);
    procedure RenderTrackDetail(aTrackRel: TTrackRel);
    procedure ShowPages(aTabSheetArr: TArray<TTabSheet>);
  public
    { Public declarations }
    procedure RenderMediaFile(var aMediaFile: TMediaFile);
    property MediaFileArr: TArray<TMediaFile> read FMediaFileArr;
  end;

var
  ViewAddingFiles: TViewAddingFiles;

implementation

{$R *.dfm}

uses
  API_VCL_UIExt,
  Vcl.Imaging.jpeg,
  Vcl.Imaging.pngimage;

function TViewAddingFiles.LoadCoverPictureFromFile(const aPath: string): Boolean;
var
  FileStream: TFileStream;
  MIMEType: string;
begin
  FileStream := TFilesEngine.GetFileStream(aPath);
  try
    MIMEType := GetMIMEType(aPath);

    if MIMEType <> '' then
      Result := LoadCoverPictureFromStream(FileStream, MIMEType);
  finally
    FileStream.Free;
  end;
end;

function TViewAddingFiles.LoadCoverPictureFromStream(aCoverPictureStream: TStream; const aMIMEType: string): Boolean;
var
  JPEGPicture: TJPEGImage;
  PNGPicture: TPNGImage;
begin
  Result := True;
  try
    //If JPG
    if (aMIMEType = 'image/jpeg') or
       (aMIMEType = 'image/jpg')
    then
      begin
        JPEGPicture := TJPEGImage.Create;
        try
          JPEGPicture.LoadFromStream(aCoverPictureStream);
          JPEGPicture.DIBNeeded;
          imgCover.Picture.Assign(JPEGPicture);

          lblCoverSize.Caption := Format('Size: %d x %d', [JPEGPicture.Width, JPEGPicture.Height]);
          lblCoverSize.Visible := True;
        finally
          JPEGPicture.Free;
        end;
      end;
    // If PNG
    if aMIMEType = 'image/png' then
      begin
        PNGPicture := TPNGImage.Create;
        try
          PNGPicture.LoadFromStream(aCoverPictureStream);
          imgCover.Picture.Assign(PNGPicture);
        finally
          PNGPicture.Free;
        end;
      end;
    //If BMP
    if aMIMEType = 'image/bmp' then
      begin
        aCoverPictureStream.Seek(0, soFromBeginning);
        imgCover.Picture.Bitmap.LoadFromStream(aCoverPictureStream);
      end;
  except
    Result := False;
  end;
end;

function TViewAddingFiles.GetActiveMediaFile: PMediaFile;
var
  FileNode: TFileNode;
begin
  if vstFiles.FocusedNode <> nil then
    begin
      FileNode := vstFiles.GetNodeData<TFileNode>(vstFiles.FocusedNode);
      Result := FMediaFileArr.FindByHash(FileNode.Hash);
    end;
end;

procedure TViewAddingFiles.leWMAGenreChange(Sender: TObject);
begin
  inherited;

  if leWMAGenre.Modified then
    GetActiveMediaFile^.WMA.Genre := leWMAGenre.Text;
end;

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

procedure TViewAddingFiles.RenderTrackDetail(aTrackRel: TTrackRel);
begin
  FBind.BindEntity(aTrackRel, 'Track');
  FBind.BindEntity(aTrackRel.Track, 'Track');
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
var
  CoverPictureStream: TStream;
  MIMEType: string;
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

  leWMATrack.Text := aMediaFile.WMA.Track;
  leWMATitle.Text := aMediaFile.WMA.Title;
  leWMAArtist.Text := aMediaFile.WMA.Artist;
  leWMAAlbum.Text := aMediaFile.WMA.Album;
  leWMAYear.Text := aMediaFile.WMA.Year.ToString;
  leWMAGenre.Text := aMediaFile.WMA.Genre;
  leWMAComment.Text := aMediaFile.WMA.Comment;
  leWMAAlbumArtist.Text := aMediaFile.WMA.AlbumArtist;

  imgCover.Picture.Assign(nil);
  lblCoverSize.Visible := False;
  if not aMediaFile.NewCoverPicture.IsEmpty then
    LoadCoverPictureFromFile(aMediaFile.NewCoverPicture)
  else
  if aMediaFile.MediaFormat = mfMP3 then
    begin
      CoverPictureStream := aMediaFile.ID3v2.GetCoverPictureStream(MIMEType);
      if CoverPictureStream <> nil then
        begin
          LoadCoverPictureFromStream(CoverPictureStream, MIMEType);
          CoverPictureStream.Free;
        end;
    end;
end;

procedure TViewAddingFiles.RenderMediaFile(var aMediaFile: TMediaFile);
begin
  FMediaFileArr := FMediaFileArr + [aMediaFile];
  RenderMediaFileGrid(aMediaFile);

  if aMediaFile.Artist <> nil then
    RenderArtistTree(aMediaFile.Artist);

  if aMediaFile.Album <> nil then
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
  MediaFile: PMediaFile;
  TrackRel: TTrackRel;
begin
  inherited;

  if Sender.FocusedNode <> nil then
    begin
      MediaFile := GetActiveMediaFile;

      if MediaFile.MediaFormat = mfMP3 then
        ShowPages([tsFile, tsArtist, tsAlbum, tsTrack, tsTagID3v1, tsTagID3v2, tsCover])
      else
      if MediaFile.MediaFormat = mfWMA then
        ShowPages([tsFile, tsArtist, tsAlbum, tsTrack, tsWMATag, tsCover])
      else
        ShowPages([]);

      RenderMediaFileDetail(MediaFile^);

      TrackRel := MediaFile.TrackRel;
      if TrackRel <> nil then
        RenderTrackDetail(TrackRel);
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

procedure TViewAddingFiles.btnAddCoverClick(Sender: TObject);
begin
  inherited;

  if dpgCoverPicture.Execute then
    begin
      if LoadCoverPictureFromFile(dpgCoverPicture.FileName) then
        GetActiveMediaFile.NewCoverPicture := dpgCoverPicture.FileName;
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
  tsWMATag.TabVisible := False;
  tsCover.TabVisible := False;

  SendMessage('PullFiles');
end;

end.
