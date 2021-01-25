object fServer: TfServer
  Left = 0
  Top = 0
  Caption = 'Server'
  ClientHeight = 327
  ClientWidth = 242
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 104
    Top = 96
    Width = 20
    Height = 13
    Caption = 'Port'
  end
  object Port: TSpinEdit
    Left = 72
    Top = 125
    Width = 89
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 0
    Value = 4010
  end
  object Button1: TButton
    Left = 72
    Top = 168
    Width = 89
    Height = 25
    Caption = 'Start'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 72
    Top = 216
    Width = 89
    Height = 25
    Caption = 'Stop'
    TabOrder = 2
    OnClick = Button2Click
  end
  object ServerSocket1: TServerSocket
    Active = False
    Port = 0
    ServerType = stNonBlocking
    OnClientRead = ServerSocket1ClientRead
    Left = 24
    Top = 272
  end
  object IdUDPClient1: TIdUDPClient
    Port = 0
    Left = 184
    Top = 264
  end
end
