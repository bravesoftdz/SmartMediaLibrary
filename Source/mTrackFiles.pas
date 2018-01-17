unit mTrackFiles;

interface

uses
  API_MVC,
  eTrack;

type
  TModelTrackFiles = class(TModelAbstract)
  public
    inDropedFiles: TArray<string>;
    outTrackFileArr: TArray<TTrackFile>;
    procedure Start; override;
  end;

implementation

uses
  API_Files,
  System.Hash;

procedure TModelTrackFiles.Start;
var
  FileName: string;
  FileInfo: TFileInfo;
  FileInfoArr: TArray<TFileInfo>;
  TrackFile: TTrackFile;
begin
  FileInfoArr := [];
  for FileName in inDropedFiles do
    FileInfoArr := FileInfoArr + TFilesEngine.GetFileInfoArr(FileName);

  outTrackFileArr := [];
  for FileInfo in FileInfoArr do
    begin
      TrackFile.ID := THashMD5.GetHashString(FileInfo.FullPath);
      TrackFile.FileInfo := FileInfo;
      TrackFile.ID3v1.LoadFromFile(FileInfo.FullPath);
      TrackFile.ID3v2.LoadFromFile(FileInfo.FullPath);

      outTrackFileArr := outTrackFileArr + [TrackFile];
    end;
end;

end.
