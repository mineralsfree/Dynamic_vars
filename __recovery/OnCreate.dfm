object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 367
  ClientWidth = 805
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = mm1
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object strngrd1: TStringGrid
    Left = 16
    Top = 48
    Width = 793
    Height = 153
    ColCount = 4
    DefaultColWidth = 150
    TabOrder = 0
    OnMouseUp = strngrd1MouseUp
  end
  object btnAdd: TButton
    Left = 472
    Top = 279
    Width = 129
    Height = 50
    Caption = 'Add_new_list'
    TabOrder = 2
    OnClick = btnAddClick
  end
  object btn1: TButton
    Left = 224
    Top = 256
    Width = 75
    Height = 25
    Caption = 'delete'
    TabOrder = 1
    OnClick = btn1Click
  end
  object mm1: TMainMenu
    Top = 8
    object Listselection1: TMenuItem
      Caption = 'List selection'
      object PriceList1: TMenuItem
        Caption = 'PriceList'
        OnClick = PriceList1Click
      end
      object OrdList1: TMenuItem
        Caption = 'OrdList'
        OnClick = OrdList1Click
      end
      object Invoice1: TMenuItem
        Caption = 'Invoice'
        OnClick = Invoice1Click
      end
      object Naklodnaya1: TMenuItem
        Caption = 'Naklodnaya'
      end
    end
    object save1: TMenuItem
      Caption = 'Save'
      OnClick = save1Click
    end
    object stth1: TMenuItem
      Caption = 'stth'
    end
  end
end