unit add_position;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfAddPosition = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    nameEdit: TEdit;
    priceEdit: TEdit;
    addButton: TButton;
    procedure addButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fAddPosition: TfAddPosition;

implementation

{$R *.dfm}

uses order;

procedure TfAddPosition.addButtonClick(Sender: TObject);
begin
  fOrder.orderMemo.Lines.Add(nameEdit.Text + ' ' + priceEdit.Text);
  fOrder.positions.Add(nameEdit.Text, StrToFloat(priceEdit.Text));
  Close;
end;

end.
