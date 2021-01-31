unit server;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin,
  System.Win.ScktComp, System.JSON, REST.JSON, Data.DB, IdBaseComponent,
  IdComponent, IdUDPBase, IdUDPServer, IdUDPClient, mydm, utils, requestProcessor;

type
  TfServer = class(TForm)
    PortEdit: TSpinEdit;
    StartButton: TButton;
    StopButton: TButton;
    ServerSocket1: TServerSocket;
    IdUDPClient1: TIdUDPClient;
    HostNameEdit: TEdit;
    DataBasePathEdit: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Button1: TButton;
    procedure StartButtonClick(Sender: TObject);
    procedure StopButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ServerSocket1ClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure sendOperatorWindowList(jsonObjectToReceive: tJsonObject; Socket: TCustomWinSocket);
    procedure updateDb();
    procedure processClientRequest(Sender: TObject; Socket: TCustomWinSocket;
                                operation: String; receivedJson:TJSONObject);
    procedure processMobileRequest(Sender: TObject; Socket: TCustomWinSocket;
                                operation: String; receivedJson:TJSONObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fServer: TfServer;

implementation

{$R *.dfm}

procedure TfServer.updateDb;
begin
  IdUDPClient1.Host := 'localhost';
  IdUDPClient1.Port := 4011;
  IdUDPClient1.Connect;
  if IdUDPClient1.Connected = true then
    begin
      IDUdpClient1.Send('updateData');
    end;
end;

procedure TfServer.StartButtonClick(Sender: TObject);

begin

  dm.EditHost(HostNameEdit.Text, DataBasePathEdit.Text);
  ServerSocket1.Port := PortEdit.Value;
  ServerSocket1.Active := true;

end;

procedure TfServer.StopButtonClick(Sender: TObject);
begin
  ServerSocket1.Active := false;

end;


procedure TfServer.Button1Click(Sender: TObject);
begin
  dm.CreateOperator('Операторов', 'Опер', '','userok', 'someword');
end;

procedure TfServer.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ServerSocket1.Active := false;

end;


procedure TfServer.ServerSocket1ClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
var
  inputByteArray: array [0..4095] of byte;
  receivedString, operation: String;
  receivedJson: TJSONObject;
  a: integer;
begin
  receivedString := '';
  a := Socket.ReceiveBuf(inputByteArray, 4095);
  receivedString := getSocketString(inputByteArray);
  receivedJson := TJSONObject.ParseJSONValue(receivedString) as TJSONObject;
  operation := getJsonStringAttribute(receivedJson, 'operation');

  if operation.StartsWith('client') then
  begin
    processClientRequest(Sender, Socket, operation, receivedJson);
  end;

  if operation.StartsWith('mobile') then
  begin
    processMobileRequest(Sender, Socket, operation, receivedJson);
  end;

end;


procedure TfServer.processClientRequest(Sender: TObject; Socket: TCustomWinSocket;
                                operation: String; receivedJson: TJSONObject);
var
  jsonToSend, jsonArrayElement: TJSONObject;
  jsonArray: TJSONArray;
  stringToSend, startTime, testString, str: String;
  clientId, i, orderId: Integer;
begin
  if operation = 'client_login' then
    login(receivedJson, Socket);

  if operation = 'client_create_admin_user' then
    create_admin_user(receivedJson);

  if operation = 'client_create_operator' then
    create_operator(receivedJson);

  //-----------------------



  if operation = 'Client' then
    begin
      dm.addClient(
        getJsonStringAttribute(receivedJson, 'name'),
        getJsonStringAttribute(receivedJson, 'phone_number')
      );
    end;
  if operation = 'Courier' then
    begin
      dm.addCourier(
        getJsonStringAttribute(receivedJson, 'name'),
        getJsonStringAttribute(receivedJson, 'surname'),
        getJsonStringAttribute(receivedJson, 'phone_number'),
        getJsonStringAttribute(receivedJson, 'email'),
        getJsonStringAttribute(receivedJson, 'transport')
      );
    end;
  if operation = 'getClients' then
    begin
      dm.tClient.Open;
      dm.dsClient.DataSet.First;
      jsonArray := TJsonArray.Create;
      jsonToSend := TJSONObject.Create;
      jsonToSend.AddPair('type', 'ClientList');
      while not dm.dsClient.DataSet.Eof do
        begin
          jsonArray.AddElement(TJSONObject.Create);
          jsonArrayElement := jsonArray.Items[pred(jsonArray.Count)] as TJsonObject;
          jsonArrayElement
            .AddPair('id', dm.dsClient.DataSet.FieldByName('id').Value)
            .AddPair('name', dm.dsClient.DataSet.FieldByName('name').Value)
            .AddPair('phone_number', dm.dsClient.DataSet.FieldByName('phone_number').Value);
          dm.dsClient.DataSet.Next;
        end;
      jsonToSend.addPair('clients', jsonArray);
      stringToSend := jsonToSend.ToString;
      Socket.SendText(stringToSend);
    end;

  if operation = 'address' then
    begin
      dm.AddAddress(
        StrToInt(getJsonStringAttribute(receivedJson, 'clientId')),
        getJsonStringAttribute(receivedJson, 'address')
      );
    end;
  if operation = 'getClientAddress' then
    begin
      jsonArray := TJsonArray.Create;
      jsonToSend := TJsonObject.Create;
      jsonToSend.AddPair('type', 'clientAddresses');
      clientId := getJsonStringAttribute(receivedJson, 'clientId').ToInteger;
      dm.qAddresses.Close;
      dm.qAddresses.ParamByName('in_client_id').Value := clientId;
      dm.qAddresses.Open;
      dm.dsAddress.DataSet := dm.qAddresses;
      while not dm.dsAddress.DataSet.Eof do
        begin
          jsonArray.AddElement(TJsonObject.Create);
          jsonArrayElement := jsonArray.Items[pred(jsonArray.Count)] as tJsonObject;
          jsonArrayElement
                .addPair('id', dm.dsAddress.DataSet.FieldByName('id').Value)
                .addPair('clientId', dm.dsAddress.DataSet.FieldByName('client_id').Value)
                .addPair('address', dm.dsAddress.DataSet.FieldByName('address').Value);
          dm.dsAddress.DataSet.Next;
        end;
      jsonToSend.AddPair('addresses', jsonArray);
      stringToSend := jsonToSend.ToString;
      Socket.SendText(stringToSend);
    end;

  if operation = 'getCouriers' then
    begin
      jsonArray := tJsonArray.Create;
      jsonToSend := tJsonObject.Create;
      jsonToSend.AddPair('type', 'courierList');
      dm.qCourier.Close;
      dm.qCourier.Open;
      dm.dsCourier.DataSet := dm.qCourier;
      while not dm.dsCourier.DataSet.Eof do
        begin
          jsonArray.AddElement(TJsonObject.Create);
          jsonArrayElement := jsonArray.Items[pred(jsonArray.Count)] as tJsonObject;
          jsonArrayElement
            .addPair('id', dm.dsCourier.DataSet.FieldByName('id').Value)
            .addPair('name', dm.dsCourier.DataSet.FieldByName('name').Value)
            .addPair('surname', dm.dsCourier.DataSet.FieldByName('surname').Value)
            .addPair('phone_number', dm.dsCourier.DataSet.FieldByName('phone_number').Value)
            .addPair('email', dm.dsCourier.DataSet.FieldByName('email').Value)
            .addPair('transport_type', dm.dsCourier.DataSet.FieldByName('transport_type').Value);
          dm.dsCourier.DataSet.Next;
        end;
      jsonToSend.AddPair('couriers', jsonArray);
      stringToSend := jsonToSend.ToString;
      Socket.SendText(stringToSend);
    end;

  if operation = 'order' then
    begin
      startTime :=  getJsonStringAttribute(receivedJson, 'startTime');
      orderId := dm.addOrder(
        getJsonStringAttribute(receivedJson, 'courierId').ToInteger(),
        getJsonStringAttribute(receivedJson, 'addressId').ToInteger(),
        startTime
      );
      jsonArray := receivedJson.GetValue('positions') as tJsonArray;
      for i := 0 to pred(jsonArray.Count) do
        begin
          dm.addOrderList(
            orderId,
            getJsonStringAttribute(jsonArray.Items[i] as tJsonObject, 'name'),
            getJsonStringAttribute(jsonArray.Items[i] as tJsonObject, 'price').ToDouble()
          );
        end;
      updateDb();
    end;

  if operation = 'operatorWindow' then
    begin
      sendOperatorWindowList(receivedJson, Socket);
    end;

  if operation = 'confirmQuery' then
     begin
       jsonArray := tJsonArray.Create;
       jsonToSend := tJsonObject.Create;
       jsonToSend.AddPair('type', 'confirmedByCourier');
       dm.qConfirmedOrders.Close;
       dm.qConfirmedOrders.Open;
       testString := dm.qConfirmedOrders.Text;
       dm.dsConfirmedOrders.DataSet := dm.qConfirmedOrders;
       while not dm.dsConfirmedOrders.DataSet.Eof do
        begin
          jsonArray.AddElement(tJsonObject.Create);
          jsonArrayElement := jsonArray.Items[pred(jsonArray.Count)] as tJsonObject;
          jsonArrayElement
            .addPair('id', dm.dsConfirmedOrders.DataSet.FieldByName('id').Value)
            .addPair('start_time', DateTimeToStr(dm.dsConfirmedOrders.DataSet.FieldByName('start_time').Value))
            .addPair('courier_name', dm.dsConfirmedOrders.DataSet.FieldByName('name').Value)
            .addPair('courier_surname', dm.dsConfirmedOrders.DataSet.FieldByName('surname').Value)
            .addPair('client_name', dm.dsConfirmedOrders.DataSet.FieldByName('name1').Value)
            .addPair('address', dm.dsConfirmedOrders.DataSet.FieldByName('address').Value);
          dm.dsConfirmedOrders.DataSet.Next;
        end;
       jsonToSend.AddPair('orders', jsonArray);
       stringToSend := jsonToSend.ToString;
       Socket.SendText(stringToSend);
     end;

  if operation = 'confirmation' then
    begin
      jsonArray := receivedJson.GetValue('confirmations') as tJsonArray;
      for i := 0 to pred(jsonArray.Count) do
        begin
          dm.confirmOrder(
            StrToInt(jsonArray.Items[i].FindValue('id').Value),
            jsonArray.Items[i].FindValue('finishTime').Value
          );
        end;
      sendOperatorWindowList(receivedJson, Socket);
    end;

  if operation = 'orderList' then
    begin
      dm.qOrderList.Close;
      orderId := getJsonStringAttribute(receivedJson, 'id').ToInteger;;
      dm.qOrderList.ParamByName('in_order_id').Value := orderId;
      testString := dm.qOrderList.Text;
      dm.qOrderList.Open;
      dm.dsOrderList.DataSet := dm.qOrderList;
      jsonArray := tJsonarray.Create;
      jsonToSend := tJsonObject.Create;
      jsonToSend.AddPair('type', 'orderList');
      while not dm.dsOrderList.DataSet.Eof do
        begin
          jsonArray.AddElement(tJsonObject.Create);
          jsonArrayElement := jsonArray.Items[pred(jsonArray.Count)] as tJsonObject;
          jsonArrayElement
            .AddPair('position_name', dm.dsOrderList.DataSet.FieldByName('position_name').Value)
            .AddPair('price', FloatToStr(dm.dsOrderList.DataSet.FieldByName('price').Value));
          dm.dsOrderList.DataSet.Next;
        end;
      jsonToSend.AddPair('list', jsonArray);
      stringToSend := jsonToSend.ToString;
      Socket.SendText(stringToSend);
    end;
end;
//---------------------------------------------


procedure TfServer.processMobileRequest(Sender: TObject; Socket: TCustomWinSocket;
                                operation: String; receivedJson:TJSONObject);
var
  jsonToSend, jsonArrayElement: TJSONObject;
  jsonArray: TJSONArray;
  stringToSend, testString: String;
  i, orderId, courierId: Integer;
  outputByteArray: array [0..4095] of byte;
begin
//    TODO
  if (operation = 'notif') or (operation = 'login') then
    begin
      courierId := getJsonStringAttribute(receivedJson, 'login').ToInteger();
      if dm.hasNewOrder(courierId) = 'FALSE' then
        begin
          jsonToSend := tJsonObject.Create;
          jsonToSend.AddPair('result', 'false');
        end
      else
        begin
          jsonToSend := tJsonObject.Create;
          jsonToSend.AddPair('result', 'true');
        end;
      stringToSend := jsonToSend.ToString;
      {
      Socket.SendText(stringToSend);
      }
      //outputByteArray := TEncoding.UTF8.GetBytes(jsonObjectToSend.ToString);
      for i := 0 to stringToSend.Length do
        begin
          outputByteArray[i] := byte(stringToSend[i + 1]);
        end;
      Socket.SendBuf(outputbyteArray, jsonToSend.ToString.Length);
    end;
  if operation = 'courierOrders' then
    begin
      courierId := getJsonStringAttribute(receivedJson, 'login').ToInteger();
      jsonArray := tJsonArray.Create;
      jsonToSend := tJsonObject.Create;
      jsonToSend.AddPair('type', 'courierOrders');
      dm.qCourierOrders.Close;
      dm.qCourierOrders.ParamByName('in_id').Value := courierId;
      dm.qCourierOrders.Open;
      testString := dm.qCourierOrders.Text;
      dm.dsCourierOrders.DataSet := dm.qCourierOrders;
      while not dm.dsCourierOrders.DataSet.Eof do
      begin
        jsonArray.AddElement(tJsonObject.Create);
        jsonArrayElement := jsonArray.Items[pred(jsonArray.Count)] as tJsonObject;
        jsonArrayElement
          .addPair('id', dm.dsCourierOrders.DataSet.FieldByName('id').Value)
          .addPair('address', dm.dsCourierOrders.DataSet.FieldByName('address').Value)
          .addPair('start_time', DateTimeToStr(dm.dsCourierOrders.DataSet.FieldByName('start_time').Value));
        dm.dsCourierOrders.DataSet.Next;
      end;
      jsonToSend.AddPair('result', jsonArray);
      stringToSend := jsonToSend.ToString;
      for i := 0 to stringToSend.Length do
        begin
           outputByteArray[2*i] := TEncoding.UTF8.GetBytes(stringToSend[i + 1])[0];
          outputByteArray[2*i+1] := TEncoding.UTF8.GetBytes(stringToSend[i + 1])[1];
        end;
      Socket.SendBuf(outputbyteArray, jsonToSend.ToString.Length*2);
    end;
    //Начало добавления
  if operation = 'courierOrder' then
    begin
      orderId := getJsonStringAttribute(receivedJson, 'id').ToInteger();
      jsonToSend := tJsonObject.Create;
      jsonToSend.AddPair('type', 'courierOrder');
      dm.qCourierOrder.Close;
      dm.qCourierOrder.ParamByName('in_order_id').Value := orderId;
      dm.qCourierOrder.Open;
      testString := '';
      dm.dsCourierOrder.DataSet := dm.qCourierOrder;
      dm.qCourierOrder_List.Close;
      dm.qCourierOrder_List.ParamByName('in_order_id').Value := dm.dsCourierOrder.DataSet.FieldByName('ID').Value;
      dm.qCourierOrder_List.Open;
      dm.dsCourierOrder_List.DataSet := dm.qCourierOrder_List;
      while not dm.dsCourierOrder_List.DataSet.Eof do
      begin
        testString := testString + dm.dsCourierOrder_List.DataSet.FieldByName('POSITION_NAME').Text
        + ' ' + dm.dsCourierOrder_List.DataSet.FieldByName('PRICE').Text  + #13#10;
        dm.dsCourierOrder_List.DataSet.Next;
      end;
        jsonArrayElement := tJsonObject.Create;
        jsonArrayElement
          .addPair('id', dm.dsCourierOrder.DataSet.FieldByName('ID').Value)
          .addPair('address', dm.dsCourierOrder.DataSet.FieldByName('ADDRESS').Value)
          .addPair('start_time', DateTimeToStr(dm.dsCourierOrder.DataSet.FieldByName('START_TIME').Value))
          .addPair('name', dm.dsCourierOrder.DataSet.FieldByName('NAME').Value)
          .addPair('phone', dm.dsCourierOrder.DataSet.FieldByName('PHONE_NUMBER').Value)
          .addPair('is_reported', dm.dsCourierOrder.DataSet.FieldByName('IS_REPORTED').Value)
          .addPair('content', testString);
      jsonToSend.AddPair('result', jsonArrayElement);
      stringToSend := jsonToSend.ToString;
      for i := 0 to stringToSend.Length do
        begin
          outputByteArray[2*i] := TEncoding.UTF8.GetBytes(stringToSend[i + 1])[0];
          outputByteArray[2*i+1] := TEncoding.UTF8.GetBytes(stringToSend[i + 1])[1];
        end;
      Socket.SendBuf(outputbyteArray, jsonToSend.ToString.Length*2);
    end;
    if operation = 'orderReport' then
     begin
       jsonToSend := tJsonObject.Create;
       jsonToSend.AddPair('result', dm.SetReport(
          StrToInt(getJsonStringAttribute(receivedJson, 'id'))
        ));
       jsonToSend.AddPair('type', 'orderCourier');

       jsonToSend.AddPair('orders', jsonArrayElement);
       stringToSend := jsonToSend.ToString;
       for i := 0 to stringToSend.Length do
        begin
          outputByteArray[2*i] := TEncoding.UTF8.GetBytes(stringToSend[i + 1])[0];
          outputByteArray[2*i+1] := TEncoding.UTF8.GetBytes(stringToSend[i + 1])[1];
        end;
        UpdateDB;
      Socket.SendBuf(outputbyteArray, jsonToSend.ToString.Length*2);
     end;
   //Конец добавления
end;

procedure TfServer.sendOperatorWindowList(jsonObjectToReceive: tJsonObject; Socket: TCustomWinSocket);
var
  jsonArray: tJsonArray;
  jsonObjectToSend, jsonArrayElement: tJsonObject;
  stringToSend: String;
begin
  jsonArray := tJsonArray.Create;
  jsonObjectToSend := tJsonObject.Create;
  jsonObjectToSend.AddPair('type', 'orders');
  jsonObjectToSend.AddPair('tab', jsonObjectToReceive.GetValue('tab').ToString);
  if jsonObjectToReceive.GetValue('tab').ToString = '0' then
    begin
      dm.qActiveOrder.Close;
      dm.qActiveOrder.Open;
      dm.dsActiveOrder.DataSet := dm.qActiveOrder;
      while not dm.dsActiveOrder.DataSet.Eof do
        begin
          jsonArray.AddElement(tJsonObject.Create);
          jsonArrayElement := jsonArray.Items[pred(jsonArray.Count)] as tJsonObject;
          jsonArrayElement
            .addPair('id', IntToStr(dm.dsActiveOrder.DataSet.FieldByName('id').Value))
            .addPair('startTime', dm.dsActiveOrder.DataSet.FieldByName('start_time').Value)
            .addPair('courierName', dm.dsActiveOrder.DataSet.FieldByName('name').Value)
            .addPair('courierSurname', dm.dsActiveOrder.DataSet.FieldByName('surname').Value)
            .addPair('clientName', dm.dsActiveOrder.DataSet.FieldByName('name1').Value)
            .addPair('address', dm.dsActiveOrder.DataSet.FieldByName('address').Value)
            .addPair('reported', dm.dsActiveOrder.DataSet.FieldByName('is_reported').Value);
          dm.dsActiveOrder.DataSet.Next;
        end;
      jsonObjectToSend.AddPair('orders', jsonArray);
      stringToSend := jsonObjectToSend.ToString;
      Socket.SendText(stringToSend);
    end;
  if jsonObjectToReceive.GetValue('tab').ToString = '1' then
    begin
      dm.qFinishedOrder.Close;
      dm.qFinishedOrder.Open;
      dm.dsFinishedOrder.DataSet := dm.qFinishedOrder;
      while not dm.dsFinishedOrder.DataSet.Eof do
        begin
          jsonArray.AddElement(tJsonObject.Create);
          jsonArrayElement := jsonArray.Items[pred(jsonArray.Count)] as tJsonObject;
          jsonArrayElement
            .addPair('id', IntToStr(dm.dsActiveOrder.DataSet.FieldByName('id').Value))
            .addPair('endTime', dm.dsFinishedOrder.DataSet.FieldByName('end_time').Value)
            .addPair('startTime', dm.dsFinishedOrder.DataSet.FieldByName('start_time').Value)
            .addPair('courierName', dm.dsFinishedOrder.DataSet.FieldByName('name').Value)
            .addPair('courierSurname', dm.dsFinishedOrder.DataSet.FieldByName('surname').Value)
            .addPair('clientName', dm.dsFinishedOrder.DataSet.FieldByName('name1').Value)
            .addPair('address', dm.dsFinishedOrder.DataSet.FieldByName('address').Value)
            .addPair('reported', 'false');
          dm.dsFinishedOrder.DataSet.Next;
        end;
      jsonObjectToSend.AddPair('orders', jsonArray);
      stringToSend := jsonObjectToSend.ToString;
      Socket.SendText(stringToSend);
    end;
end;

end.
