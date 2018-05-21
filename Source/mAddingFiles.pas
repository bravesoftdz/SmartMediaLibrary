unit mAddingFiles;

interface

uses
  API_Files,
  API_MVC,
  eArtist,
  eGenre,
  eMediaFile;

type
  TModelDefineFiles = class(TModelAbstract)
  private
    FAudioGenreList: TGenreList;
    function CheckConsilience(aStrArr: TArray<string>; aValue: string): Boolean;
    procedure AddVariant(var aStrArr: TArray<string>; aValue: string);
    procedure ApplyToAudioLib(aMediaFile: TMediaFile; const aArtistVariants,
      aAlbumVariants, aTrackVariants: TArray<string>);
    procedure ReadFileData(aMediaFile: TMediaFile; var aArtistVariants,
      aAlbumVariants, aTrackVariants: TArray<string>);
    procedure ReadMP3Data(aMediaFile: TMediaFile; out aArtistVariants,
      aAlbumVariants, aTrackVariants: TArray<string>);
    procedure ReadWMAData(aMediaFile: TMediaFile; out aArtistVariants,
      aAlbumVariants, aTrackVariants: TArray<string>);
    procedure WriteMP3Data(aMediaFile: TMediaFile);
    procedure WriteWMAData(aMediaFile: TMediaFile);
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
    inMediaFileList: TMediaFileList;
    procedure Start; override;
  end;

implementation

uses
  API_Strings,
  eAlbum,
  eTrack,
  System.Classes,
  System.SysUtils;

procedure TModelDefineFiles.WriteWMAData(aMediaFile: TMediaFile);
begin
  aMediaFile.WMA.Artist := aMediaFile.Artist.Title;
  aMediaFile.WMA.Album := aMediaFile.Album.Title;
  aMediaFile.WMA.Title := aMediaFile.TrackRel.Track.Title;
  aMediaFile.WMA.Track := aMediaFile.Album.TrackNum[aMediaFile.TrackRel.Track];
  aMediaFile.WMA.Year := aMediaFile.Album.Year;
  aMediaFile.WMA.AlbumArtist := aMediaFile.Artist.Title;
  aMediaFile.WMA.Comment := 'Alezzle`s Collection';
end;

procedure TModelDefineFiles.ReadWMAData(aMediaFile: TMediaFile; out aArtistVariants,
  aAlbumVariants, aTrackVariants: TArray<string>);
begin
  aMediaFile.WMA.LoadFromFile(aMediaFile.FileInfo.FullPath);

  aArtistVariants := [];
  AddVariant(aArtistVariants, aMediaFile.WMA.Artist);

  aAlbumVariants := [];
  AddVariant(aAlbumVariants, aMediaFile.WMA.Album);

  aTrackVariants := [];
  AddVariant(aTrackVariants, aMediaFile.WMA.Title);

  aMediaFile.TrackOrder := StrToIntDef(aMediaFile.WMA.Track, 0);
  aMediaFile.Year := aMediaFile.WMA.Year;
end;

procedure TModelDefineFiles.WriteMP3Data(aMediaFile: TMediaFile);
begin
  aMediaFile.ID3v1.Artist := aMediaFile.Artist.Title;
  aMediaFile.ID3v1.Album := aMediaFile.Album.Title;
  //aMediaFile.ID3v1.Title := aMediaFile.TrackRel.Track.Title;
  //aMediaFile.ID3v1.Track := aMediaFile.Album.TrackNum[aMediaFile.TrackRel.Track];
  aMediaFile.ID3v1.Year :=  aMediaFile.Album.Year;
  aMediaFile.ID3v1.Comment := 'Alezzle`s Collection';

  aMediaFile.ID3v2.Artist := aMediaFile.Artist.Title;
  aMediaFile.ID3v2.Album := aMediaFile.Album.Title;
  //aMediaFile.ID3v2.Title := aMediaFile.TrackRel.Track.Title;
  aMediaFile.ID3v2.Track := aMediaFile.Album.TrackNum[aMediaFile.TrackRel.Track];
  aMediaFile.ID3v2.Year := aMediaFile.Album.Year;
  aMediaFile.ID3v2.Comment := 'Alezzle`s Collection';
end;

procedure TModelDefineFiles.ReadFileData(aMediaFile: TMediaFile; var aArtistVariants,
  aAlbumVariants, aTrackVariants: TArray<string>);
var
  TrackOrder: string;
begin
  TrackOrder := TStrTool.GetRegExFirstMatch(aMediaFile.FileInfo.Name, '\d{1,2}');
  if not TrackOrder.IsEmpty and
     (TrackOrder <> aMediaFile.TrackOrder.ToString)
  then
    aMediaFile.TrackOrder := TrackOrder.ToInteger;
end;

procedure TModelStoreFiles.Start;
var
  DestPath: string;
  i: Integer;
  MediaFile: TMediaFile;
  SourcePath: string;
begin
  for i := 0 to inMediaFileList.Count - 1 do
    begin
      MediaFile := inMediaFileList.Items[i];

      if MediaFile.MediaType = mtUnknown then
        Continue;

      SourcePath := MediaFile.FileInfo.FullPath;
      DestPath := MediaFile.Destination.FullPath;

      TFilesEngine.Move(SourcePath, DestPath);

      case MediaFile.MediaFormat of
        mfMP3: begin
                 MediaFile.ID3v1.SaveToFile(DestPath);
                 MediaFile.ID3v2.SaveToFile(DestPath);
               end;
        mfWMA: MediaFile.WMA.SaveToFile(DestPath);
      end;
    end;
end;

