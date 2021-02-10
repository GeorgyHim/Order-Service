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
    CreateMainMenu: TMenuItem;
    CreateAdmin: TMenuItem;
    CreateOperator: TMenuItem;
    CreateRestaurant: TMenuItem;
    MainMenuUpdate: TMenuItem;
    dsAllAdmins: TDataSource;
    dsAllOperators: TDataSource;
    dsAllRestaurants: TDataSource;
    dsAllOrders: TDataSource;
    DeactivateButton: TButton;
    dsAllDeactivatedUsers: TDataSource;
    EditButton: TButton;
    ChangeProfileMainMenu: TMenuItem;
    procedure AdminTabControlChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure UpdateData();
    procedure CreateAdminClick(Sender: TObject);
    procedure MainMenuUpdateClick(Sender: TObject);
    procedure CreateOperatorClick(Sender: TObject);
    procedure CreateRestaurantClick(Sender: TObject);
    procedure DeactivateButtonClick(Sender: TObject);
    procedure EditButtonClick(Sender: TObject);
    procedure ChangeProfileMainMenuClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fAdminWindow: TfAdminWindow;

implementation

{$R *.dfm}

uses create_admin, create_operator, create_restaurant, change_admin,
  client, courier, address, login, order, confirm_order, network;

procedure TfAdminWindow.FormActivate(Sender: TObject);
begin
  AdminGrid.EditorMode := True;
  AdminTabControlChange(nil);
end;

procedure TfAdminWindow.ChangeProfileMainMenuClick(Sender: TObject);
begin
  fChangeAdmin := TfChangeAdmin.Create(Application);
  fChangeAdmin.ShowModal;
  fChangeAdmin.Release;
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

procedure TfAdminWindow.DeactivateButtonClick(Sender: TObject);
begin
  if AdminTabControl.TabIndex = 0 then
    begin
      dm.DeactivateUser(AdminGrid.DataSource.DataSet.Fields[0].Value);
    end;
  if AdminTabControl.TabIndex = 1 then
    begin
      dm.DeactivateUser(AdminGrid.DataSource.DataSet.Fields[3].Value);
    end;
  if AdminTabControl.TabIndex = 2 then
    begin
      dm.DeactivateUser(AdminGrid.DataSource.DataSet.Fields[5].Value);
    end;
  if AdminTabControl.TabIndex = 4 then
     begin
      dm.ActivateUser(AdminGrid.DataSource.DataSet.Fields[0].Value);
    end;
  UpdateData();
end;

procedure TfAdminWindow.EditButtonClick(Sender: TObject);
var
  Login: string;
begin
  if AdminTabControl.TabIndex = 0 then
    begin
      fChangeAdmin := TfChangeAdmin.Create(Application);
      fChangeAdmin.ShowModal;
      fChangeAdmin.Release;
      Login := AdminGrid.DataSource.DataSet.Fields[0].Value;
    end;
  if AdminTabControl.TabIndex = 1 then
    begin

    end;
  if AdminTabControl.TabIndex = 2 then
    begin

    end;
end;

procedure TfAdminWindow.AdminTabControlChange(Sender: TObject);
var i : Integer;
begin
  DeactivateButton.Caption := 'Deactive';
  DeactivateButton.Enabled := True;
  EditButton.Enabled := True;

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
      EditButton.Enabled := False;
    end;
  if AdminTabControl.TabIndex = 3 then
    begin
      AdminGrid.DataSource := dsAllOrders;
      DeactivateButton.Enabled := False;
      EditButton.Enabled := False;
    end;
  if AdminTabControl.TabIndex = 4 then
    begin
      AdminGrid.DataSource := dsAllDeactivatedUsers;
      DeactivateButton.Caption := 'Active';
      EditButton.Enabled := False;
    end;
  AdminGrid.DataSource.DataSet.Open;

  for i := 0 to AdminGrid.Columns.Count-1 do begin
    AdminGrid.Columns[i].Expanded := False;
    AdminGrid.Columns[i].Width := 100
  end;
end;

procedure TfAdminWindow.MainMenuUpdateClick(Sender: TObject);
begin
  UpdateData();
end;

procedure TfAdminWindow.UpdateData();
begin
  dm.UpdateData();
  AdminTabControlChange(nil);
  FormNetwork.IdUDPClient1.Broadcast('updateData', 6969);
end;

end.
