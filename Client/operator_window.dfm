object fOperatorWindow: TfOperatorWindow
  Left = 0
  Top = 0
  Caption = #1054#1082#1085#1086' '#1086#1087#1077#1088#1072#1090#1086#1088#1072
  ClientHeight = 452
  ClientWidth = 733
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = OperatorMainMenu
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object OperatorTabControl: TTabControl
    Left = 0
    Top = 0
    Width = 733
    Height = 452
    Align = alClient
    TabOrder = 0
    Tabs.Strings = (
      #1040#1082#1090#1080#1074#1085#1099#1077' '#1079#1072#1082#1072#1079#1099
      #1047#1072#1074#1077#1088#1096#1105#1085#1085#1099#1077' '#1079#1072#1082#1072#1079#1099
      #1054#1090#1084#1077#1085#1105#1085#1085#1099#1077' '#1079#1072#1082#1072#1079#1099)
    TabIndex = 0
    OnChange = OperatorTabControlChange
    object OperatorGrid: TDBGrid
      Left = 4
      Top = 24
      Width = 725
      Height = 321
      Align = alTop
      DataSource = dsActiveOrders
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnCellClick = OperatorGridCellClick
      OnDrawColumnCell = OperatorGridDrawColumnCell
    end
    object OrderInfoMemo: TMemo
      Left = 4
      Top = 351
      Width = 726
      Height = 82
      Color = clMaroon
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clAqua
      Font.Height = 22
      Font.Name = 'Tahoma'
      Font.Style = []
      Lines.Strings = (
        'OrderInfoMemo')
      ParentFont = False
      TabOrder = 1
    end
  end
  object OperatorMainMenu: TMainMenu
    Left = 40
    Top = 200
    object AddOrderMainMenu: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1079#1072#1082#1072#1079
      OnClick = AddOrderMainMenuClick
    end
    object UpdateMainMenu: TMenuItem
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      OnClick = UpdateMainMenuClick
    end
  end
  object dsActiveOrders: TDataSource
    Left = 40
    Top = 40
  end
  object dsCompletedOrders: TDataSource
    Left = 160
    Top = 40
  end
  object dsCanceledOrders: TDataSource
    Left = 272
    Top = 40
  end
end
