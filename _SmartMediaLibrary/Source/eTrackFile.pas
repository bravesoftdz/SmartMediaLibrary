unit eTrackFile;

interface

uses
  API_Files,
  eAlbum,
  eArtist,
  eTrack;

type
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
  end;

  TID3v2 = record
  public
    Album: string;
    AlbumArtist: string;
    Artist: string;
    BPM: string;
    Comment: string;
    Composer: string;
    Copyright: string;
    Disc: string;
    Encoded: string;
    Genre: string;
    OrigArtist: string;
    Publisher: string;
    Title: string;
    Track: string;
    URL: string;
    Year: Integer;
    procedure LoadFromFile(const aPath: string);
  end;

  TTrackFile = record
  private
    function GetSubArr(aFileFormat: string): TArray<string>;
    function ReplaceSub(aOldStr, aSub: string): string;
  public
    Album: TAlbum;
    Artist: TArtist;
    Track: TTrack;
    FileInfo: TFileInfo;
    ID3v1: TID3v1;
    ID3v2: TID3v2;
    ID: string;
    NewFileName: string;
    NewPath: string;
    procedure SetNewFileName(aFileFormat: string);
    procedure SetNewPath(aPathFormat: string);
  end;

  TTrackFileArrHelper = record helper for TArray<TTrackFile>
    function FindByID(aID: string): TTrackFile;
  end;

implementation

uses
  ID3v1Library,
  ID3v2Library,
  System.SysUtils;

function TTrackFile.ReplaceSub(aOldStr, aSub: string): string;
var
  NewSub: string;
begin
  if aSub = 'TrackNum' then
    NewSub := Album.TrackNum[Track];

  if aSub = 'TrackTitle' then
    NewSub := Track.Title;

  if aSub = 'ArtistName' then
    NewSub := Artist.Title;

  if aSub = 'AlbumType' then
    NewSub := Album.AlbumTypeID.ToString;

  if aSub = 'AlbumYear' then
    NewSub := Album.Year.ToString;

  if aSub = 'AlbumTitle' then
    NewSub := Album.Title;

  Result := aOldStr.Replace(Format('{%s}', [aSub]), NewSub);
end;

procedure TTrackFile.SetNewPath(aPathFormat: string);
var
  Sub: string;
  SubArr: TArray<string>;
begin
  SubArr := GetSubArr(aPathFormat);
  NewPath := aPathFormat;

  for Sub in SubArr do
    NewPath := ReplaceSub(NewPath, Sub);

  NewPath := NewPath + NewFileName;
end;

function TTrackFile.GetSubArr(aFileFormat: string): TArray<string>;
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

procedure TTrackFile.SetNewFileName(aFileFormat: string);
var
  Sub: string;
  SubArr: TArray<string>;
begin
  SubArr := GetSubArr(aFileFormat);
  NewFileName := aFileFormat;

  for Sub in SubArr do
    NewFileName := ReplaceSub(NewFileName, Sub);

  NewFileName := Format('%s.%s', [NewFileName, FileInfo.Extension]);
end;

function TTrackFileArrHelper.FindByID(aID: string): TTrackFile;
var
  TrackFile: TTrackFile;
begin
  for TrackFile in Self do
    if TrackFile.ID = aID then
      Exit(TrackFile);
end;

procedure TID3v2.LoadFromFile(const aPath: string);
var
  ID3v2Tag: TID3v2Tag;
begin
  ID3v2Tag := TID3v2Tag.Create;
  try
    ID3v2Tag.LoadFromFile(aPath);

    Self.Track := ID3v2Tag.GetUnicodeText('TRCK');
    Self.Disc := ID3v2Tag.GetUnicodeText('MCDI');
    Self.Title := ID3v2Tag.GetUnicodeText('TIT2');
    Self.Artist := ID3v2Tag.GetUnicodeText('TPE1');
    Self.Album := ID3v2Tag.GetUnicodeText('TALB');
    Self.Year := StrToIntDef(ID3v2Tag.GetUnicodeText('TYER'), 0);
    Self.Genre := ID3v2DecodeGenre(ID3v2Tag.GetUnicodeText('TCON'));
    Self.Comment := ID3v2Tag.GetUnicodeText('COMM');
    Self.Composer := ID3v2Tag.GetUnicodeText('TCOM');
    Self.Publisher := ID3v2Tag.GetUnicodeText('TPUB');
    Self.OrigArtist := ID3v2Tag.GetUnicodeText('TOPE');
    Self.Copyright := ID3v2Tag.GetUnicodeText('WCOP');
    Self.URL := ID3v2Tag.GetUnicodeText('WXXX');
    Self.Encoded := ID3v2Tag.GetUnicodeText('TENC');
    Self.BPM := ID3v2Tag.GetUnicodeText('TBPM');
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
