object fOrder: TfOrder
  Left = 0
  Top = 0
  Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1079#1072#1082#1072#1079
  ClientHeight = 357
  ClientWidth = 517
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 48
    Top = 112
    Width = 37
    Height = 13
    Caption = #1050#1091#1088#1100#1077#1088
  end
  object Label2: TLabel
    Left = 54
    Top = 82
    Width = 31
    Height = 13
    Caption = #1040#1076#1088#1077#1089
  end
  object Label3: TLabel
    Left = 48
    Top = 49
    Width = 37
    Height = 13
    Caption = #1050#1083#1080#1077#1085#1090
  end
  object courierEdit: TEdit
    Left = 112
    Top = 109
    Width = 161
    Height = 21
    TabOrder = 0
    Text = #1042#1099#1073#1088#1072#1090#1100' '#1082#1091#1088#1100#1077#1088#1072
  end
  object addressEdit: TEdit
    Left = 112
    Top = 80
    Width = 161
    Height = 21
    TabOrder = 1
    Text = #1042#1099#1073#1088#1072#1090#1100' '#1072#1076#1088#1077#1089
  end
  object chooseCourier: TButton
    Left = 248
    Top = 107
    Width = 25
    Height = 25
    Caption = '...'
    TabOrder = 2
    OnClick = chooseCourierClick
  end
  object chooseAddress: TButton
    Left = 248
    Top = 77
    Width = 25
    Height = 25
    Caption = '...'
    TabOrder = 3
    OnClick = chooseAddressClick
  end
  object orderMemo: TMemo
    Left = 320
    Top = 37
    Width = 169
    Height = 292
    TabOrder = 4
  end
  object addPositionButton: TButton
    Left = 160
    Top = 152
    Width = 113
    Height = 25
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1087#1086#1079#1080#1094#1080#1102
    TabOrder = 5
    OnClick = addPositionButtonClick
  end
  object approveOrderButton: TButton
    Left = 136
    Top = 304
    Width = 145
    Height = 25
    Caption = #1055#1086#1076#1090#1074#1077#1088#1076#1080#1090#1100' '#1079#1072#1082#1072#1079
    TabOrder = 6
    OnClick = approveOrderButtonClick
  end
  object clientEdit: TEdit
    Left = 112
    Top = 48
    Width = 161
    Height = 21
    TabOrder = 7
    Text = #1042#1099#1073#1088#1072#1090#1100' '#1082#1083#1080#1077#1085#1090#1072
  end
  object chooseClientButton: TButton
    Left = 248
    Top = 46
    Width = 25
    Height = 25
    Caption = '...'
    TabOrder = 8
    OnClick = chooseClientButtonClick
  end
end
