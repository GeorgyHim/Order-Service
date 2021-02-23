unit distributing_orders;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdUDPServer,
  IdGlobal, IdSocketHandle, Vcl.ExtCtrls, IdBaseComponent, IdComponent,
  IdUDPBase, Vcl.Menus;

type
  TfDistributingOrders = class(TForm)
    OrdersPanel: TPanel;
    RestaurantsPanel: TPanel;
    MainMenu1: TMainMenu;
    AddOrderMainMenu: TMenuItem;
    UpdateMainMenu: TMenuItem;
    procedure UpdateMainMenuClick(Sender: TObject);
    procedure UpdateData();
    procedure FormCreate(Sender: TObject);
    procedure AddOrderMainMenuClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fDistributingOrders: TfDistributingOrders;

implementation

{$R *.dfm}

uses mydm, new_order;

procedure TfDistributingOrders.UpdateMainMenuClick(Sender: TObject);
begin
  UpdateData();
end;

procedure TfDistributingOrders.AddOrderMainMenuClick(Sender: TObject);
begin
  fNewOrder := TfNewOrder.Create(Application);
  fNewOrder.ShowModal;
  fNewOrder.Release;
end;

procedure TfDistributingOrders.FormCreate(Sender: TObject);
begin

  with OrdersPanel do begin

  end;

  Width := screen.Width;
  Height := screen.Height;
  RestaurantsPanel.Width := trunc(Width*0.7);
  OrdersPanel.Width := trunc(Width*0.3);
  RestaurantsPanel.Height := trunc(Height);
  OrdersPanel.Height := trunc(Height);
  OrdersPanel.Left := trunc(Width*0.7);

  UpdateData();
end;

procedure TfDistributingOrders.UpdateData();
begin
  dm.UpdateData();
end;
end.
