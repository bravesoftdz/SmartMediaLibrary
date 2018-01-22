unit eArtist;

interface

uses
  API_ORM,
  eCommon;

type
  TArtist = class(TEntity)
  private
    FTitle: string;
  public
    class function GetStructure: TSructure; override;
  published
    property Title: string read FTitle write FTitle;
  end;

  TArtistList = class(TEntityList<TArtist>)
  end;

implementation

class function TArtist.GetStructure: TSructure;
begin
  Result.TableName := 'AUDIO_ARTISTS';
end;

end.
