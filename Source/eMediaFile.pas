unit eMediaFile;

interface

uses
  API_Files,
  API_Types,
  eAlbum,
  eArtist,
  eTrack,
  System.Classes,
  System.Generics.Collections;

type
  TMediaType = (mtUnknown, mtAudio, mtVideo);
  TMediaFormat = (mfUnknown, mfMP3, mfWMA);

  TWMA = record
  public
    Album: string;
    AlbumArtist: string;
    Artist: string;
    Comment: string;
    Genre: string;
    Title: string;
    Track: string;
    Year: Integer;
    procedure LoadFromFile(const aPath: string);
    procedure SaveToFile(const aPath: string);
  end;

  TID3v1 = record
  public
    Album: string;
    Artist: string;
    Comment: string;
    Genre: string;
    Title: string;
    Track: string;
    Year: Integer;
    procedure LoadFromFile(const aPath: string);
    procedure SaveToFile(const aPath: string);
  end;

  TID3v2 = record
  private
    FCoverPic: string;
    FFileName: string;
  public
    Album: string;
    AlbumArtist: string;
    Artist: string;
    BPM: string;
    Comment: string;
    Composer: string;
    Copyright: string;
    CoverPicMIME: TMIMEType;
    Disc: string;
    Encoded: string;
    Genre: string;
    OrigArtist: string;
    Publisher: string;
    Title: string;
    Track: string;
    URL: string;
    Year: Integer;
    function CreateCoverPictureStream: TStream;
    procedure LoadFromFile(const aPath: string);
    procedure SaveToFile(const aPath: string);
    procedure SetCoverPictureFromStream(aPictureStream: TStream);
  end;

  TDestination = record
  public
    FileName: string;
    FullPath: string;
  end;

  TMediaFile = class
  private
    FFileFormat: string;
    FPathFormat: string;
    function GetSubArr(aFileFormat: string): TArray<string>;
    function RemoveInvalidChars(aStr: string): string;
    function ReplaceSub(aOldStr, aSub: string): string;
    procedure OnAlbumCoverChanged;
    procedure OnAlbumGenreChanged;
    procedure OnAlbumTitleChanged;
    procedure OnAlbumYearChanged;
    procedure OnArtistTitleChanged;
    procedure UpdateDestination;
  public
    Album: TAlbum;
    Artist: TArtist;
    Destination: TDestination;
    FileInfo: TFileInfo;
    Genre: string;
    ID3v1: TID3v1;
    ID3v2: TID3v2;
    MediaFormat: TMediaFormat;
    MediaType: TMediaType;
    TrackRel: TTrackRel;
    TrackOrder: Integer;
    WMA: TWMA;
    Year: Integer;
    procedure LinkAlbum(aAlbum: TAlbum);
    procedure LinkArtist(aArtist: TArtist);
    procedure OnTrackOrderChanged;
    procedure OnTrackTitleChanged;
    procedure SetDestFileName(const aFileFormat: string);
    procedure SetDestPath(const aPathFormat: string);
  end;

  TMediaFileList = class(TObjectList<TMediaFile>)
  public
    procedure ReplaceAlbum(aOldAlbum, aNewAlbum: TAlbum);
    procedure ReplaceArtist(aOldArtist, aNewArtist: TArtist);
  end;

implementation

uses
  ID3v1Library,
  ID3v2Library,
  System.IOUtils,
  System.SysUtils,
  WMATagLibrary;

procedure TMediaFileList.ReplaceArtist(aOldArtist, aNewArtist: TArtist);
var
  MediaFile: TMediaFile;
begin
  for MediaFile in Self do
    if MediaFile.Artist = aOldArtist then
      MediaFile.LinkArtist(aNewArtist);
end;

procedure TMediaFileList.ReplaceAlbum(aOldAlbum, aNewAlbum: TAlbum);
var
  MediaFile: TMediaFile;
