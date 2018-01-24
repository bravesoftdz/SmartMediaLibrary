unit cController;

interface

uses
  API_DB,
  API_MVC_VCLDB,
  mTrackFiles;

type
  TController = class(TControllerVCLDB)
  private
    procedure InitDB(var aDBEngineClass: TDBEngineClass; out aConnectParams: TConnectParams;
      out aConnectOnCreate: Boolean); override;
  protected
    procedure AfterCreate; override;
  published
    procedure AddToLibrary;
    procedure OnModelTrackFilesInit(aModel: TModelTrackFiles);
    procedure OnModelTrackFilesEnd(const aMsg: string; aModel: TModelTrackFiles);
    procedure PullTrackFiles;
  end;

var
  DBEngine: TDBEngine;

implementation

uses
  API_DB_MySQL,
  eTrack,
  System.Classes,
  vAudioAppend,
  vMain,
  Vcl.Controls;

procedure TController.AfterCreate;
begin
  cController.DBEngine := Self.DBEngine;
end;

procedure TController.OnModelTrackFilesInit(aModel: TModelTrackFiles);
begin
  aModel.inDropedFiles := ViewMain.DropedFiles;
end;

procedure TController.OnModelTrackFilesEnd(const aMsg: string; aModel: TModelTrackFiles);
begin
  TThread.Synchronize(nil, procedure()
    begin
      ViewAudioAppend.RenderArtistList(aModel.outArtistList);
      ViewAudioAppend.RenderTrackFiles(aModel.outTrackFileArr);

      ViewAudioAppend.ArtistList := aModel.outArtistList;
      //ViewAudioAppend.RenderTrackFiles(aModel.outTrackFileArr);
    end
  );
end;

procedure TController.PullTrackFiles;
begin
  CallModel<TModelTrackFiles>;
end;

procedure TController.AddToLibrary;
begin
  ViewAudioAppend := VCL.CreateView<TViewAudioAppend>;

  if ViewAudioAppend.ShowModal = mrOK then
    begin
      ViewAudioAppend.ArtistList.Store;
    end;

  ViewAudioAppend.ArtistList.Free;
end;

procedure TController.InitDB(var aDBEngineClass: TDBEngineClass;
  out aConnectParams: TConnectParams; out aConnectOnCreate: Boolean);
begin
  aDBEngineClass := TMySQLEngine;
  aConnectOnCreate := True;
  aConnectParams.GetFormFile('Settings\MySQL.ini');
end;

end.
