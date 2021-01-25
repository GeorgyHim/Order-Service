unit server;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin,
  System.Win.ScktComp, System.JSON, REST.JSON, Data.DB, IdBaseComponent,
  IdComponent, IdUDPBase, IdUDPServer, IdUDPClient;

type
  TfServer = class(TForm)
    Label1: TLabel;
    Port: TSpinEdit;
    Button1: TButton;
    Button2: TButton;
    ServerSocket1: TServerSocket;
    IdUDPClient1: TIdUDPClient;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ServerSocket1ClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    function modifyJSONString(jsonObject: TJSONObject; key: String): String;
    procedure sendOperatorWindowList(jsonObjectToReceive: tJsonObject; Socket: TCustomWinSocket);
    procedure updateDb();
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fServer: TfServer;

implementation

uses mydm;

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

procedure TfServer.Button1Click(Sender: TObject);

begin
  ServerSocket1.Port := Port.Value;
  ServerSocket1.Active := true;

end;

procedure TfServer.Button2Click(Sender: TObject);
begin
  ServerSocket1.Active := false;

end;


procedure TfServer.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ServerSocket1.Active := false;

end;


procedure TfServer.ServerSocket1ClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
var
  stringToReceive, stringToSend, objectType, startTime, positionName, positionPrice, testString, str: String;
  jsonObjectToReceive, jsonObjectToSend, jsonArrayElement: TJSONObject;
  jsonArray: TJSONArray;
  i, clientId, currentId, orderId, courierId, a: integer;
  inputByteArray: array [0..4095] of byte;
  outputByteArray: array [0..4095] of byte;