begin
  for MediaFile in Self do
    if MediaFile.Album = aOldAlbum then
      MediaFile.LinkAlbum(aNewAlbum);
end;

procedure TMediaFile.OnAlbumYearChanged;
begin
  ID3v1.Year := Album.Year;
  ID3v2.Year := Album.Year;

  UpdateDestination;
end;

function TMediaFile.RemoveInvalidChars(aStr: string): string;
var
  InvalidChar: Char;
begin
  Result := aStr;

  for InvalidChar in TPath.GetInvalidFileNameChars do
    if Result.IndexOf(InvalidChar) >= 0 then
      Result := Result.Replace(InvalidChar, '');

  for InvalidChar in TPath.GetInvalidPathChars + [':'] do
    if Result.IndexOf(InvalidChar) >= 0 then
      Result := Result.Replace(InvalidChar, '');
end;

procedure TMediaFile.OnArtistTitleChanged;
begin
  ID3v1.Artist := Artist.Title;
  ID3v2.Artist := Artist.Title;

  UpdateDestination;
end;

procedure TMediaFile.LinkArtist(aArtist: TArtist);
var
  Proc: TObjProc;
begin
  Artist := aArtist;

  Proc := OnArtistTitleChanged;
  TMethodEngine.AddProcToArr(Artist.OnTitleChangedProcArr, @Proc, Self);
  OnArtistTitleChanged;
end;

procedure TMediaFile.OnAlbumGenreChanged;
begin
  ID3v1.Genre := Album.DefaultGenre.Name;
  ID3v2.Genre := Album.DefaultGenre.Name;

  UpdateDestination;
end;

procedure TMediaFile.OnAlbumCoverChanged;
begin
  ID3v2.FCoverPic := Album.Cover.PicBytes;
  ID3v2.CoverPicMIME := Album.Cover.MIMEType;
end;

procedure TMediaFile.LinkAlbum(aAlbum: TAlbum);
var
  OldAlbum: TAlbum;
  Proc: TObjProc;
begin
  OldAlbum := Album;
  Album := aAlbum;

  Proc := OnAlbumTitleChanged;
  if OldAlbum <> nil then
    TMethodEngine.RemoveProcFromArr(OldAlbum.OnTitleChangedProcArr, @Proc, Self);
  TMethodEngine.AddProcToArr(Album.OnTitleChangedProcArr, @Proc, Self);
  OnAlbumTitleChanged;

  Proc := OnAlbumCoverChanged;
  if OldAlbum <> nil then
    TMethodEngine.RemoveProcFromArr(OldAlbum.OnCoverChangedProcArr, @Proc, Self);
  TMethodEngine.AddProcToArr(Album.OnCoverChangedProcArr, @Proc, Self);
  if Album.Cover <> nil then
    OnAlbumCoverChanged;

  Proc := OnAlbumGenreChanged;
  if OldAlbum <> nil then
    TMethodEngine.RemoveProcFromArr(OldAlbum.OnGenreChangedProcArr, @Proc, Self);
  TMethodEngine.AddProcToArr(Album.OnGenreChangedProcArr, @Proc, Self);
  if Album.DefaultGenre <> nil then
    OnAlbumGenreChanged;

  Proc := OnAlbumYearChanged;
  if OldAlbum <> nil then
    TMethodEngine.RemoveProcFromArr(OldAlbum.OnYearChangedProcArr, @Proc, Self);
  TMethodEngine.AddProcToArr(Album.OnYearChangedProcArr, @Proc, Self);
  OnAlbumYearChanged;
end;

procedure TMediaFile.OnAlbumTitleChanged;
begin
  ID3v1.Album := Album.Title;
  ID3v2.Album := Album.Title;

  UpdateDestination;
end;

procedure TMediaFile.OnTrackOrderChanged;
begin
  ID3v1.Track := Album.TrackNum[TrackRel.Track];
  ID3v2.Track := Album.TrackNum[TrackRel.Track];

  UpdateDestination;
