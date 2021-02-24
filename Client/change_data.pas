unit change_data;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfChangeData = class(TForm)
    SurnameEdit: TEdit;
    NameEdit: TEdit;
    PatronymicEdit: TEdit;
    SurnameLabel: TLabel;
    NameLabel: TLabel;
    PatronymicLabel: TLabel;
    OKButton: TButton;
    CancelButton: TButton;
    WrongPasswordLabel: TLabel;
    procedure OKButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
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

procedure TfChangeData.FormShow(Sender: TObject);
begin
  dm.qGetOperatorData.ParamByName('USERNAME').Value := username;
  dm.qGetOperatorData.Open;
  SurnameEdit.Text := dm.qGetOperatorData.FieldByName('SURNAME').Value;
  NameEdit.Text := dm.qGetOperatorData.FieldByName('NAME').Value;
  PatronymicEdit.Text := dm.qGetOperatorData.FieldByName('PATRONYMIC').Value;
  dm.qGetOperatorData.Close;
end;

procedure TfChangeData.OKButtonClick(Sender: TObject);
begin
  dm.ChangeOperatorData(username, SurnameEdit.Text, NameEdit.Text, PatronymicEdit.Text);
  fOperatorWindow.UpdateData();
  fChangeData.Close;
end;

procedure TfChangeData.CancelButtonClick(Sender: TObject);
begin
  fChangeData.Close;
end;
end.
