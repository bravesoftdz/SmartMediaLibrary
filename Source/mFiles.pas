unit mFiles;

interface

uses
  API_MVC;

type
  TModelMediaFiles = class(TModelAbstract)
  public
    procedure Start; override;
  end;

implementation

uses
  API_Files;

procedure TModelMediaFiles.Start;
var
  FileName: string;
  FileInfoArr: TArray<TFileInfo>;
  PDropedFiles: ^TArray<string>;
begin
  PDropedFiles := FDataPointer.Items['DropedFiles'];

  FileInfoArr := [];
  for FileName in PDropedFiles^ do
    FileInfoArr := FileInfoArr + TFilesEngine.GetFileInfoArr(FileName);
end;

end.
