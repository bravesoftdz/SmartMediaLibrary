unit mMediaFiles;

interface

uses
  API_MVC;

type
  TModelAudioFiles = class(TModelAbstract)
  public
    procedure Start; override;
  end;

implementation

uses
  API_Files,
  eTrack;

procedure TModelAudioFiles.Start;
var
  FileName: string;
  FileInfo: TFileInfo;
  FileInfoArr: TArray<TFileInfo>;
  PDropedFiles: ^TArray<string>;
  TrackFile: TTrackFile;
  TrackFileArr: TTrackFileArr;
begin
  PDropedFiles := FDataPointer.Items['DropedFiles'];

  FileInfoArr := [];
  for FileName in PDropedFiles^ do
    FileInfoArr := FileInfoArr + TFilesEngine.GetFileInfoArr(FileName);

  TrackFileArr := [];
  for FileInfo in FileInfoArr do
    begin
      TrackFile.FileInfo := FileInfo;

      TrackFileArr := TrackFileArr + [TrackFile];
    end;

  FDataPointer.AddOrSetValue('TrackFiles', @TrackFileArr);
end;

end.
