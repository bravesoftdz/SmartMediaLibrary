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
    procedure OnAfterTrackFileFill(const aMsg: string; aModel: TModelTrackFiles);
    procedure OnModelTrackFilesInit(aModel: TModelTrackFiles);
    procedure OnModelTrackFilesEnd(const aMsg: string; aModel: TModelTrackFiles);
    procedure PullTrackFiles;
  end;

const
  AUDIO_PATH = 'D:\Music\';
  FILE_FORMAT = '{track.num} - {track.title}';
  PATH_FORMAT = '{artist.name}\{album.type}\{album.year} {album.title}';

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

procedure TController.OnAfterTrackFileFill(const aMsg: string; aModel: TModelTrackFiles);
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

procedure TController.OnModelTrackFilesInit(aModel: TModelTrackFiles);
begin
  aModel.inDropedFiles := ViewMain.DropedFiles;
  aModel.inFileFormat := FILE_FORMAT;
end;

procedure TController.OnModelTrackFilesEnd(const aMsg: string; aModel: TModelTrackFiles);
begin
  TThread.Synchronize(nil, procedure()
    begin
      ViewAudioAppend.ArtistList := aModel.outArtistList;
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
    ViewAudioAppend.ArtistList.Store;

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
