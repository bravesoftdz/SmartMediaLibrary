unit eCommon;

interface

uses
  API_ORM;

type
  TEntity = class abstract(TEntityFeatID)
  public
    constructor Create(aID: Integer = 0);
  end;

implementation

uses
  cController;

constructor TEntity.Create(aID: Integer = 0);
begin
  inherited Create(DBEngine, aID);
end;

end.
