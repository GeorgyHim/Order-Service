 unit mydm;

interface

uses
  System.SysUtils, System.Classes, IBX.IBStoredProc, Data.DB,
  IBX.IBCustomDataSet, IBX.IBTable, IBX.IBDatabase, IBX.IBQuery, config;

type
  Tdm = class(TDataModule)
    IBDatabase: TIBDatabase;
    IBTransaction_Read: TIBTransaction;
    IBTransaction_Edit: TIBTransaction;
    spAddUser: TIBStoredProc;
    qUserByUsername: TIBQuery;
    qCreateOperator: TIBQuery;
    qCreateRestaurant: TIBQuery;
    qAllAdmins: TIBQuery;
    qAllOperators: TIBQuery;
    qAllRestaurants: TIBQuery;
    qAllOrders: TIBQuery;
    qDeactivate: TIBQuery;
    qAllDeactivatedUsers: TIBQuery;
    qActivate: TIBQuery;
    qChangePassword: TIBQuery;
    qActiveOrders: TIBQuery;
    qCompletedOrders: TIBQuery;
    qCanceledOrders: TIBQuery;
    qOrderInfo: TIBQuery;
    qCancelOrder: TIBQuery;
    qCompleteOrder: TIBQuery;
    qChangeOperatorData: TIBQuery;
    qGetOperatorData: TIBQuery;
    spAddOrder: TIBStoredProc;
    qGetOperatorId: TIBQuery;
    qAppointOrder: TIBQuery;
    qGetAppointableOrders: TIBQuery;
    qGetRestaurantsShort: TIBQuery;
    qGetRestaurantOrders: TIBQuery;
    qDelayOrder: TIBQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure EditHost(host_name:string;fbd_path: string);

    function CheckPassword(username, password : string; var user_id : Int64; var role: SmallInt) : boolean;
    function ChangePassword(username, old_password, new_password : string): boolean;
    procedure ChangeOperatorData(username, surname, name, patronymic: string);

    function CreateUser(username, password : string; role: SmallInt): Int64;
    procedure CreateOperator(surname, name, patronymic, username, password: String);
    procedure CreateRestaurant(name, address, start_hour, end_hour, menu, username, password: String);
    function CreateOrder(user_id: Int64; client_phone, info: String): Int64;

    procedure DeactivateUser(username: String);
    procedure ActivateUser(username: String);

    function GetOrderInfo(order_id: Int64): String;
    procedure CompleteOrder(order_id: Int64; end_time: String);
    procedure CancelOrder(order_id: Int64);
    procedure AppointOrder(order_id, restaurant_id: Int64);
    procedure DelayOrder(order_id: Int64);

    procedure UpdateData();
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

procedure Tdm.EditHost(host_name:string;fbd_path: string);
begin
  with  IBDatabase do begin
      close;
      DatabaseName := host_name + '/' + DefaultPort + ':' + fbd_path;
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


function Tdm.ChangePassword(username, old_password, new_password : string): boolean;
var user_id : Int64;
    role: SmallInt;
begin
  if CheckPassword(username, old_password, user_id, role) then
  begin
    qChangePassword.ParamByName('USERNAME').Value := username;
    qChangePassword.ParamByName('PASSWORD').Value := new_password;
    qChangePassword.ExecSQL;
    qChangePassword.Transaction.Commit;
    ChangePassword := True;
  end
  else ChangePassword := False;
end;


procedure Tdm.ChangeOperatorData(username, surname, name, patronymic: string);
begin
  qChangeOperatorData.ParamByName('USERNAME').Value := username;
  qChangeOperatorData.ParamByName('SURNAME').Value := surname;
  qChangeOperatorData.ParamByName('NAME').Value := name;
  qChangeOperatorData.ParamByName('PATRONYMIC').Value := patronymic;
  qChangeOperatorData.ExecSQL;
  qChangeOperatorData.Transaction.Commit;
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


function Tdm.CreateOrder(user_id: Int64; client_phone, info: String): Int64;
var oper_id: Int64;
begin
  qGetOperatorId.ParamByName('USER_ID').Value := user_id;
  qGetOperatorId.Open;
  oper_id := qGetOperatorId.FieldByName('ID').Value;
  qGetOperatorId.Close;

  spAddOrder.Params[0].Value := oper_id;
  spAddOrder.Params[1].Value := client_phone;
  spAddOrder.Params[2].Value := info;
  spAddOrder.Params[3].Value := DateTimeToStr(Now);

  if not spAddOrder.Transaction.InTransaction then
    spAddOrder.Transaction.StartTransaction;
  spAddOrder.ExecProc;
  Result := spAddOrder.Params[4].Value;
  spAddOrder.Transaction.Commit;
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

procedure Tdm.DeactivateUser(username: String);
begin
  qDeactivate.ParamByName('USERNAME').Value := username;
  qDeactivate.ExecSQL;
  qDeactivate.Transaction.Commit;
end;

procedure Tdm.ActivateUser(username: String);
begin
  qActivate.ParamByName('USERNAME').Value := username;
  qActivate.ExecSQL;
  qActivate.Transaction.Commit;
end;


function Tdm.GetOrderInfo(order_id: Int64): String;
begin
  qOrderInfo.ParamByName('ORDER_ID').Value := order_id;
  qOrderInfo.Open;
  GetOrderInfo := qOrderInfo.FieldByName('INFO').Value;
  qOrderInfo.Close;
end;


procedure Tdm.CompleteOrder(order_id: Int64; end_time: string);
begin
  if end_time = '' then
    end_time := DateTimeToStr(Now);

  qCompleteOrder.ParamByName('ID').Value := order_id;
  qCompleteOrder.ParamByName('END_TIME').Value := end_time;
  qCompleteOrder.ExecSQL;
  qCompleteOrder.Transaction.Commit;
end;

procedure Tdm.CancelOrder(order_id: Int64);
begin
  qCancelOrder.ParamByName('ID').Value := order_id;
  qCancelOrder.ExecSQL;
  qCancelOrder.Transaction.Commit;
end;

procedure Tdm.AppointOrder(order_id, restaurant_id: Int64);
begin
  qAppointOrder.ParamByName('ORDER_ID').Value := order_id;
  qAppointOrder.ParamByName('RESTAURANT_ID').Value := restaurant_id;
  qAppointOrder.ExecSQL;
  qAppointOrder.Transaction.Commit;
end;

procedure Tdm.DelayOrder(order_id: Int64);
begin
  qDelayOrder.ParamByName('ORDER_ID').Value := order_id;
  qDelayOrder.ExecSQL;
  qDelayOrder.Transaction.Commit;
end;

procedure Tdm.UpdateData();
begin
  IBTransaction_Read.Active := False;
  IBTransaction_Read.Active := True;
end;

{$R *.dfm}

end.
