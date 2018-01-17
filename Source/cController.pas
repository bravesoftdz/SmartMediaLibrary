unit cController;

interface

uses
  API_MVC,
  API_MVC_VCLDB,
  mTrackFiles;

type
  TController = class(TControllerVCLDB)
  private
    procedure InitDB; override;
  published
    procedure DefineAudioInfo;
    procedure OnModelTrackFilesInit(aModel: TModelTrackFiles);
    procedure OnModelTrackFilesEnd(const aMsg: string; aModel: TModelTrackFiles);
    procedure PullTrackFiles;
  end;

implementation

uses
  API_DB_MySQL,
  eTrack,
  System.Classes,
  vAudioInfo,
  vMain,
  Vcl.Controls;

procedure TController.OnModelTrackFilesInit(aModel: TModelTrackFiles);
begin
  aModel.inDropedFiles := ViewMain.DropedFiles;
end;

procedure TController.OnModelTrackFilesEnd(const aMsg: string; aModel: TModelTrackFiles);
begin
  TThread.Synchronize(nil, procedure()
    begin
      ViewAudioInfo.RenderTrackFiles(aModel.outTrackFileArr);
    end
  );
end;

procedure TController.PullTrackFiles;
begin
  CallModel<TModelTrackFiles>;
end;

procedure TController.DefineAudioInfo;
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
