unit mAddingFiles;

interface

uses
  API_Files,
  API_MVC,
  eArtist,
  eMediaFile;

type
  TModelDefineFiles = class(TModelAbstract)
  private
    function CheckConsilience(aStrArr: TArray<string>; aValue: string): Boolean;
    procedure AddVariant(var aStrArr: TArray<string>; aValue: string);
    procedure ApplyToAudioLib(var aMediaFile: TMediaFile; const aArtistVariants,
      aAlbumVariants, aTrackVariants: TArray<string>);
    procedure DefineMP3File(var aMediaFile: TMediaFile; out aArtistVariants,
      aAlbumVariants, aTrackVariants: TArray<string>);
  public
    inDropedFiles: TArray<string>;
    inFileFormat: string;
    inPathFormat: string;
    outAudioList: TAudioList;
    outMediaFile: TMediaFile;
    procedure Start; override;
  end;

  TModelStoreFiles = class(TModelAbstract)
  public
    inMediaFileArr: TArray<TMediaFile>;
    procedure Start; override;
  end;

implementation

uses
  eAlbum,
  eTrack,
  System.Hash,
  System.SysUtils;

procedure TModelStoreFiles.Start;
var
  DestPath: string;
  MediaFile: TMediaFile;
  SourcePath: string;
begin
  for MediaFile in inMediaFileArr do
    begin
      SourcePath := MediaFile.FileInfo.FullPath;
      DestPath := MediaFile.Destination.FullPath;

      TFilesEngine.Move(SourcePath, DestPath);
    end;
end;

procedure TModelDefineFiles.ApplyToAudioLib(var aMediaFile: TMediaFile; const aArtistVariants,
  aAlbumVariants, aTrackVariants: TArray<string>);
var
  Album: TAlbum;
  Artist: TArtist;
  Track: TTrack;
  TrackRel: TTrackRel;
begin
  Artist := outAudioList.AddOrGetArtist(aArtistVariants[0]);
  outMediaFile.Artist := Artist;

  Album := Artist.AlbumList.GetByName(aAlbumVariants[0]);
  if Album = nil then
    begin
      Album := TAlbum.Create;
      Album.Title := aAlbumVariants[0];

      Artist.AlbumList.Add(Album);
    end;
  outMediaFile.Album := Album;

  Track := Album.TrackRels.GetTrackByName(aTrackVariants[0]);
  if Track = nil then
    begin
      TrackRel := TTrackRel.Create;
      TrackRel.Track := TTrack.Create;
      TrackRel.Track.Title := aTrackVariants[0];
      TrackRel.Order := aMediaFile.TrackOrder;

      Album.TrackRels.Add(TrackRel);

      Track := TrackRel.Track;
    end;
  outMediaFile.Track := Track;
end;

function TModelDefineFiles.CheckConsilience(aStrArr: TArray<string>; aValue: string): Boolean;
var
  ArrValue: string;
begin
  Result := False;

  for ArrValue in aStrArr do
    if UpperCase(ArrValue) = UpperCase(aValue) then
      Exit(True);
end;

procedure TModelDefineFiles.AddVariant(var aStrArr: TArray<string>; aValue: string);
begin
  if not aValue.IsEmpty and
     not CheckConsilience(aStrArr, aValue.Trim)
  then
    aStrArr := aStrArr + [aValue.Trim];
end;

procedure TModelDefineFiles.DefineMP3File(var aMediaFile: TMediaFile; out aArtistVariants,
  aAlbumVariants, aTrackVariants: TArray<string>);
begin
  aMediaFile.ID3v1.LoadFromFile(aMediaFile.FileInfo.FullPath);
  aMediaFile.ID3v2.LoadFromFile(aMediaFile.FileInfo.FullPath);

  aArtistVariants := [];
  AddVariant(aArtistVariants, aMediaFile.ID3v1.Artist);
  AddVariant(aArtistVariants, aMediaFile.ID3v2.Artist);

  aAlbumVariants := [];
  AddVariant(aAlbumVariants, aMediaFile.ID3v1.Album);
  AddVariant(aAlbumVariants, aMediaFile.ID3v2.Album);

  aTrackVariants := [];
  AddVariant(aTrackVariants, aMediaFile.ID3v1.Title);
  AddVariant(aTrackVariants, aMediaFile.ID3v2.Title);

  aMediaFile.TrackOrder := StrToIntDef(aMediaFile.ID3v1.Track, 0);
end;

procedure TModelDefineFiles.Start;
var
  AlbumVariants: TArray<string>;
  ArtistVariants: TArray<string>;
  FileInfo: TFileInfo;
  FileInfoArr: TArray<TFileInfo>;
  FileName: string;
  TrackVariants: TArray<string>;
begin
  outAudioList := TAudioList.Create([], []);

  FileInfoArr := [];
  for FileName in inDropedFiles do
    FileInfoArr := FileInfoArr + TFilesEngine.GetFileInfoArr(FileName);

  for FileInfo in FileInfoArr do
    begin
      outMediaFile.Hash := THashMD5.GetHashString(FileInfo.FullPath);
      outMediaFile.FileInfo := FileInfo;

      if FileInfo.Extension.ToUpper = 'MP3' then
        begin
          outMediaFile.MediaType := mtAudio;
          outMediaFile.MediaFormat := mfMP3;
          DefineMP3File(outMediaFile, ArtistVariants, AlbumVariants, TrackVariants);
        end
      else
        outMediaFile.MediaType := mtUnknown;

      case outMediaFile.MediaType of
        mtAudio: ApplyToAudioLib(outMediaFile, ArtistVariants, AlbumVariants, TrackVariants);
      end;

      outMediaFile.SetDestFileName(inFileFormat);
      outMediaFile.SetDestPath(inPathFormat);

      SendMessage('OnFileAdded');
    end;
end;

end.
