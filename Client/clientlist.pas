unit clientlist;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.Menus, System.JSON, IBX.IBCustomDataSet, IBX.IBTable, Datasnap.DBClient;

type
  TfClientList = class(TForm)
    MainMenu1: TMainMenu;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    ClientDataSet1id: TIntegerField;
    ClientDataSet1name: TWideStringField;
    ClientDataSet1phone_number: TWideStringField;
    N1: TMenuItem;
    procedure N1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fClientList: TfClientList;

implementation

{$R *.dfm}

uses address, order;

procedure TfClientList.N1Click(Sender: TObject);
begin
  if fClientList.Tag = 1 then
    begin
      fAddress.selectedClientId := ClientDataSet1.FieldByName('id').AsInteger;
      fAddress.clientName := ClientDataSet1.FieldByName('name').Value;
    end;
  if fClientList.Tag = 2 then
    begin
      fOrder.selectedClientId := ClientDataSet1.FieldByName('id').AsInteger;
      fOrder.selectedClientName := ClientDataSet1.FieldByName('name').Value;
    end;
  Close;
end;

end.
