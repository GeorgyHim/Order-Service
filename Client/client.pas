unit client;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.JSON;

type
  TfClient = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    NameEdit: TEdit;
    PhoneEdit: TEdit;
    AddButton: TButton;
    procedure AddButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fClient: TfClient;

implementation

{$R *.dfm}

uses login;

procedure TfClient.AddButtonClick(Sender: TObject);
var
  jsonObject: TJSONObject;
  stringToSend: String;
begin
  jsonObject := TJSONObject.Create;
  jsonObject.AddPair('type', 'Client');
  jsonObject.AddPair('name', NameEdit.Text);
  jsonObject.AddPair('phone_number', PhoneEdit.Text);
  stringToSend := jsonObject.ToString;
  fLogin.ClientSocket1.Socket.SendText(RawByteString(jsonObject.ToString));
  Close;
end;

end.
