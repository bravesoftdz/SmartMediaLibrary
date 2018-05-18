unit eAlbum;

interface

uses
  API_ORM,
  eCommon,
  eGenre,
  ePics,
  eTrack;

type
  TAlbum = class(TEntity)
  private
    FArtistID: Integer;
    FGenreRels: TAlbumGenreRelList;
    FPicRels: TAlbumPicRelList;
    FTitle: string;
    FTrackRels: TTrackRelList;
    FYear: Integer;
    function GetCover: TPic;
    function GetGenre: TGenre;
    function GetGenreRel: TAlbumGenreRelList;
    function GetPicRels: TAlbumPicRelList;
    function GetTrackNum(aTrack: TTrack): string;
    function GetTrackRels: TTrackRelList;
    procedure SetTitle(const aValue: string);
  public
    OnCoverChangedProcArr: TArray<TMethod>;
    OnTitleChangedProcArr: TArray<TMethod>;
    class function GetStructure: TSructure; override;
    procedure AddCoverFromFile(const aPath: string);
    property Cover: TPic read GetCover;
    property Genre: TGenre read GetGenre;
    property GenreRels: TAlbumGenreRelList read GetGenreRel;
    property PicRels: TAlbumPicRelList read GetPicRels;
    property TrackNum[aTrack: TTrack]: string read GetTrackNum;
    property TrackRels: TTrackRelList read GetTrackRels;
  published
    property ArtistID: Integer read FArtistID write FArtistID;
    property Title: string read FTitle write SetTitle;
    property Year: Integer read FYear write FYear;
  end;

  TAlbumList = class(TEntityList<TAlbum>)
  public
    function GetByName(const aAlbumName: string): TAlbum;
  end;

implementation

uses
  API_Files,
  API_Types,
  eArtist,
  System.Classes,
  System.SysUtils;

function TAlbum.GetGenre: TGenre;
var
  AlbumGenreRel: TAlbumGenreRel;
begin
  Result := nil;

  for AlbumGenreRel in GenreRels do
    if AlbumGenreRel.IsDefault then
      Exit(AlbumGenreRel.Genre);
end;

function TAlbum.GetGenreRel: TAlbumGenreRelList;
begin
  if not Assigned(FGenreRels) then
    FGenreRels := TAlbumGenreRelList.Create(Self);

  Result := FGenreRels;
end;

function TAlbum.GetCover: TPic;
var
  AlbumPicRel: TAlbumPicRel;
begin
  Result := nil;

  for AlbumPicRel in PicRels do
    if AlbumPicRel.IsDefault then
      Exit(AlbumPicRel.Pic);
end;

procedure TAlbum.AddCoverFromFile(const aPath: string);
var
  AlbumPicRel: TAlbumPicRel;
  PictureStream: TFileStream;
begin
  AlbumPicRel := TAlbumPicRel.Create;
  AlbumPicRel.IsDefault := True;
  AlbumPicRel.Pic := TPic.Create;

  PictureStream := TFilesEngine.CreateFileStream(aPath);
  try
    AlbumPicRel.Pic.AssignStream(PictureStream);
    AlbumPicRel.Pic.MIMEType := TFilesEngine.GetMIMEType(aPath);
  finally
    PictureStream.Free;
  end;

  PicRels.Add(AlbumPicRel);

  TMethodEngine.ExecProcArr(OnCoverChangedProcArr);
end;

procedure TAlbum.SetTitle(const aValue: string);
begin
  FTitle := aValue;

  TMethodEngine.ExecProcArr(OnTitleChangedProcArr);
end;

function TAlbum.GetPicRels: TAlbumPicRelList;
begin
  if not Assigned(FPicRels) then
    FPicRels := TAlbumPicRelList.Create(Self);

  Result := FPicRels;
end;

function TAlbum.GetTrackRels: TTrackRelList;
begin
  if not Assigned(FTrackRels) then
    FTrackRels := TTrackRelList.Create(Self);

  Result := FTrackRels;
end;

function TAlbum.GetTrackNum(aTrack: TTrack): string;
var
  TrackRel: TTrackRel;
begin
  Result := '';

  for TrackRel in TrackRels do
    if TrackRel.Track = aTrack then
      begin
        Result := TrackRel.Order.ToString;
        if Length(Result) = 1 then
          Result := Format('0%s', [Result]);
        Exit(Result);
      end;
end;

function TAlbumList.GetByName(const aAlbumName: string): TAlbum;
var
  Album: TAlbum;
begin
  Result := nil;

  for Album in Self do
    if UpperCase(Album.Title) = UpperCase(aAlbumName) then
      Exit(Album);
end;

class function TAlbum.GetStructure: TSructure;
begin
  Result.TableName := 'AUDIO_ALBUMS';

  AddForeignKey(Result.ForeignKeyArr, 'ARTIST_ID', TArtist, 'ID');
end;

end.
