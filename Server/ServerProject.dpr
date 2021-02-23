program ServerProject;

uses
  Vcl.Forms,
  mydm in 'mydm.pas' {dm: TDataModule},
  server in 'server.pas' {fServer},
  utils in 'utils.pas',
  config in 'config.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TfServer, fServer);
  Application.Run;
end.
