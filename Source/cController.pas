unit cController;

interface

uses
  API_MVC_VCLDB;

type
  TController = class(TControllerVCLDB)
  private
    procedure InitDB; override;
  published
    procedure PullExternalAudioInfo;
  end;

implementation

uses
  API_DB_MySQL,
  mFiles,
  vAudioInfoExt,
  vMain,
  Vcl.Controls;

procedure TController.PullExternalAudioInfo;
begin
  ViewAudioInfoExt := VCL.CreateView<TViewAudioInfoExt>;

  FDataPointer.AddOrSetValue('DropedFiles', @ViewMain.DropedFiles);
  CallModel<TModelMediaFiles>;

  //ViewAudioInfoExt.RenderDropedFiles(ViewMain.DropedFiles);

  if ViewAudioInfoExt.ShowModal = mrOK then
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
