unit change_password;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfChangePassword = class(TForm)
    OldPasswordLabel: TLabel;
    OldPasswordEdit: TEdit;
    OKButton: TButton;
    CancelButton: TButton;
    NewPasswordLabel: TLabel;
    NewPasswordEdit: TEdit;
    WrongOldPasswordLabel: TLabel;
    procedure CancelButtonClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fChangePassword: TfChangePassword;

implementation

{$R *.dfm}

uses mydm, admin_window, login, operator_window;

procedure TfChangePassword.OKButtonClick(Sender: TObject);
begin
  if dm.ChangePassword(username, OldPasswordEdit.Text, NewPasswordEdit.Text) then
    begin
      if role = 0 then
        fAdminWindow.UpdateData()
      else
        fOperatorWindow.UpdateData();
      fChangePassword.Close;
    end
  else
    begin
      WrongOldPasswordLabel.Caption := 'Wrong old password'
    end;
end;

procedure TfChangePassword.CancelButtonClick(Sender: TObject);
begin
  fChangePassword.Close;
end;

end.
