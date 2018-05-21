unit eGenre;

interface

uses
  API_ORM,
  eCommon;

type
  TGenre = class(TEntity)
  private
    FName: string;
  public
    class function GetStructure: TSructure; override;
  published
    property Name: string read FName write FName;
  end;

  TGenreList = class(TEntityList<TGenre>)
  public
    function GetGenreIDByName(const aName: string): Integer;
  end;

  TAlbumGenreRel = class(TEntity)
  private
    FAlbumID: Integer;
    FGenre: TGenre;
    FGenreID: Integer;
    FIsDefault: Boolean;
  public
    class function GetStructure: TSructure; override;
  published
    property AlbumID: Integer read FAlbumID write FAlbumID;
    property Genre: TGenre read FGenre write FGenre;
    property GenreID: Integer read FGenreID write FGenreID;
    property IsDefault: Boolean read FIsDefault write FIsDefault;
  end;

  TAlbumGenreRelList = TEntityList<TAlbumGenreRel>;

implementation

uses
  eAlbum,
  System.SysUtils;

function TGenreList.GetGenreIDByName(const aName: string): Integer;
var
  Genre: TGenre;
begin
  Result := 0;

  for Genre in Self do
    if Genre.Name.ToUpper = aName.ToUpper then
      Exit(Genre.ID);
end;

class function TAlbumGenreRel.GetStructure: TSructure;
begin
  Result.TableName := 'AUDIO_GENRE2ALBUM';

  AddForeignKey(Result.ForeignKeyArr, 'ALBUM_ID', TAlbum, 'ID');
  AddForeignKey(Result.ForeignKeyArr, 'GENRE_ID', TGenre, 'ID');
end;

class function TGenre.GetStructure: TSructure;
begin
  Result.TableName := 'AUDIO_GENRES';
end;

end.
