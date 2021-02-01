object fCreateRestaurant: TfCreateRestaurant
  Left = 0
  Top = 0
  Caption = 'Create restaurant'
  ClientHeight = 336
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
  object NameLabel: TLabel
    Left = 24
    Top = 85
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
  object LoginLabel: TLabel
    Left = 24
    Top = 13
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
    Top = 51
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
  object AddressLabel: TLabel
    Left = 24
    Top = 127
    Width = 57
    Height = 20
    Caption = 'Address'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object StartHourLabel: TLabel
    Left = 24
    Top = 167
    Width = 71
    Height = 20
    Caption = 'Start hour'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object EndHourLabel: TLabel
    Left = 24
    Top = 207
    Width = 65
    Height = 20
    Caption = 'End hour'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object MenuLabel: TLabel
    Left = 24
    Top = 245
    Width = 38
    Height = 20
    Caption = 'Menu'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object LoginEdit: TEdit
    Left = 105
    Top = 16
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object PasswordEdit: TEdit
    Left = 105
    Top = 54
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object NameEdit: TEdit
    Left = 105
    Top = 88
    Width = 121
    Height = 21
    TabOrder = 2
  end
  object AddressEdit: TEdit
    Left = 105
    Top = 130
    Width = 121
    Height = 21
    TabOrder = 3
  end
  object OKButton: TButton
    Left = 24
    Top = 288
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 4
    OnClick = OKButtonClick
  end
  object CancelButton: TButton
    Left = 151
    Top = 288
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 5
    OnClick = CancelButtonClick
  end
  object StartHourEdit: TEdit
    Left = 105
    Top = 170
    Width = 121
    Height = 21
    TabOrder = 6
  end
  object EndHourEdit: TEdit
    Left = 105
    Top = 210
    Width = 121
    Height = 21
    TabOrder = 7
  end
  object MenuEdit: TEdit
    Left = 105
    Top = 248
    Width = 121
    Height = 21
    TabOrder = 8
  end
end
