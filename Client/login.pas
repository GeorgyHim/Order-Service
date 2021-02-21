unit login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin,
  System.Win.ScktComp, System.JSON, IdBaseComponent, IdComponent, IdUDPBase,
  IdUDPClient, IdUDPServer, IdGlobal, IdSocketHandle, mydm, config;

type
  TfLogin = class(TForm)
    HostEdit: TEdit;
    PortEdit: TSpinEdit;
    LoginButton: TButton;
    portLabel: TLabel;
    HostLabel: TLabel;
    LoginLabel: TLabel;
    Label1: TLabel;
    PasswordEdit: TEdit;
    LoginEdit: TEdit;
    LoginDenied: TLabel;
    DBPathLabel: TLabel;
    DataBasePathEdit: TEdit;
    ClientSocket1: TClientSocket;
    procedure LoginButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fLogin: TfLogin;
  user_id: Int64;
  role: SmallInt;
  username: string;

implementation

{$R *.dfm}

uses operator_window, clientlist, db, client_address_list, courierlist, confirm_order,
  admin_window, network;

procedure TfLogin.LoginButtonClick(Sender: TObject);
var
  jsonObject: TJsonObject;
  stringToSend: String;

begin
  LoginDenied.Caption := '';
  dm.EditHost(HostEdit.Text, DataBasePathEdit.Text);
  if dm.CheckPassword(LoginEdit.Text, PasswordEdit.Text, user_id, role) then
    begin
      FormNetwork.IdUDPServer1.Active := False;
      FormNetwork.IdUDPServer1.Bindings.Clear();
      FormNetwork.IdUDPServer1.Bindings.Add.IP := ClientIP;
      FormNetwork.IdUDPServer1.Bindings.Add.Port := 6969;
      FormNetwork.IdUDPServer1.Active := True;
      username := LoginEdit.Text;
      if role = 0 then
      begin
        fAdminWindow := TfAdminWindow.create(APPLICATION);
        fAdminWindow.ShowModal;
      end;

      if role = 1 then
      begin
        fOperatorWindow := TfOperatorWindow.create(APPLICATION);
        fOperatorWindow.ShowModal;
      end;

      if role = 2 then
        LoginDenied.Caption := 'Login denied, not desktop';
    end
    else
      LoginDenied.Caption := 'Login denied';
end;

procedure TfLogin.FormCreate(Sender: TObject);
begin
  DataBasePathEdit.Text := DBPath;
end;

end.
