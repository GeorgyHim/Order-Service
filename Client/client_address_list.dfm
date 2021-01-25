object fClientAddress: TfClientAddress
  Left = 0
  Top = 0
  Caption = #1042#1099#1073#1086#1088' '#1072#1076#1088#1077#1089#1072' '#1082#1083#1080#1077#1085#1090#1072
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 635
    Height = 299
    Align = alClient
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 488
    Top = 216
  end
  object MainMenu1: TMainMenu
    Left = 576
    Top = 216
    object N1: TMenuItem
      Caption = #1042#1099#1073#1086#1088
      OnClick = N1Click
    end
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 408
    Top = 216
    object ClientDataSet1id: TIntegerField
      FieldName = 'id'
      Visible = False
    end
    object ClientDataSet1clientId: TIntegerField
      FieldName = 'clientId'
      Visible = False
    end
    object ClientDataSet1address: TWideStringField
      DisplayLabel = #1040#1076#1088#1077#1089
      FieldName = 'address'
    end
  end
end
