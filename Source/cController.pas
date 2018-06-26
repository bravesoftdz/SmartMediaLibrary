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
    function GetAudioLib: TAudioList;
    function GetAudioList: TAudioList;
    procedure InitDB(var aDBEngineClass: TDBEngineClass; out aConnectParams: TConnectParams;
      out aConnectOnCreate: Boolean); override;
  protected
    procedure AfterCreate; override;
    property AudioList: TAudioList read GetAudioList;
    property AudioLib: TAudioList read GetAudioLib;
  published
    procedure AddFiles;
    procedure DBService;
    procedure OnFileAdded(aModel: TModelDefineFiles);
    procedure OnModelDefineFilesInit(aModel: TModelDefineFiles);
    procedure OnModelDefineFilesEnd(aModel: TModelDefineFiles);
    procedure OnModelStoreFilesInit(aModel: TModelStoreFiles);
    procedure OnModelStoreFilesEnd(aModel: TModelStoreFiles);
    procedure OnViewMainClosed;
    procedure PullFiles;
    procedure PullLibrary;
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
  eGenre,
  FireDAC.Comp.Client,
  System.Classes,
  System.SysUtils,
  vAddingFiles,
  Vcl.Controls,
  vMain;

procedure TController.DBService;
var
  dsQuery: TFDQuery;
  SQL: string;
  Table: string;
  Tables: TArray<string>;
begin
  Tables := [
    'audio_artists',
    'audio_albums',
    'audio_genre2album',
    'audio_pic2album',
    'audio_track2album',
    'audio_tracks',
    'meta_pics',
    'video_movies'
  ];

  dsQuery := TFDQuery.Create(nil);
  try
    for Table in Tables do
      begin
        SQL := Format('delete from %s', [Table]);
        dsQuery.Close;
        dsQuery.SQL.Text := SQL;
        DBEngine.ExecQuery(dsQuery);

        SQL := 'delete from SQLITE_SEQUENCE where name = :table;';
        dsQuery.Close;
        dsQuery.SQL.Text := SQL;
        dsQuery.ParamByName('table').AsString := Table;
        DBEngine.ExecQuery(dsQuery);
      end;

    dsQuery.Close;
    dsQuery.SQL.Text := 'vacuum;';
    DBEngine.ExecQuery(dsQuery);
  finally
    dsQuery.Free;
  end;
end;

procedure TController.OnViewMainClosed;
begin
  AudioLib.Free;
end;

function TController.GetAudioLib: TAudioList;
begin
  Result := FDataObj.Items['AudioLib'] as TAudioList;
end;

procedure TController.PullLibrary;
var
  AudioLibrary: TAudioList;
begin
  AudioLibrary := TAudioList.Create(['*'], ['TITLE']);
  FDataObj.AddOrSetValue('AudioLib', AudioLibrary);
  ViewMain.RenderLibrary(AudioLibrary);
end;

procedure TController.OnModelStoreFilesEnd(aModel: TModelStoreFiles);
begin
  ViewAddingFiles.MediaFileList.Free;

  AudioList.Store;
  AudioList.Free;
end;

procedure TController.OnModelStoreFilesInit(aModel: TModelStoreFiles);
begin
  aModel.inMediaFileList := ViewAddingFiles.MediaFileList;
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
  GenreList: TGenreList;
  IsOK: Boolean;
begin
  GenreList := TGenreList.Create(['*'], ['NAME']);
  try
    ViewAddingFiles := VCL.CreateView<TViewAddingFiles>;
    ViewAddingFiles.RenderGenreList(GenreList);

    if ViewAddingFiles.ShowModal = mrOK then
      IsOK := True
    else
      begin
        IsOK := False;
        ViewAddingFiles.MediaFileList.Free;
        AudioList.Free;
      end;
  finally
    GenreList.Free;
  end;

  if IsOK then
    CallModel<TModelStoreFiles>;
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
