unit server;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin,
  System.Win.ScktComp, System.JSON, REST.JSON, Data.DB, IdBaseComponent,
  IdComponent, IdUDPBase, IdUDPServer, IdUDPClient, mydm, utils,
  System.Generics.Collections;

type
  TfServer = class(TForm)
    PortEdit: TSpinEdit;
    StartButton: TButton;
    StopButton: TButton;
    ListenerSocket: TServerSocket;
    IdUDPClient1: TIdUDPClient;
    HostNameEdit: TEdit;
    DataBasePathEdit: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    StatusLabel: TLabel;
    procedure StartButtonClick(Sender: TObject);
    procedure StopButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SocketClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure updateDb();
    procedure processClientRequest(Sender: TObject; Socket: TCustomWinSocket;
                                operation: String; receivedJson:TJSONObject);
    procedure processMobileRequest(Sender: TObject; Socket: TCustomWinSocket;
                                operation: String; receivedJson:TJSONObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    MobileSockets: TObjectList<TServerSocket>;
  end;

var
  fServer: TfServer;

implementation

{$R *.dfm}

procedure TfServer.updateDb;
// TODO: Разобраться что с этим делать
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
  ListenerSocket.Port := PortEdit.Value;
  ListenerSocket.Active := true;
  StatusLabel.Caption := 'WORKING';
  StatusLabel.Visible := True;
end;

procedure TfServer.StopButtonClick(Sender: TObject);
begin
  ListenerSocket.Active := false;
  StatusLabel.Caption := 'STOPPED';
end;


procedure TfServer.FormClose(Sender: TObject; var Action: TCloseAction);
var i: Integer;
begin
  ListenerSocket.Active := false;
  MobileSockets.Free;
end;


procedure TfServer.FormCreate(Sender: TObject);
begin
  MobileSockets := TObjectList<TServerSocket>.Create;
end;

procedure TfServer.SocketClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
var
  inputByteArray: array [0..4095] of byte;
  receivedString, operation: String;
  receivedJson, jsonToSend: TJSONObject;
  a: integer;
  new_socket: TServerSocket;
begin
  receivedString := Socket.ReceiveText;
  receivedJson := TJSONObject.ParseJSONValue(receivedString) as TJSONObject;
  operation := getJsonStringAttribute(receivedJson, 'operation');

  if operation = 'mobile_connect' then
  begin
    new_socket := createSocketForMobile();
    new_socket.OnClientRead := SocketClientRead;
    new_socket.Active := True;
    MobileSockets.Add(new_socket);
    jsonToSend := tJsonObject.Create;
    jsonToSend.AddPair('result', 'true');
    jsonToSend.AddPair('port', new_socket.Port.ToString);
    Socket.SendText(jsonToSend.ToString);
  end
  else
    processMobileRequest(Sender, Socket, operation, receivedJson);
end;


procedure TfServer.processClientRequest(Sender: TObject; Socket: TCustomWinSocket;
                                operation: String; receivedJson: TJSONObject);
var
  jsonToSend, jsonArrayElement: TJSONObject;
  jsonArray: TJSONArray;
  stringToSend, startTime, testString, str: String;
  clientId, i, orderId: Integer;
begin
  // TODO: Переписать всю работу с клиентом
  // Там наверно будет только запрос на назначение заказа ресторану

  if operation = 'send_order' then
    begin
      // TODO
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
  if operation = 'mobile_login' then
  begin
    jsonToSend := tJsonObject.Create;
    if dm.CheckPassword(
      getJsonStringAttribute(receivedJson, 'login'),
      getJsonStringAttribute(receivedJson, 'password')
    ) then
      jsonToSend.AddPair('result', 'true')
    else
      jsonToSend.AddPair('result', 'false');
    Socket.SendText(jsonToSend.ToString);
  end;
  





//    TODO: Убрать это всё
  if operation = 'courierOrders' then
    begin
      courierId := getJsonStringAttribute(receivedJson, 'login').ToInteger();
      jsonArray := tJsonArray.Create;
      jsonToSend := tJsonObject.Create;
      jsonToSend.AddPair('type', 'courierOrders');
//      dm.qCourierOrders.Close;
//      dm.qCourierOrders.ParamByName('in_id').Value := courierId;
//      dm.qCourierOrders.Open;
//      testString := dm.qCourierOrders.Text;
//      dm.dsCourierOrders.DataSet := dm.qCourierOrders;
//      while not dm.dsCourierOrders.DataSet.Eof do
//      begin
//        jsonArray.AddElement(tJsonObject.Create);
//        jsonArrayElement := jsonArray.Items[pred(jsonArray.Count)] as tJsonObject;
//        jsonArrayElement
//          .addPair('id', dm.dsCourierOrders.DataSet.FieldByName('id').Value)
//          .addPair('address', dm.dsCourierOrders.DataSet.FieldByName('address').Value)
//          .addPair('start_time', DateTimeToStr(dm.dsCourierOrders.DataSet.FieldByName('start_time').Value));
//        dm.dsCourierOrders.DataSet.Next;
//      end;
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
//      dm.qCourierOrder.Close;
//      dm.qCourierOrder.ParamByName('in_order_id').Value := orderId;
//      dm.qCourierOrder.Open;
//      testString := '';
//      dm.dsCourierOrder.DataSet := dm.qCourierOrder;
//      dm.qCourierOrder_List.Close;
//      dm.qCourierOrder_List.ParamByName('in_order_id').Value := dm.dsCourierOrder.DataSet.FieldByName('ID').Value;
//      dm.qCourierOrder_List.Open;
//      dm.dsCourierOrder_List.DataSet := dm.qCourierOrder_List;
//      while not dm.dsCourierOrder_List.DataSet.Eof do
//      begin
//        testString := testString + dm.dsCourierOrder_List.DataSet.FieldByName('POSITION_NAME').Text
//        + ' ' + dm.dsCourierOrder_List.DataSet.FieldByName('PRICE').Text  + #13#10;
//        dm.dsCourierOrder_List.DataSet.Next;
//      end;
//        jsonArrayElement := tJsonObject.Create;
//        jsonArrayElement
//          .addPair('id', dm.dsCourierOrder.DataSet.FieldByName('ID').Value)
//          .addPair('address', dm.dsCourierOrder.DataSet.FieldByName('ADDRESS').Value)
//          .addPair('start_time', DateTimeToStr(dm.dsCourierOrder.DataSet.FieldByName('START_TIME').Value))
//          .addPair('name', dm.dsCourierOrder.DataSet.FieldByName('NAME').Value)
//          .addPair('phone', dm.dsCourierOrder.DataSet.FieldByName('PHONE_NUMBER').Value)
//          .addPair('is_reported', dm.dsCourierOrder.DataSet.FieldByName('IS_REPORTED').Value)
//          .addPair('content', testString);
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

end.
