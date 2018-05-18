unit ePics;

interface

uses
  API_ORM,
  API_Types,
  eCommon,
  System.Classes;

type
  TPic = class(TEntity)
  private
    FMIME: string;
    FPic: string;
    function GetMIMEType: TMIMEType;
    procedure SetMIMEType(const aValue: TMIMEType);
  public
    class function GetStructure: TSructure; override;
    function CreateStream: TStream;
    procedure AssignStream(aPicStream: TStream);
    property MIMEType: TMIMEType read GetMIMEType write SetMIMEType;
  published
    property MIME: string read FMIME write FMIME;
    property PicBytes: string read FPic write FPic;
  end;

  TAlbumPicRel = class(TEntity)
  private
    FAlbumID: Integer;
    FIsDefault: Boolean;
    FPic: TPic;
    FPicID: Integer;
  public
    class function GetStructure: TSructure; override;
  published
    property AlbumID: Integer read FAlbumID write FAlbumID;
    property IsDefault: Boolean read FIsDefault write FIsDefault;
    property Pic: TPic read FPic write FPic;
    property PicID: Integer read FPicID write FPicID;
  end;

  TAlbumPicRelList = TEntityList<TAlbumPicRel>;

implementation

uses
  eAlbum;

procedure TPic.AssignStream(aPicStream: TStream);
begin
  PicBytes := TStreamEngine.GetByteString(aPicStream);
end;

procedure TPic.SetMIMEType(const aValue: TMIMEType);
begin
  MIME := MIMETypeToStr(aValue);
end;

function TPic.GetMIMEType: TMIMEType;
begin
  Result := StrToMIMEType(MIME);
end;

function TPic.CreateStream: TStream;
begin
  Result := TStreamEngine.CreateStreamFromByteString(PicBytes);
end;

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
