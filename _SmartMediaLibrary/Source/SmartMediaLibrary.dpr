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
  vAudioAppend in 'vAudioAppend.pas' {ViewAudioAppend},
  API_DragDrop in '..\..\Libs\Delphi\API_DragDrop.pas',
  API_Files in '..\..\Libs\Delphi\API_Files.pas',
  eTrack in 'eTrack.pas',
  mTrackFiles in 'mTrackFiles.pas',
  API_ORM in '..\..\Libs\Delphi\API_ORM.pas',
  eCommon in 'eCommon.pas',
  eAlbum in 'eAlbum.pas',
  eArtist in 'eArtist.pas',
  eTrackFile in 'eTrackFile.pas',
  API_ORM_BindVCL in '..\..\Libs\Delphi\API_ORM_BindVCL.pas';

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
