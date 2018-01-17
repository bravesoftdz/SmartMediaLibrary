unit vAudioInfo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, VirtualTrees, Vcl.Graphics,
  API_MVC_VCL,

  API_Files,
  eTrack, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TViewAudioInfo = class(TViewVCLBase)
    vstTrackFiles: TVirtualStringTree;
    splHorizont: TSplitter;
    pgcPages: TPageControl;
    tsFile: TTabSheet;
    tsID3v1: TTabSheet;
    tsID3v2: TTabSheet;
    leFileName: TLabeledEdit;
    leFullPath: TLabeledEdit;
    sbxTagID3v1: TScrollBox;
    leTrack: TLabeledEdit;
    leGenre: TLabeledEdit;
    leComment: TLabeledEdit;
    leYear: TLabeledEdit;
    leAlbum: TLabeledEdit;
    leArtist: TLabeledEdit;
    leTitle: TLabeledEdit;
    sbxID3v2: TScrollBox;
    leT2Album: TLabeledEdit;
    procedure FormShow(Sender: TObject);
    procedure vstTrackFilesGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure vstTrackFilesGetNodeDataSize(Sender: TBaseVirtualTree;
      var NodeDataSize: Integer);
    procedure vstTrackFilesFocusChanged(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex);
  private
    { Private declarations }
    FTrackFileArr: TArray<TTrackFile>;
    procedure RenderTrackFileDetail(aTrackFileID: string);
  public
    { Public declarations }
    procedure RenderTrackFile(aTrackFile: TTrackFile);
    procedure RenderTrackFiles(aTrackFileArr: TArray<TTrackFile>);
  end;

  TNodeData = record
    FileName: WideString;
    ID: ShortString;
    Path: WideString;
  end;

var
  ViewAudioInfo: TViewAudioInfo;

implementation

{$R *.dfm}

procedure TViewAudioInfo.RenderTrackFileDetail(aTrackFileID: string);
var
  TrackFile: TTrackFile;
begin
  TrackFile := FTrackFileArr.FindByID(aTrackFileID);

  leFileName.Text := TrackFile.FileInfo.FileName;
  leFullPath.Text := TrackFile.FileInfo.FullPath;

  leTrack.Text := TrackFile.ID3v1.Track;
  leTitle.Text := TrackFile.ID3v1.Title;
  leArtist.Text := TrackFile.ID3v1.Artist;
  leAlbum.Text := TrackFile.ID3v1.Album;
  leYear.Text := TrackFile.ID3v1.Year.ToString;
  leGenre.Text := TrackFile.ID3v1.Genre;
  leComment.Text := TrackFile.ID3v1.Comment;

  leT2Album.Text := TrackFile.ID3v2.Album;
end;

procedure TViewAudioInfo.RenderTrackFiles(aTrackFileArr: TArray<TTrackFile>);
var
  TrackFile: TTrackFile;
begin
  FTrackFileArr := aTrackFileArr;

  for TrackFile in FTrackFileArr do
    RenderTrackFile(TrackFile);
end;

procedure TViewAudioInfo.vstTrackFilesFocusChanged(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex);
var
  NodeData: TNodeData;
begin
  inherited;

  if Sender.FocusedNode <> nil then
    begin
      NodeData := Sender.GetNodeData<TNodeData>(Sender.FocusedNode);

      RenderTrackFileDetail(NodeData.ID);
    end;
end;

procedure TViewAudioInfo.vstTrackFilesGetNodeDataSize(Sender: TBaseVirtualTree;
  var NodeDataSize: Integer);
begin
  inherited;

  NodeDataSize := SizeOf(TNodeData);
end;

procedure TViewAudioInfo.vstTrackFilesGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  NodeData: TNodeData;
begin
  inherited;

  NodeData := Sender.GetNodeData<TNodeData>(Node);

  case Column of
    0: CellText := NodeData.FileName;
    1: CellText := NodeData.Path;
  end;
end;

procedure TViewAudioInfo.RenderTrackFile(aTrackFile: TTrackFile);
var
  NodeData: TNodeData;
  VirtualNode: PVirtualNode;
begin
  NodeData.ID := aTrackFile.ID;
  NodeData.FileName := aTrackFile.FileInfo.FileName;
  NodeData.Path := aTrackFile.FileInfo.FullPath;

  VirtualNode := vstTrackFiles.AddChild(nil);
  VirtualNode.SetData<TNodeData>(NodeData);
end;

procedure TViewAudioInfo.FormShow(Sender: TObject);
begin
  inherited;

  SendMessage('PullTrackFiles');
end;

end.
