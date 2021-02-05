unit admin_window;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, System.JSON, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, Vcl.ExtCtrls, Datasnap.DBClient,
  IdBaseComponent, IdComponent, IdUDPBase, IdUDPClient, mydm, Vcl.StdCtrls;

type
  TfAdminWindow = class(TForm)
    AdminMainMenu: TMainMenu;
    AdminTabControl: TTabControl;
    AdminGrid: TDBGrid;
    Timer1: TTimer;
    CreateMenu: TMenuItem;
    CreateAdmin: TMenuItem;
    CreateOperator: TMenuItem;
    CreateRestaurant: TMenuItem;
    Update: TMenuItem;
    dsAllAdmins: TDataSource;
    dsAllOperators: TDataSource;
    dsAllRestaurants: TDataSource;
    dsAllOrders: TDataSource;
    procedure nClientClick(Sender: TObject);
    procedure nCourierClick(Sender: TObject);
    procedure nAddressClick(Sender: TObject);
    procedure nOrderClick(Sender: TObject);
    procedure updateDataButtonClick(Sender: TObject);
    procedure AdminTabControlChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure updateData();
    procedure CreateAdminClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure AdminGridCellClick(Column: TColumn);
    procedure UpdateClick(Sender: TObject);
    procedure CreateOperatorClick(Sender: TObject);
    procedure CreateRestaurantClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fAdminWindow: TfAdminWindow;

implementation

{$R *.dfm}

uses create_admin, create_operator, create_restaurant, client, courier, address, login, order, confirm_order;

procedure TfAdminWindow.AdminGridCellClick(Column: TColumn);
var
  jsonObjectToSend: tJsonObject;
  stringToSend: String;
  rowNumber: integer;
begin
//  jsonObjectToSend := tJsonObject.Create;
//  jsonObjectToSend.AddPair('type', 'orderList');
//  jsonObjectToSend.AddPair('id', IntToStr(AdminGrid.DataSource.DataSet.FieldByName('id').Value));
//  {
//  if TabControl1.TabIndex = 0 then
//    begin
//      jsonObjectToSend.AddPair('id', IntToStr(cdsActiveOrders.FieldByName('id').Value));
//    end;
//  if TabControl1.TabIndex = 1 then
//    begin
//      jsonObjectToSend.AddPair('id', IntToStr(cdsOrderHistory.FieldByName('id').Value));
//    end;
//  }
//  stringToSend := jsonObjectToSend.ToString;
//  fLogin.ClientSocket1.Socket.SendText(stringToSend);
end;
{
procedure TfAdminWindow.askData();
var
    jsonObjectToSend: TJsonObject;
    stringToSend: String;
begin
    jsonObjectToSend := tJsonObject.Create;
    jsonObjectToSend.AddPair('type', 'operatorWindow');
    jsonObjectToSend.AddPair('tab', AdminTabControl.TabIndex.ToString);
    stringToSend := jsonObjectToSend.ToString;
    fLogin.ClientSocket1.Socket.SendText(stringToSend);
end;
}

procedure TfAdminWindow.FormActivate(Sender: TObject);
begin
//  askData();
  AdminTabControlChange(nil);
//  dsAdmins.DataSet := dm.qAllAdmins;
//  dsOperators.DataSet := dm.qAllOperators;
//  dsRestaurants.DataSet := dm.qAllRestaurants;
//  dsOrders.DataSet := dm.qAllOrders;
end;

procedure TfAdminWindow.updateDataButtonClick(Sender: TObject);
begin
  //askData();
end;

procedure TfAdminWindow.CreateAdminClick(Sender: TObject);
begin
  fCreateAdmin := TfCreateAdmin.Create(Application);
  fCreateAdmin.ShowModal;
  fCreateAdmin.Release;
end;

procedure TfAdminWindow.CreateOperatorClick(Sender: TObject);
begin
  fCreateOperator := TfCreateOperator.Create(Application);
  fCreateOperator.ShowModal;
  fCreateOperator.Release;
end;

procedure TfAdminWindow.CreateRestaurantClick(Sender: TObject);
begin
  fCreateRestaurant := TfCreateRestaurant.Create(Application);
  fCreateRestaurant.ShowModal;
  fCreateRestaurant.Release;
end;

procedure TfAdminWindow.nAddressClick(Sender: TObject);
begin
  fAddress := TfAddress.Create(Application);
  fAddress.ShowModal;
  fAddress.Release;
end;

procedure TfAdminWindow.nClientClick(Sender: TObject);
begin
  fClient := TfClient.Create(Application);
  fClient.ShowModal;
  fClient.Release;
end;

procedure TfAdminWindow.nCourierClick(Sender: TObject);
begin
  fCourier := TfCourier.Create(Application);
  fCourier.ShowModal;
  fCourier.Release;
end;

procedure TfAdminWindow.nOrderClick(Sender: TObject);
begin
  fOrder := TfOrder.Create(Application);
  fOrder.ShowModal;
  fOrder.Release;
end;

procedure TfAdminWindow.AdminTabControlChange(Sender: TObject);
begin
  if AdminTabControl.TabIndex = 0 then
    begin
      AdminGrid.DataSource := dsAllAdmins;
    end;
  if AdminTabControl.TabIndex = 1 then
    begin
      AdminGrid.DataSource := dsAllOperators;
    end;
  if AdminTabControl.TabIndex = 2 then
    begin
      AdminGrid.DataSource := dsAllRestaurants;
    end;
  if AdminTabControl.TabIndex = 3 then
    begin
      AdminGrid.DataSource := dsAllOrders;
    end;
  dm.IBTransaction_Read.Active := False;
  dm.IBTransaction_Read.Active := True;
  AdminGrid.DataSource.DataSet.Open;
end;

procedure TfAdminWindow.Timer1Timer(Sender: TObject);
begin
  Timer1.Interval := 5000;
  //askData();
  Timer1.Enabled := false;
end;

procedure TfAdminWindow.UpdateClick(Sender: TObject);
begin
  updateData();
end;

procedure TfAdminWindow.updateData();
begin
  AdminTabControlChange(nil);
end;

end.
