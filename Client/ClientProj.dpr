program ClientProj;

uses
  Vcl.Forms,
  login in 'login.pas' {fLogin},
  operator_window in 'operator_window.pas' {fOperatorWindow},
  admin_window in 'admin_window.pas' {fAdminWindow},
  create_admin in 'create_admin.pas' {fCreateAdmin},
  create_operator in 'create_operator.pas' {fCreateOperator},
  create_restaurant in 'create_restaurant.pas' {fCreateRestaurant},
  mydm in 'mydm.pas' {dm: TDataModule},
  change_password in 'change_password.pas' {fChangePassword},
  config in 'config.pas',
  network in 'network.pas' {FormNetwork},
  change_data in 'change_data.pas' {fChangeData},
  distributing_orders in 'distributing_orders.pas' {fDistributingOrders},
  new_order in 'new_order.pas' {fNewOrder};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfLogin, fLogin);
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TFormNetwork, FormNetwork);
  Application.CreateForm(TfNewOrder, fNewOrder);
  Application.Run;
end.
