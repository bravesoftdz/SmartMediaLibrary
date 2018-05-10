program SmartMediaLibrary;

uses
  Vcl.Forms,
  vMain in 'vMain.pas' {ViewMain},
  cController in 'cController.pas',
  API_MVC_DB in '..\..\Libs\Delphi\API_MVC_DB.pas',
  API_DB in '..\..\Libs\Delphi\API_DB.pas',
  API_MVC_VCLDB in '..\..\Libs\Delphi\API_MVC_VCLDB.pas',
  API_ORM in '..\..\Libs\Delphi\API_ORM.pas',
  API_MVC_VCL in '..\..\Libs\Delphi\API_MVC_VCL.pas' {ViewVCLBase},
  API_MVC in '..\..\Libs\Delphi\API_MVC.pas',
  eCommon in 'eCommon.pas',
  API_DB_SQLite in '..\..\Libs\Delphi\API_DB_SQLite.pas',
  API_DragDrop in '..\..\Libs\Delphi\API_DragDrop.pas',
  vAddingFiles in 'vAddingFiles.pas' {ViewAddingFiles},
  mAddingFiles in 'mAddingFiles.pas',
  API_Files in '..\..\Libs\Delphi\API_Files.pas',
  eArtist in 'eArtist.pas',
  eMediaFile in 'eMediaFile.pas',
  API_VCL_UIExt in '..\..\Libs\Delphi\API_VCL_UIExt.pas',
  eAlbum in 'eAlbum.pas',
  eTrack in 'eTrack.pas',
  API_ORM_BindVCL in '..\..\Libs\Delphi\API_ORM_BindVCL.pas',
  API_Strings in '..\..\Libs\Delphi\API_Strings.pas',
  ePics in 'ePics.pas';

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
