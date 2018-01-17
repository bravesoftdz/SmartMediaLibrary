unit cController;

interface

uses
  API_MVC,
  API_MVC_VCLDB;

type
  TController = class(TControllerVCLDB)
  private
    procedure InitDB; override;
  published
    procedure AssignAudioInfo;
    procedure OnModelAudioFilesInit(aModel: TModelAbstract);
    procedure OnModelAudioFilesEnd(const aMsg: string; aModel: TModelAbstract);
    procedure PullTrackFiles;
  end;

implementation

uses
  API_DB_MySQL,
  eTrack,
  mMediaFiles,
  vAudioInfo,
  vMain,
  Vcl.Controls;

procedure TController.OnModelAudioFilesInit(aModel: TModelAbstract);
begin

end;

procedure TController.OnModelAudioFilesEnd(const aMsg: string; aModel: TModelAbstract);
var
  TrackFile: TTrackFile;
  PArr: PTrackFileArr;
  TrackFileArr: TTrackFileArr;
begin
  //debug
  //GetMem(PArr, SizeOf(TTrackFileArr));

  {PArr := FDataPointer.Items['TrackFiles'];
  TrackFileArr := PArr^;

  for TrackFile in TrackFileArr do
    ViewAudioInfo.RenderDropedFiles([TrackFile.FileInfo.FileName]);}
end;

procedure TController.PullTrackFiles;
begin
  FDataPointer.AddOrSetValue('DropedFiles', @ViewMain.DropedFiles);

  CallModel<TModelAudioFiles>;
end;

procedure TController.AssignAudioInfo;
begin
  ViewAudioInfo := VCL.CreateView<TViewAudioInfo>;

  if ViewAudioInfo.ShowModal = mrOK then
    begin

    end;
end;

procedure TController.InitDB;
begin
  FDBEngineClass := TMySQLEngine;
  FConnectOnCreate := True;
  FConnectParams.GetFormFile('Settings\MySQL.ini');
end;

end.
