unit client_address_list;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Datasnap.DBClient, Vcl.Menus;

type
  TfClientAddress = class(TForm)
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    MainMenu1: TMainMenu;
    ClientDataSet1: TClientDataSet;
    N1: TMenuItem;
    ClientDataSet1id: TIntegerField;
    ClientDataSet1clientId: TIntegerField;
    ClientDataSet1address: TWideStringField;
    procedure N1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fClientAddress: TfClientAddress;

implementation

{$R *.dfm}

uses order;

procedure TfClientAddress.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  fOrder.selectedCourierId := ClientDataSet1.FieldByName('clientId').Value;
  fOrder.SelectedClientAddress := ClientDataSet1.FieldByName('address').Value;
  fOrder.selectedAddressId := ClientDataSet1.FieldByName('id').Value;
end;

procedure TfClientAddress.N1Click(Sender: TObject);
begin
  Close;
end;

end.
