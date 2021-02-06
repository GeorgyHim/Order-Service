unit change_admin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfChangeAdmin = class(TForm)
    LoginLabel: TLabel;
    LoginEdit: TEdit;
    OKButton: TButton;
    CancelButton: TButton;
    procedure CancelButtonClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fChangeAdmin: TfChangeAdmin;

implementation

{$R *.dfm}

uses mydm, admin_window;

procedure TfChangeAdmin.FormCreate(Sender: TObject);
begin
  LoginEdit.Text := fAdminWindow.AdminGrid.DataSource.DataSet.Fields[0].Value;
end;

procedure TfChangeAdmin.OKButtonClick(Sender: TObject);
begin
  //dm.ChangeUser(LoginEdit.Text);
  fAdminWindow.UpdateData();
  fChangeAdmin.Close;
end;

procedure TfChangeAdmin.CancelButtonClick(Sender: TObject);
begin
  fChangeAdmin.Close;
end;

end.
