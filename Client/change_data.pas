unit change_data;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfChangeData = class(TForm)
    EditSurname: TEdit;
    EditName: TEdit;
    EditPatronymic: TEdit;
    SurnameLabel: TLabel;
    NameLabel: TLabel;
    PatronymicLabel: TLabel;
    OKButton: TButton;
    CancelButton: TButton;
    PasswordEdit: TEdit;
    PasswordLabel: TLabel;
    WrongPasswordLabel: TLabel;
    procedure OKButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fChangeData: TfChangeData;

implementation

{$R *.dfm}

uses mydm, operator_window, login;

procedure TfChangeData.OKButtonClick(Sender: TObject);
begin
//  if dm.ChangeData(username, PasswordEdit.Text, SurnameEdit.Text, NameEdit.Text, PatronymicEdit.Text) then
//    begin
//      fOperatorWindow.UpdateData();
//      fChangeData.Close;
//    end
//  else
//    begin
//      WrongPasswordLabel.Caption := 'Wrong password'
//    end;         TODO... Need dm.ChangeData
end;

procedure TfChangeData.CancelButtonClick(Sender: TObject);
begin
  fChangeData.Close;
end;
end.
