unit change_admin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfChangeAdmin = class(TForm)
    OldPasswordLabel: TLabel;
    OldPasswordEdit: TEdit;
    OKButton: TButton;
    CancelButton: TButton;
    NewPasswordLabel: TLabel;
    NewPasswordEdit: TEdit;
    procedure CancelButtonClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fChangeAdmin: TfChangeAdmin;

implementation

{$R *.dfm}

uses mydm, admin_window, login;

procedure TfChangeAdmin.OKButtonClick(Sender: TObject);
begin
  dm.ChangePassword(username, OldPasswordEdit.Text, NewPasswordEdit.Text);
  fAdminWindow.UpdateData();
  fChangeAdmin.Close;
end;

procedure TfChangeAdmin.CancelButtonClick(Sender: TObject);
begin
  fChangeAdmin.Close;
end;

end.
