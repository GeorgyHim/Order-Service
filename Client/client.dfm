object fClient: TfClient
  Left = 0
  Top = 0
  Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1082#1083#1080#1077#1085#1090#1072
  ClientHeight = 141
  ClientWidth = 318
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
    Left = 81
    Top = 24
    Width = 19
    Height = 13
    Caption = #1048#1084#1103
  end
  object Label2: TLabel
    Left = 16
    Top = 56
    Width = 84
    Height = 13
    Caption = #1053#1086#1084#1077#1088' '#1090#1077#1083#1077#1092#1086#1085#1072
  end
  object NameEdit: TEdit
    Left = 136
    Top = 21
    Width = 169
    Height = 21
    TabOrder = 0
    Text = #1048#1084#1103
  end
  object PhoneEdit: TEdit
    Left = 136
    Top = 53
    Width = 169
    Height = 21
    TabOrder = 1
    Text = #1058#1077#1083#1077#1092#1086#1085
  end
  object AddButton: TButton
    Left = 230
    Top = 104
    Width = 75
    Height = 25
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    TabOrder = 2
    OnClick = AddButtonClick
  end
end
