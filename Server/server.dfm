object fServer: TfServer
  Left = 0
  Top = 0
  Caption = 'Server'
  ClientHeight = 179
  ClientWidth = 219
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
  object Label2: TLabel
    Left = 8
    Top = 17
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
  object Label3: TLabel
    Left = 8
    Top = 52
    Width = 56
    Height = 20
    Caption = 'DB Path'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 8
    Top = 90
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
  object PortEdit: TSpinEdit
    Left = 72
    Top = 93
    Width = 89
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 0
    Value = 4010
  end
  object StartButton: TButton
    Left = 8
    Top = 136
    Width = 89
    Height = 25
    Caption = 'Start'
    TabOrder = 1
    OnClick = StartButtonClick
  end
  object StopButton: TButton
    Left = 112
    Top = 136
    Width = 89
    Height = 25
    Caption = 'Stop'
    TabOrder = 2
    OnClick = StopButtonClick
  end
  object HostName: TEdit
    Left = 72
    Top = 16
    Width = 89
    Height = 21
    TabOrder = 3
    Text = '127.0.0.1'
  end
  object DataBasePath: TEdit
    Left = 72
    Top = 55
    Width = 89
    Height = 21
    TabOrder = 4
    Text = 
      'C:\Users\Alexey\Documents\Embarcadero\Studio\test\order-service\' +
      'DELIVERY.FDB'
  end
  object ServerSocket1: TServerSocket
    Active = False
    Port = 0
    ServerType = stNonBlocking
    OnClientRead = ServerSocket1ClientRead
    Left = 168
    Top = 88
  end
  object IdUDPClient1: TIdUDPClient
    Port = 0
    Left = 168
    Top = 8
  end
end
