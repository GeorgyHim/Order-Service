unit network;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdUDPServer, IdGlobal, IdSocketHandle,
  IdBaseComponent, IdComponent, IdUDPBase, IdUDPClient, System.Win.ScktComp,
  mydm, admin_window, operator_window, login, config, distributing_orders;

type
  TFormNetwork = class(TForm)
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
var receivedString, currentFormName: String;
begin
  currentFormName := Screen.ActiveForm.Name;
  ReceivedString := BytesToString(AData, IndyTextEncoding_UTF8);
  if ((receivedString = 'updateData') and (ABinding.PeerIP <> SelfIP))
        or (receivedString = 'updateDataFromServer') then
    begin
      if role = 0 then
        fAdminWindow.UpdateData(False);

      if role = 1 then
      begin
        if currentFormName = 'fDistributingOrders' then
          fDistributingOrders.UpdateData(False)
        else
          if currentFormName = 'fOperatorWindow' then
              fOperatorWindow.UpdateData(False);
      end;
    end;
end;

end.
