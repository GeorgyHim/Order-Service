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
    CreateMenu: TMenuItem;
    CreateAdmin: TMenuItem;
    CreateOperator: TMenuItem;
    CreateRestaurant: TMenuItem;
    Update: TMenuItem;
    dsAllAdmins: TDataSource;
    dsAllOperators: TDataSource;
    dsAllRestaurants: TDataSource;
    dsAllOrders: TDataSource;
    procedure AdminTabControlChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure UpdateData();
    procedure CreateAdminClick(Sender: TObject);
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

procedure TfAdminWindow.FormActivate(Sender: TObject);
begin
  AdminGrid.EditorMode := True;
  AdminTabControlChange(nil);
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

procedure TfAdminWindow.UpdateClick(Sender: TObject);
begin
  UpdateData();
end;

procedure TfAdminWindow.UpdateData();
begin
  AdminTabControlChange(nil);
end;

end.
