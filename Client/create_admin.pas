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

uses mydm, admin_window;

procedure TfCreateAdmin.OKButtonClick(Sender: TObject);
begin
  dm.CreateUser(LoginEdit.Text, PasswordEdit.Text, 0);
  fAdminWindow.UpdateData();
  fCreateAdmin.Close;
end;

procedure TfCreateAdmin.CancelButtonClick(Sender: TObject);
begin
  fCreateAdmin.Close;
end;

end.
