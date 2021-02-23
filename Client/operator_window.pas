unit operator_window;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, System.JSON, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Vcl.ExtCtrls, Datasnap.DBClient,
  IdBaseComponent, IdComponent, IdUDPBase, IdUDPClient, Vcl.StdCtrls;

type
  TfOperatorWindow = class(TForm)
    OperatorMainMenu: TMainMenu;
    OrdersMainMenu: TMenuItem;
    OperatorTabControl: TTabControl;
    OperatorGrid: TDBGrid;
    dsActiveOrders: TDataSource;
    UpdateMainMenu: TMenuItem;
    dsCompletedOrders: TDataSource;
    OrderInfoMemo: TMemo;
    dsCanceledOrders: TDataSource;
    CompleteButton: TButton;
    CancelButton: TButton;
    N1: TMenuItem;
    ChangePasswordOperatorMainMenu: TMenuItem;
    ChangeDataOperatorMainMenu: TMenuItem;
    AddOrderMainMenu: TMenuItem;
    DistributingOrdersMainMenu: TMenuItem;
    procedure UpdateMainMenuClick(Sender: TObject);
    procedure OperatorTabControlChange(Sender: TObject);
//  procedure TestMainMenuClick(Sender: TObject);
    procedure OperatorGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure UpdateData(send_broadcast:Boolean=True);
    procedure FormCreate(Sender: TObject);
    procedure OperatorGridCellClick(Column: TColumn);
    procedure ChangePasswordOperatorMainMenuClick(Sender: TObject);
    procedure ChangeDataOperatorMainMenuClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure CompleteButtonClick(Sender: TObject);
    procedure AddOrderMainMenuClick(Sender: TObject);
    procedure DistributingOrdersMainMenuClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fOperatorWindow: TfOperatorWindow;

implementation

{$R *.dfm}

uses distributing_orders, new_order, change_password, change_data, client, courier, address, login, order, test, confirm_order, mydm, network;

procedure TfOperatorWindow.FormCreate(Sender: TObject);
begin
  UpdateData();
end;

procedure TfOperatorWindow.AddOrderMainMenuClick(Sender: TObject);
begin
  fNewOrder := TfNewOrder.Create(Application);
  fNewOrder.ShowModal;
  fNewOrder.Release;
end;

procedure TfOperatorWindow.CancelButtonClick(Sender: TObject);
begin
  if MessageDlg('Do you really want to cancel the order?', mtConfirmation, mbYesNo, 0) = mrYes then
    begin
      dm.CancelOrder(OperatorGrid.DataSource.DataSet.Fields[0].Value);
      UpdateData();
    end;
end;

procedure TfOperatorWindow.CompleteButtonClick(Sender: TObject);
begin
  if MessageDlg('Do you really want to complete the order?', mtConfirmation, mbYesNo, 0) = mrYes then
    begin
      dm.CompleteOrder(
        OperatorGrid.DataSource.DataSet.FieldByName('ID').Value,
        VarToStr(OperatorGrid.DataSource.DataSet.FieldByName('REAL_END_TIME').Value)
        );
      UpdateData();
    end;
end;

procedure TfOperatorWindow.DistributingOrdersMainMenuClick(Sender: TObject);
begin
  fDistributingOrders := TfDistributingOrders.Create(Application);
  fDistributingOrders.ShowModal;
  fDistributingOrders.Release;
end;

procedure TfOperatorWindow.ChangeDataOperatorMainMenuClick(Sender: TObject);
begin
  fChangeData := TfChangeData.Create(Application);
  fChangeData.ShowModal;
  fChangeData.Release;
end;

procedure TfOperatorWindow.ChangePasswordOperatorMainMenuClick(Sender: TObject);
begin
  fChangePassword := TfChangePassword.Create(Application);
  fChangePassword.ShowModal;
  fChangePassword.Release;
end;

procedure TfOperatorWindow.FormActivate(Sender: TObject);
begin
  OperatorGrid.EditorMode := True;
  OperatorTabControlChange(nil);
end;

procedure TfOperatorWindow.FormShow(Sender: TObject);
begin
  UpdateData();
end;

procedure TfOperatorWindow.OperatorGridCellClick(Column: TColumn);
var
  jsonObjectToSend: tJsonObject;
  stringToSend: String;
  rowNumber: integer;
begin
  jsonObjectToSend := tJsonObject.Create;
  jsonObjectToSend.AddPair('type', 'orderList');
  jsonObjectToSend.AddPair('id', IntToStr(OperatorGrid.DataSource.DataSet.FieldByName('id').Value));
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

procedure TfOperatorWindow.OperatorGridDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  with OperatorGrid do
    with Canvas do
      begin
        if ('false' = 'true') then
          begin
            OperatorGrid.Canvas.Brush.Color := clGreen;
            OperatorGrid.DefaultDrawColumnCell(Rect, DataCol, Column, State);
          end;
      end;   // TODO...
end;

procedure TfOperatorWindow.UpdateMainMenuClick(Sender: TObject);
begin
  UpdateData();
end;

//procedure TfOperatorWindow.TestMainMenuClick(Sender: TObject);
//begin
//  fTest := TfTest.Create(Application);
//  fTest.ShowModal;
//  fTest.Release;
//end;             для тестирование чего-нибудь

procedure TfOperatorWindow.OperatorTabControlChange(Sender: TObject);
var
  i: integer;
begin
  CompleteButton.Enabled := True;
  CancelButton.Enabled := True;
  if OperatorTabControl.TabIndex = 0 then
    begin
      OperatorGrid.DataSource := dsActiveOrders;
    end;
  if OperatorTabControl.TabIndex = 1 then
    begin
      OperatorGrid.DataSource := dsCompletedOrders;
      CompleteButton.Enabled := False;
      CancelButton.Enabled := False;
    end;
  if OperatorTabControl.TabIndex = 2 then
    begin
      OperatorGrid.DataSource := dsCanceledOrders;
      CompleteButton.Enabled := False;
      CancelButton.Enabled := False;
    end;
  OperatorGrid.DataSource.DataSet.Open;

  OperatorGrid.Columns[0].Expanded := False;
  OperatorGrid.Columns[0].Width := 0;
  for i := 1 to OperatorGrid.Columns.Count-1 do begin
    OperatorGrid.Columns[i].Expanded := False;
    OperatorGrid.Columns[i].Width := 100;
  end;
end;

procedure TfOperatorWindow.UpdateData(send_broadcast:Boolean=True);
begin
  dm.UpdateData();
  OperatorTabControlChange(nil);
  if send_broadcast then
    FormNetwork.IdUDPClient1.Broadcast('updateData', 6969);
end;

end.
