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
      Top = 24
      Width = 726
      Height = 417
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
      OnCellClick = AdminGridCellClick
      OnDrawColumnCell = AdminGridDrawColumnCell
    end
  end
  object AdminMainMenu: TMainMenu
    Left = 48
    Top = 200
    object N1: TMenuItem
      Caption = #1057#1086#1079#1076#1072#1090#1100
      object N2: TMenuItem
        Caption = #1040#1076#1084#1080#1085#1080#1089#1090#1088#1072#1090#1086#1088
        OnClick = N2Click
      end
      object N3: TMenuItem
        Caption = #1054#1087#1077#1088#1072#1090#1086#1088
      end
      object N4: TMenuItem
        Caption = #1056#1077#1089#1090#1086#1088#1072#1085
      end
    end
    object N5: TMenuItem
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
    end
  end
  object dsActiveOrders: TDataSource
    DataSet = cdsActiveOrders
    Left = 48
    Top = 136
  end
  object cdsActiveOrders: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 48
    Top = 80
    object cdsActiveOrdersid: TIntegerField
      FieldName = 'id'
      Visible = False
    end
    object cdsActiveOrdersstartTime: TDateTimeField
      DisplayLabel = #1042#1088#1077#1084#1103' '#1088#1077#1075#1080#1089#1090#1088#1072#1094#1080#1080
      FieldName = 'startTime'
    end
    object cdsActiveOrderscourierName: TWideStringField
      DisplayLabel = #1048#1084#1103' '#1082#1091#1088#1100#1077#1088#1072
      FieldName = 'courierName'
    end
    object cdsActiveOrderscourierSurname: TWideStringField
      DisplayLabel = #1060#1072#1084#1080#1083#1080#1103' '#1082#1091#1088#1100#1077#1088#1072
      FieldName = 'courierSurname'
    end
    object cdsActiveOrdersclientName: TWideStringField
      DisplayLabel = #1050#1083#1080#1077#1085#1090
      FieldName = 'clientName'
    end
    object cdsActiveOrdersaddress: TWideStringField
      DisplayLabel = #1040#1076#1088#1077#1089' '#1076#1086#1089#1090#1072#1074#1082#1080
      FieldName = 'address'
    end
    object cdsActiveOrdersis_reported: TWideStringField
      FieldName = 'is_reported'
      Visible = False
    end
  end
  object dsOrderHistory: TDataSource
    DataSet = cdsOrderHistory
    Left = 168
    Top = 136
  end
  object cdsOrderHistory: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 168
    Top = 80
    object cdsOrderHistoryid: TIntegerField
      FieldName = 'id'
      Visible = False
    end
    object cdsOrderHistoryendTime: TDateTimeField
      DisplayLabel = #1042#1088#1077#1084#1103' '#1079#1072#1074#1077#1088#1096#1077#1085#1080#1103
      FieldName = 'endTime'
    end
    object cdsOrderHistorystartTime: TDateTimeField
      DisplayLabel = #1042#1088#1077#1084#1103' '#1088#1077#1075#1080#1089#1090#1088#1072#1094#1080#1080
      FieldName = 'startTime'
    end
    object cdsOrderHistorycourierName: TWideStringField
      DisplayLabel = #1048#1084#1103' '#1082#1091#1088#1100#1077#1088#1072
      FieldName = 'courierName'
    end
    object cdsOrderHistorycourierSurname: TWideStringField
      DisplayLabel = #1060#1072#1084#1080#1083#1080#1103' '#1082#1091#1088#1100#1077#1088#1072
      FieldName = 'courierSurname'
    end
    object cdsOrderHistoryclientName: TWideStringField
      DisplayLabel = #1050#1083#1080#1077#1085#1090
      FieldName = 'clientName'
    end
    object cdsOrderHistoryaddress: TWideStringField
      DisplayLabel = #1040#1076#1088#1077#1089
      FieldName = 'address'
    end
    object cdsOrderHistoryis_reported: TWideStringField
      FieldName = 'is_reported'
      Visible = False
    end
  end
  object Timer1: TTimer
    Interval = 1
    OnTimer = Timer1Timer
    Left = 736
    Top = 216
  end
end
