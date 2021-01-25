object fAddPosition: TfAddPosition
  Left = 0
  Top = 0
  Caption = #1044#1086#1073#1072#1074#1080#1090' '#1087#1086#1079#1080#1094#1080#1102
  ClientHeight = 156
  ClientWidth = 334
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
    Left = 32
    Top = 40
    Width = 73
    Height = 13
    Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
  end
  object Label2: TLabel
    Left = 74
    Top = 72
    Width = 26
    Height = 13
    Caption = #1062#1077#1085#1072
  end
  object nameEdit: TEdit
    Left = 136
    Top = 37
    Width = 169
    Height = 21
    TabOrder = 0
    Text = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
  end
  object priceEdit: TEdit
    Left = 136
    Top = 69
    Width = 169
    Height = 21
    TabOrder = 1
    Text = '0.00'
  end
  object addButton: TButton
    Left = 230
    Top = 112
    Width = 75
    Height = 25
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    TabOrder = 2
    OnClick = addButtonClick
  end
end
