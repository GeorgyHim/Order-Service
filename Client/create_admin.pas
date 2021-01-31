unit create_admin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.JSON;

type
  TfCreateAdmin = class(TForm)
    PasswordEdit: TEdit;
    LoginEdit: TEdit;
    LoginLabel: TLabel;
    PasswordLabel: TLabel;
    OKButton: TButton;
    CancelButton: TButton;
    procedure CancelButtonClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fCreateAdmin: TfCreateAdmin;

implementation

{$R *.dfm}

uses login;

procedure TfCreateAdmin.OKButtonClick(Sender: TObject);
var
  jsonObject: TJsonObject;

begin
  jsonObject := TJSONObject.Create;
  jsonObject.AddPair('operation', 'client_create_admin_user');
  jsonObject.AddPair('username', LoginEdit.Text);
  jsonObject.AddPair('password', PasswordEdit.Text);
  fLogin.ClientSocket1.Socket.SendText(jsonObject.ToString);
end;

procedure TfCreateAdmin.CancelButtonClick(Sender: TObject);
begin
  fCreateAdmin.Close;
end;

end.
