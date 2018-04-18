unit eArtist;

interface

uses
  API_ORM,
  eAlbum,
  eCommon;

type
  TArtist = class(TEntity)
  private
    FAlbumList: TAlbumList;
    FTitle: string;
    function GetAlbumList: TAlbumList;
  public
    class function GetStructure: TSructure; override;
    property AlbumList: TAlbumList read GetAlbumList;
  published
    property Title: string read FTitle write FTitle;
  end;

  TArtistList = class(TEntityList<TArtist>)
  private
    function GetArtistIDFormStorage(aArtistName: string): Integer;
  public
    function AddOrGetFromStorage(aArtistName: string): TArtist;
  end;

implementation

uses
  FireDAC.Comp.Client,
  System.SysUtils;

function TArtist.GetAlbumList: TAlbumList;
begin
  if not Assigned(FAlbumList) then
    FAlbumList := TAlbumList.Create(Self);

  Result := FAlbumList;
end;

function TArtistList.GetArtistIDFormStorage(aArtistName: string): Integer;
var
  dsQuery: TFDQuery;
begin
  Result := 0;

  dsQuery := TFDQuery.Create(nil);
  try
    dsQuery.SQL.Text := 'select Id from AUDIO_ARTISTS where UPPER(TITLE) = UPPER(:TITLE)';
    dsQuery.ParamByName('TITLE').AsString := aArtistName;
    DBEngine.OpenQuery(dsQuery);

    if not dsQuery.IsEmpty then
      Result := dsQuery.Fields[0].AsInteger;
  finally
    dsQuery.Free;
  end;
end;

function TArtistList.AddOrGetFromStorage(aArtistName: string): TArtist;
var
  Artist: TArtist;
  ArtistID: Integer;
begin
  Result := nil;

  for Artist in Self do
    if UpperCase(Artist.Title) = UpperCase(aArtistName) then
      Exit(Artist);

  ArtistID := GetArtistIDFormStorage(aArtistName);
  if ArtistID > 0 then
    begin
      Artist := TArtist.Create(ArtistID);
      Add(Artist);
      Exit(Artist);
    end;

  if Result = nil then
    begin
      Artist := TArtist.Create;
      Artist.Title := aArtistName;
      Add(Artist);

      Result := Artist;
    end;
end;

class function TArtist.GetStructure: TSructure;
begin
  Result.TableName := 'AUDIO_ARTISTS';
end;

end.
