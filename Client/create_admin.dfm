object fCreateAdmin: TfCreateAdmin
  Left = 0
  Top = 0
  Caption = 'Create admin'
  ClientHeight = 128
  ClientWidth = 268
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
  object PasswordEdit: TEdit
    Left = 120
    Top = 48
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object LoginEdit: TEdit
    Left = 120
    Top = 11
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object OKButton: TButton
    Left = 24
    Top = 88
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 2
    OnClick = OKButtonClick
  end
  object CancelButton: TButton
    Left = 166
    Top = 88
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 3
    OnClick = CancelButtonClick
  end
end
