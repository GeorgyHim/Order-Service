object fCourierList: TfCourierList
  Left = 0
  Top = 0
  Caption = #1042#1099#1073#1088#1072#1090#1100' '#1082#1091#1088#1100#1077#1088#1072
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
  object MainMenu1: TMainMenu
    Left = 544
    Top = 216
    object N1: TMenuItem
      Caption = #1042#1099#1073#1088#1072#1090#1100
      OnClick = N1Click
    end
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 464
    Top = 216
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 392
    Top = 216
    object ClientDataSet1id: TIntegerField
      FieldName = 'id'
      Visible = False
    end
    object ClientDataSet1name: TWideStringField
      DisplayLabel = #1048#1084#1103
      FieldName = 'name'
    end
    object ClientDataSet1surname: TWideStringField
      DisplayLabel = #1060#1072#1084#1080#1083#1080#1103
      FieldName = 'surname'
    end
    object ClientDataSet1phone_number: TWideStringField
      DisplayLabel = #1058#1077#1083#1077#1092#1086#1085
      FieldName = 'phone_number'
    end
    object ClientDataSet1email: TWideStringField
      DisplayLabel = 'Email'
      FieldName = 'email'
    end
    object ClientDataSet1transport_type: TWideStringField
      DisplayLabel = #1058#1080#1087' '#1090#1088#1072#1085#1089#1087#1086#1088#1090#1072
      FieldName = 'transport_type'
    end
  end
end
