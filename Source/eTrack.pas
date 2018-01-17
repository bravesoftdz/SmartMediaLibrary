unit eTrack;

interface

uses
  API_Files;

type
  TTrackFile = record
    FileInfo: TFileInfo;
  end;

  PTrackFileArr = ^TTrackFileArr;
  TTrackFileArr = TArray<TTrackFile>;

implementation

end.