end;

procedure TMediaFile.UpdateDestination;
begin
  SetDestFileName(FFileFormat);
  SetDestPath(FPathFormat);
end;

procedure TMediaFile.OnTrackTitleChanged;
begin
  ID3v1.Title := TrackRel.Track.Title;
  ID3v2.Title := TrackRel.Track.Title;

  UpdateDestination;
end;

function TID3v2.CreateCoverPictureStream: TStream;
begin
  Result := TStreamEngine.CreateStreamFromByteString(FCoverPic);
end;

procedure TID3v2.SetCoverPictureFromStream(aPictureStream: TStream);
begin
  FCoverPic := TStreamEngine.GetByteString(aPictureStream);
end;

procedure TWMA.SaveToFile(const aPath: string);
var
  WMATag: TWMATag;
begin
  WMATag := TWMATag.Create;
  try
    WMATag.SetTextFrameText(g_wszWMTrackNumber, Self.Track);
    WMATag.SetTextFrameText(g_wszWMAlbumTitle, Self.Album);
    WMATag.SetTextFrameText(g_wszWMAuthor, Self.Artist);
    WMATag.SetTextFrameText(g_wszWMAlbumArtist, Self.AlbumArtist);
    WMATag.SetTextFrameText(g_wszWMTitle, Self.Title);
    WMATag.SetTextFrameText(g_wszWMYear, Self.Year.ToString);
    WMATag.SetTextFrameText(g_wszWMGenre, Self.Genre);
    WMATag.SetTextFrameText(g_wszWMDescription, Self.Comment);

    WMATag.SaveToFile(aPath);
  finally
    WMATag.Free;
  end;
end;

procedure TWMA.LoadFromFile(const aPath: string);
var
  WMATag: TWMATag;
begin
  WMATag := TWMATag.Create;
  try
    WMATag.LoadFromFile(aPath);

    Self.Track := WMATag.ReadFrameByNameAsText(g_wszWMTrackNumber);
    Self.Album := WMATag.ReadFrameByNameAsText(g_wszWMAlbumTitle);
    Self.Artist := WMATag.ReadFrameByNameAsText(g_wszWMAuthor);
    Self.AlbumArtist := WMATag.ReadFrameByNameAsText(g_wszWMAlbumArtist);
    Self.Title := WMATag.ReadFrameByNameAsText(g_wszWMTitle);
    Self.Year := StrToIntDef(WMATag.ReadFrameByNameAsText(g_wszWMYear), 0);
    Self.Genre := WMATag.ReadFrameByNameAsText(g_wszWMGenre);
    Self.Comment := WMATag.ReadFrameByNameAsText(g_wszWMDescription);
  finally
    WMATag.Free;
  end;
end;

procedure TID3v2.SaveToFile(const aPath: string);
var
  Description: string;
  FrameIndex: Integer;
  ID3v2Tag: TID3v2Tag;
  LanguageID: TLanguageID;
  MIME: string;
  PictureStream: TStream;
  PictureType: Integer;
