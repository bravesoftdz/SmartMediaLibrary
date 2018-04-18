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
    procedure OnAfterTrackFileFill(const aMsg: string; aModel: TModelDefineTrackFiles);
    procedure OnModelDefineTrackFilesInit(aModel: TModelDefineTrackFiles);
    procedure OnModelDefineTrackFilesEnd(const aMsg: string; aModel: TModelDefineTrackFiles);
    procedure PullTrackFiles;
  end;

const
  AUDIO_PATH = 'D:\Music\';
  FILE_FORMAT = '{TrackNum} - {TrackTitle}';
  PATH_FORMAT = '{ArtistName}\{AlbumYear} {AlbumTitle}\';

var
  DBEngine: TDBEngine;

implementation

uses
  API_DB_MySQL,
  eArtist,
  eTrack,
  System.Classes,
  vAudioAppend,
  vMain,
  Vcl.Controls;

procedure TController.OnAfterTrackFileFill(const aMsg: string; aModel: TModelDefineTrackFiles);
begin
  TThread.Synchronize(nil, procedure()
    begin
      ViewAudioAppend.RenderTrackFile(aModel.outTrackFile);
    end
  );
end;

procedure TController.AfterCreate;
begin
  cController.DBEngine := Self.DBEngine;
end;

procedure TController.OnModelDefineTrackFilesInit(aModel: TModelDefineTrackFiles);
begin
  aModel.inDropedFiles := ViewMain.DropedFiles;
  aModel.inFileFormat := FILE_FORMAT;
  aModel.inPathFormat := AUDIO_PATH + PATH_FORMAT;
end;

procedure TController.OnModelDefineTrackFilesEnd(const aMsg: string; aModel: TModelDefineTrackFiles);
begin
  TThread.Synchronize(nil, procedure()
    begin
      ViewAudioAppend.ArtistList := aModel.outArtistList;
    end
  );
end;

procedure TController.PullTrackFiles;
begin
  CallModel<TModelDefineTrackFiles>;
end;

procedure TController.AddToLibrary;
begin
  ViewAudioAppend := VCL.CreateView<TViewAudioAppend>;

  if ViewAudioAppend.ShowModal = mrOK then
    ViewAudioAppend.ArtistList.Store;

  ViewAudioAppend.ArtistList.Free;
end;

procedure TController.InitDB(var aDBEngineClass: TDBEngineClass;
  out aConnectParams: TConnectParams; out aConnectOnCreate: Boolean);
begin
  aDBEngineClass := TMySQLEngine;
  aConnectOnCreate := True;
  aConnectParams.GetFromFile('Settings\MySQL.ini');
end;

end.
