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
    procedure OperatorGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure UpdateData(send_broadcast:Boolean=True);
    procedure FormCreate(Sender: TObject);
    procedure ChangePasswordOperatorMainMenuClick(Sender: TObject);
    procedure ChangeDataOperatorMainMenuClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure CompleteButtonClick(Sender: TObject);
    procedure AddOrderMainMenuClick(Sender: TObject);
    procedure DistributingOrdersMainMenuClick(Sender: TObject);
    procedure dsActiveOrdersDataChange(Sender: TObject; Field: TField);
    procedure dsCompletedOrdersDataChange(Sender: TObject; Field: TField);
    procedure dsCanceledOrdersDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fOperatorWindow: TfOperatorWindow;

implementation

{$R *.dfm}

uses distributing_orders, new_order, change_password, change_data, login, mydm, network;

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

procedure TfOperatorWindow.dsActiveOrdersDataChange(Sender: TObject;
  Field: TField);
begin
  OrderInfoMemo.Lines[0] := dm.GetOrderInfo(OperatorGrid.DataSource.DataSet.Fields[0].Value);
  if OperatorGrid.DataSource.DataSet.Fields[7].Value = 2 then
    begin
      CompleteButton.Enabled := True;
    end
  else
    begin
      CompleteButton.Enabled := False;
    end;
end;

procedure TfOperatorWindow.dsCanceledOrdersDataChange(Sender: TObject;
  Field: TField);
begin
  OrderInfoMemo.Lines[0] := dm.GetOrderInfo(OperatorGrid.DataSource.DataSet.Fields[0].Value);
end;

procedure TfOperatorWindow.dsCompletedOrdersDataChange(Sender: TObject;
  Field: TField);
begin
  OrderInfoMemo.Lines[0] := dm.GetOrderInfo(OperatorGrid.DataSource.DataSet.Fields[0].Value);
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

procedure TfOperatorWindow.OperatorGridDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  with OperatorGrid do
    with Canvas do
      begin
        if (OperatorGrid.DataSource.DataSet.Fields[7].Value = 2) then
          begin
            OperatorGrid.Canvas.Brush.Color := clGreen;
            OperatorGrid.DefaultDrawColumnCell(Rect, DataCol, Column, State);
          end;
      end;
end;

procedure TfOperatorWindow.UpdateMainMenuClick(Sender: TObject);
begin
  UpdateData(False);
end;

procedure TfOperatorWindow.OperatorTabControlChange(Sender: TObject);
var
  i: integer;
begin
  CompleteButton.Enabled := False;
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
