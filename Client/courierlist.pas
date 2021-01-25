unit courierlist;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.Menus, Datasnap.DBClient;

type
  TfCourierList = class(TForm)
    DBGrid1: TDBGrid;
    MainMenu1: TMainMenu;
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    N1: TMenuItem;
    ClientDataSet1id: TIntegerField;
    ClientDataSet1name: TWideStringField;
    ClientDataSet1surname: TWideStringField;
    ClientDataSet1phone_number: TWideStringField;
    ClientDataSet1email: TWideStringField;
    ClientDataSet1transport_type: TWideStringField;
    procedure N1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fCourierList: TfCourierList;

implementation

{$R *.dfm}

uses order;

procedure TfCourierList.N1Click(Sender: TObject);
begin
  fOrder.selectedCourierId := ClientDataSet1.FieldByName('id').AsInteger;
  fOrder.selectedCourierName :=
    ClientDataSet1.FieldByName('name').Value + ' ' + ClientDataSet1.FieldByName('surname').Value;
  Close;
end;

end.
