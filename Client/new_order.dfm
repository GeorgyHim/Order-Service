object fNewOrder: TfNewOrder
  Left = 0
  Top = 0
  Caption = 'New order'
  ClientHeight = 212
  ClientWidth = 263
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object PhoneNumberLabel: TLabel
    Left = 8
    Top = 13
    Width = 104
    Height = 20
    Caption = 'Phone number'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object OrderInfoLabel: TLabel
    Left = 8
    Top = 53
    Width = 41
    Height = 20
    Caption = 'Order'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 20
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object PhoneNumberEdit: TEdit
    Left = 128
    Top = 16
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object OKButton: TButton
    Left = 8
    Top = 168
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 2
    OnClick = OKButtonClick
  end
  object CancelButton: TButton
    Left = 179
    Top = 168
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 3
    OnClick = CancelButtonClick
  end
  object OrderEdit: TRichEdit
    Left = 69
    Top = 56
    Width = 185
    Height = 89
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    Zoom = 100
  end
end
