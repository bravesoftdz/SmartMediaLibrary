unit eAlbum;

interface

uses
  API_ORM,
  eCommon,
  eTrack;

type
  TAlbum = class(TEntity)
  private
    FArtistID: Integer;
    FTitle: string;
    FTrackRels: TTrackRelList;
    function GetTrackRels: TTrackRelList;
  public
    class function GetStructure: TSructure; override;
    property TrackRels: TTrackRelList read GetTrackRels;
  published
    property ArtistID: Integer read FArtistID write FArtistID;
    property Title: string read FTitle write FTitle;
  end;

  TAlbumList = class(TEntityList<TAlbum>)
  public
    function GetByName(const aAlbumName: string): TAlbum;
  end;

implementation

uses
  eArtist,
  System.SysUtils;

function TAlbum.GetTrackRels: TTrackRelList;
begin
  if not Assigned(FTrackRels) then
    FTrackRels := TTrackRelList.Create(Self);

  Result := FTrackRels;
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
