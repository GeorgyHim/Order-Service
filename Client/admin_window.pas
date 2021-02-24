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
    UpdateMainMenu: TMenuItem;
    dsAllAdmins: TDataSource;
    dsAllOperators: TDataSource;
    dsAllRestaurants: TDataSource;
    dsAllOrders: TDataSource;
    DeactivateButton: TButton;
    dsAllDeactivatedUsers: TDataSource;
    ChangeProfileMainMenu: TMenuItem;
    procedure AdminTabControlChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure UpdateData(send_broadcast:Boolean=True);
    procedure CreateAdminClick(Sender: TObject);
    procedure UpdateMainMenuClick(Sender: TObject);
    procedure CreateOperatorClick(Sender: TObject);
    procedure CreateRestaurantClick(Sender: TObject);
    procedure DeactivateButtonClick(Sender: TObject);
    procedure ChangeProfileMainMenuClick(Sender: TObject);
    procedure AdminGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fAdminWindow: TfAdminWindow;

implementation

{$R *.dfm}

uses create_admin, create_operator, create_restaurant, change_password, login, network;

procedure TfAdminWindow.FormActivate(Sender: TObject);
begin
  AdminGrid.EditorMode := True;
  AdminTabControlChange(nil);
end;

procedure TfAdminWindow.ChangeProfileMainMenuClick(Sender: TObject);
begin
  fChangePassword := TfChangePassword.Create(Application);
  fChangePassword.ShowModal;
  fChangePassword.Release;
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

procedure TfAdminWindow.AdminGridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if (gdFocused in State) then
    AdminGrid.Canvas.Brush.Color := clBlue
end;

procedure TfAdminWindow.AdminTabControlChange(Sender: TObject);
var i : Integer;
begin
  DeactivateButton.Caption := 'Deactive';
  DeactivateButton.Enabled := True;

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
      DeactivateButton.Enabled := False;
    end;
  if AdminTabControl.TabIndex = 4 then
    begin
      AdminGrid.DataSource := dsAllDeactivatedUsers;
      DeactivateButton.Caption := 'Active';
    end;
  AdminGrid.DataSource.DataSet.Open;

  for i := 0 to AdminGrid.Columns.Count - 1 do begin
    AdminGrid.Columns[i].Expanded := False;
    AdminGrid.Columns[i].Width := 100
  end;
end;

procedure TfAdminWindow.UpdateMainMenuClick(Sender: TObject);
begin
  UpdateData();
end;

procedure TfAdminWindow.UpdateData(send_broadcast:Boolean=True);
begin
  dm.UpdateData();
  AdminTabControlChange(nil);
  if send_broadcast then
    FormNetwork.IdUDPClient1.Broadcast('updateData', 6969);
end;

end.
