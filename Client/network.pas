unit network;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdUDPServer, IdGlobal, IdSocketHandle,
  IdBaseComponent, IdComponent, IdUDPBase, IdUDPClient, System.Win.ScktComp,
  mydm, admin_window, operator_window;

type
  TFormNetwork = class(TForm)
    ClientSocket1: TClientSocket;
    IdUDPClient1: TIdUDPClient;
    IdUDPServer1: TIdUDPServer;
    procedure IdUDPServer1UDPRead(AThread: TIdUDPListenerThread;
      const AData: TIdBytes; ABinding: TIdSocketHandle);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormNetwork: TFormNetwork;

implementation

{$R *.dfm}

procedure TFormNetwork.IdUDPServer1UDPRead(AThread: TIdUDPListenerThread;
  const AData: TIdBytes; ABinding: TIdSocketHandle);
var receivedString, CurrentFormName: String;
begin
  ReceivedString := BytesToString(AData, en7bit);
  if receivedString = 'updateData' then
    begin
      CurrentFormName := Screen.ActiveForm.Name;
      if CurrentFormName = 'fAdminWindow' then
        fAdminWindow.UpdateData();
      if CurrentFormName = 'fOperatorWindow' then
        // TODO: fOperatorWindow.UpdateData();
        ;
    end;
end;

end.