begin
  ID3v2Tag := TID3v2Tag.Create;
  try
    ID3v2Tag.LoadFromFile(aPath);

    ID3v2Tag.SetUnicodeText('TRCK', Self.Track);
    ID3v2Tag.SetUnicodeText('MCDI', Self.Disc);
    ID3v2Tag.SetUnicodeText('TIT2', Self.Title);
    ID3v2Tag.SetUnicodeText('TPE1', Self.Artist);
    ID3v2Tag.SetUnicodeText('TALB', Self.Album);
    ID3v2Tag.SetUnicodeText('TYER', Self.Year.ToString);
    ID3v2Tag.SetUnicodeText('TCON', Self.Genre);

    StringToLanguageID(Self.Comment, LanguageID);
    ID3v2Tag.SetUnicodeComment('COMM', Self.Comment, LanguageID, '');

    ID3v2Tag.SetUnicodeText('TCOM', Self.Composer);
    ID3v2Tag.SetUnicodeText('TPUB', Self.Publisher);
    ID3v2Tag.SetUnicodeText('TOPE', Self.OrigArtist);
    ID3v2Tag.SetUnicodeText('WCOP', Self.Copyright);
    ID3v2Tag.SetUnicodeText('WXXX', Self.URL);
    ID3v2Tag.SetUnicodeText('TENC', Self.Encoded);
    ID3v2Tag.SetUnicodeText('TBPM', Self.BPM);

    if CoverPicMIME <> TMIMEType.mtUnknown then
      begin
        PictureStream := TStreamEngine.CreateStreamFromByteString(FCoverPic);
        try
          if PictureStream.Size > 0 then
            begin
              ID3v2Tag.DeleteAllCoverArts;

              FrameIndex := ID3v2Tag.AddFrame('APIC');
              PictureType := $03;
              MIME := MIMETypeToStr(CoverPicMIME);
              ID3v2Tag.SetUnicodeCoverPictureFromStream(FrameIndex, Description, PictureStream, MIME, PictureType);
            end;
        finally
          PictureStream.Free;
        end;
      end;

    ID3v2Tag.SaveToFile(aPath);
    FFileName := aPath;
  finally
    ID3v2Tag.Free;
  end;
end;

procedure TID3v1.SaveToFile(const aPath: string);
var
  ID3v1Tag: TID3v1Tag;
begin
  ID3v1Tag := TID3v1Tag.Create;
  try
    ID3v1Tag.LoadFromFile(aPath);

    ID3v1Tag.Track := StrToIntDef(Self.Track, 1);
    ID3v1Tag.Album := Self.Album;
    ID3v1Tag.Artist := Self.Artist;
    ID3v1Tag.Title := Self.Title;
    ID3v1Tag.Year := Self.Year.ToString;
    ID3v1Tag.Genre := Self.Genre;
    ID3v1Tag.Comment := Self.Comment;

    ID3v1Tag.SaveToFile(aPath);
  finally
    ID3v1Tag.Free;
  end;
end;

function TMediaFile.ReplaceSub(aOldStr, aSub: string): string;
var
  NewSub: string;
begin
  if aSub = 'TrackNum' then
    NewSub := Album.TrackNum[TrackRel.Track];

  if aSub = 'TrackTitle' then
    NewSub := TrackRel.Track.Title;

  if aSub = 'ArtistName' then
    NewSub := Artist.Title;

  //if aSub = 'AlbumType' then
  //  NewSub := Album.AlbumTypeID.ToString;

  if aSub = 'AlbumYear' then
    NewSub := Album.Year.ToString;

  if aSub = 'AlbumTitle' then
    NewSub := Album.Title;

  NewSub := RemoveInvalidChars(NewSub);
  Result := aOldStr.Replace(Format('{%s}', [aSub]), NewSub);
end;

function TMediaFile.GetSubArr(aFileFormat: string): TArray<string>;
var
  CanRead: Boolean;
  Chr: string;
  i: Integer;
  Sub: string;
begin
  Result := [];
  Sub := '';
  CanRead := False;

  for i := 1 to Length(aFileFormat) do
    begin
      Chr := aFileFormat[i];

      if Chr = '{' then
        CanRead := True;

      if Chr = '}' then
        begin
          Result := Result + [Sub];
          Sub := '';
          CanRead := False;
        end;

      if CanRead and
         (Chr <> '{')
      then
        Sub := Sub + Chr;
    end;
end;

procedure TMediaFile.SetDestFileName(const aFileFormat: string);
var
  FileName: string;
  Sub: string;
  SubArr: TArray<string>;
begin
  if FFileFormat.IsEmpty then
    FFileFormat := aFileFormat;

  SubArr := GetSubArr(FFileFormat);
  FileName := FFileFormat;

  for Sub in SubArr do
    FileName := ReplaceSub(FileName, Sub);

  Destination.FileName := Format('%s.%s', [FileName, FileInfo.Extension]);
