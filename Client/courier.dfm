object fCourier: TfCourier
  Left = 0
  Top = 0
  Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1082#1091#1088#1100#1077#1088#1072
  ClientHeight = 237
  ClientWidth = 359
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 74
    Top = 32
    Width = 19
    Height = 13
    Caption = #1048#1084#1103
  end
  object Label2: TLabel
    Left = 49
    Top = 59
    Width = 44
    Height = 13
    Caption = #1060#1072#1084#1080#1083#1080#1103
  end
  object Label3: TLabel
    Left = 49
    Top = 88
    Width = 44
    Height = 13
    Caption = #1058#1077#1083#1077#1092#1086#1085
  end
  object Label4: TLabel
    Left = 69
    Top = 115
    Width = 24
    Height = 13
    Caption = 'Email'
  end
  object Label5: TLabel
    Left = 40
    Top = 142
    Width = 53
    Height = 13
    Caption = #1058#1088#1072#1085#1089#1087#1086#1088#1090
  end
  object NameEdit: TEdit
    Left = 144
    Top = 29
    Width = 185
    Height = 21
    TabOrder = 0
    Text = #1048#1084#1103
  end
  object surnameEdit: TEdit
    Left = 144
    Top = 56
    Width = 185
    Height = 21
    TabOrder = 1
    Text = #1060#1072#1084#1080#1083#1080#1103
  end
  object phoneEdit: TEdit
    Left = 144
    Top = 85
    Width = 185
    Height = 21
    TabOrder = 2
    Text = #1058#1077#1083#1077#1092#1086#1085
  end
  object emailEdit: TEdit
    Left = 144
    Top = 112
    Width = 185
    Height = 21
    TabOrder = 3
    Text = 'Email'
  end
  object transportEdit: TEdit
    Left = 144
    Top = 139
    Width = 185
    Height = 21
    TabOrder = 4
    Text = #1058#1088#1072#1085#1089#1087#1086#1088#1090
  end
  object addButton: TButton
    Left = 254
    Top = 184
    Width = 75
    Height = 25
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    TabOrder = 5
    OnClick = addButtonClick
  end
end