procedure TModelDefineFiles.ApplyToAudioLib(aMediaFile: TMediaFile; const aArtistVariants,
  aAlbumVariants, aTrackVariants: TArray<string>);
var
  Album: TAlbum;
  Artist: TArtist;
  CoverStream: TStream;
  GenreID: Integer;
  TrackRel: TTrackRel;
begin
  Artist := outAudioList.AddOrGetArtist(aArtistVariants[0]);
  outMediaFile.LinkArtist(Artist);

  Album := Artist.AlbumList.GetByName(aAlbumVariants[0]);
  if Album = nil then
    begin
      Album := TAlbum.Create;
      Album.Title := aAlbumVariants[0];
      Album.Year := outMediaFile.Year;

      GenreID := FAudioGenreList.GetGenreIDByName(outMediaFile.Genre);
      Album.SetDefaultGenre(GenreID);

      CoverStream := outMediaFile.ID3v2.CreateCoverPictureStream;
      try 
        Album.SetCoverFromStream(CoverStream, outMediaFile.ID3v2.CoverPicMIME);      
      finally
        CoverStream.Free;
      end;

      Artist.AlbumList.Add(Album);
    end;
  outMediaFile.LinkAlbum(Album);

  TrackRel := Album.TrackRels.GetTrackByName(aTrackVariants[0]);
  if TrackRel = nil then
    begin
      TrackRel := TTrackRel.Create;
      TrackRel.Track := TTrack.Create;
      TrackRel.Track.Title := aTrackVariants[0];
      TrackRel.Order := aMediaFile.TrackOrder;

      Album.TrackRels.Add(TrackRel);
    end;
  outMediaFile.TrackRel := TrackRel;

  TrackRel.Track.OnTitleChanged := outMediaFile.OnTrackTitleChanged;
  outMediaFile.OnTrackTitleChanged;

  TrackRel.OnOrderChanged := outMediaFile.OnTrackOrderChanged;
  outMediaFile.OnTrackOrderChanged;
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

procedure TModelDefineFiles.ReadMP3Data(aMediaFile: TMediaFile; out aArtistVariants,
  aAlbumVariants, aTrackVariants: TArray<string>);
begin
  aMediaFile.ID3v1.LoadFromFile(aMediaFile.FileInfo.FullPath);
  aMediaFile.ID3v2.LoadFromFile(aMediaFile.FileInfo.FullPath);

  aArtistVariants := [];
  AddVariant(aArtistVariants, aMediaFile.ID3v2.Artist);
  AddVariant(aArtistVariants, aMediaFile.ID3v1.Artist);

  aAlbumVariants := [];
  AddVariant(aAlbumVariants, aMediaFile.ID3v2.Album);
  AddVariant(aAlbumVariants, aMediaFile.ID3v1.Album);

  aTrackVariants := [];
  AddVariant(aTrackVariants, aMediaFile.ID3v2.Title);
  AddVariant(aTrackVariants, aMediaFile.ID3v1.Title);

  aMediaFile.TrackOrder := StrToIntDef(aMediaFile.ID3v1.Track, 0);
  aMediaFile.Year := aMediaFile.ID3v1.Year;
  aMediaFile.Genre := aMediaFile.ID3v2.Genre;
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
  FAudioGenreList := TGenreList.Create(['*'], ['NAME']);

  try 
    FileInfoArr := [];
    for FileName in inDropedFiles do
      FileInfoArr := FileInfoArr + TFilesEngine.GetFileInfoArr(FileName);

    for FileInfo in FileInfoArr do
      begin
        // Init
        outMediaFile := TMediaFile.Create;
        outMediaFile.FileInfo := FileInfo;
        outMediaFile.Album := nil;
        outMediaFile.Artist := nil;
        outMediaFile.TrackRel := nil;
        outMediaFile.TrackOrder := 0;
        outMediaFile.Year := 0;
        outMediaFile.Genre := '';

        // Read Data
        if FileInfo.Extension.ToUpper = 'MP3' then
          begin
            outMediaFile.MediaType := mtAudio;
            outMediaFile.MediaFormat := mfMP3;
            ReadMP3Data(outMediaFile, ArtistVariants, AlbumVariants, TrackVariants);
          end
        else
        if FileInfo.Extension.ToUpper = 'WMA' then
          begin
            outMediaFile.MediaType := mtAudio;
            outMediaFile.MediaFormat := mfWMA;
            ReadWMAData(outMediaFile, ArtistVariants, AlbumVariants, TrackVariants);
          end
        else
          begin
            outMediaFile.MediaType := mtUnknown;
            outMediaFile.MediaFormat := mfUnknown;
          end;

        ReadFileData(outMediaFile, ArtistVariants, AlbumVariants, TrackVariants);

        // Apply To Lib
        case outMediaFile.MediaType of
          mtAudio: ApplyToAudioLib(outMediaFile, ArtistVariants, AlbumVariants, TrackVariants);
        end;

        // Write Data
        {case outMediaFile.MediaFormat of
          mfMP3: WriteMP3Data(outMediaFile);
          mfWMA: WriteWMAData(outMediaFile);
        end; }
        // TEMP
        outMediaFile.ID3v1.Comment := 'Alezzle`s Collection';
        outMediaFile.ID3v2.Comment := 'Alezzle`s Collection';

        if outMediaFile.MediaType <> mtUnknown then
          begin
            outMediaFile.SetDestFileName(inFileFormat);
            outMediaFile.SetDestPath(inPathFormat);
          end;

        SendMessage('OnFileAdded');
      end;
  finally
    FAudioGenreList.Free;
  end;
end;

end.
