unit login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin,
  System.Win.ScktComp, System.JSON, IdBaseComponent, IdComponent, IdUDPBase,
  IdUDPClient, IdUDPServer, IdGlobal, IdSocketHandle;

type
  TfLogin = class(TForm)
    HostEdit: TEdit;
    PortEdit: TSpinEdit;
    Button1: TButton;
    Button2: TButton;
    ClientSocket1: TClientSocket;
    portLabel: TLabel;
    Label1: TLabel;
    IdUDPServer1: TIdUDPServer;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ClientSocket1Read(Sender: TObject; Socket: TCustomWinSocket);
    function modifyJsonString(jsonObject: TJSONObject; key: String): String;
    procedure IdUDPServer1UDPRead(AThread: TIdUDPListenerThread;
      const AData: TIdBytes; ABinding: TIdSocketHandle);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fLogin: TfLogin;

implementation

{$R *.dfm}

uses operator_window, clientlist, db, client_address_list, courierlist, confirm_order;

procedure TfLogin.Button1Click(Sender: TObject);
var
  jsonObjectToSend: TJsonObject;
  stringToSend: String;
begin
  ClientSocket1.Host := HostEdit.Text;
  ClientSocket1.Port := PortEdit.Value;
  ClientSocket1.Active := true;
  IdUDPServer1.Active := false;
  IdUDPServer1.Bindings.Clear;
  IdUDPServer1.Bindings.Add.Port := 4011;
  IdUDPServer1.Active := True;
  fWindow := TfWindow.Create(Application);
  fWindow.ShowModal;
  fWindow.Release;
end;

procedure TfLogin.Button2Click(Sender: TObject);
begin
  ClientSocket1.Active := false;
end;

procedure TfLogin.ClientSocket1Read(Sender: TObject; Socket: TCustomWinSocket);
var
  jsonObjectToSend, jsonObjectToReceive, jsonArrayElement: TJSONObject;
  jsonArray: TJSONArray;
  receivedString, objectType, testString, tab: String;
  i: integer;
  bool: boolean;
