unit eTrack;

interface

uses
  API_ORM,
  API_Types,
  eCommon;

type
  TTrack = class(TEntity)
  private
    FOnTitleChanged: TObjProc;
    FTitle: string;
    procedure SetTitle(const aValue: string);
  public
    class function GetStructure: TSructure; override;
    property OnTitleChanged: TObjProc read FOnTitleChanged write FOnTitleChanged;
  published
    property Title: string read FTitle write SetTitle;
  end;

  TTrackRel = class(TEntity)
  private
    FAlbumID: Integer;
    FOnOrderChanged: TObjProc;
    FOrder: Integer;
    FTrack: TTrack;
    FTrackID: Integer;
  public
    class function GetStructure: TSructure; override;
    procedure SetOrder(aValue: Integer);
    property OnOrderChanged: TObjProc read FOnOrderChanged write FOnOrderChanged;
  published
    property AlbumID: Integer read FAlbumID write FAlbumID;
    property Order: Integer read FOrder write SetOrder;
    property Track: TTrack read FTrack write FTrack;
    property TrackID: Integer read FTrackID write FTrackID;
  end;

  TTrackRelList = class(TEntityList<TTrackRel>)
  public
    function GetTrackByName(aTrackName: string): TTrackRel;
  end;

implementation

uses
  eAlbum,
  System.SysUtils;

procedure TTrackRel.SetOrder(aValue: Integer);
begin
  FOrder := aValue;

  if Assigned(FOnOrderChanged) then
    FOnOrderChanged;
end;

procedure TTrack.SetTitle(const aValue: string);
begin
  FTitle := aValue;

  if Assigned(FOnTitleChanged) then
    FOnTitleChanged;
end;

function TTrackRelList.GetTrackByName(aTrackName: string): TTrackRel;
var
  TrackRel: TTrackRel;
begin
  Result := nil;

  for TrackRel in Self do
    if UpperCase(TrackRel.Track.Title) = UpperCase(aTrackName) then
      Exit(TrackRel);
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
