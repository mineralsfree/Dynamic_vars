object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 377
  ClientWidth = 680
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = mm1
  OldCreateOrder = False
  OnClick = okay
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object strngrd1: TStringGrid
    Left = 16
    Top = 48
    Width = 609
    Height = 225
    ColCount = 4
    DefaultColWidth = 150
    TabOrder = 0
    OnMouseUp = strngrd1MouseUp
  end
  object mm1: TMainMenu
    object invoices1: TMenuItem
      Caption = 'invoices'
    end
  end
end