begin
  stringToReceive := '';
  a := Socket.ReceiveBuf(inputByteArray, 4095);
  for i := 0 to 4095 do
    begin
      if Chr(inputByteArray[i]) = '' then
        begin
          break;
        end;
      stringToReceive := stringToReceive + TEncoding.ANSI.GetChars(inputByteArray[i])[0];
    end;
  //stringToReceive := Socket.ReceiveText;
  jsonObjectToReceive := TJSONObject.ParseJSONValue(stringToReceive) as TJSONObject;
  if jsonObjectToReceive.TryGetValue('type', str) then
    begin
  objectType := jsonObjectToReceive.GetValue('type').ToString;
    end;
  if objectType = '"Client"' then
    begin
      dm.addClient(
        modifyJSONString(jsonObjectToReceive, 'name'),
        modifyJSONString(jsonObjectToReceive, 'phone_number')
      );
    end;
  if objectType = '"Courier"' then
    begin
      dm.addCourier(
        modifyJSONString(jsonObjectToReceive, 'name'),
        modifyJSONString(jsonObjectToReceive, 'surname'),
        modifyJSONString(jsonObjectToReceive, 'phone_number'),
        modifyJSONString(jsonObjectToReceive, 'email'),
        modifyJSONString(jsonObjectToReceive, 'transport')
      );
    end;
  if objectType = '"getClients"' then
    begin
      dm.tClient.Open;
      dm.dsClient.DataSet.First;
      jsonArray := TJsonArray.Create;
      jsonObjectToSend := TJSONObject.Create;
      jsonObjectToSend.AddPair('type', 'ClientList');
      while not dm.dsClient.DataSet.Eof do
        begin
          jsonArray.AddElement(TJSONObject.Create);
          jsonArrayElement := jsonArray.Items[pred(jsonArray.Count)] as tJsonObject;
          jsonArrayElement
            .AddPair('id', dm.dsClient.DataSet.FieldByName('id').Value)
            .AddPair('name', dm.dsClient.DataSet.FieldByName('name').Value)
            .AddPair('phone_number', dm.dsClient.DataSet.FieldByName('phone_number').Value);
          dm.dsClient.DataSet.Next;
        end;
      jsonObjectToSend.addPair('clients', jsonArray);
      stringToSend := jsonObjectToSend.ToString;
      Socket.SendText(stringToSend);
    end;
  if objectType = '"address"' then
    begin
      dm.AddAddress(
        StrToInt(modifyJSONString(jsonObjectToReceive, 'clientId')),
        modifyJSONString(jsonObjectToReceive, 'address')
      );
    end;
  if objectType = '"getClientAddress"' then
    begin
      jsonArray := TJsonArray.Create;
      jsonObjectToSend := TJsonObject.Create;
      jsonObjectToSend.AddPair('type', 'clientAddresses');
      clientId := modifyJsonString(jsonObjectToReceive, 'clientId').ToInteger;
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
      jsonObjectToSend.AddPair('addresses', jsonArray);
      stringToSend := jsonObjectToSend.ToString;
      Socket.SendText(stringToSend);
    end;
  if objectType = '"getCouriers"' then
    begin
      jsonArray := tJsonArray.Create;
      jsonObjectToSend := tJsonObject.Create;
      jsonObjectToSend.AddPair('type', 'courierList');
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
      jsonObjectToSend.AddPair('couriers', jsonArray);
      stringToSend := jsonObjectToSend.ToString;
      Socket.SendText(stringToSend);
    end;
  if objectType = '"order"' then
    begin
      startTime :=  modifyJsonString(jsonObjectToReceive, 'startTime');
      orderId := dm.addOrder(
        modifyJsonString(jsonObjectToReceive, 'courierId').ToInteger(),
        modifyJsonString(jsonObjectToReceive, 'addressId').ToInteger(),
        startTime
      );
      jsonArray := jsonObjectToReceive.GetValue('positions') as tJsonArray;
      for i := 0 to pred(jsonArray.Count) do
        begin
          dm.addOrderList(
            orderId,
            modifyJsonString(jsonArray.Items[i] as tJsonObject, 'name'),
            modifyJsonString(jsonArray.Items[i] as tJsonObject, 'price').ToDouble()
          );
        end;
      updateDb();
    end;
  if objectType = '"operatorWindow"' then
    begin
      sendOperatorWindowList(jsonObjectToReceive, Socket);
    end;
    if (objectType = '"notif"') or (objectType = '"login"') then
      begin
        courierId := modifyJsonString(jsonObjectToReceive, 'login').ToInteger();
        if dm.hasNewOrder(courierId) = 'FALSE' then
          begin
            jsonObjectToSend := tJsonObject.Create;
            jsonObjectToSend.AddPair('result', 'false');
          end
        else
          begin
            jsonObjectToSend := tJsonObject.Create;
            jsonObjectToSend.AddPair('result', 'true');
          end;
        stringToSend := jsonObjectToSend.ToString;
        {
        Socket.SendText(stringToSend);
        }
        //outputByteArray := TEncoding.UTF8.GetBytes(jsonObjectToSend.ToString);
        for i := 0 to stringToSend.Length do
          begin
            outputByteArray[i] := byte(stringToSend[i + 1]);
          end;
        Socket.SendBuf(outputbyteArray, jsonObjectToSend.ToString.Length);
      end;
    if objectType = '"courierOrders"' then
      begin
        courierId := modifyJsonString(jsonObjectToReceive, 'login').ToInteger();
        jsonArray := tJsonArray.Create;
        jsonObjectToSend := tJsonObject.Create;
        jsonObjectToSend.AddPair('type', 'courierOrders');
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
        jsonObjectToSend.AddPair('result', jsonArray);
        stringToSend := jsonObjectToSend.ToString;
        for i := 0 to stringToSend.Length do
          begin
             outputByteArray[2*i] := TEncoding.UTF8.GetBytes(stringToSend[i + 1])[0];
            outputByteArray[2*i+1] := TEncoding.UTF8.GetBytes(stringToSend[i + 1])[1];
          end;
        Socket.SendBuf(outputbyteArray, jsonObjectToSend.ToString.Length*2);
      end;
      //Начало добавления
    if objectType = '"courierOrder"' then
      begin
        orderId := modifyJsonString(jsonObjectToReceive, 'id').ToInteger();
        jsonObjectToSend := tJsonObject.Create;
        jsonObjectToSend.AddPair('type', 'courierOrder');
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
        jsonObjectToSend.AddPair('result', jsonArrayElement);
        stringToSend := jsonObjectToSend.ToString;
        for i := 0 to stringToSend.Length do
          begin
            outputByteArray[2*i] := TEncoding.UTF8.GetBytes(stringToSend[i + 1])[0];
            outputByteArray[2*i+1] := TEncoding.UTF8.GetBytes(stringToSend[i + 1])[1];
          end;
        Socket.SendBuf(outputbyteArray, jsonObjectToSend.ToString.Length*2);
      end;
      if objectType = '"orderReport"' then
       begin
         jsonObjectToSend := tJsonObject.Create;
         jsonObjectToSend.AddPair('result', dm.SetReport(
            StrToInt(modifyJSONString(jsonObjectToReceive, 'id'))
          ));
         jsonObjectToSend.AddPair('type', 'orderCourier');

         jsonObjectToSend.AddPair('orders', jsonArrayElement);
         stringToSend := jsonObjectToSend.ToString;
         for i := 0 to stringToSend.Length do
          begin
            outputByteArray[2*i] := TEncoding.UTF8.GetBytes(stringToSend[i + 1])[0];
            outputByteArray[2*i+1] := TEncoding.UTF8.GetBytes(stringToSend[i + 1])[1];
          end;
          UpdateDB;
        Socket.SendBuf(outputbyteArray, jsonObjectToSend.ToString.Length*2);
       end;
     //Конец добавления
    if objectType = '"confirmQuery"' then
       begin
         jsonArray := tJsonArray.Create;
         jsonObjectToSend := tJsonObject.Create;
         jsonObjectToSend.AddPair('type', 'confirmedByCourier');
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
         jsonObjectToSend.AddPair('orders', jsonArray);
         stringToSend := jsonObjectToSend.ToString;
         Socket.SendText(stringToSend);
       end;

    if objectType = '"confirmation"' then
      begin
        jsonArray := jsonObjectToReceive.GetValue('confirmations') as tJsonArray;
        for i := 0 to pred(jsonArray.Count) do
          begin
            dm.confirmOrder(
              StrToInt(jsonArray.Items[i].FindValue('id').Value),
              jsonArray.Items[i].FindValue('finishTime').Value
            );
          end;
        sendOperatorWindowList(jsonObjectToReceive, Socket);
      end;
    if objectType = '"orderList"' then
      begin
        dm.qOrderList.Close;
        orderId := modifyJsonString(jsonObjectToReceive, 'id').ToInteger;;
        dm.qOrderList.ParamByName('in_order_id').Value := orderId;
        testString := dm.qOrderList.Text;
        dm.qOrderList.Open;
        dm.dsOrderList.DataSet := dm.qOrderList;
        jsonArray := tJsonarray.Create;
        jsonObjectToSend := tJsonObject.Create;
        jsonObjectToSend.AddPair('type', 'orderList');
        while not dm.dsOrderList.DataSet.Eof do
          begin
            jsonArray.AddElement(tJsonObject.Create);
            jsonArrayElement := jsonArray.Items[pred(jsonArray.Count)] as tJsonObject;
            jsonArrayElement
              .AddPair('position_name', dm.dsOrderList.DataSet.FieldByName('position_name').Value)
              .AddPair('price', FloatToStr(dm.dsOrderList.DataSet.FieldByName('price').Value));
            dm.dsOrderList.DataSet.Next;
          end;
        jsonObjectToSend.AddPair('list', jsonArray);
        stringToSend := jsonObjectToSend.ToString;
        Socket.SendText(stringToSend);
      end;
end;

function TfServer.modifyJsonString(jsonObject: TJSONObject; key: String): String;
begin
  result := jsonObject.GetValue(key).ToString;
  result := Copy(result, 2, result.Length - 2);
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
  if jsonObjectToReceive.GetValue('tab').ToString = '"0"' then
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
  if jsonObjectToReceive.GetValue('tab').ToString = '"1"' then
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
