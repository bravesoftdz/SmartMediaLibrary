unit ePics;

interface

uses
  API_ORM,
  eCommon;

type
  TPic = class(TEntity)
  private
    FPic: string;
  public
    class function GetStructure: TSructure; override;
  published
    property Pic: string read FPic write FPic;
  end;

  TAlbumPicRel = class(TEntity)
  private
    FAlbumID: Integer;
    FIsDefault: Boolean;
    FPicID: Integer;
  public
    class function GetStructure: TSructure; override;
  published
    property AlbumID: Integer read FAlbumID write FAlbumID;
    property IsDefault: Boolean read FIsDefault write FIsDefault;
    property PicID: Integer read FPicID write FPicID;
  end;

  TAlbumPicRelList = TEntityList<TAlbumPicRel>;

implementation

uses
  eAlbum;

class function TAlbumPicRel.GetStructure: TSructure;
begin
  Result.TableName := 'AUDIO_PIC2ALBUM';

  AddForeignKey(Result.ForeignKeyArr, 'ALBUM_ID', TAlbum, 'ID');
  AddForeignKey(Result.ForeignKeyArr, 'PIC_ID', TPic, 'ID');
end;

class function TPic.GetStructure: TSructure;
begin
  Result.TableName := 'META_PICS';
end;

end.
