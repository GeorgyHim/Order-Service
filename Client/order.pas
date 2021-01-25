unit order;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.JSON,
  System.Generics.Defaults, System.Generics.Collections;

type
  TfOrder = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    courierEdit: TEdit;
    addressEdit: TEdit;
    chooseCourier: TButton;
    chooseAddress: TButton;
    orderMemo: TMemo;
    addPositionButton: TButton;
    approveOrderButton: TButton;
    Label3: TLabel;
    clientEdit: TEdit;
    chooseClientButton: TButton;
    procedure chooseCourierClick(Sender: TObject);
    procedure chooseAddressClick(Sender: TObject);
    procedure addPositionButtonClick(Sender: TObject);
    procedure approveOrderButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure chooseClientButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    selectedCourierId, selectedAddressId, selectedClientId: integer;
    selectedCourierName, selectedClientAddress, selectedClientName, testString: String;
    positions: TDictionary<String, Double>;
  end;

var
  fOrder: TfOrder;

implementation

{$R *.dfm}

uses login, clientlist, client_address_list, add_position, courierlist, operator_window;

procedure TfOrder.addPositionButtonClick(Sender: TObject);
begin
  fAddPosition := TfAddPosition.Create(Application);
  fAddPosition.ShowModal;
  fAddPosition.Release;
end;

procedure TfOrder.approveOrderButtonClick(Sender: TObject);
var
  jsonObjectToSend, jsonArrayElement: tJsonObject;
  jsonArray: tJsonArray;
  stringToSend, timestamp: String;
  item: TPair<String, Double>;
  i: integer;
begin
  jsonObjectToSend := tJsonObject.Create;
  jsonObjectToSend.AddPair('type', 'order');
  jsonObjectToSend.AddPair('tab', fWindow.TabControl1.TabIndex.ToString);
  jsonObjectToSend.AddPair('courierId', selectedCourierId.ToString);
  jsonObjectToSend.AddPair('addressId', selectedAddressId.ToString);
  DateTimeToString(timestamp, 'dd.mm.yyyy hh:mm', now);
  jsonObjectToSend.AddPair('startTime', timestamp);
  jsonArray := tJsonArray.Create;
  i := positions.Count;
  for item in positions do
    begin
      jsonArray.AddElement(tJsonObject.Create);
      jsonArrayElement := jsonArray.Items[pred(jsonArray.Count)] as tJsonObject;
      jsonArrayElement
        .addPair('name', item.Key)
        .addPair('price', item.Value.ToString);
    end;
  positions.Clear;
  jsonObjectToSend.AddPair('positions', jsonArray);
  stringToSend := jsonObjectToSend.ToString;
  fLogin.ClientSocket1.Socket.SendText(stringToSend);
  Close;
end;

procedure TfOrder.chooseAddressClick(Sender: TObject);
var
  jsonObjectToSend: TJsonObject;
begin
  jsonObjectToSend := TJsonObject.Create;
  jsonObjectToSend.AddPair('type', 'getClientAddress');
  jsonObjectToSend.AddPair('clientId', selectedClientId.ToString);
  fLogin.ClientSocket1.Socket.SendText(jsonObjectToSend.ToString);
  fClientAddress := TfClientAddress.Create(Application);
  fClientAddress.ShowModal;
  fClientAddress.Release;
  addressEdit.Text := selectedClientAddress;
end;

procedure TfOrder.chooseClientButtonClick(Sender: TObject);
var
  jsonObjectToSend: TJSONObject;
begin
  jsonObjectToSend := TJSONObject.Create;
  jsonObjectToSend.AddPair('type', 'getClients');
  fLogin.ClientSocket1.Socket.SendText(jsonObjectToSend.ToString);
  fClientList := TfClientList.Create(Application);
  fClientList.Tag := 2;
  fClientList.ShowModal;
  fClientList.Release;
  clientEdit.Text := selectedClientName;
end;

procedure TfOrder.chooseCourierClick(Sender: TObject);
var
  jsonObjectToSend: TJsonObject;
begin
  jsonObjectToSend := TJsonObject.Create;
  jsonObjectToSend.AddPair('type', 'getCouriers');
  fLogin.ClientSocket1.Socket.SendText(jsonObjectToSend.ToString);
  fCourierList := TfCourierList.Create(Application);
  fCourierList.ShowModal;
  fCourierList.Release;
  courierEdit.Text := selectedCourierName;
end;

procedure TfOrder.FormCreate(Sender: TObject);
begin
  positions := TDictionary<String, Double>.Create;
end;

end.
