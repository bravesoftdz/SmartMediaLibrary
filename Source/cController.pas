unit cController;

interface

uses
  API_DB,
  API_MVC_VCLDB,
  mAddingFiles;

type
  TController = class(TControllerVCLDB)
  private
    procedure InitDB(var aDBEngineClass: TDBEngineClass; out aConnectParams: TConnectParams;
      out aConnectOnCreate: Boolean); override;
  protected
    procedure AfterCreate; override;
  published
    procedure AddFiles;
    procedure OnFileAdded(aModel: TModelDefineFiles);
    procedure OnModelDefineFilesInit(aModel: TModelDefineFiles);
    procedure OnModelDefineFilesEnd(aModel: TModelDefineFiles);
    procedure PullFiles;
  end;

var
  DBEngine: TDBEngine;

implementation

uses
  API_DB_SQLite,
  System.Classes,
  System.SysUtils,
  vAddingFiles,
  vMain;

procedure TController.OnModelDefineFilesEnd(aModel: TModelDefineFiles);
begin
  aModel.outAudioList.Free;
end;

procedure TController.OnFileAdded(aModel: TModelDefineFiles);
begin
  TThread.Synchronize(nil, procedure()
    begin
      ViewAddingFiles.RenderFile(aModel.outMediaFile.FileInfo);
    end
  );
end;

procedure TController.OnModelDefineFilesInit(aModel: TModelDefineFiles);
begin
  aModel.inDropedFiles := ViewMain.DropedFiles;
end;

procedure TController.PullFiles;
begin
  CallModel<TModelDefineFiles>;
end;

procedure TController.AddFiles;
begin
  ViewAddingFiles := VCL.CreateView<TViewAddingFiles>;
  ViewAddingFiles.ShowModal;
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
