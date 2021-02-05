unit create_operator;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.JSON, mydm;

type
  TfCreateOperator = class(TForm)
    PasswordEdit: TEdit;
    LoginEdit: TEdit;
    LoginLabel: TLabel;
    PasswordLabel: TLabel;
    OKButton: TButton;
    CancelButton: TButton;
    SurnameLabel: TLabel;
    NameLabel: TLabel;
    PatronymicLabel: TLabel;
    NameEdit: TEdit;
    PatronymicEdit: TEdit;
    SurnameEdit: TEdit;
    procedure CancelButtonClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fCreateOperator: TfCreateOperator;

implementation

{$R *.dfm}

uses login, admin_window;

procedure TfCreateOperator.OKButtonClick(Sender: TObject);
begin
  dm.CreateOperator(
    SurnameEdit.Text, NameEdit.Text, PatronymicEdit.Text, LoginEdit.Text, PasswordEdit.Text
  );
  fAdminWindow.UpdateData();
  fCreateOperator.Close;
end;

procedure TfCreateOperator.CancelButtonClick(Sender: TObject);
begin
  fCreateOperator.Close;
end;

end.
