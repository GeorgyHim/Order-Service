object fCreateOperator: TfCreateOperator
  Left = 0
  Top = 0
  Caption = 'Create operator'
  ClientHeight = 240
  ClientWidth = 262
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object LoginLabel: TLabel
    Left = 24
    Top = 8
    Width = 39
    Height = 20
    Caption = 'Login'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object PasswordLabel: TLabel
    Left = 24
    Top = 45
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
  object SurnameLabel: TLabel
    Left = 24
    Top = 88
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
    Left = 24
    Top = 121
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
    Left = 24
    Top = 155
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
  object PasswordEdit: TEdit
    Left = 120
    Top = 48
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object LoginEdit: TEdit
    Left = 120
    Top = 8
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object OKButton: TButton
    Left = 16
    Top = 200
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 5
    OnClick = OKButtonClick
  end
  object CancelButton: TButton
    Left = 166
    Top = 200
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 6
    OnClick = CancelButtonClick
  end
  object SurnameEdit: TEdit
    Left = 120
    Top = 91
    Width = 121
    Height = 21
    TabOrder = 2
  end
  object NameEdit: TEdit
    Left = 120
    Top = 131
    Width = 121
    Height = 21
    TabOrder = 3
  end
  object PatronymicEdit: TEdit
    Left = 120
    Top = 158
    Width = 121
    Height = 21
    TabOrder = 4
  end
end
