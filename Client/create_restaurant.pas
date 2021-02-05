unit create_restaurant;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, mydm;

type
  TfCreateRestaurant = class(TForm)
    LoginEdit: TEdit;
    PasswordEdit: TEdit;
    NameEdit: TEdit;
    NameLabel: TLabel;
    OKButton: TButton;
    CancelButton: TButton;
    LoginLabel: TLabel;
    PasswordLabel: TLabel;
    AddressLabel: TLabel;
    StartHourLabel: TLabel;
    StartHourEdit: TEdit;
    EndHourLabel: TLabel;
    EndHourEdit: TEdit;
    AddressEdit: TEdit;
    MenuEdit: TEdit;
    MenuLabel: TLabel;
    procedure CancelButtonClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fCreateRestaurant: TfCreateRestaurant;

implementation

{$R *.dfm}

uses login;

procedure TfCreateRestaurant.OKButtonClick(Sender: TObject);
begin
  dm.CreateRestaurant(
    NameEdit.Text, AddressEdit.Text, StartHourEdit.Text, EndHourEdit.Text,
    MenuEdit.Text, LoginEdit.Text, PasswordEdit.Text
  );
  fCreateRestaurant.Close;
end;

procedure TfCreateRestaurant.CancelButtonClick(Sender: TObject);
begin
  fCreateRestaurant.Close;
end;

end.
