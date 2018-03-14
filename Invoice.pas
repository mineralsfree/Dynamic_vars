unit Invoice;

interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms,
   Vcl.Dialogs, Vcl.Menus, Vcl.Grids, Vcl.StdCtrls, UOrdList,UPriceList;
type InvoiceINF = record
   productCode: string[10];
   productQuantity:string[30];
   productsumPrice:Currency;
   end;
   InvoiceADR=^TSP3;
    TSP3= record
    INF: InvoiceINF;
    ADR: InvoiceADR;
    end;
    procedure writeinvoiceList (const head:InvoiceADR; Grid:TStringGrid);
     procedure makeNaklodnayaGreatAgain
    (const OrdListHead:ordListADR; const PriceHead:PriceListADR;
    n:Integer; strngrd1:TStringGrid; ordnum:string);

implementation
 procedure writeinvoiceList (const head:InvoiceADR; Grid:TStringGrid);
    var i,j: Integer;
    temp:InvoiceADR;
    begin
    Grid.RowCount:=2;
    Grid.ColCount:=4;
    Grid.Cells[0,0]:='Product Code';
    Grid.Cells[1,0]:='Product Name';
    Grid.Cells[2,0]:='Product Price';
    Grid.Cells[3,0]:='Delete';
    temp:=head^.ADR;
    while temp<>nil do
    begin
    Grid.Cells[0,Grid.RowCount-1]:=Temp.INF.productCode;
    Grid.Cells[1,Grid.RowCount-1]:=Temp.INF.productQuantity;
    Grid.Cells[2,Grid.RowCount-1]:=CurrToStr(Temp.INF.productsumPrice);
    Grid.Cells[3,Grid.RowCount-1]:='-';
    Grid.RowCount:= Grid.RowCount+1;
    temp:=temp^.ADR;
    end;
    Grid.RowCount:= Grid.RowCount-1;
    end;


    procedure makeNaklodnayaGreatAgain
    (const OrdListHead:ordListADR; const PriceHead:PriceListADR;
    n:Integer; strngrd1:TStringGrid; ordnum:string);
    var
    OrdListtemp:OrdListADR;
    i:Integer;
    Ptemp:prodlistadr;
    currprice:Currency;
    fullprice:Currency;
    begin
      fullprice:=0;
      strngrd1.RowCount:=2;
      strngrd1.ColCount:=3;
      strngrd1.Cells[0,0]:='Order num: '+ ordNum;
      strngrd1.Cells[1,0]:='Quantity';
      OrdListTemp:=OrdListHead;
          for i := 1 to n do
          begin
          OrdListTemp:=OrdListTemp^.ADR;   // head of Order
          end;
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

end.
