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
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure EditHost(host_name:string;fbd_path: string);
    function CheckPassword(username, password : string; var user_id : Int64; var role: SmallInt) : boolean;
    function CreateUser(username, password : string; role: SmallInt): Int64;
    procedure CreateOperator(surname, name, patronymic, username, password: String);
    procedure CreateRestaurant(name, address, start_hour, end_hour, menu, username, password: String);
    procedure DeactivateUser(username: String);
    procedure ActivateUser(username: String);
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

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
    with IBDatabase do begin
      close;
      DatabaseName := DBPath;
      Open;
  end;
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

procedure Tdm.UpdateData();
begin
  IBTransaction_Read.Active := False;
  IBTransaction_Read.Active := True;
end;

{$R *.dfm}

end.
