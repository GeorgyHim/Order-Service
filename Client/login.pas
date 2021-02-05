unit login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin,
  System.Win.ScktComp, System.JSON, IdBaseComponent, IdComponent, IdUDPBase,
  IdUDPClient, IdUDPServer, IdGlobal, IdSocketHandle, mydm;

type
  TfLogin = class(TForm)
    HostEdit: TEdit;
    PortEdit: TSpinEdit;
    LoginButton: TButton;
    ClientSocket1: TClientSocket;
    portLabel: TLabel;
    HostLabel: TLabel;
    IdUDPServer1: TIdUDPServer;
    LoginLabel: TLabel;
    Label1: TLabel;
    PasswordEdit: TEdit;
    LoginEdit: TEdit;
    LoginDenied: TLabel;
    DBPathLabel: TLabel;
    DataBasePathEdit: TEdit;
    procedure LoginButtonClick(Sender: TObject);
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
  user_id: Int64;
  role: SmallInt;

implementation

{$R *.dfm}

uses operator_window, clientlist, db, client_address_list, courierlist, confirm_order,
  admin_window;

procedure TfLogin.LoginButtonClick(Sender: TObject);
var
  jsonObject: TJsonObject;
  stringToSend: String;

begin
  LoginDenied.Caption := '';
  dm.EditHost(HostEdit.Text, DataBasePathEdit.Text);
  if dm.CheckPassword(LoginEdit.Text, PasswordEdit.Text, user_id, role) then
    begin
      if role = 0 then
      begin
        fAdminWindow := TfAdminWindow.create(APPLICATION);
        fAdminWindow.ShowModal;
      end;

      if role = 1 then
      begin
        fOperatorWindow := TfOperatorWindow.create(APPLICATION);
        fOperatorWindow.ShowModal;
      end;

      if role = 2 then
        LoginDenied.Caption := 'Login denied, not desktop';
    end
    else
      LoginDenied.Caption := 'Login denied';
end;

procedure TfLogin.ClientSocket1Read(Sender: TObject; Socket: TCustomWinSocket);
var
  jsonObjectToSend, jsonObjectToReceive, jsonArrayElement: TJSONObject;
  jsonArray: TJSONArray;
  receivedString, operation, testString, tab: String;
  i : Integer;
  access: boolean;
begin
  receivedString := Socket.ReceiveText;
  jsonObjectToReceive :=
        TJSONObject.ParseJSONValue(receivedString) as TJSONObject;
  if jsonObjectToReceive.TryGetValue('operation', testString) then
    begin
      operation := jsonObjectToReceive.GetValue('operation').ToString;
    end;
  if operation = '"ClientList"' then
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
  if operation = '"clientAddresses"' then
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
  if operation = '"courierList"' then
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
  if operation = '"orders"' then
    begin
      jsonArray := jsonObjectToReceive.GetValue('orders') as tJsonArray;
      tab := jsonObjectToReceive.GetValue('tab').Value;
      if tab = '"0"' then
        begin
          fOperatorWindow.cdsActiveOrders.Close;
          fOperatorWindow.cdsActiveOrders.CreateDataSet;
          fOperatorWindow.DBGrid1.DataSource := fOperatorWindow.dsActiveOrders;
          for i := 0 to pred(jsonArray.Count) do
            begin
              fOperatorWindow.cdsActiveOrders.AppendRecord([
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
                 fOperatorWindow.DBGrid1.Canvas.Brush.Color := clYellow;
                end;
            end;
        end;
      if tab = '"1"' then
        begin
          fOperatorWindow.cdsOrderHistory.Close;
          fOperatorWindow.cdsOrderHistory.CreateDataSet;
          fOperatorWindow.DBGrid1.DataSource := fOperatorWindow.dsOrderHistory;
          for i := 0 to pred(jsonArray.Count) do
            begin
              fOperatorWindow.cdsOrderHistory.AppendRecord([
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
  if operation = '"createWindow"' then
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
  if operation = '"confirmedByCourier"' then
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
  if operation = '"orderList"' then
    begin
      jsonArray := jsonObjectToReceive.GetValue('list') as tJsonArray;
      fOperatorWindow.cdsOrderList.Close;
      fOperatorWindow.cdsOrderList.CreateDataSet;
      for i := 0 to pred(jsonArray.Count) do
        begin
          fOperatorWindow.cdsOrderList.AppendRecord([
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
      fOperatorWindow.askData();
    end;
end;

function TfLogin.modifyJsonString(jsonObject: TJSONObject; key: String): String;
begin
  result := jsonObject.GetValue(key).ToString;
  result := Copy(result, 2, result.Length - 2);
end;
end.
