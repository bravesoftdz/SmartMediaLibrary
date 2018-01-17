program SmartMediaLibrary;

uses
  Vcl.Forms,
  API_MVC_VCL in '..\..\Libs\Delphi\API_MVC_VCL.pas' {ViewVCLBase},
  vMain in 'vMain.pas' {ViewMain},
  API_MVC in '..\..\Libs\Delphi\API_MVC.pas',
  cController in 'cController.pas',
  API_MVC_DB in '..\..\Libs\Delphi\API_MVC_DB.pas',
  API_DB in '..\..\Libs\Delphi\API_DB.pas',
  API_MVC_VCLDB in '..\..\Libs\Delphi\API_MVC_VCLDB.pas',
  API_DB_MySQL in '..\..\Libs\Delphi\API_DB_MySQL.pas',
  vAudioInfo in 'vAudioInfo.pas' {ViewAudioInfo},
  API_DragDrop in '..\..\Libs\Delphi\API_DragDrop.pas',
  API_Files in '..\..\Libs\Delphi\API_Files.pas',
  eTrack in 'eTrack.pas',
  mMediaFiles in 'mMediaFiles.pas';

{$R *.res}

begin
{$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown := True;
{$ENDIF DEBUG}

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TViewMain, ViewMain);
  Application.Run;
end.
