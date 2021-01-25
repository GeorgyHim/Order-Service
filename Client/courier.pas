unit courier;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.JSON;

type
  TfCourier = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    NameEdit: TEdit;
    surnameEdit: TEdit;
    phoneEdit: TEdit;
    emailEdit: TEdit;
    transportEdit: TEdit;
    addButton: TButton;
    procedure addButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fCourier: TfCourier;

implementation

uses login;

{$R *.dfm}

procedure TfCourier.addButtonClick(Sender: TObject);
var
  jsonObject: TJSONObject;
begin
  jsonObject := TJSONObject.Create;
  jsonObject.AddPair('type', 'Courier');
  jsonObject.AddPair('name', NameEdit.Text);
  jsonObject.AddPair('surname', surnameEdit.Text);
  jsonObject.AddPair('phone_number', PhoneEdit.Text);
  jsonObject.AddPair('email', emailEdit.Text);
  jsonObject.AddPair('transport', transportEdit.text);
  fLogin.ClientSocket1.Socket.SendText(jsonObject.ToString);
  Close;
end;

end.
