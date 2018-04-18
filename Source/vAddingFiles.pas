unit vAddingFiles;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VirtualTrees,
  API_Files,
  API_MVC_VCL;

type
  TFileNode = record
    FileName: WideString;
    Path: WideString;
  end;

  TViewAddingFiles = class(TViewVCLBase)
    vstFiles: TVirtualStringTree;
    procedure FormShow(Sender: TObject);
    procedure vstFilesGetNodeDataSize(Sender: TBaseVirtualTree;
      var NodeDataSize: Integer);
    procedure vstFilesGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure RenderFile(const aFileInfo: TFileInfo);
  end;

var
  ViewAddingFiles: TViewAddingFiles;

implementation

{$R *.dfm}

procedure TViewAddingFiles.RenderFile(const aFileInfo: TFileInfo);
var
  FileNode: TFileNode;
  VirtualNode: PVirtualNode;
begin
  FileNode.FileName := aFileInfo.FileName;
  FileNode.Path := aFileInfo.FullPath;

  VirtualNode := vstFiles.AddChild(nil);
  VirtualNode.SetData<TFileNode>(FileNode);
end;

procedure TViewAddingFiles.vstFilesGetNodeDataSize(Sender: TBaseVirtualTree;
  var NodeDataSize: Integer);
begin
  inherited;

  NodeDataSize := SizeOf(TFileNode);
end;

procedure TViewAddingFiles.vstFilesGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  FileNode: TFileNode;
begin
  inherited;

  FileNode := Sender.GetNodeData<TFileNode>(Node);
  {case Column of
    0: CellText := FileNode.FileName;
    1: CellText := NodeData.Path;
  end; }
  CellText := FileNode.FileName;
end;

procedure TViewAddingFiles.FormShow(Sender: TObject);
begin
  inherited;

  SendMessage('PullFiles');
end;

end.
