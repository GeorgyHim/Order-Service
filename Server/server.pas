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
  MobileSockets.Clear;
  StatusLabel.Caption := 'STOPPED';
end;


procedure TfServer.FormClose(Sender: TObject; var Action: TCloseAction);
var i: Integer;
begin
  ListenerSocket.Active := false;
  MobileSockets.Clear;
end;


procedure TfServer.FormCreate(Sender: TObject);
begin
  MobileSockets := TObjectList<TServerSocket>.Create;
end;

procedure TfServer.SocketClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
var
  receivedString, operation: String;
  receivedJson, jsonToSend: TJSONObject;
  new_socket: TServerSocket;
  port: Integer;
begin
  dm.updateDb();
  receivedString := Socket.ReceiveText;
  receivedJson := TJSONObject.ParseJSONValue(receivedString) as TJSONObject;
  operation := getJsonStringAttribute(receivedJson, 'operation');

  if operation = 'mobile_connect' then
  begin
    port := getFreePort();
    new_socket := TServerSocket.Create(Application);
    new_socket.Active := False;
    new_socket.Port := port;
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


procedure TfServer.processMobileRequest(Sender: TObject; Socket: TCustomWinSocket;
                                operation: String; receivedJson:TJSONObject);
var
  jsonToSend, jsonObj: TJSONObject;
  jsonArray: TJSONArray;
  stringToSend, help_string: String;
  i: Integer;
begin
  help_string := receivedJson.ToString;

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
    Exit;
  end;
  
  if operation = 'mobile_get_orders' then
  begin
    // TODO
    jsonArray := tJsonArray.Create;
    jsonToSend := tJsonObject.Create;
    dm.qGetRestaurantOrders.Close;
    dm.qGetRestaurantOrders.ParamByName('LOGIN').Value :=
                            getJsonStringAttribute(receivedJson, 'login');
    dm.qGetRestaurantOrders.Open;
    while not dm.qGetRestaurantOrders.Eof do
    begin
      jsonObj := tJsonObject.Create;
      jsonObj.addPair('id', dm.qGetRestaurantOrders.FieldByName('ID').Value);
      jsonObj.addPair('info', dm.qGetRestaurantOrders.FieldByName('INFO').Value);
      jsonObj.addPair(
        'start_time',
        TimeToStr(dm.qGetRestaurantOrders.FieldByName('START_TIME').Value)
      );
      jsonObj.addPair('status', dm.qGetRestaurantOrders.FieldByName('STATUS').Value);
      jsonArray.AddElement(jsonObj);
      dm.qGetRestaurantOrders.Next;
    end;
    jsonToSend.AddPair('result', jsonArray);
    Socket.SendText(jsonToSend.ToString);
    Exit;
  end;

  if operation = 'mobile_get_order' then
  begin
    dm.qGetOrderInfo.Close;
    dm.qGetOrderInfo.ParamByName('ORDER_ID').Value :=
                            getJsonStringAttribute(receivedJson, 'order_id');
    dm.qGetOrderInfo.Open;

    jsonToSend := tJsonObject.Create;
    jsonToSend.addPair('result', 'true');
    jsonToSend.addPair('id', dm.qGetOrderInfo.FieldByName('ID').Value);
    jsonToSend.addPair(
      'client_phone', dm.qGetOrderInfo.FieldByName('CLIENT_PHONE').Value
    );
    jsonToSend.addPair(
      'start_time', dm.qGetOrderInfo.FieldByName('START_TIME').Value
    );
    jsonToSend.addPair('operator', dm.qGetOrderInfo.FieldByName('OPERATOR').Value);
    jsonToSend.addPair('info', dm.qGetOrderInfo.FieldByName('INFO').Value);
    jsonToSend.addPair('status', dm.qGetOrderInfo.FieldByName('STATUS').Value);
    Socket.SendText(jsonToSend.ToString);
    Exit;
  end;

  if operation = 'mobile_complete_order' then
  begin
    dm.CompleteOrder(StrToInt64(getJsonStringAttribute(receivedJson, 'order_id')));
    jsonToSend := tJsonObject.Create;
    jsonToSend.addPair('result', 'true');
    Socket.SendText(jsonToSend.ToString);
    IdUDPClient1.Broadcast('updateData', 6969)
  end;
end;

end.
