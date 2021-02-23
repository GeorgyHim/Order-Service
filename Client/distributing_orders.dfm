object fDistributingOrders: TfDistributingOrders
  Left = 0
  Top = 0
  Caption = 'Distributing orders'
  ClientHeight = 423
  ClientWidth = 526
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object OrdersPanel: TPanel
    Left = 248
    Top = -2
    Width = 281
    Height = 427
    Caption = 'Orders'
    DragMode = dmAutomatic
    TabOrder = 0
  end
  object RestaurantsPanel: TPanel
    Left = -7
    Top = -2
    Width = 256
    Height = 427
    Caption = 'Restaurants'
    DragMode = dmAutomatic
    TabOrder = 1
  end
  object MainMenu1: TMainMenu
    Left = 16
    Top = 40
    object AddOrderMainMenu: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1079#1072#1082#1072#1079
      OnClick = AddOrderMainMenuClick
    end
    object UpdateMainMenu: TMenuItem
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      OnClick = UpdateMainMenuClick
    end
  end
end
