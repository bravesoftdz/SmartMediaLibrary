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
    lblAlbumCoverSize: TLabel;
    pnlAlbumCover: TPanel;
    imgAlbumCover: TImage;
    btnAddAlbumCover: TButton;
    Button2: TButton;
    Button3: TButton;
    bcGenreName: TComboBox;
    lblAlbumGenre: TLabel;
    procedure FormShow(Sender: TObject);
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
    procedure tsTagID3v1Show(Sender: TObject);
    procedure tsTagID3v2Show(Sender: TObject);
    procedure tsFileShow(Sender: TObject);
    procedure btnAddAlbumCoverClick(Sender: TObject);
  private
    { Private declarations }
    FBind: TORMBind;
    FMediaFileList: TMediaFileList;
    function GetActiveAlbum: TAlbum;
    function GetActiveMediaFile: TMediaFile;
    procedure RenderAlbumDetail(aAlbum: TAlbum);
    procedure RenderAlbumTree(aArtist: TArtist; aAlbum: TAlbum);
    procedure RenderArtistDetail(aArtist: TArtist);
    procedure RenderArtistTree(aArtist: TArtist);
    procedure RenderFileInfo(aMediaFile: TMediaFile);
    procedure RenderID3v1(aID3v1: TID3v1);
    procedure RenderID3v2(aID3v2: TID3v2);
    procedure RenderMediaFileDetail(aMediaFile: TMediaFile);
    procedure RenderMediaFileGrid(aMediaFile: TMediaFile);
    procedure RenderTrackDetail(aTrackRel: TTrackRel);
    procedure ShowPages(aTabSheetArr: TArray<TTabSheet>);
    property ActiveAlbum: TAlbum read GetActiveAlbum;
    property ActiveMediaFile: TMediaFile read GetActiveMediaFile;
  public
    { Public declarations }
    procedure RenderMediaFile(aMediaFile: TMediaFile);
    property MediaFileList: TMediaFileList read FMediaFileList;
  end;

var
  ViewAddingFiles: TViewAddingFiles;

implementation

{$R *.dfm}

uses
  API_Types,
  API_VCL_UIExt,
  ePics,
  Vcl.Imaging.jpeg,
  Vcl.Imaging.pngimage;

function TViewAddingFiles.GetActiveAlbum: TAlbum;
begin
  Result := nil;

  if ActiveMediaFile <> nil then
    Exit(ActiveMediaFile.Album);

  if vstLibrary.FocusedNode <> nil then
    Result := vstLibrary.GetNodeData<TAlbum>(vstLibrary.FocusedNode);
end;

procedure TViewAddingFiles.RenderFileInfo(aMediaFile: TMediaFile);
begin
  leFileName.Text := aMediaFile.FileInfo.FileName;
  leFullPath.Text := aMediaFile.FileInfo.FullPath;

  leDestFileName.Text := aMediaFile.Destination.FileName;
  leDestFullPath.Text := aMediaFile.Destination.FullPath;
end;

procedure TViewAddingFiles.RenderID3v2(aID3v2: TID3v2);
begin
  leT2Track.Text := aID3v2.Track;
  leT2Disc.Text := aID3v2.Disc;
  leT2Title.Text := aID3v2.Title;
  leT2Artist.Text := aID3v2.Artist;
  leT2Album.Text := aID3v2.Album;
  if aID3v2.Year > 0 then
    leT2Year.Text := aID3v2.Year.ToString;
  leT2Genre.Text := aID3v2.Genre;
  leT2Comment.Text := aID3v2.Comment;
  leT2AlbumArtist.Text := aID3v2.AlbumArtist;
  leT2Composer.Text := aID3v2.Composer;
  leT2Publisher.Text := aID3v2.Publisher;
  leT2OrigArtist.Text := aID3v2.OrigArtist;
  leT2Copyright.Text := aID3v2.Copyright;
  leT2URL.Text := aID3v2.URL;
  leT2Encoded.Text := aID3v2.Encoded;
  leT2BPM.Text := aID3v2.BPM;
end;

procedure TViewAddingFiles.RenderID3v1(aID3v1: TID3v1);
begin
  inherited;

  leTrack.Text := aID3v1.Track;
  leTitle.Text := aID3v1.Title;
  leArtist.Text := aID3v1.Artist;
  leAlbum.Text := aID3v1.Album;
  leYear.Text := aID3v1.Year.ToString;
  leGenre.Text := aID3v1.Genre;
  leComment.Text := aID3v1.Comment;
end;

function TViewAddingFiles.GetActiveMediaFile: TMediaFile;
begin
  Result := nil;

  if vstFiles.FocusedNode <> nil then
    Result := vstFiles.GetNodeData<TMediaFile>(vstFiles.FocusedNode);
end;

procedure TViewAddingFiles.leWMAGenreChange(Sender: TObject);
begin
  inherited;

  if leWMAGenre.Modified then
    ActiveMediaFile.WMA.Genre := leWMAGenre.Text;
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

procedure TViewAddingFiles.tsFileShow(Sender: TObject);
begin
  inherited;

  if ActiveMediaFile <> nil then
    RenderFileInfo(ActiveMediaFile);
end;

