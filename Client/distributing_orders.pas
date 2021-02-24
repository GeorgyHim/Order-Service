unit distributing_orders;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdUDPServer, System.Generics.Collections,
  IdGlobal, IdSocketHandle, Vcl.ExtCtrls, IdBaseComponent, IdComponent,
  IdUDPBase, Vcl.Menus, Data.DB, Vcl.Grids, Vcl.DBGrids, Datasnap.DBClient;

type
  TfDistributingOrders = class(TForm)
    OrdersPanel: TPanel;
    MainMenu1: TMainMenu;
    AddOrderMainMenu: TMenuItem;
    UpdateMainMenu: TMenuItem;
    OrdersGrid: TDBGrid;
    OrdersDataSource: TDataSource;
    procedure UpdateMainMenuClick(Sender: TObject);
    procedure UpdateData();
    procedure buildRestaurantsGrids();
    procedure FormCreate(Sender: TObject);
    procedure AddOrderMainMenuClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure OrdersGridDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    RestauantsGrids: TObjectList<TDBGrid>;
  end;

var
  fDistributingOrders: TfDistributingOrders;

implementation

{$R *.dfm}

uses custom_pannels, mydm, operator_window, new_order;

procedure TfDistributingOrders.UpdateMainMenuClick(Sender: TObject);
begin
  UpdateData();
end;

procedure TfDistributingOrders.AddOrderMainMenuClick(Sender: TObject);
begin
  fNewOrder := TfNewOrder.Create(Application);
  fNewOrder.ShowModal;
  fNewOrder.Release;
  UpdateData();
end;

procedure TfDistributingOrders.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  fOperatorWindow.OperatorTabControlChange(nil);
end;

procedure TfDistributingOrders.FormCreate(Sender: TObject);
begin
  RestauantsGrids := TObjectList<TDBGrid>.Create();
  UpdateData();
end;

procedure TfDistributingOrders.OrdersGridDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := (Sender is TDBGrid) and ((Sender as TDBGrid).Name <> OrdersGrid.Name);
end;

procedure TfDistributingOrders.UpdateData();
begin
  dm.UpdateData();
  RestauantsGrids.Clear;
  OrdersGrid.DataSource.DataSet.Open;
  buildRestaurantsGrids();
end;

procedure TfDistributingOrders.buildRestaurantsGrids();
var RestGrid: TDBGrid;
i : Integer;
test_val: String;
Col : TColumn;
begin
  i := 0;
  dm.qGetRestaurantsShort.Open;

  while not dm.qGetRestaurantsShort.Eof do
  begin
    RestGrid := TDBGrid.Create(Self);
    RestGrid.Left := 330 * (i mod 3) + 10;
    RestGrid.Top := 230 * (i div 3) + 10;
    RestGrid.Width := 300;
    RestGrid.Height := 200;
    RestGrid.Visible := True;
    RestGrid.Parent := Self;

    RestGrid.DataSource := TDataSource.Create(Self);
    RestGrid.DataSource.DataSet := TClientDataSet.Create(Self);
    RestGrid.DataSource.DataSet.FieldDefs.Add('ID', ftLargeint);
    RestGrid.DataSource.DataSet.FieldDefs.Add('INFO', ftWideString, 1000);
    (RestGrid.DataSource.DataSet as TClientDataSet).CreateDataSet;
    RestGrid.DataSource.DataSet.Open;

    dm.qGetRestaurantOrders.Close;
    dm.qGetRestaurantOrders.ParamByName('REST_ID').Value :=
                    dm.qGetRestaurantsShort.FieldByName('ID').Value;
    dm.qGetRestaurantOrders.Open;

    while not dm.qGetRestaurantOrders.Eof do
    begin
      test_val := dm.qGetRestaurantOrders.FieldByName('INFO').Value;
      (RestGrid.DataSource.DataSet as TClientDataSet).AppendRecord([
          dm.qGetRestaurantOrders.FieldByName('ID').Value, 
          dm.qGetRestaurantOrders.FieldByName('INFO').Value 
      ]); 
      dm.qGetRestaurantOrders.Next;                                         
    end;
    
    RestauantsGrids.Add(RestGrid);
    inc(i);
    dm.qGetRestaurantsShort.Next;
  end;

end;

end.
