unit create_operator;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.JSON;

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

uses login;

procedure TfCreateOperator.OKButtonClick(Sender: TObject);
var
  jsonObject: TJsonObject;

begin
  jsonObject := TJSONObject.Create;
  jsonObject.AddPair('operation', 'client_create_operator');
  jsonObject.AddPair('username', LoginEdit.Text);
  jsonObject.AddPair('password', PasswordEdit.Text);
  jsonObject.AddPair('surname', SurnameEdit.Text);
  jsonObject.AddPair('name', NameEdit.Text);
  jsonObject.AddPair('patronymic', PatronymicEdit.Text);
  fLogin.ClientSocket1.Socket.SendText(jsonObject.ToString);
  fCreateOperator.Close;
end;

procedure TfCreateOperator.CancelButtonClick(Sender: TObject);
begin
  fCreateOperator.Close;
end;

end.
