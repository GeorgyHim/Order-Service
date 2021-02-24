object fDistributingOrders: TfDistributingOrders
  Left = 0
  Top = 0
  Caption = 'Distributing orders'
  ClientHeight = 423
  ClientWidth = 746
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object OrdersPanel: TPanel
    Left = 448
    Top = 0
    Width = 298
    Height = 423
    Align = alRight
    Caption = 'Orders'
    DragMode = dmAutomatic
    TabOrder = 0
    object OrdersGrid: TDBGrid
      Left = 1
      Top = 1
      Width = 296
      Height = 421
      Align = alClient
      DataSource = OrdersDataSource
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnDragOver = OrdersGridDragOver
    end
  end
  object MainMenu1: TMainMenu
    Left = 40
    Top = 8
    object AddOrderMainMenu: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1079#1072#1082#1072#1079
      OnClick = AddOrderMainMenuClick
    end
    object UpdateMainMenu: TMenuItem
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      OnClick = UpdateMainMenuClick
    end
  end
  object OrdersDataSource: TDataSource
    DataSet = dm.qGetAppointableOrders
    Left = 560
    Top = 248
  end
end
