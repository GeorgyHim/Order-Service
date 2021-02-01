unit mydm;

interface

uses
  System.SysUtils, System.Classes, IBX.IBStoredProc, Data.DB,
  IBX.IBCustomDataSet, IBX.IBTable, IBX.IBDatabase, IBX.IBQuery;

type
  Tdm = class(TDataModule)
    IBDatabase1: TIBDatabase;
    IBTransaction1: TIBTransaction;
    tAddress: TIBTable;
    tClient: TIBTable;
    tCourier: TIBTable;
    tOrderList: TIBTable;
    tOrders: TIBTable;
    spAddAddress: TIBStoredProc;
    spAddClient: TIBStoredProc;
    spAddUser: TIBStoredProc;
    spAddOrder: TIBStoredProc;
    spAddOrderList: TIBStoredProc;
    spConfirmOrder: TIBStoredProc;
    qAddresses: TIBQuery;
    qAddressesID: TIntegerField;
    qAddressesCLIENT_ID: TIntegerField;
    qAddressesADDRESS: TIBStringField;
    dsClient: TDataSource;
    dsAddress: TDataSource;
    qCourier: TIBQuery;
    dsCourier: TDataSource;
    qActiveOrder: TIBQuery;
    dsActiveOrder: TDataSource;
    qFinishedOrder: TIBQuery;
    dsFinishedOrder: TDataSource;
    spHasNewOrder: TIBStoredProc;
    qCourierOrders: TIBQuery;
    dsCourierOrders: TDataSource;
    qConfirmedOrders: TIBQuery;
    dsConfirmedOrders: TDataSource;
    qOrderList: TIBQuery;
    dsOrderList: TDataSource;
    qCourierOrder: TIBQuery;
    qCourierOrder_List: TIBQuery;
    dsCourierOrder_List: TDataSource;
    dsCourierOrder: TDataSource;
    spSetReport: TIBStoredProc;


    IBDatabase: TIBDatabase;
    IBTransaction_Read: TIBTransaction;
    IBTransaction_Edit: TIBTransaction;
    UserDataSet: TIBDataSet;
    qUserByUsername: TIBQuery;
    qCreateOperator: TIBQuery;
    qCreateRestaurant: TIBQuery;
    procedure dsFinishedOrderDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure EditHost(host_name:string;fbd_path: string);
    function CheckPassword(username, password : string; var user_id : Int64; var role: SmallInt) : boolean;
    function CreateUser(username, password : string; role: SmallInt): Int64;
    procedure CreateOperator(surname, name, patronymic, username, password: String);
    procedure CreateRestaurant(name, address, start_hour, end_hour, menu, username, password: String);
  {------------------------------------}

  { ELDAR CODE}
    function AddAddress(clientId: integer; address: String): integer;
    function addClient(name: String; phoneNumber: String): integer;
    function addCourier(
        name: String;
        surname: String;
        phoneNumber: String;
        email: String;
        transportType: String
    ): integer;
    function addOrder(
        courierId: integer;
        addressId: integer;
        timeStart: String
    ): integer;
    function addOrderList(
        ordersId: integer;
        positionName: String;
        price: Double
    ): integer;
    procedure confirmOrder(orderId: integer; timeEnd: String);
    function hasNewOrder(in_id: integer): String;
    function SetReport(in_id: integer): String;
  {--ELDAR CODE--}
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

procedure Tdm.EditHost(host_name:string;fbd_path: string);
begin
// TODO: Когда удалим IBDatabase1 делать with для нашей IBDatabase
  with  IBDatabase do begin
      close;
      DatabaseName := host_name + ':' + fbd_path;
      Open;
  end;
end;

function Tdm.CheckPassword(username, password : string; var user_id : Int64; var role: SmallInt) : boolean;
begin
  qUserByUsername.ParamByName('USERNAME').Value := username;
  qUserByUsername.Open;
  if (qUserByUsername.FieldByName('ID') <> nil) and
      (qUserByUsername.FieldByName('PASSWORD').Value = password) and
      (qUserByUsername.FieldByName('IS_ACTIVE').Value = 1)  then begin
    user_id := qUserByUsername.FieldByName('ID').Value;
    role := qUserByUsername.FieldByName('ROLE').Value;
    CheckPassword := True;
  end
  else begin
    user_id := -1;
    role := -1;
    CheckPassword := False;
  end;
  qUserByUsername.Close;
end;


function Tdm.CreateUser(username, password : string; role: SmallInt): Int64;
begin
  spAddUser.Params[0].Value := username;
  spAddUser.Params[1].Value := password;
  spAddUser.Params[2].Value := role;

  if not spAddUser.Transaction.InTransaction then
    spAddUser.Transaction.StartTransaction;
  spAddUser.ExecProc;
  Result := spAddUser.Params[3].Value;
  if spAddUser.Transaction.InTransaction then
    spAddUser.Transaction.Commit;
end;


procedure Tdm.CreateOperator(surname, name, patronymic, username, password: String);
var
  user_id : Int64;
