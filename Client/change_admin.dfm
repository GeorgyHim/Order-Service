object fChangeAdmin: TfChangeAdmin
  Left = 0
  Top = 0
  Caption = 'Change admin'
  ClientHeight = 113
  ClientWidth = 230
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
  object LoginLabel: TLabel
    Left = 16
    Top = 16
    Width = 39
    Height = 20
    Caption = 'Login'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object LoginEdit: TEdit
    Left = 88
    Top = 19
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object OKButton: TButton
    Left = 16
    Top = 64
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 1
    OnClick = OKButtonClick
  end
  object CancelButton: TButton
    Left = 134
    Top = 64
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = CancelButtonClick
  end
end
