unit mTrackFiles;

interface

uses
  API_MVC,
  eArtist,
  eTrack,
  eTrackFile;

type
  TModelTrackFiles = class(TModelAbstract)
  private
    function CheckConsilience(aStrArr: TArray<string>; aValue: string): Boolean;
    function DefineAlbumName(aTrackFile: TTrackFile): TArray<string>;
    function DefineArtistName(aTrackFile: TTrackFile): TArray<string>;
    function DefineTrackName(aTrackFile: TTrackFile): TArray<string>;
    procedure AddVariant(var aStrArr: TArray<string>; aValue: string);
    procedure ApplyTrackToArtistList(aArtistList: TArtistList; var aTrackFile: TTrackFile);
  public
    inDropedFiles: TArray<string>;
    outArtistList: TArtistList;
    outTrackFileArr: TArray<TTrackFile>;
    procedure Start; override;
  end;

implementation

uses
  API_Files,
  eAlbum,
  System.Hash,
  System.SysUtils;

function TModelTrackFiles.DefineTrackName(aTrackFile: TTrackFile): TArray<string>;
begin
  Result := [];

  AddVariant(Result, aTrackFile.ID3v1.Title);
  AddVariant(Result, aTrackFile.ID3v2.Title);

  if Length(Result) = 0 then
    Result := Result + ['Unknown Track'];
end;

function TModelTrackFiles.DefineAlbumName(aTrackFile: TTrackFile): TArray<string>;
begin
  Result := [];

  AddVariant(Result, aTrackFile.ID3v1.Album);
  AddVariant(Result, aTrackFile.ID3v2.Album);

  if Length(Result) = 0 then
    Result := Result + ['Unknown Album'];
end;

procedure TModelTrackFiles.AddVariant(var aStrArr: TArray<string>; aValue: string);
begin
  if not aValue.IsEmpty and
     not CheckConsilience(aStrArr, aValue.Trim)
  then
    aStrArr := aStrArr + [aValue.Trim];
end;

function TModelTrackFiles.CheckConsilience(aStrArr: TArray<string>; aValue: string): Boolean;
var
  ArrValue: string;
begin
  Result := False;

  for ArrValue in aStrArr do
    if UpperCase(ArrValue) = UpperCase(aValue) then
      Exit(True);
end;

function TModelTrackFiles.DefineArtistName(aTrackFile: TTrackFile): TArray<string>;
begin
  Result := [];

  AddVariant(Result, aTrackFile.ID3v1.Artist);
  AddVariant(Result, aTrackFile.ID3v2.Artist);

  if Length(Result) = 0 then
    Result := Result + ['Unknown Artist'];
end;

procedure TModelTrackFiles.ApplyTrackToArtistList(aArtistList: TArtistList; var aTrackFile: TTrackFile);
var
  Album: TAlbum;
  AlbumVariants: TArray<string>;
  Artist: TArtist;
  ArtistVariants: TArray<string>;
  Track: TTrack;
  TrackRel: TTrackRel;
  TrackVariants: TArray<string>;
begin
  ArtistVariants := DefineArtistName(aTrackFile);
  Artist := aArtistList.AddOrGetFromStorage(ArtistVariants[0]);
  aTrackFile.Artist := Artist;

  AlbumVariants := DefineAlbumName(aTrackFile);
  Album := Artist.AlbumList.GetByName(AlbumVariants[0]);
  if Album = nil then
    begin
      Album := TAlbum.Create;
      Album.Title := AlbumVariants[0];
      Artist.AlbumList.Add(Album);
    end;
  aTrackFile.Album := Album;

  TrackVariants := DefineTrackName(aTrackFile);
  Track := Album.TrackRels.GetTrackByName(TrackVariants[0]);
  if Track = nil then
    begin
      TrackRel := TTrackRel.Create;
      TrackRel.Track := TTrack.Create;
      TrackRel.Track.Title := TrackVariants[0];
      Album.TrackRels.Add(TrackRel);
    end;
  aTrackFile.Track := Track;
end;

procedure TModelTrackFiles.Start;
var
  FileName: string;
  FileInfo: TFileInfo;
  FileInfoArr: TArray<TFileInfo>;
  TrackFile: TTrackFile;
begin
  FileInfoArr := [];
  outArtistList := TArtistList.Create([], []);

  for FileName in inDropedFiles do
    FileInfoArr := FileInfoArr + TFilesEngine.GetFileInfoArr(FileName);

  outTrackFileArr := [];
  for FileInfo in FileInfoArr do
    begin
      TrackFile.ID := THashMD5.GetHashString(FileInfo.FullPath);
      TrackFile.FileInfo := FileInfo;
      TrackFile.ID3v1.LoadFromFile(FileInfo.FullPath);
      TrackFile.ID3v2.LoadFromFile(FileInfo.FullPath);

      ApplyTrackToArtistList(outArtistList, TrackFile);

      outTrackFileArr := outTrackFileArr + [TrackFile];
    end;
end;

end.
