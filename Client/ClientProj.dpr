program ClientProj;

uses
  Vcl.Forms,
  login in 'login.pas' {fLogin},
  operator_window in 'operator_window.pas' {fOperatorWindow},
  client in 'client.pas' {fClient},
  courier in 'courier.pas' {fCourier},
  address in 'address.pas' {fAddress},
  clientlist in 'clientlist.pas' {fClientList},
  order in 'order.pas' {fOrder},
  client_address_list in 'client_address_list.pas' {fClientAddress},
  add_position in 'add_position.pas' {fAddPosition},
  courierlist in 'courierlist.pas' {fCourierList},
  test in 'test.pas' {fTest},
  confirm_order in 'confirm_order.pas' {fConfirmOrders},
  admin_window in 'admin_window.pas' {fAdminWindow},
  create_admin in 'create_admin.pas' {fCreateAdmin};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfLogin, fLogin);
  Application.CreateForm(TfConfirmOrders, fConfirmOrders);
  Application.CreateForm(TfAdminWindow, fAdminWindow);
  Application.CreateForm(TfCreateAdmin, fCreateAdmin);
  Application.Run;
end.
