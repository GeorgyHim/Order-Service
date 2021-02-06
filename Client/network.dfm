object FormNetwork: TFormNetwork
  Left = 0
  Top = 0
  Caption = 'Network'
  ClientHeight = 201
  ClientWidth = 447
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object ClientSocket1: TClientSocket
    Active = False
    ClientType = ctNonBlocking
    Port = 0
    Left = 384
    Top = 77
  end
  object IdUDPClient1: TIdUDPClient
    BroadcastEnabled = True
    Port = 6969
    Left = 288
    Top = 77
  end
  object IdUDPServer1: TIdUDPServer
    Bindings = <>
    DefaultPort = 0
    OnUDPRead = IdUDPServer1UDPRead
    Left = 192
    Top = 69
  end
end