begin
  receivedString := Socket.ReceiveText;
  jsonObjectToReceive :=
        TJSONObject.ParseJSONValue(receivedString) as TJSONObject;
  if jsonObjectToReceive.TryGetValue('type', testString) then
    begin
      objectType := jsonObjectToReceive.GetValue('type').ToString;
    end;
  if objectType = '"ClientList"' then
    begin
      fCLientList.ClientDataSet1.CreateDataSet;
      jsonArray := jsonObjectToReceive.GetValue('clients') as TJsonArray;
      for i := 0 to Pred(jsonArray.Count) do
        begin
          fClientList.ClientDataSet1.AppendRecord([
              jsonArray.Items[i].FindValue('id').Value.ToInteger(),
              modifyJsonString(jsonArray.Items[i] as TJSONObject, 'name'),
              modifyJsonString(jsonArray.Items[i] as TJSONObject, 'phone_number')
          ]);
      end;
    end;
  if objectType = '"clientAddresses"' then
    begin
      fClientAddress.ClientDataSet1.CreateDataSet;
      jsonArray := jsonObjectToReceive.GetValue('addresses') as tJsonArray;
      for i := 0 to pred(jsonArray.Count) do
        begin
          fClientAddress.ClientDataSet1.AppendRecord([
            jsonArray.Items[i].FindValue('id').Value.ToInteger(),
            jsonArray.Items[i].FindValue('clientId').Value.ToInteger(),
            modifyJsonString(jsonArray.Items[i] as tJsonObject, 'address')
          ]);
        end;
    end;
  if objectType = '"courierList"' then
    begin
      fCourierList.ClientDataSet1.CreateDataSet;
      jsonArray := jsonObjectToReceive.GetValue('couriers') as tJsonArray;
      for i := 0 to pred(jsonArray.Count) do
        begin
          fCourierList.ClientDataSet1.AppendRecord([
            jsonArray.Items[i].FindValue('id').Value.ToInteger(),
            jsonArray.Items[i].FindValue('name').Value,
            jsonArray.Items[i].FindValue('surname').Value,
            jsonArray.Items[i].FindValue('phone_number').Value,
            jsonArray.Items[i].FindValue('email').Value,
            jsonArray.Items[i].FindValue('transport_type').Value
          ]);
        end;
    end;
  if objectType = '"orders"' then
    begin
      jsonArray := jsonObjectToReceive.GetValue('orders') as tJsonArray;
      tab := jsonObjectToReceive.GetValue('tab').Value;
      if tab = '"0"' then
        begin
          fWindow.cdsActiveOrders.Close;
          fWindow.cdsActiveOrders.CreateDataSet;
          fWindow.DBGrid1.DataSource := fWindow.dsActiveOrders;
          for i := 0 to pred(jsonArray.Count) do
            begin
              fWindow.cdsActiveOrders.AppendRecord([
                jsonArray.Items[i].FindValue('id').Value,
                jsonArray.Items[i].FindValue('startTime').Value,
                jsonArray.Items[i].FindValue('courierName').Value,
                jsonArray.Items[i].FindValue('courierSurname').Value,
                jsonArray.Items[i].FindValue('clientName').Value,
                jsonArray.Items[i].FindValue('address').Value,
                jsonArray.Items[i].FindValue('reported').Value
              ]);
              if jsonArray.Items[i].FindValue('reported').Value = '"true"' then
                begin
                 fWindow.DBGrid1.Canvas.Brush.Color := clYellow;
                end;
            end;
        end;
      if tab = '"1"' then
        begin
          fWindow.cdsOrderHistory.Close;
          fWindow.cdsOrderHistory.CreateDataSet;
          fWindow.DBGrid1.DataSource := fWindow.dsOrderHistory;
          for i := 0 to pred(jsonArray.Count) do
            begin
              fWindow.cdsOrderHistory.AppendRecord([
                jsonArray.Items[i].FindValue('id').Value,
                jsonArray.Items[i].FindValue('endTime').Value,
                jsonArray.Items[i].FindValue('startTime').Value,
                jsonArray.Items[i].FindValue('courierName').Value,
                jsonArray.Items[i].FindValue('courierSurname').Value,
                jsonArray.Items[i].FindValue('clientName').Value,
                jsonArray.Items[i].FindValue('address').Value,
                jsonArray.Items[i].FindValue('reported').Value
              ]);
            end;
        end;
    end;
  if objectType = '"createWindow"' then
    begin   {
      fWindow := TfWindow.Create(Application);
      fWindow.cdsOrder.Close;
      fWindow.cdsOrder.CreateDataSet;
      jsonArray := jsonObjectToReceive.GetValue('orders') as tJsonArray;
      for i := 0 to pred(jsonArray.Count) do
        begin
          fWindow.cdsOrder.AppendRecord([
            jsonArray.Items[i].FindValue('startTime').Value,
            jsonArray.Items[i].FindValue('courierName').Value,
            jsonArray.Items[i].FindValue('courierSurname').Value,
            jsonArray.Items[i].FindValue('clientName').Value,
            jsonArray.Items[i].FindValue('address').Value
          ]);
        end;
      fWindow.ShowModal;
      fWindow.Release;}
    end;
  if objectType = '"confirmedByCourier"' then
    begin
      fConfirmOrders.cdsUnconfirmed.Close;
      fConfirmOrders.cdsUnconfirmed.CreateDataSet;
      jsonArray := jsonObjectToReceive.GetValue('orders') as tJsonArray;
      for i := 0 to pred(jsonArray.Count) do
        begin
          fConfirmOrders.cdsUnconfirmed.AppendRecord([
            jsonArray.Items[i].FindValue('id').Value,
            jsonArray.Items[i].FindValue('start_time').Value,
            jsonArray.Items[i].FindValue('courier_name').Value,
            jsonArray.Items[i].FindValue('courier_surname').Value,
            jsonArray.Items[i].FindValue('client_name').Value,
            jsonArray.Items[i].FindValue('address').Value
          ]);
        end;
    end;
  if objectType = '"orderList"' then
    begin
      jsonArray := jsonObjectToReceive.GetValue('list') as tJsonArray;
      fWindow.cdsOrderList.Close;
      fWindow.cdsOrderList.CreateDataSet;
      for i := 0 to pred(jsonArray.Count) do
        begin
          fWindow.cdsOrderList.AppendRecord([
            jsonArray.Items[i].FindValue('position_name').Value,
            jsonArray.Items[i].FindValue('price').Value
          ]);
        end;
    end;
end;

procedure TfLogin.IdUDPServer1UDPRead(AThread: TIdUDPListenerThread;
const AData: TIdBytes; ABinding: TIdSocketHandle);
var receivedString: String;
begin
  ReceivedString := BytesToString(AData, en7bit);
  if receivedString = 'updateData' then
    begin
      fWindow.askData();
    end;
end;

function TfLogin.modifyJsonString(jsonObject: TJSONObject; key: String): String;
begin
  result := jsonObject.GetValue(key).ToString;
  result := Copy(result, 2, result.Length - 2);
end;
end.
