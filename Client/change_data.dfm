object fChangeData: TfChangeData
  Left = 0
  Top = 0
  Caption = 'Change data'
  ClientHeight = 212
  ClientWidth = 231
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object SurnameLabel: TLabel
    Left = 8
    Top = 29
    Width = 63
    Height = 20
    Caption = 'Surname'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object NameLabel: TLabel
    Left = 8
    Top = 66
    Width = 41
    Height = 20
    Caption = 'Name'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object PatronymicLabel: TLabel
    Left = 8
    Top = 106
    Width = 79
    Height = 20
    Caption = 'Patronymic'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object WrongPasswordLabel: TLabel
    Left = 76
    Top = 142
    Width = 5
    Height = 20
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object SurnameEdit: TEdit
    Left = 102
    Top = 32
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object NameEdit: TEdit
    Left = 102
    Top = 69
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object PatronymicEdit: TEdit
    Left = 102
    Top = 109
    Width = 121
    Height = 21
    TabOrder = 2
  end
  object OKButton: TButton
    Left = 8
    Top = 168
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 3
    OnClick = OKButtonClick
  end
  object CancelButton: TButton
    Left = 148
    Top = 168
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 4
    OnClick = CancelButtonClick
  end
end
