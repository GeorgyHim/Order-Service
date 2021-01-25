unit confirm_order;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.Menus, Datasnap.DBClient, System.JSON;

type
  TfConfirmOrders = class(TForm)
    DBGrid2: TDBGrid;
    MainMenu1: TMainMenu;
    confirmButton: TMenuItem;
    requestDataButton: TMenuItem;
    cdsUnconfirmed: TClientDataSet;
    cdsUnconfirmedstartTime: TDateTimeField;
    cdsUnconfirmedcourierName: TWideStringField;
    cdsUnconfirmedcourierSurname: TWideStringField;
    cdsUnconfirmedclient: TWideStringField;
    cdsUnconfirmedaddress: TWideStringField;
    cdsUnconfirmedid: TIntegerField;
    DBGrid1: TDBGrid;
    dsUnconfirmed: TDataSource;
    dsConfirmed: TDataSource;
    cdsConfirmed: TClientDataSet;
    cdsConfirmedid: TIntegerField;
    cdsConfirmedstartTime: TDateTimeField;
    cdsConfirmedcourierName: TWideStringField;
    cdsConfirmedcourierSurname: TWideStringField;
    cdsConfirmedclient: TWideStringField;
    cdsConfirmedaddress: TWideStringField;
    procedure requestDataButtonClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure DBGrid2DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure DBGrid2DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure confirmButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fConfirmOrders: TfConfirmOrders;

implementation

{$R *.dfm}

uses login, operator_window;

procedure TfConfirmOrders.DBGrid1CellClick(Column: TColumn);
begin
  DBGrid1.BeginDrag(true);
end;

procedure TfConfirmOrders.DBGrid2DragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  i: integer;
begin
  cdsConfirmed.AppendRecord([
    cdsUnconfirmed.FieldByName('id'),
    DBGrid1.Fields[0].Value,
    DBGrid1.Fields[1].Value,
    DBGrid1.Fields[2].Value,
    DBGrid1.Fields[3].Value,
    DBGrid1.Fields[4].Value
  ]);
end;

procedure TfConfirmOrders.DBGrid2DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  accept := source is TDBGrid;
end;

procedure TfConfirmOrders.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  cdsUnconfirmed.Close;
  cdsUnconfirmed.CreateDataSet;
end;

procedure TfConfirmOrders.FormCreate(Sender: TObject);
var
  jsonObjectToSend: tJsonObject;
  stringToSend: String;
begin
  cdsConfirmed.Close;
  cdsConfirmed.CreateDataSet;
  jsonObjectToSend := tJsonObject.Create;
  jsonObjectToSend.AddPair('type', 'confirmQuery');
  fLogin.ClientSocket1.Socket.SendText(jsonObjectToSend.ToString);
end;

procedure TfConfirmOrders.confirmButtonClick(Sender: TObject);
var
  jsonObjectToSend, jsonArrayElement: tJsonObject;
  jsonArray: tJsonArray;
  stringToSend, finishTime: String;
begin
  jsonObjectToSend := tJsonObject.Create;
  jsonObjectToSend.AddPair('type', 'confirmation');
  jsonObjectToSend.AddPair('tab', fWindow.TabControl1.TabIndex.ToString);
  jsonArray := tJsonArray.Create;
  cdsConfirmed.First;
  while not cdsConfirmed.Eof do
    begin
      jsonArray.AddElement(tJsonObject.Create);
      jsonArrayElement := jsonArray.Items[pred(jsonArray.Count)] as tJsonObject;
      DateTimeToString(finishTime, 'dd.mm.yyyy hh:mm', now);
      jsonArrayElement
        .addPair('id', cdsConfirmedid.Value.ToString)
        .addPair('finishTime', finishTime);
      cdsConfirmed.Next;
    end;
  jsonObjectToSend.AddPair('confirmations', jsonArray);
  stringToSend := jsonObjectToSend.ToString;
  fLogin.ClientSocket1.Socket.SendText(stringToSend);
  Close;
end;

procedure TfConfirmOrders.requestDataButtonClick(Sender: TObject);
var
  jsonObjectToSend: tJsonObject;
  stringToSend: String;
begin
  jsonObjectToSend := tJsonObject.Create;
  jsonObjectToSend.AddPair('type', 'confirmQuery');
  fLogin.ClientSocket1.Socket.SendText(jsonObjectToSend.ToString);
end;

end.
