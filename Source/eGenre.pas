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

  TGenreList = TEntityList<TGenre>;

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
  eAlbum;

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
