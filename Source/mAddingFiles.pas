unit mAddingFiles;

interface

uses
  API_Files,
  API_MVC,
  eArtist,
  eMediaFile;

type
  TModelDefineFiles = class(TModelAbstract)
  private
    procedure DefineMP3File(var aMediaFile: TMediaFile);
  public
    inDropedFiles: TArray<string>;
    outAudioList: TAudioList;
    outMediaFile: TMediaFile;
    procedure Start; override;
  end;

implementation

uses
  System.Hash,
  System.SysUtils;

procedure TModelDefineFiles.DefineMP3File(var aMediaFile: TMediaFile);
begin
  aMediaFile.ID3v1.LoadFromFile(aMediaFile.FileInfo.FullPath);
  aMediaFile.ID3v2.LoadFromFile(aMediaFile.FileInfo.FullPath);


end;

procedure TModelDefineFiles.Start;
var
  FileInfo: TFileInfo;
  FileInfoArr: TArray<TFileInfo>;
  FileName: string;
begin
  outAudioList := TAudioList.Create([], []);

  FileInfoArr := [];
  for FileName in inDropedFiles do
    FileInfoArr := FileInfoArr + TFilesEngine.GetFileInfoArr(FileName);

  for FileInfo in FileInfoArr do
    begin
      outMediaFile.Hash := THashMD5.GetHashString(FileInfo.FullPath);
      outMediaFile.FileInfo := FileInfo;

      if FileInfo.Extension.ToUpper = 'MP3' then
        begin
          outMediaFile.MediaType := mtMP3;
          DefineMP3File(outMediaFile);
        end
      else
        outMediaFile.MediaType := mtUnknown;

      SendMessage('OnFileAdded');
    end;
end;

end.
