object fLogin: TfLogin
  Left = 0
  Top = 0
  Caption = 'Client'
  ClientHeight = 242
  ClientWidth = 215
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
    Left = 96
    Top = 80
    Width = 20
    Height = 13
    Caption = 'Port'
  end
  object Label1: TLabel
    Left = 96
    Top = 24
    Width = 22
    Height = 13
    Caption = 'Host'
  end
  object HostEdit: TEdit
    Left = 52
    Top = 51
    Width = 113
    Height = 21
    TabOrder = 0
    Text = '127.0.0.1'
  end
  object PortEdit: TSpinEdit
    Left = 52
    Top = 99
    Width = 113
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 1
    Value = 4010
  end
  object Button1: TButton
    Left = 72
    Top = 136
    Width = 75
    Height = 25
    Caption = 'Connect'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 72
    Top = 176
    Width = 75
    Height = 25
    Caption = 'Disconnect'
    TabOrder = 3
    OnClick = Button2Click
  end
  object ClientSocket1: TClientSocket
    Active = False
    ClientType = ctNonBlocking
    Port = 0
    OnRead = ClientSocket1Read
    Left = 24
    Top = 184
  end
  object IdUDPServer1: TIdUDPServer
    Bindings = <>
    DefaultPort = 0
    OnUDPRead = IdUDPServer1UDPRead
    Left = 160
    Top = 192
  end
end
