unit cController;

interface

uses
  API_DB,
  API_MVC_VCLDB,
  eArtist,
  mAddingFiles;

type
  TController = class(TControllerVCLDB)
  private
    function GetAudioList: TAudioList;
    procedure InitDB(var aDBEngineClass: TDBEngineClass; out aConnectParams: TConnectParams;
      out aConnectOnCreate: Boolean); override;
  protected
    procedure AfterCreate; override;
    property AudioList: TAudioList read GetAudioList;
  published
    procedure AddFiles;
    procedure OnFileAdded(aModel: TModelDefineFiles);
    procedure OnModelDefineFilesInit(aModel: TModelDefineFiles);
    procedure OnModelDefineFilesEnd(aModel: TModelDefineFiles);
    procedure OnModelStoreFilesInit(aModel: TModelStoreFiles);
    procedure PullFiles;
  end;

const
  AUDIO_PATH = 'D:\Music\';
  FILE_FORMAT = '{TrackNum} - {TrackTitle}';
  PATH_FORMAT = '{ArtistName}\{AlbumYear} {AlbumTitle}\';

var
  DBEngine: TDBEngine;

implementation

uses
  API_DB_SQLite,
  System.Classes,
  System.SysUtils,
  vAddingFiles,
  Vcl.Controls,
  vMain;

procedure TController.OnModelStoreFilesInit(aModel: TModelStoreFiles);
begin
  aModel.inMediaFileArr := ViewAddingFiles.MediaFileArr;
end;

function TController.GetAudioList: TAudioList;
begin
  Result := FDataObj.Items['AudioList'] as TAudioList;
end;

procedure TController.OnModelDefineFilesEnd(aModel: TModelDefineFiles);
begin
  FDataObj.AddOrSetValue('AudioList', aModel.outAudioList);
end;

procedure TController.OnFileAdded(aModel: TModelDefineFiles);
begin
  TThread.Synchronize(nil, procedure()
    begin
      ViewAddingFiles.RenderMediaFile(aModel.outMediaFile);
    end
  );
end;

procedure TController.OnModelDefineFilesInit(aModel: TModelDefineFiles);
begin
  aModel.inDropedFiles := ViewMain.DropedFiles;
  aModel.inFileFormat := FILE_FORMAT;
  aModel.inPathFormat := AUDIO_PATH + PATH_FORMAT;
end;

procedure TController.PullFiles;
begin
  CallModel<TModelDefineFiles>;
end;

procedure TController.AddFiles;
var
  IsOK: Boolean;
begin
  ViewAddingFiles := VCL.CreateView<TViewAddingFiles>;

  if ViewAddingFiles.ShowModal = mrOK then
    IsOK := True
  else
    IsOK := False;

  if IsOK then
    begin
      CallModel<TModelStoreFiles>;
      AudioList.Store;
    end;

  AudioList.Free;
end;

procedure TController.AfterCreate;
begin
  cController.DBEngine := Self.DBEngine;
end;

procedure TController.InitDB(var aDBEngineClass: TDBEngineClass; out aConnectParams: TConnectParams;
      out aConnectOnCreate: Boolean);
begin
  aDBEngineClass := TSQLiteEngine;
  aConnectOnCreate := True;
  aConnectParams.DataBase := GetCurrentDir + '\DB\local.db';
end;

end.
