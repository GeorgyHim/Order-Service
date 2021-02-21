object fLogin: TfLogin
  Left = 0
  Top = 0
  Caption = 'Client'
  ClientHeight = 254
  ClientWidth = 225
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object portLabel: TLabel
    Left = 8
    Top = 163
    Width = 29
    Height = 20
    Caption = 'Port'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object HostLabel: TLabel
    Left = 8
    Top = 126
    Width = 32
    Height = 20
    Caption = 'Host'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object LoginLabel: TLabel
    Left = 8
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
  object Label1: TLabel
    Left = 8
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
  object LoginDenied: TLabel
    Left = 64
    Top = 191
    Width = 5
    Height = 20
    BiDiMode = bdLeftToRight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentBiDiMode = False
    ParentFont = False
    Layout = tlBottom
  end
  object DBPathLabel: TLabel
    Left = 8
    Top = 86
    Width = 56
    Height = 20
    Caption = 'DB path'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object HostEdit: TEdit
    Left = 98
    Top = 129
    Width = 113
    Height = 21
    TabOrder = 2
    Text = '127.0.0.1'
  end
  object PortEdit: TSpinEdit
    Left = 98
    Top = 166
    Width = 113
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 3
    Value = 4010
  end
  object LoginButton: TButton
    Left = 75
    Top = 217
    Width = 75
    Height = 25
    Caption = 'Login'
    TabOrder = 4
    OnClick = LoginButtonClick
  end
  object PasswordEdit: TEdit
    Left = 98
    Top = 44
    Width = 113
    Height = 21
    TabOrder = 1
    Text = 'scrra'
  end
  object LoginEdit: TEdit
    Left = 98
    Top = 8
    Width = 113
    Height = 21
    TabOrder = 0
    Text = 'atingo'
  end
  object DataBasePathEdit: TEdit
    Left = 98
    Top = 89
    Width = 113
    Height = 21
    TabOrder = 5
  end
  object ClientSocket1: TClientSocket
    Active = False
    ClientType = ctNonBlocking
    Port = 0
    Left = 184
    Top = 208
  end
end
