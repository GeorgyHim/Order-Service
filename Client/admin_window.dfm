object fAdminWindow: TfAdminWindow
  Left = 0
  Top = 0
  Caption = #1054#1082#1085#1086' '#1072#1076#1084#1080#1085#1080#1089#1090#1088#1072#1090#1086#1088#1072
  ClientHeight = 480
  ClientWidth = 734
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = AdminMainMenu
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object AdminTabControl: TTabControl
    Left = 0
    Top = 0
    Width = 734
    Height = 480
    Align = alClient
    Style = tsButtons
    TabOrder = 0
    Tabs.Strings = (
      #1040#1076#1084#1080#1085#1080#1089#1090#1088#1072#1090#1086#1088#1099
      #1054#1087#1077#1088#1072#1090#1086#1088#1099
      #1056#1077#1089#1090#1086#1088#1072#1085#1099
      #1047#1072#1082#1072#1079#1099)
    TabIndex = 0
    OnChange = AdminTabControlChange
    object AdminGrid: TDBGrid
      Left = 4
      Top = 27
      Width = 726
      Height = 361
      Align = alTop
      DataSource = dsAllAdmins
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnCellClick = AdminGridCellClick
    end
  end
  object AdminMainMenu: TMainMenu
    Left = 48
    Top = 200
    object CreateMenu: TMenuItem
      Caption = #1057#1086#1079#1076#1072#1090#1100
      object CreateAdmin: TMenuItem
        Caption = #1040#1076#1084#1080#1085#1080#1089#1090#1088#1072#1090#1086#1088
        OnClick = CreateAdminClick
      end
      object CreateOperator: TMenuItem
        Caption = #1054#1087#1077#1088#1072#1090#1086#1088
        OnClick = CreateOperatorClick
      end
      object CreateRestaurant: TMenuItem
        Caption = #1056#1077#1089#1090#1086#1088#1072#1085
        OnClick = CreateRestaurantClick
      end
    end
    object Update: TMenuItem
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      OnClick = UpdateClick
    end
  end
  object Timer1: TTimer
    Interval = 1
    OnTimer = Timer1Timer
    Left = 736
    Top = 216
  end
  object dsAllAdmins: TDataSource
    DataSet = dm.qAllAdmins
    Left = 32
    Top = 56
  end
  object dsAllOperators: TDataSource
    DataSet = dm.qAllOperators
    Left = 120
    Top = 32
  end
  object dsAllRestaurants: TDataSource
    DataSet = dm.qAllRestaurants
    Left = 192
    Top = 56
  end
  object dsAllOrders: TDataSource
    DataSet = dm.qAllOrders
    Left = 256
    Top = 32
  end
end
