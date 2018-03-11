unit UProductList;

interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.Grids,
  Vcl.StdCtrls,UOrdList,UPriceList;
       procedure Deleteproduct(const mainhead:OrdListADR;orderq:Integer; productname:string;n:Integer);
  procedure saveProductList(const mainHead:OrdListADR;Filename:string);
 procedure readproductlist(const mainHead:OrdListADR;Filename:string);
  procedure ProductsWrite(const OrdListHead:ordListADR; n:Integer; strngrd1:TStringGrid; ordnum:string);
 procedure InsertProductList(const OrdListHead:ordListADR; const Pricehead:PriceListADR; n:Integer; strngrd1:TStringGrid; ordnum:string);
implementation


procedure InsertProductList(const OrdListHead:ordListADR; const Pricehead:PriceListADR; n:Integer; strngrd1:TStringGrid; ordnum:string);
var
  OrdListTemp:ordListADR;    //    //  ordListCreate
  Ptemp:ProdListADR;         //
  name:string;
  begin

   OrdListTemp:=OrdListHead^.ADR;
    while (OrdListTemp^.INF.orderNum<>ordnum) do
      OrdListTemp:=OrdListTemp^.ADR;   // head of Order
    Ptemp:=OrdListTemp^.HADR;
    while PTemp^.ADR<>nil do
      PTemp:=PTemp^.ADR;
    name:=InputBox('InsertName','Insert Name','Blin');
    if ObjAdrOfname(PriceHead, name)<>nil then
      begin
      New(Ptemp^.ADR);
      Ptemp:=Ptemp^.ADR;
      Ptemp^.ADR:=nil;
      Ptemp^.INF.orderNum:= ordnum;
      Ptemp^.INF.productName:=name;
      Ptemp^.INF.productQuantity:=StrToInt(InputBox
       ('InsertQuantity','Insert Quantity',IntToStr(Random(10)+1)));
      end
    else
      begin
      ShowMessage('Add such a product into PriceList');
      end;

  end;
  procedure ProductsWrite(const OrdListHead:ordListADR; n:Integer; strngrd1:TStringGrid; ordnum:string);
  var i:Integer;
  OrdListTemp:ordListADR;
  Ptemp:prodlistadr;
  begin
  strngrd1.RowCount:=2;
  strngrd1.ColCount:=4;
  strngrd1.Cells[0,0]:='Order num';
  strngrd1.Cells[1,0]:='Product name';
  strngrd1.Cells[2,0]:='Quantity';
   strngrd1.Cells[3,0]:='Delete';
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
    strngrd1.Cells[3,strngrd1.RowCount-1]:='-';
     strngrd1.RowCount:= strngrd1.RowCount+1;
  Ptemp:=Ptemp^.ADR;
  end;
  strngrd1.RowCount:= strngrd1.RowCount-1;
  end;
  procedure readproductlist(const mainHead:OrdListADR;Filename:string);
    var
   mainTemp:ordlistADR;
   temp:ProdListADR;
   TInfo:ProductlistINF;
   f: file of ProductlistINF;
   begin
    assignFile(f,'ProductList.brakhmen');
   if fileExists('ProductList.brakhmen') then
     begin
     Reset(f);
     //mainHead^.ADR:=nil;
     maintemp:=mainHead^.ADR;
     {temp:=maintemp^.HADR;
          temp^.ADR:=nil;
               temp:=temp^.ADR;}
      if not(Eof(f)) then read(f,TInfo)
      else exit;
     while not(Eof(f)) do
      begin
     temp:=maintemp^.HADR;
     //temp^.ADR:=nil;
     //temp:=temp^.ADR;

     while  TInfo.orderNum= maintemp.INF.orderNum do
     begin
       new(Temp^.adr);
       Temp:=Temp^.ADR;
       Temp.ADR:=nil;
       temp.INF:=TInfo;
      if not(Eof(f)) then read(f,TInfo)
      else exit;

     end;
      maintemp:=mainTemp^.ADR;
     end;
     end
     else
     begin
       Rewrite(f);
       ShowMessage('No such file or directiory');
       readproductlist(mainHead,Filename);
     end;
     close(f)
   end;
  procedure saveProductList(const mainHead:OrdListADR;Filename:string);
   var
   Maintemp:OrdListADR;
   Temp:ProdlistADR;
   f: file of ProductlistINF;
   begin
   AssignFile(f,'ProductList.brakhmen');
   Rewrite(f);
   Seek(f,Filesize(f));
     if mainHead.ADR<>nil then
       begin
       maintemp:=mainHead.ADR;
       while mainTemp<> nil do
         begin
           if Maintemp^.HADR.ADR<>nil then
           begin
           temp:=maintemp^.HADR.ADR;
           while Temp<> nil do
             begin
               write(f,Temp.INF);
               Temp:=Temp^.ADR;
             end;
           end;                                 {write(f,Temp.INF); }
           mainTemp:=mainTemp^.ADR;

       end;
     Close(f);
     end;
   end;

   procedure Deleteproduct(const mainhead:OrdListADR;orderq:Integer; productname:string;n:Integer);
    var
    OrdListTemp:ordListADR;
    temp:ProdListADR;
    temp2:ProdListADR;
    i:integer;
    begin
     OrdListTemp:=mainhead;
      for i := 1 to n do
      begin
      OrdListTemp:=OrdListTemp^.ADR;   // head of Order
      end;
      temp:=OrdListTemp^.HADR;
    while (temp^.ADR<>nil) do
    begin
       temp2:=temp^.ADR;
    if (temp2^.INF.productQuantity = orderq) and (temp2^.INF.productName=productname)then
    begin
      temp^.ADR:=temp2^.adr;
      Dispose(temp2);
      Exit;
    end
    else
    temp:=temp^.ADR;
    end;
    end;
    function getPrice(const head:PriceListADR; name:string):Integer;
    var temp:PriceListADR;
    begin
      temp:=ObjAdrOfname(head,name);
      result:=temp^.INF.productPrice;
    end;
end.


