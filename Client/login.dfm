object fLogin: TfLogin
  Left = 0
  Top = 0
  Caption = 'Client'
  ClientHeight = 241
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
  object portLabel: TLabel
    Left = 16
    Top = 133
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
    Left = 16
    Top = 94
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
    Left = 16
    Top = 14
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
    Left = 16
    Top = 54
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
    Top = 216
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
  object HostEdit: TEdit
    Left = 98
    Top = 97
    Width = 113
    Height = 21
    TabOrder = 2
    Text = '127.0.0.1'
  end
  object PortEdit: TSpinEdit
    Left = 98
    Top = 136
    Width = 113
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 3
    Value = 4010
  end
  object ConnectButton: TButton
    Left = 8
    Top = 176
    Width = 75
    Height = 25
    Caption = 'Connect'
    TabOrder = 4
    OnClick = ConnectButtonClick
  end
  object DisconnectButton: TButton
    Left = 136
    Top = 176
    Width = 75
    Height = 25
    Caption = 'Disconnect'
    TabOrder = 5
    OnClick = DisconnectButtonClick
  end
  object PasswordEdit: TEdit
    Left = 98
    Top = 57
    Width = 113
    Height = 21
    TabOrder = 1
  end
  object LoginEdit: TEdit
    Left = 98
    Top = 17
    Width = 113
    Height = 21
    TabOrder = 0
  end
  object ClientSocket1: TClientSocket
    Active = False
    ClientType = ctNonBlocking
    Port = 0
    OnRead = ClientSocket1Read
    Left = 136
    Top = 200
  end
  object IdUDPServer1: TIdUDPServer
    Bindings = <>
    DefaultPort = 0
    OnUDPRead = IdUDPServer1UDPRead
    Left = 64
    Top = 200
  end
end
