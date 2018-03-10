unit UProductList;

interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.Grids,
  Vcl.StdCtrls,UOrdList;



  procedure ProductsWrite(const OrdListHead:ordListADR; n:Integer; strngrd1:TStringGrid; ordnum:string);
 procedure ReadProductList(const OrdListHead:ordListADR;n:Integer; strngrd1:TStringGrid; ordnum:string);
implementation


procedure ReadProductList(const OrdListHead:ordListADR;n:Integer; strngrd1:TStringGrid; ordnum:string);
var
  OrdListTemp:ordListADR;    //    //  ordListCreate
  Ptemp:ProdListADR;         //

  begin

  OrdListTemp:=OrdListHead;
    OrdListTemp:=OrdListTemp^.ADR;
    while (OrdListTemp^.INF.orderNum<>ordnum) do
      OrdListTemp:=OrdListTemp^.ADR;   // head of Order
    Ptemp:=OrdListTemp^.HADR;
    while PTemp^.ADR<>nil do
      PTemp:=PTemp^.ADR;


    New(Ptemp^.ADR);
    Ptemp:=Ptemp^.ADR;
    Ptemp^.ADR:=nil;
    Ptemp^.INF.orderNum:= ordnum;
    Ptemp^.INF.productName:=InputBox
    ('InsertName','Insert Name','blinchik s vetchinoi i syrom');
    Ptemp^.INF.productQuantity:=StrToInt(InputBox('InsertQuantity','Insert Quantity','2'));

    //orderwrite(n,strngrd1,ordnum);
   // OrderWrite(strngrd1);
  end;
  procedure ProductsWrite(const OrdListHead:ordListADR; n:Integer; strngrd1:TStringGrid; ordnum:string);
  var i:Integer;
  OrdListTemp:ordListADR;

  Ptemp:prodlistadr;
  begin
  strngrd1.RowCount:=2;
  strngrd1.ColCount:=3;
  strngrd1.Cells[0,0]:='Order num';
  strngrd1.Cells[1,0]:='Product name';
  strngrd1.Cells[2,0]:='Quantity';
  OrdListTemp:=OrdListHead;
      for i := 1 to n do
      begin
      OrdListTemp:=OrdListTemp^.ADR;   // head of Order
      end;
  Ptemp:=OrdListTemp^.HADR;
  Ptemp:=Ptemp^.ADR;
    while Ptemp <> nil do
   begin
    strngrd1.Cells[0,strngrd1.RowCount-1]:=ordNum;
    strngrd1.Cells[1,strngrd1.RowCount-1]:=(Ptemp^.INF.productName);
    strngrd1.Cells[2,strngrd1.RowCount-1]:=IntToStr(Ptemp^.INF.productQuantity);
     strngrd1.RowCount:= strngrd1.RowCount+1;
  Ptemp:=Ptemp^.ADR;
  end;
  strngrd1.RowCount:= strngrd1.RowCount-1;
  end;

end.


