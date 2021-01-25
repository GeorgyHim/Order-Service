object fConfirmOrders: TfConfirmOrders
  Left = 0
  Top = 0
  Caption = #1055#1086#1076#1090#1074#1077#1088#1076#1080#1090#1100' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1077' '#1079#1072#1082#1072#1079#1086#1074
  ClientHeight = 299
  ClientWidth = 718
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid2: TDBGrid
    Left = 0
    Top = 152
    Width = 718
    Height = 147
    Align = alBottom
    DataSource = dsConfirmed
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDragDrop = DBGrid2DragDrop
    OnDragOver = DBGrid2DragOver
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 718
    Height = 153
    Align = alTop
    DataSource = dsUnconfirmed
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnCellClick = DBGrid1CellClick
  end
  object MainMenu1: TMainMenu
    Left = 352
    Top = 8
    object confirmButton: TMenuItem
      Caption = #1055#1086#1076#1090#1074#1077#1088#1076#1080#1090#1100
      OnClick = confirmButtonClick
    end
    object requestDataButton: TMenuItem
      Caption = #1047#1072#1087#1088#1086#1089#1080#1090#1100' '#1076#1072#1085#1085#1099#1077
      Visible = False
      OnClick = requestDataButtonClick
    end
  end
  object cdsUnconfirmed: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 32
    Top = 72
    object cdsUnconfirmedid: TIntegerField
      FieldName = 'id'
      Visible = False
    end
    object cdsUnconfirmedstartTime: TDateTimeField
      DisplayLabel = #1042#1088#1077#1084#1103' '#1088#1077#1075#1080#1089#1090#1088#1072#1094#1080#1080
      FieldName = 'startTime'
    end
    object cdsUnconfirmedcourierName: TWideStringField
      DisplayLabel = #1048#1084#1103' '#1082#1091#1088#1100#1077#1088#1072
      FieldName = 'courierName'
    end
    object cdsUnconfirmedcourierSurname: TWideStringField
      DisplayLabel = #1060#1072#1084#1080#1083#1080#1103' '#1082#1091#1088#1100#1077#1088#1072
      FieldName = 'courierSurname'
    end
    object cdsUnconfirmedclient: TWideStringField
      DisplayLabel = #1050#1083#1080#1077#1085#1090
      FieldName = 'client'
    end
    object cdsUnconfirmedaddress: TWideStringField
      DisplayLabel = #1040#1076#1088#1077#1089
      FieldName = 'address'
    end
  end
  object dsUnconfirmed: TDataSource
    DataSet = cdsUnconfirmed
    Left = 112
    Top = 72
  end
  object dsConfirmed: TDataSource
    DataSet = cdsConfirmed
    Left = 208
    Top = 200
  end
  object cdsConfirmed: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 88
    Top = 208
    object cdsConfirmedid: TIntegerField
      FieldName = 'id'
      Visible = False
    end
    object cdsConfirmedstartTime: TDateTimeField
      DisplayLabel = #1042#1088#1077#1084#1103' '#1088#1077#1075#1080#1089#1090#1088#1072#1094#1080#1080
      FieldName = 'startTime'
    end
    object cdsConfirmedcourierName: TWideStringField
      DisplayLabel = #1048#1084#1103' '#1082#1091#1088#1100#1077#1088#1072
      FieldName = 'courierName'
    end
    object cdsConfirmedcourierSurname: TWideStringField
      DisplayLabel = #1060#1072#1084#1080#1083#1080#1103' '#1082#1091#1088#1100#1077#1088#1072
      FieldName = 'courierSurname'
    end
    object cdsConfirmedclient: TWideStringField
      DisplayLabel = #1050#1083#1080#1077#1085#1090
      FieldName = 'client'
    end
    object cdsConfirmedaddress: TWideStringField
      DisplayLabel = #1040#1076#1088#1077#1089
      FieldName = 'address'
    end
  end
end