begin
  user_id := CreateUser(username, password, 1);

  qCreateOperator.ParamByName('USER_ID').Value := user_id;
  qCreateOperator.ParamByName('NAME').Value := name;
  qCreateOperator.ParamByName('SURNAME').Value := surname;
  qCreateOperator.ParamByName('PATRONYMIC').Value := patronymic;
  qCreateOperator.ExecSQL;
  qCreateOperator.Transaction.Commit;
end;


procedure Tdm.CreateRestaurant(name, address, start_hour, end_hour, menu, username, password: String);
var
  user_id : Int64;
begin
  user_id := CreateUser(username, password, 1);

  qCreateRestaurant.ParamByName('USER_ID').Value := user_id;
  qCreateRestaurant.ParamByName('NAME').Value := name;
  qCreateRestaurant.ParamByName('ADRESS').Value := address;
  qCreateRestaurant.ParamByName('START_HOUR').Value := start_hour;
  qCreateRestaurant.ParamByName('END_HOUR').Value := end_hour;
  qCreateRestaurant.ParamByName('MENU').Value := menu;
  qCreateRestaurant.ExecSQL;
  qCreateRestaurant.Transaction.Commit;
end;
















{ ELDAR CODE}
function Tdm.AddAddress(clientId: integer; address: String): integer;
begin
  spAddAddress.Params[0].Value := clientId;
  spAddAddress.Params[1].Value := address;
  if not spAddAddress.Transaction.InTransaction then
    begin
      spAddAddress.Transaction.StartTransaction;
    end;
  spAddAddress.ExecProc;
  result := spAddAddress.Params[2].Value;
  if spAddAddress.Transaction.InTransaction then
    begin
      spAddAddress.Transaction.Commit;
    end;
end;

function Tdm.addClient(name: String; phoneNumber: String): integer;
begin
  spAddClient.Params[0].Value :=  name;
  spAddClient.Params[1].Value := phoneNumber;
  if not spAddClient.Transaction.InTransaction then
    begin
      spAddClient.Transaction.StartTransaction;
    end;
  spAddClient.ExecProc;
  result := spAddClient.Params[2].Value;
  if spAddClient.Transaction.InTransaction then
    begin
      spAddClient.Transaction.Commit;
    end;
end;

function Tdm.addCourier(
        name: String;
        surname: String;
        phoneNumber: String;
        email: String;
        transportType: String
    ): integer;
begin
  Result := 322;
end;

function Tdm.addOrder(
        courierId: integer;
        addressId: integer;
        timeStart: String
    ): integer;
begin
  spAddOrder.Params[1].Value :=  courierId;
  spAddOrder.Params[2].Value := addressId;
  spAddOrder.Params[3].Value :=  timeStart;
  if not spAddOrder.Transaction.InTransaction then
    begin
      spAddOrder.Transaction.StartTransaction;
    end;
  spAddOrder.ExecProc;
  result := spAddOrder.Params[0].Value;
  if spAddOrder.Transaction.InTransaction then
    begin
      spAddOrder.Transaction.Commit;
    end;
end;

function Tdm.addOrderList(
        ordersId: integer;
        positionName: String;
        price: Double
    ): integer;
begin
  spAddOrderList.Params[1].Value :=  ordersId;
  spAddOrderList.Params[2].Value := positionName;
  spAddOrderList.Params[3].Value :=  price;
  if not spAddOrderList.Transaction.InTransaction then
    begin
      spAddOrderList.Transaction.StartTransaction;
    end;
  spAddOrderList.ExecProc;
  result := spAddOrderList.Params[0].Value;
  if spAddOrderList.Transaction.InTransaction then
    begin
      spAddOrderList.Transaction.Commit;
    end;
end;

procedure Tdm.confirmOrder(orderId: integer; timeEnd: String);
begin
  spConfirmOrder.Params[0].Value := orderId;
  spConfirmOrder.Params[1].Value := timeEnd;
  if not spConfirmOrder.Transaction.InTransaction then
   spConfirmOrder.Transaction.StartTransaction;
  spConfirmOrder.ExecProc;
  if spConfirmOrder.Transaction.InTransaction then
   spConfirmOrder.Transaction.Commit;
end;

function Tdm.hasNewOrder(in_id: integer): String;
begin
  spHasNewOrder.Params[0].Value := in_id;
  if not spHasNewOrder.Transaction.InTransaction then
   spHasNewOrder.Transaction.StartTransaction;
  spHasNewOrder.ExecProc;
  result := spHasNewOrder.Params[1].Value;
  if spHasNewOrder.Transaction.InTransaction then
   spHasNewOrder.Transaction.Commit;
end;

function Tdm.SetReport(in_id: integer): String;
begin
  spSetReport.Params[0].Value := in_id;
  if not spSetReport.Transaction.InTransaction then
   spSetReport.Transaction.StartTransaction;
   spSetReport.ExecProc;
  if spSetReport.Transaction.InTransaction then
  begin
   spSetReport.Transaction.Commit;
   result:='true'
  end
  else
  result:='false'
end;

procedure Tdm.dsFinishedOrderDataChange(Sender: TObject; Field: TField);
begin

end;
{--ELDAR CODE--}

{$R *.dfm}

end.
