unit eAlbum;

interface

uses
  API_ORM,
  API_Types,
  eCommon,
  eGenre,
  ePics,
  eTrack,
  System.Classes;

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
    function GetDefaultGenre: TGenre;
    function GetGenreRel: TAlbumGenreRelList;
    function GetPicRels: TAlbumPicRelList;
    function GetTrackNum(aTrack: TTrack): string;
    function GetTrackRels: TTrackRelList;
    procedure SetTitle(const aValue: string);
    procedure SetYear(const aValue: Integer);
  public
    OnCoverChangedProcArr: TArray<TMethod>;
    OnGenreChangedProcArr: TArray<TMethod>;
    OnTitleChangedProcArr: TArray<TMethod>;
    OnYearChangedProcArr: TArray<TMethod>;
    class function GetStructure: TSructure; override;
    procedure SetCoverFromFile(const aPath: string);
    procedure SetCoverFromStream(aPictureStream: TStream; aMIMEType: TMIMEType);
    procedure SetDefaultGenre(const aGenreID: Integer);
    property Cover: TPic read GetCover;
    property DefaultGenre: TGenre read GetDefaultGenre;
    property GenreRels: TAlbumGenreRelList read GetGenreRel;
    property PicRels: TAlbumPicRelList read GetPicRels;
    property TrackNum[aTrack: TTrack]: string read GetTrackNum;
    property TrackRels: TTrackRelList read GetTrackRels;
  published
    property ArtistID: Integer read FArtistID write FArtistID;
    property Title: string read FTitle write SetTitle;
    property Year: Integer read FYear write SetYear;
  end;

  TAlbumList = class(TEntityList<TAlbum>)
  public
    function GetByName(const aAlbumName: string): TAlbum;
  end;

implementation

uses
  API_Files,
  eArtist,
  System.SysUtils;

procedure TAlbum.SetYear(const aValue: Integer);
begin
  FYear := aValue;

  TMethodEngine.ExecProcArr(OnYearChangedProcArr);
end;

procedure TAlbum.SetDefaultGenre(const aGenreID: Integer);
var
  AlbumGenreRel: TAlbumGenreRel;
begin
  if aGenreID = 0 then
    Exit;

  if DefaultGenre <> nil then
    begin
      if DefaultGenre.ID = aGenreID then
        Exit;

      for AlbumGenreRel in GenreRels do
        if AlbumGenreRel.IsDefault then
          begin
            GenreRels.Remove(AlbumGenreRel);
            Break;
          end;
    end;

  AlbumGenreRel := TAlbumGenreRel.Create;
  AlbumGenreRel.Genre := TGenre.Create(aGenreID);
  AlbumGenreRel.IsDefault := True;

  GenreRels.Add(AlbumGenreRel);
  TMethodEngine.ExecProcArr(OnGenreChangedProcArr);
end;

function TAlbum.GetDefaultGenre: TGenre;
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

procedure TAlbum.SetCoverFromStream(aPictureStream: TStream; aMIMEType: TMIMEType);
var
  AlbumPicRel: TAlbumPicRel;
begin
  if aPictureStream.Size = 0 then
    Exit;

  AlbumPicRel := TAlbumPicRel.Create;
  AlbumPicRel.IsDefault := True;
  AlbumPicRel.Pic := TPic.Create;

  AlbumPicRel.Pic.AssignStream(aPictureStream);
  AlbumPicRel.Pic.MIMEType := aMIMEType;

  PicRels.Add(AlbumPicRel);

  TMethodEngine.ExecProcArr(OnCoverChangedProcArr);
end;

procedure TAlbum.SetCoverFromFile(const aPath: string);
var
  MIMEType: TMIMEType;
  PictureStream: TFileStream;
begin
  PictureStream := TFilesEngine.CreateFileStream(aPath);
  try
    MIMEType := TFilesEngine.GetMIMEType(aPath);
    SetCoverFromStream(PictureStream, MIMEType);
  finally
    PictureStream.Free;
  end;
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
