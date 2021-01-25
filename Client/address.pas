unit address;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.JSON;

type
  TfAddress = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    clientEdit: TEdit;
    addressEdit: TEdit;
    chooseButton: TButton;
    addButton: TButton;
    procedure chooseButtonClick(Sender: TObject);
    procedure addButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    selectedClientId: integer;
    clientName: String;
  end;

var
  fAddress: TfAddress;

implementation

{$R *.dfm}

uses clientlist, login;

procedure TfAddress.addButtonClick(Sender: TObject);
var
  jsonObject: TJsonObject;
begin
  jsonObject := TJsonObject.Create;
  jsonObject.AddPair('type', 'address');
  jsonObject.AddPair('clientId', selectedClientId.ToString);
  jsonObject.AddPair('address', AddressEdit.Text);
  fLogin.ClientSocket1.Socket.SendText(jsonObject.ToString);
  Close;
end;

procedure TfAddress.chooseButtonClick(Sender: TObject);
var
  jsonObjectToSend: TJSONObject;
begin
  jsonObjectToSend := TJSONObject.Create;
  jsonObjectToSend.AddPair('type', 'getClients');
  fLogin.ClientSocket1.Socket.SendText(jsonObjectToSend.ToString);
  fClientList := TfClientList.Create(Application);
  fClientList.Tag := 1;
  fClientList.ShowModal;
  fClientList.Release;
  clientEdit.Text := clientName;
end;

end.
