object fAddress: TfAddress
  Left = 0
  Top = 0
  Caption = 'fAddress'
  ClientHeight = 176
  ClientWidth = 341
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
    Left = 21
    Top = 40
    Width = 77
    Height = 13
    Caption = #1042#1099#1073#1086#1088' '#1082#1083#1080#1077#1085#1090#1072
  end
  object Label2: TLabel
    Left = 22
    Top = 80
    Width = 76
    Height = 13
    Caption = #1040#1076#1088#1077#1089' '#1082#1083#1080#1077#1085#1090#1072
  end
  object clientEdit: TEdit
    Left = 136
    Top = 37
    Width = 161
    Height = 21
    TabOrder = 0
    Text = #1042#1099#1073#1086#1088' '#1082#1083#1080#1077#1085#1090#1072
  end
  object addressEdit: TEdit
    Left = 136
    Top = 77
    Width = 161
    Height = 21
    TabOrder = 1
    Text = #1040#1076#1088#1077#1089
  end
  object chooseButton: TButton
    Left = 270
    Top = 35
    Width = 27
    Height = 25
    Caption = '...'
    TabOrder = 2
    OnClick = chooseButtonClick
  end
  object addButton: TButton
    Left = 222
    Top = 128
    Width = 75
    Height = 25
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    TabOrder = 3
    OnClick = addButtonClick
  end
end
