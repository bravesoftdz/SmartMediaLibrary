unit eAlbum;

interface

uses
  API_ORM,
  eCommon;

type
  TAlbum = class(TEntity)
  private
    FTitle: string;
  public
    class function GetStructure: TSructure; override;
  published
    property Title: string read FTitle write FTitle;
  end;

  TAlbumList = class(TEntityList<TAlbum>)
  end;

implementation

class function TAlbum.GetStructure: TSructure;
begin
  Result.TableName := 'AUDIO_ALBUMS';
end;

end.
