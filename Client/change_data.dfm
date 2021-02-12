object fChangeData: TfChangeData
  Left = 0
  Top = 0
  Caption = 'Change data'
  ClientHeight = 233
  ClientWidth = 231
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object SurnameLabel: TLabel
    Left = 8
    Top = 61
    Width = 63
    Height = 20
    Caption = 'Surname'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object NameLabel: TLabel
    Left = 8
    Top = 98
    Width = 41
    Height = 20
    Caption = 'Name'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object PatronymicLabel: TLabel
    Left = 8
    Top = 138
    Width = 79
    Height = 20
    Caption = 'Patronymic'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object PasswordLabel: TLabel
    Left = 8
    Top = 21
    Width = 67
    Height = 20
    Caption = 'Password'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object WrongPasswordLabel: TLabel
    Left = 76
    Top = 174
    Width = 20
    Height = 20
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object EditSurname: TEdit
    Left = 102
    Top = 64
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object EditName: TEdit
    Left = 102
    Top = 101
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object EditPatronymic: TEdit
    Left = 102
    Top = 141
    Width = 121
    Height = 21
    TabOrder = 2
  end
  object OKButton: TButton
    Left = 8
    Top = 200
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 3
    OnClick = OKButtonClick
  end
  object CancelButton: TButton
    Left = 148
    Top = 200
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 4
    OnClick = CancelButtonClick
  end
  object PasswordEdit: TEdit
    Left = 102
    Top = 24
    Width = 121
    Height = 21
    TabOrder = 5
  end
end
