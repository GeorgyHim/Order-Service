unit mydm;

interface

uses
  System.SysUtils, System.Classes, IBX.IBStoredProc, Data.DB,
  IBX.IBCustomDataSet, IBX.IBTable, IBX.IBDatabase, IBX.IBQuery;

type
  Tdm = class(TDataModule)
    IBDatabase: TIBDatabase;
    IBTransaction_Read: TIBTransaction;
    qUserByUsername: TIBQuery;
    qGetRestaurantOrders: TIBQuery;
    qGetOrderInfo: TIBQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure EditHost(host_name:string;fbd_path: string);
    function CheckPassword(username, password : string) : boolean;
    procedure updateDb();
  end;

var
  dm: Tdm;

implementation

{$R *.dfm}

procedure Tdm.EditHost(host_name:string;fbd_path: string);
begin
  with  IBDatabase do begin
      close;
      DatabaseName := host_name + ':' + fbd_path;
      Open;
  end;
end;

function Tdm.CheckPassword(username, password : string) : boolean;
begin
  qUserByUsername.ParamByName('USERNAME').Value := username;
  qUserByUsername.Open;
  if (qUserByUsername.FieldByName('ID') <> nil) and
      (qUserByUsername.FieldByName('PASSWORD').Value = password) and
      (qUserByUsername.FieldByName('IS_ACTIVE').Value = 1) and
      (qUserByUsername.FieldByName('ROLE').Value = 2) then
    CheckPassword := True
  else
    CheckPassword := False;
  qUserByUsername.Close;
end;


procedure Tdm.updateDb();
begin
  IBTransaction_Read.Active := False;
  IBTransaction_Read.Active := True;
end;

end.