end;

procedure TMediaFile.SetDestPath(const aPathFormat: string);
var
  Path: string;
  Sub: string;
  SubArr: TArray<string>;
begin
  if FPathFormat.IsEmpty then
    FPathFormat := aPathFormat;

  SubArr := GetSubArr(FPathFormat);
  Path := FPathFormat;

  for Sub in SubArr do
    Path := ReplaceSub(Path, Sub);

  Destination.FullPath := Path + Destination.FileName;
  if TrackRel <> nil then
    TrackRel.Track.Path := Destination.FullPath;
end;

procedure TID3v2.LoadFromFile(const aPath: string);
var
  Description: string;
  ID3v2Tag: TID3v2Tag;
  Index: Integer;
  LanguageID: TLanguageID;
  MIME: string;
  PictureStream: TMemoryStream;
  PictureType: Integer;
begin
  ID3v2Tag := TID3v2Tag.Create;
  try
    ID3v2Tag.LoadFromFile(aPath);
    FFileName := aPath;

    Self.Track := ID3v2Tag.GetUnicodeText('TRCK');
    Self.Disc := ID3v2Tag.GetUnicodeText('MCDI');
    Self.Title := ID3v2Tag.GetUnicodeText('TIT2');
    Self.Artist := ID3v2Tag.GetUnicodeText('TPE1');
    Self.Album := ID3v2Tag.GetUnicodeText('TALB');
    Self.Year := StrToIntDef(ID3v2Tag.GetUnicodeText('TYER'), 0);
    Self.Genre := ID3v2DecodeGenre(ID3v2Tag.GetUnicodeText('TCON'));
    Self.Comment := ID3v2Tag.GetUnicodeComment('COMM', LanguageID, Description);
    Self.Composer := ID3v2Tag.GetUnicodeText('TCOM');
    Self.Publisher := ID3v2Tag.GetUnicodeText('TPUB');
    Self.OrigArtist := ID3v2Tag.GetUnicodeText('TOPE');
    Self.Copyright := ID3v2Tag.GetUnicodeText('WCOP');
    Self.URL := ID3v2Tag.GetUnicodeText('WXXX');
    Self.Encoded := ID3v2Tag.GetUnicodeText('TENC');
    Self.BPM := ID3v2Tag.GetUnicodeText('TBPM');

    FCoverPic := '';
    Self.CoverPicMIME := TMIMEType.mtUnknown;
    Index := ID3v2Tag.FrameExists('APIC');
    if Index >= 0 then
      begin
        PictureStream := TMemoryStream.Create;
        try
          if ID3v2Tag.GetUnicodeCoverPictureStream(Index, TStream(PictureStream), MIME, Description, PictureType) and
             (PictureStream.Size > 0)
          then
            begin
              FCoverPic := TStreamEngine.GetByteString(PictureStream);
              Self.CoverPicMIME := StrToMIMEType(MIME.ToLower);
            end;
        finally
          PictureStream.Free;
        end;
      end;
  finally
    ID3v2Tag.Free;
  end;
end;

procedure TID3v1.LoadFromFile(const aPath: string);
var
  ID3v1Tag: TID3v1Tag;
begin
  ID3v1Tag := TID3v1Tag.Create;
  try
    ID3v1Tag.LoadFromFile(aPath);

    Self.Track := ID3v1Tag.TrackString;
    Self.Album := ID3v1Tag.Album;
    Self.Artist := ID3v1Tag.Artist;
    Self.Title := ID3v1Tag.Title;
    Self.Year := StrToIntDef(ID3v1Tag.Year, 0);
    Self.Genre := ID3v1Tag.Genre;
    Self.Comment := ID3v1Tag.Comment;
  finally
    ID3v1Tag.Free;
  end;
end;

end.
