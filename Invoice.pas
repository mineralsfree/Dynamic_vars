unit Invoice;

interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms,
   Vcl.Dialogs, Vcl.Menus, Vcl.Grids, Vcl.StdCtrls, UOrdList,UPriceList;
     procedure makeNaklodnayaGreatAgain
    (const OrdListHead:ordListADR; const PriceHead:PriceListADR;
    strngrd1:TStringGrid; ordnum:string);
    procedure invoiceSave(const OrdHead:OrdListADR; const Pricehead:PriceListADR;
     ordnum:string; location:string);
implementation
procedure makeNaklodnayaGreatAgain
(const OrdListHead:ordListADR; const PriceHead:PriceListADR; strngrd1:TStringGrid;
 ordnum:string);
    var OrdListtemp:OrdListADR;
    Ptemp:prodlistadr;
    currprice,fullprice:Currency;
    begin
      fullprice:=0;
      strngrd1.RowCount:=2;
      strngrd1.ColCount:=3;
      strngrd1.Cells[0,0]:=ordNum;
      strngrd1.Cells[1,0]:='Quantity';
      OrdListTemp:=OrdListHead;
          while (OrdListtemp.INF.orderNum<>StrToInt(ordNum)) do
          OrdListTemp:=OrdListTemp^.ADR;   // head of Order

      Ptemp:=OrdListTemp^.HADR;
      Ptemp:=Ptemp^.ADR;
        while Ptemp <> nil do
       begin
       currprice:=getprice(PriceHead,Ptemp^.INF.productName)*
        Ptemp^.INF.productQuantity;
        strngrd1.Cells[0,strngrd1.RowCount-1]:=Ptemp^.INF.productName;
        strngrd1.Cells[1,strngrd1.RowCount-1]:=IntToStr(Ptemp^.INF.productQuantity);
        strngrd1.Cells[2,strngrd1.RowCount-1]:=CurrToStr(currprice);
        strngrd1.RowCount:= strngrd1.RowCount+1;
        Ptemp:=Ptemp^.ADR;
        fullprice:=fullprice+currprice;
      end;
        strngrd1.RowCount:= strngrd1.RowCount-1;
      strngrd1.Cells[2,0]:='price: '+CurrToStr(fullprice);
    end;
    procedure invoiceSave(const OrdHead:OrdListADR; const Pricehead:PriceListADR;
     ordnum:string; location:string);
     var fullprice, currprice:Currency;
    OrdListtemp:OrdListADR;
    Ptemp,temp:prodlistadr;
    f: TextFile;
    begin
    fullprice:=0;
    OrdListTemp:=OrdHead;
    while (OrdListtemp.INF.orderNum<>StrToInt(ordNum)) do
      OrdListTemp:=OrdListTemp^.ADR;

    Ptemp:=OrdListTemp^.HADR;
    Ptemp:=Ptemp^.ADR;
    while Ptemp <> nil do
    begin
      currprice:=getprice(PriceHead,Ptemp^.INF.productName)*
      Ptemp^.INF.productQuantity;
      Ptemp:=Ptemp^.ADR;
      fullprice:=fullprice+currprice;
    end;
       AssignFile(f,location);
       Rewrite(f);
       write(f,'Номер заказа:' + ordnum+#$9);
       writeln(f,'Полная стоимость:'+ CurrToStr(fullprice));
       OrdListTemp:=OrdHead;
    while (OrdListtemp.INF.orderNum<>StrToInt(ordNum)) do
      OrdListTemp:=OrdListTemp^.ADR;
      Ptemp:=OrdListTemp^.HADR;
        write(f,'Наименование'+#$9);
        write(f,'Количество'+#$9);
        writeln(f,'Стоимость'+#$9);
    if Ptemp.ADR<>nil then
     begin
     temp:=Ptemp.ADR;
     while Temp<> nil do
       begin
         write(f,#$9 + Temp.INF.productName+#$9+#$9+#$9);
         write(f,IntToStr(temp.INF.productQuantity)+#$9+#$9+#$9);
         writeln(f,CurrToStr(getprice(PriceHead,temp.INF.productName)*
        temp.INF.productQuantity));
         Temp:=Temp^.ADR;
       end;
     end;
     Close(f);
    end;

end.
