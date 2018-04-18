unit mTrackFiles;

interface

uses
  API_MVC,
  eArtist,
  eTrack,
  eTrackFile;

type
  TModelDefineTrackFiles = class(TModelAbstract)
  private
    function CheckConsilience(aStrArr: TArray<string>; aValue: string): Boolean;
    function DefineAlbumName(aTrackFile: TTrackFile): TArray<string>;
    function DefineAlbumYear(aTrackFile: TTrackFile): Integer;
    function DefineArtistName(aTrackFile: TTrackFile): TArray<string>;
    function DefineTrackName(aTrackFile: TTrackFile): TArray<string>;
    function DefineTrackOrder(aTrackFile: TTrackFile): Integer;
    procedure AddVariant(var aStrArr: TArray<string>; aValue: string);
    procedure ApplyTrackFileToArtistList(aArtistList: TArtistList; var aTrackFile: TTrackFile);
  public
    inDropedFiles: TArray<string>;
    inFileFormat: string;
    inPathFormat: string;
    outArtistList: TArtistList;
    outTrackFile: TTrackFile;
    outTrackFileArr: TArray<TTrackFile>;
    procedure Start; override;
  end;

  TModelStoreTrackFiles = class(TModelAbstract)
  public
    procedure Start; override;
  end;

implementation

uses
  API_Files,
  eAlbum,
  System.Hash,
  System.SysUtils;

procedure TModelStoreTrackFiles.Start;
begin

end;

function TModelDefineTrackFiles.DefineAlbumYear(aTrackFile: TTrackFile): Integer;
begin
  Result := aTrackFile.ID3v1.Year;
end;

function TModelDefineTrackFiles.DefineTrackOrder(aTrackFile: TTrackFile): Integer;
begin
  Result := StrToIntDef(aTrackFile.ID3v1.Track, 0);
end;

function TModelDefineTrackFiles.DefineTrackName(aTrackFile: TTrackFile): TArray<string>;
begin
  Result := [];

  AddVariant(Result, aTrackFile.ID3v1.Title);
  AddVariant(Result, aTrackFile.ID3v2.Title);

  if Length(Result) = 0 then
    Result := Result + ['Unknown Track'];
end;

function TModelDefineTrackFiles.DefineAlbumName(aTrackFile: TTrackFile): TArray<string>;
begin
  Result := [];

  AddVariant(Result, aTrackFile.ID3v1.Album);
  AddVariant(Result, aTrackFile.ID3v2.Album);

  if Length(Result) = 0 then
    Result := Result + ['Unknown Album'];
end;

procedure TModelDefineTrackFiles.AddVariant(var aStrArr: TArray<string>; aValue: string);
begin
  if not aValue.IsEmpty and
     not CheckConsilience(aStrArr, aValue.Trim)
  then
    aStrArr := aStrArr + [aValue.Trim];
end;

function TModelDefineTrackFiles.CheckConsilience(aStrArr: TArray<string>; aValue: string): Boolean;
var
  ArrValue: string;
begin
  Result := False;

  for ArrValue in aStrArr do
    if UpperCase(ArrValue) = UpperCase(aValue) then
      Exit(True);
end;

function TModelDefineTrackFiles.DefineArtistName(aTrackFile: TTrackFile): TArray<string>;
begin
  Result := [];

  AddVariant(Result, aTrackFile.ID3v1.Artist);
  AddVariant(Result, aTrackFile.ID3v2.Artist);

  if Length(Result) = 0 then
    Result := Result + ['Unknown Artist'];
end;

procedure TModelDefineTrackFiles.ApplyTrackFileToArtistList(aArtistList: TArtistList; var aTrackFile: TTrackFile);
var
  Album: TAlbum;
  AlbumVariants: TArray<string>;
  Artist: TArtist;
  ArtistVariants: TArray<string>;
  Track: TTrack;
  TrackOrder: Integer;
  TrackRel: TTrackRel;
  TrackVariants: TArray<string>;
  Year: Integer;
begin
  ArtistVariants := DefineArtistName(aTrackFile);
  Artist := aArtistList.AddOrGetFromStorage(ArtistVariants[0]);
  aTrackFile.Artist := Artist;

  AlbumVariants := DefineAlbumName(aTrackFile);
  Year := DefineAlbumYear(aTrackFile);
  Album := Artist.AlbumList.GetByName(AlbumVariants[0]);
  if Album = nil then
    begin
      Album := TAlbum.Create;
      Album.Title := AlbumVariants[0];
      Album.Year := Year;

      Artist.AlbumList.Add(Album);
    end;
  aTrackFile.Album := Album;

  TrackVariants := DefineTrackName(aTrackFile);
  TrackOrder := DefineTrackOrder(aTrackFile);
  Track := Album.TrackRels.GetTrackByName(TrackVariants[0]);
  if Track = nil then
    begin
      TrackRel := TTrackRel.Create;
      TrackRel.Track := TTrack.Create;
      TrackRel.Track.Title := TrackVariants[0];
      TrackRel.Order := TrackOrder;

      Album.TrackRels.Add(TrackRel);

      Track := TrackRel.Track;
    end;
  aTrackFile.Track := Track;
end;

procedure TModelDefineTrackFiles.Start;
var
  FileName: string;
  FileInfo: TFileInfo;
  FileInfoArr: TArray<TFileInfo>;
begin
  FileInfoArr := [];
  outArtistList := TArtistList.Create([], []);

  for FileName in inDropedFiles do
    FileInfoArr := FileInfoArr + TFilesEngine.GetFileInfoArr(FileName);

  for FileInfo in FileInfoArr do
    begin
      outTrackFile.ID := THashMD5.GetHashString(FileInfo.FullPath);
      outTrackFile.FileInfo := FileInfo;
      outTrackFile.ID3v1.LoadFromFile(FileInfo.FullPath);
      outTrackFile.ID3v2.LoadFromFile(FileInfo.FullPath);

      //поиск в инете

      ApplyTrackFileToArtistList(outArtistList, outTrackFile);

      outTrackFile.SetNewFileName(inFileFormat);
      outTrackFile.SetNewPath(inPathFormat);

      SendMessage('OnAfterTrackFileFill');
    end;
end;

end.
