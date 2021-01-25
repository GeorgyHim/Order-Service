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
    spAddCourier: TIBStoredProc;
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
    QUser_By_Username: TIBQuery;
    procedure dsFinishedOrderDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure EditHost(host_name:string;fbd_path: string);
    function CheckPassword(username, password : string; var user_id : Int64; var role: SmallInt) : boolean;






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
  with  IBDatabase1 do begin
      close;
      DatabaseName := host_name + ':' + fbd_path;
      Open;
  end;
end;

function Tdm.CheckPassword(username, password : string; var user_id : Int64; var role: SmallInt) : boolean;
begin
  QUser_By_Username.ParamByName('USERNAME').Value := username;
  QUser_By_Username.Open;
  if (QUser_By_Username.FieldByName('ID') <> nil) and (QUser_By_Username.FieldByName('PASSWORD').Value = password) then begin
    user_id := QUser_By_Username.FieldByName('ID').Value;
    role := QUser_By_Username.FieldByName('ROLE').Value;
    CheckPassword := True;
  end
  else begin
    user_id := -1;
    role := -1;
    CheckPassword := False;
  end;
  QUser_By_Username.Close;
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
  spAddCourier.Params[0].Value :=  name;
  spAddCourier.Params[1].Value := surname;
  spAddCourier.Params[2].Value :=  phoneNumber;
  spAddCourier.Params[3].Value := email;
  spAddCourier.Params[4].Value := transportType;
  if not spAddCourier.Transaction.InTransaction then
    begin
      spAddCourier.Transaction.StartTransaction;
    end;
  spAddCourier.ExecProc;
  result := spAddCourier.Params[5].Value;
  if spAddCourier.Transaction.InTransaction then
    begin
      spAddCourier.Transaction.Commit;
    end;
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
