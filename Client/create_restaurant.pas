unit create_restaurant;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.JSON;

type
  TfCreateRestaurant = class(TForm)
    LoginEdit: TEdit;
    PasswordEdit: TEdit;
    NameEdit: TEdit;
    NameLabel: TLabel;
    OKButton: TButton;
    CancelButton: TButton;
    LoginLabel: TLabel;
    PasswordLabel: TLabel;
    AddressLabel: TLabel;
    StartHourLabel: TLabel;
    StartHourEdit: TEdit;
    EndHourLabel: TLabel;
    EndHourEdit: TEdit;
    AddressEdit: TEdit;
    MenuEdit: TEdit;
    MenuLabel: TLabel;
    procedure CancelButtonClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fCreateRestaurant: TfCreateRestaurant;

implementation

{$R *.dfm}

uses login;

procedure TfCreateRestaurant.OKButtonClick(Sender: TObject);
var
  jsonObject: TJsonObject;
begin
  jsonObject := TJSONObject.Create;
  jsonObject.AddPair('operation', 'client_create_restaurant');
  jsonObject.AddPair('username', LoginEdit.Text);
  jsonObject.AddPair('password', PasswordEdit.Text);
  jsonObject.AddPair('name', NameEdit.Text);
  jsonObject.AddPair('address', AddressEdit.Text);
  jsonObject.AddPair('start_hour', StartHourEdit.Text);
  jsonObject.AddPair('end_hour', EndHourEdit.Text);
  jsonObject.AddPair('menu', MenuEdit.Text);
  fLogin.ClientSocket1.Socket.SendText(jsonObject.ToString);
  fCreateRestaurant.Close;
end;

procedure TfCreateRestaurant.CancelButtonClick(Sender: TObject);
begin
  fCreateRestaurant.Close;
end;

end.
