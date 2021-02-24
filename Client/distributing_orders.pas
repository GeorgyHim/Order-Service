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
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure PanelDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure PanelDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure Redraw();
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
end;

procedure TfDistributingOrders.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  fOperatorWindow.OperatorTabControlChange(nil);
end;

procedure TfDistributingOrders.FormCreate(Sender: TObject);
begin

  with OrdersPanel do begin

  end;

  Width := screen.Width div 2;
  Height := screen.Height div 2;
  RestaurantsPanel.Width := trunc(Width*0.7);
  OrdersPanel.Width := trunc(Width*0.3);
  RestaurantsPanel.Height := trunc(Height);
  OrdersPanel.Height := trunc(Height);
  OrdersPanel.Left := trunc(Width*0.7);

  //UpdateData();
end;

procedure TfDistributingOrders.UpdateData();
begin
  dm.UpdateData();
end;

procedure TfDistributingOrders.Redraw();
var
  i : integer;
begin
{        // redraw every child of panels
        with PanelOrder do begin
          for I := 0 to  ControlCount - 1 do begin
            controls[i].Left := 0;
            controls[i].Width := PanelOrder.Width;
            controls[i].Top := I * 50;
          end
        end;

        with PanelRestaurant do begin
          for I := 0 to  ControlCount - 1 do begin
            controls[i].Left := 0;
            controls[i].Top := I * 50;
          end
        end;

        // redraw orders queues
        //for I := 0 to RestaurantList.Count - 1 do
        //    (RestaurantList[i] as PanelRestaurant).redraw;
}
end;

procedure TfDistributingOrders.PanelDragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
  if (sender as TPanel).Parent is TfDistributingOrders then
    //(source as PanelOrder).AppointOrder('1','null')
    //dm.AppointOrder(PanelOrder.id, 'null')
  else
    //(source as PanelOrder).AppointOrder(((sender as TPanel).Parent as PanelRestaurant).get_id );
    //dm.AppointOrder(PanelOrder.id, PanelRestaurant.id);
  UpdateData();
end;

procedure TfDistributingOrders.PanelDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
     accept := (source is PanelOrder){and  (sender is TPanel_driver)};
end;

end.
