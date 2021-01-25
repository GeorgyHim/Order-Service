object fTest: TfTest
  Left = 0
  Top = 0
  Caption = 'Test'
  ClientHeight = 299
  ClientWidth = 635
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
    Left = 48
    Top = 37
    Width = 25
    Height = 13
    Caption = 'Login'
  end
  object AskCourierOrdersButton: TButton
    Left = 256
    Top = 32
    Width = 129
    Height = 25
    Caption = 'Ask courier orders'
    TabOrder = 0
    OnClick = AskCourierOrdersButtonClick
  end
  object loginEdit: TEdit
    Left = 104
    Top = 34
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'loginEdit'
  end
end
