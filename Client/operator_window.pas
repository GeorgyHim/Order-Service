unit operator_window;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, System.JSON, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Vcl.ExtCtrls, Datasnap.DBClient,
  IdBaseComponent, IdComponent, IdUDPBase, IdUDPClient;

type
  TfOperatorWindow = class(TForm)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    nClient: TMenuItem;
    nCourier: TMenuItem;
    nOrder: TMenuItem;
    nAddress: TMenuItem;
    TabControl1: TTabControl;
    DBGrid1: TDBGrid;
    dsActiveOrders: TDataSource;
    cdsActiveOrders: TClientDataSet;
    updateDataButton: TMenuItem;
    cdsActiveOrdersstartTime: TDateTimeField;
    cdsActiveOrderscourierName: TWideStringField;
    cdsActiveOrderscourierSurname: TWideStringField;
    cdsActiveOrdersclientName: TWideStringField;
    cdsActiveOrdersaddress: TWideStringField;
    N3: TMenuItem;
    cdsActiveOrdersis_reported: TWideStringField;
    N2: TMenuItem;
    dsOrderHistory: TDataSource;
    cdsOrderHistory: TClientDataSet;
    cdsOrderHistoryendTime: TDateTimeField;
    cdsOrderHistorystartTime: TDateTimeField;
    cdsOrderHistorycourierName: TWideStringField;
    cdsOrderHistorycourierSurname: TWideStringField;
    cdsOrderHistoryclientName: TWideStringField;
    cdsOrderHistoryaddress: TWideStringField;
    cdsOrderHistoryis_reported: TWideStringField;
    Timer1: TTimer;
    cdsActiveOrdersid: TIntegerField;
    cdsOrderHistoryid: TIntegerField;
    DBGrid2: TDBGrid;
    dsOrderList: TDataSource;
    cdsOrderList: TClientDataSet;
    cdsOrderListpositionName: TWideStringField;
    cdsOrderListprice: TBCDField;
    procedure nClientClick(Sender: TObject);
    procedure nCourierClick(Sender: TObject);
    procedure nAddressClick(Sender: TObject);
    procedure nOrderClick(Sender: TObject);
    procedure updateDataButtonClick(Sender: TObject);
    procedure TabControl1Change(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure askData();
    procedure N2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fOperatorWindow: TfOperatorWindow;

implementation

{$R *.dfm}

uses client, courier, address, login, order, test, confirm_order;

procedure TfOperatorWindow.DBGrid1CellClick(Column: TColumn);
var
  jsonObjectToSend: tJsonObject;
  stringToSend: String;
  rowNumber: integer;
begin
  jsonObjectToSend := tJsonObject.Create;
  jsonObjectToSend.AddPair('type', 'orderList');
  jsonObjectToSend.AddPair('id', IntToStr(dbGrid1.DataSource.DataSet.FieldByName('id').Value));
  {
  if TabControl1.TabIndex = 0 then
    begin
      jsonObjectToSend.AddPair('id', IntToStr(cdsActiveOrders.FieldByName('id').Value));
    end;
  if TabControl1.TabIndex = 1 then
    begin
      jsonObjectToSend.AddPair('id', IntToStr(cdsOrderHistory.FieldByName('id').Value));
    end;
  }
  stringToSend := jsonObjectToSend.ToString;
  fLogin.ClientSocket1.Socket.SendText(stringToSend);
end;

procedure TfOperatorWindow.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  with DBGrid1 do
    with Canvas do
      begin
        if (cdsActiveOrdersis_reported.Value = 'true') then
          begin
            DBGrid1.Canvas.Brush.Color := clYellow;
            DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
          end;
      end;
end;

procedure TfOperatorWindow.askData();
var
  jsonObjectToSend: TJsonObject;
  stringToSend: String;
begin
  jsonObjectToSend := tJsonObject.Create;
  jsonObjectToSend.AddPair('type', 'operatorWindow');
  jsonObjectToSend.AddPair('tab', TabControl1.TabIndex.ToString);
  stringToSend := jsonObjectToSend.ToString;
  fLogin.ClientSocket1.Socket.SendText(stringToSend);
end;

procedure TfOperatorWindow.FormActivate(Sender: TObject);
begin
  askData();
end;

procedure TfOperatorWindow.FormCreate(Sender: TObject);
begin
  askData();
end;

procedure TfOperatorWindow.FormShow(Sender: TObject);
begin
  askData();
end;

procedure TfOperatorWindow.updateDataButtonClick(Sender: TObject);
begin
  askData();
end;

procedure TfOperatorWindow.N2Click(Sender: TObject);
begin
  fConfirmOrders := TfConfirmOrders.Create(Application);
  fConfirmOrders.ShowModal;
  fConfirmOrders.Release;
end;

procedure TfOperatorWindow.N3Click(Sender: TObject);
begin
  fTest := TfTest.Create(Application);
  fTest.ShowModal;
  fTest.Release;
end;

procedure TfOperatorWindow.nAddressClick(Sender: TObject);
begin
  fAddress := TfAddress.Create(Application);
  fAddress.ShowModal;
  fAddress.Release;
end;

procedure TfOperatorWindow.nClientClick(Sender: TObject);
begin
  fClient := TfClient.Create(Application);
  fClient.ShowModal;
  fClient.Release;
end;

procedure TfOperatorWindow.nCourierClick(Sender: TObject);
begin
  fCourier := TfCourier.Create(Application);
  fCourier.ShowModal;
  fCourier.Release;
end;

procedure TfOperatorWindow.nOrderClick(Sender: TObject);
begin
  fOrder := TfOrder.Create(Application);
  fOrder.ShowModal;
  fOrder.Release;
end;

procedure TfOperatorWindow.TabControl1Change(Sender: TObject);
var
  jsonObjectToSend: TJsonObject;
  stringToSend: String;
begin
  jsonObjectToSend := tJsonObject.Create;
  jsonObjectToSend.AddPair('type', 'operatorWindow');
  jsonObjectToSend.AddPair('tab', tabControl1.TabIndex.ToString);
  stringToSend := jsonObjectToSend.ToString;
  fLogin.ClientSocket1.Socket.SendText(stringToSend);
end;

procedure TfOperatorWindow.Timer1Timer(Sender: TObject);
begin
  Timer1.Interval := 5000;
  askData();
  Timer1.Enabled := false;
end;

end.
