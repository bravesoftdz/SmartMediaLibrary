unit eTrack;

interface

uses
  API_ORM,
  eCommon;

type
  TTrack = class(TEntity)
  private
    FTitle: string;
  public
    class function GetStructure: TSructure; override;
  published
    property Title: string read FTitle write FTitle;
  end;

  TTrackRel = class(TEntity)
  private
    FAlbumID: Integer;
    FTrack: TTrack;
    FTrackID: Integer;
  public
    class function GetStructure: TSructure; override;
  published
    property AlbumID: Integer read FAlbumID write FAlbumID;
    property Track: TTrack read FTrack write FTrack;
    property TrackID: Integer read FTrackID write FTrackID;
  end;

  TTrackRelList = class(TEntityList<TTrackRel>)
  public
    function GetTrackByName(aTrackName: string): TTrack;
  end;

implementation

uses
  eAlbum,
  System.SysUtils;

function TTrackRelList.GetTrackByName(aTrackName: string): TTrack;
var
  TrackRel: TTrackRel;
begin
  Result := nil;

  for TrackRel in Self do
    if UpperCase(TrackRel.Track.Title) = UpperCase(aTrackName) then
      Exit(TrackRel.Track);
end;

class function TTrackRel.GetStructure: TSructure;
begin
  Result.TableName := 'AUDIO_TRACK2ALBUM';

  AddForeignKey(Result.ForeignKeyArr, 'ALBUM_ID', TAlbum, 'ID');
  AddForeignKey(Result.ForeignKeyArr, 'TRACK_ID', TTrack, 'ID');
end;

class function TTrack.GetStructure: TSructure;
begin
  Result.TableName := 'AUDIO_TRACKS';
end;

end.
