object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 367
  ClientWidth = 900
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
    Left = 8
    Top = 0
    Width = 929
    Height = 281
    ColCount = 4
    DefaultColWidth = 125
    TabOrder = 0
    OnMouseUp = strngrd1MouseUp
  end
  object btnAdd: TButton
    Left = 763
    Top = 309
    Width = 129
    Height = 50
    Caption = 'Add_new_list'
    TabOrder = 3
    OnClick = btnAddClick
  end
  object btn1: TButton
    Left = 8
    Top = 310
    Width = 121
    Height = 49
    Caption = 'Date_sort'
    TabOrder = 4
    OnClick = btn1Click
  end
  object btn2: TButton
    Left = 416
    Top = 309
    Width = 129
    Height = 50
    Caption = 'Search products'
    TabOrder = 2
    OnClick = btn2Click
  end
  object btn3: TButton
    Left = 208
    Top = 309
    Width = 97
    Height = 50
    Caption = #1069#1082#1089#1087#1086#1088#1090' .txt'
    TabOrder = 1
    OnClick = btn3Click
  end
  object mm1: TMainMenu
    Top = 8
    object PriceList1: TMenuItem
      Caption = 'PriceList'
      OnClick = PriceList1Click
    end
    object OrdList1: TMenuItem
      Caption = 'OrdList'
      OnClick = OrdList1Click
    end
    object save1: TMenuItem
      Caption = 'Save'
      OnClick = save1Click
    end
    object read1: TMenuItem
      Caption = 'Read'
      OnClick = read1Click
    end
  end
end
