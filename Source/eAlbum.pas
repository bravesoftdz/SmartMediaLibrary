unit eAlbum;

interface

uses
  API_ORM,
  eCommon,
  ePics,
  eTrack;

type
  TAlbum = class(TEntity)
  private
    FArtistID: Integer;
    FPicRel: TAlbumPicRelList;
    FTitle: string;
    FTrackRels: TTrackRelList;
    FYear: Integer;
    function GetPicRels: TAlbumPicRelList;
    function GetTrackNum(aTrack: TTrack): string;
    function GetTrackRels: TTrackRelList;
  public
    class function GetStructure: TSructure; override;
    property PicRels: TAlbumPicRelList read GetPicRels;
    property TrackNum[aTrack: TTrack]: string read GetTrackNum;
    property TrackRels: TTrackRelList read GetTrackRels;
  published
    property ArtistID: Integer read FArtistID write FArtistID;
    property Title: string read FTitle write FTitle;
    property Year: Integer read FYear write FYear;
  end;

  TAlbumList = class(TEntityList<TAlbum>)
  public
    function GetByName(const aAlbumName: string): TAlbum;
  end;

implementation

uses
  eArtist,
  System.SysUtils;

function TAlbum.GetPicRels: TAlbumPicRelList;
begin
  if not Assigned(FPicRel) then
    FPicRel := TAlbumPicRelList.Create(Self);

  Result := FPicRel;
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
