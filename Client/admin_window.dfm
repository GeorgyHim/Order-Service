object fAdminWindow: TfAdminWindow
  Left = 0
  Top = 0
  Caption = #1054#1082#1085#1086' '#1072#1076#1084#1080#1085#1080#1089#1090#1088#1072#1090#1086#1088#1072
  ClientHeight = 480
  ClientWidth = 722
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = AdminMainMenu
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object AdminTabControl: TTabControl
    Left = 0
    Top = 0
    Width = 722
    Height = 480
    Align = alClient
    Style = tsButtons
    TabOrder = 0
    Tabs.Strings = (
      #1040#1076#1084#1080#1085#1080#1089#1090#1088#1072#1090#1086#1088#1099
      #1054#1087#1077#1088#1072#1090#1086#1088#1099
      #1056#1077#1089#1090#1086#1088#1072#1085#1099
      #1047#1072#1082#1072#1079#1099
      #1044#1077#1072#1082#1090#1080#1074#1080#1088#1086#1074#1072#1085#1085#1099#1077' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1080)
    TabIndex = 0
    OnChange = AdminTabControlChange
    object AdminGrid: TDBGrid
      Left = 4
      Top = 27
      Width = 714
      Height = 400
      Align = alTop
      DataSource = dsAllAdmins
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
    object DeactivateButton: TButton
      Left = 643
      Top = 440
      Width = 75
      Height = 25
      Caption = 'Deactivate'
      TabOrder = 1
      OnClick = DeactivateButtonClick
    end
    object EditButton: TButton
      Left = 552
      Top = 440
      Width = 75
      Height = 25
      Caption = 'Edit'
      TabOrder = 2
      OnClick = EditButtonClick
    end
  end
  object AdminMainMenu: TMainMenu
    Left = 48
    Top = 200
    object CreateMainMenu: TMenuItem
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
    object MainMenuUpdate: TMenuItem
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      OnClick = MainMenuUpdateClick
    end
    object ChangeProfileMainMenu: TMenuItem
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1076#1072#1085#1085#1099#1077' '#1087#1088#1086#1092#1080#1083#1103
      OnClick = ChangeProfileMainMenuClick
    end
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
  object dsAllDeactivatedUsers: TDataSource
    DataSet = dm.qAllDeactivatedUsers
    Left = 384
    Top = 56
  end
end
