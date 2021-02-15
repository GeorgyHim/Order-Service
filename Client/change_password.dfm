object fChangePassword: TfChangePassword
  Left = 0
  Top = 0
  Caption = 'Change password'
  ClientHeight = 142
  ClientWidth = 273
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object OldPasswordLabel: TLabel
    Left = 16
    Top = 16
    Width = 97
    Height = 20
    Caption = 'Old password'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object NewPasswordLabel: TLabel
    Left = 16
    Top = 56
    Width = 103
    Height = 20
    Caption = 'New password'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object WrongOldPasswordLabel: TLabel
    Left = 76
    Top = 86
    Width = 5
    Height = 20
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object OldPasswordEdit: TEdit
    Left = 138
    Top = 19
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object OKButton: TButton
    Left = 16
    Top = 109
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 2
    OnClick = OKButtonClick
  end
  object CancelButton: TButton
    Left = 190
    Top = 109
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 3
    OnClick = CancelButtonClick
  end
  object NewPasswordEdit: TEdit
    Left = 138
    Top = 59
    Width = 121
    Height = 21
    TabOrder = 1
  end
end