procedure TViewAddingFiles.tsTagID3v1Show(Sender: TObject);
begin
  inherited;

  if ActiveMediaFile <> nil then
    RenderID3v1(ActiveMediaFile.ID3v1);
end;

procedure TViewAddingFiles.tsTagID3v2Show(Sender: TObject);
begin
  inherited;

  if ActiveMediaFile <> nil then
    RenderID3v2(ActiveMediaFile.ID3v2);
end;

procedure TViewAddingFiles.RenderAlbumDetail(aAlbum: TAlbum);
var
  AlbumCoverStream: TStream;
  MIMEType: TMIMEType;
begin
  FBind.BindEntity(aAlbum, 'Album');
  //FBind.BindEntity(aAlbum.Genre, 'Genre');

  if aAlbum.Cover <> nil then
    begin
      AlbumCoverStream := aAlbum.Cover.CreateStream;
      MIMEType := aAlbum.Cover.MIMEType;
      try
        AssignPicFromStream(imgAlbumCover, MIMEType, AlbumCoverStream);
      finally
        AlbumCoverStream.Free;
      end;
    end;
end;

procedure TViewAddingFiles.RenderMediaFileGrid(aMediaFile: TMediaFile);
var
  VirtualNode: PVirtualNode;
begin
  VirtualNode := vstFiles.AddChild(nil);
  VirtualNode.SetData<TMediaFile>(aMediaFile);
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

procedure TViewAddingFiles.RenderMediaFileDetail(aMediaFile: TMediaFile);
var
  CoverPictureStream: TStream;
  MIMEType: TMIMEType;
begin
  RenderFileInfo(aMediaFile);
  RenderID3v1(aMediaFile.ID3v1);
  RenderID3v2(aMediaFile.ID3v2);

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

  if aMediaFile.MediaFormat = mfMP3 then
    begin
      MIMEType := aMediaFile.ID3v2.CoverPicMIME;
      CoverPictureStream := aMediaFile.ID3v2.CreateCoverPictureStream;
      try
        if CoverPictureStream.Size > 0 then
          begin
            AssignPicFromStream(imgCover, MIMEType, CoverPictureStream, True);

            lblCoverSize.Caption := Format('Size: %d x %d', [imgCover.Picture.Width, imgCover.Picture.Height]);
            lblCoverSize.Visible := True;
          end;
      finally
        CoverPictureStream.Free;
      end;
    end;
end;

procedure TViewAddingFiles.RenderMediaFile(aMediaFile: TMediaFile);
begin
  FMediaFileList.Add(aMediaFile);
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
  MediaFile: TMediaFile;
  TrackRel: TTrackRel;
begin
  inherited;

  if Sender.FocusedNode <> nil then
    begin
      MediaFile := ActiveMediaFile;

      if MediaFile.MediaFormat = mfMP3 then
        ShowPages([tsFile, tsArtist, tsAlbum, tsTrack, tsTagID3v1, tsTagID3v2, tsCover])
      else
      if MediaFile.MediaFormat = mfWMA then
        ShowPages([tsFile, tsArtist, tsAlbum, tsTrack, tsWMATag, tsCover])
      else
        ShowPages([]);

      RenderMediaFileDetail(MediaFile);

      TrackRel := MediaFile.TrackRel;
      if TrackRel <> nil then
        RenderTrackDetail(TrackRel);
    end;
end;

procedure TViewAddingFiles.vstFilesGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  MediaFile: TMediaFile;
begin
  inherited;

  MediaFile := Sender.GetNodeData<TMediaFile>(Node);
  case Column of
    0: CellText := MediaFile.FileInfo.FileName;
    1: CellText := MediaFile.FileInfo.FullPath;
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

        for MediaFile in FMediaFileList do
          if MediaFile.Artist = Artist then
            RenderMediaFileGrid(MediaFile);
      end;
    1:
      begin
        ShowPages([tsArtist, tsAlbum]);
        pgcPages.ActivePage := tsAlbum;

        Album := Sender.GetNodeData<TAlbum>(Node);

        RenderAlbumDetail(Album);

        for MediaFile in FMediaFileList do
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

procedure TViewAddingFiles.btnAddAlbumCoverClick(Sender: TObject);
begin
  inherited;

  if dpgCoverPicture.Execute then
    begin
      if AssignPicFromFile(imgAlbumCover, dpgCoverPicture.FileName) then
        ActiveAlbum.AddCoverFromFile(dpgCoverPicture.FileName);
    end;
end;

procedure TViewAddingFiles.btnAddCoverClick(Sender: TObject);
var
  PictureStream: TFileStream;
begin
  inherited;

  if dpgCoverPicture.Execute then
    begin
      if AssignPicFromFile(imgCover, dpgCoverPicture.FileName) then
        begin
          PictureStream := TFilesEngine.CreateFileStream(dpgCoverPicture.FileName);
          try
            ActiveMediaFile.ID3v2.SetCoverPictureFromStream(PictureStream);
            ActiveMediaFile.ID3v2.CoverPicMIME := TFilesEngine.GetMIMEType(dpgCoverPicture.FileName);
          finally
            PictureStream.Free;
          end;
        end;
    end;
end;

procedure TViewAddingFiles.FormCreate(Sender: TObject);
begin
  inherited;

  FMediaFileList := TMediaFileList.Create;
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
