unit new_order;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls;

type
  TfNewOrder = class(TForm)
    PhoneNumberLabel: TLabel;
    OrderInfoLabel: TLabel;
    PhoneNumberEdit: TEdit;
    OKButton: TButton;
    CancelButton: TButton;
    OrderEdit: TRichEdit;
    procedure CancelButtonClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fNewOrder: TfNewOrder;

implementation

{$R *.dfm}

uses mydm, operator_window, login;

procedure TfNewOrder.CancelButtonClick(Sender: TObject);
begin
  fNewOrder.Close;
end;

procedure TfNewOrder.OKButtonClick(Sender: TObject);
var
  tmpString : string;
  i: Integer;
begin
  tmpString := '';
  for i := 0 to OrderEdit.Lines.Count do
    begin
      tmpString := tmpString + OrderEdit.Lines[i] + ' ';
    end;
  dm.CreateOrder(user_id, PhoneNumberEdit.Text, tmpString);
  fOperatorWindow.UpdateData();
  fNewOrder.Close;
end;

end.
