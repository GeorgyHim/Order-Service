unit test;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.JSON;

type
  TfTest = class(TForm)
    AskCourierOrdersButton: TButton;
    Label1: TLabel;
    loginEdit: TEdit;
    procedure AskCourierOrdersButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fTest: TfTest;

implementation

{$R *.dfm}

uses login;

procedure TfTest.AskCourierOrdersButtonClick(Sender: TObject);
var
  jsonObjectToSend: tJsonObject;
begin
  jsonObjectToSend := tJsonObject.Create;
  jsonObjectToSend.AddPair('type', 'courierOrders');
  jsonObjectToSend.AddPair('login', loginEdit.Text);
  fLogin.ClientSocket1.Socket.SendText(jsonObjectToSend.ToString);
end;

end.
