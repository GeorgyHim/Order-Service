object fWindow: TfWindow
  Left = 0
  Top = 0
  Caption = #1054#1082#1085#1086' '#1086#1087#1077#1088#1072#1090#1086#1088#1072
  ClientHeight = 480
  ClientWidth = 734
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object TabControl1: TTabControl
    Left = 0
    Top = 0
    Width = 734
    Height = 480
    Align = alClient
    TabOrder = 0
    Tabs.Strings = (
      #1040#1082#1090#1080#1074#1085#1099#1077' '#1079#1072#1082#1072#1079#1099
      #1048#1089#1090#1086#1088#1080#1103' '#1079#1072#1082#1072#1079#1086#1074)
    TabIndex = 0
    OnChange = TabControl1Change
    object DBGrid1: TDBGrid
      Left = 4
      Top = 24
      Width = 726
      Height = 265
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
      OnCellClick = DBGrid1CellClick
      OnDrawColumnCell = DBGrid1DrawColumnCell
    end
    object DBGrid2: TDBGrid
      Left = 4
      Top = 288
      Width = 726
      Height = 188
      Align = alBottom
      DataSource = dsOrderList
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
  end
  object MainMenu1: TMainMenu
    Left = 48
    Top = 200
    object updateDataButton: TMenuItem
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1076#1072#1085#1085#1099#1077
      OnClick = updateDataButtonClick
    end
    object N1: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      object nClient: TMenuItem
        Caption = #1050#1083#1080#1077#1085#1090#1072
        OnClick = nClientClick
      end
      object nAddress: TMenuItem
        Caption = #1040#1076#1088#1077#1089' '#1082#1083#1080#1077#1085#1090#1072
        OnClick = nAddressClick
      end
      object nCourier: TMenuItem
        Caption = #1050#1091#1088#1100#1077#1088#1072
        OnClick = nCourierClick
      end
      object nOrder: TMenuItem
        Caption = #1047#1072#1082#1072#1079
        OnClick = nOrderClick
      end
    end
    object N2: TMenuItem
      Caption = #1055#1086#1076#1090#1074#1077#1088#1078#1076#1077#1085#1080#1077' '#1079#1072#1082#1072#1079#1086#1074
      OnClick = N2Click
    end
    object N3: TMenuItem
      Caption = #1058#1077#1089#1090
      Visible = False
      OnClick = N3Click
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
  object dsOrderList: TDataSource
    DataSet = cdsOrderList
    Left = 168
    Top = 360
  end
  object cdsOrderList: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 56
    Top = 360
    object cdsOrderListpositionName: TWideStringField
      FieldName = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1090#1086#1074#1072#1088#1072
    end
    object cdsOrderListprice: TBCDField
      DisplayLabel = #1062#1077#1085#1072
      FieldName = 'price'
    end
  end
end
