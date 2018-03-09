unit UPriceList;

interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.Grids, Vcl.StdCtrls;
 type
  PricelistINF = record
   productCode: string[10];
   productName:string[30];
   productPrice:Integer;
   end;
   PriceListADR=^TSP3;
    TSP3= record
    INF: PricelistINF;
    ADR: PriceListADR;
    end;
     procedure deletePriceList(const head:PriceListADR; productcode:Integer; grd:TStringGrid;arow:Integer);

    procedure insertPriceList(const head:PriceListADR; productCode:Integer);
    procedure writePriceList (const head:PriceListADR; Grid:TStringGrid);
    procedure SavePricelist(const Head:PriceListADR; Filename:string);
    procedure readPriceList(const Head:PriceListADR; Filename:string);
  implementation
   procedure readPricelist(const Head:PriceListADR; Filename:string);
   var
   Temp:PricelistADR;
   Info:PricelistINF;

   TInfo:PricelistINF;
   f: file of PriceListINF;
   begin

   if fileExists(FileName) then
     begin
       AssignFile(f,FileName);

     Reset(f);
     Head^.ADR:=nil;
     temp:=Head;
     while not(Eof(f)) do
     begin
       read(f,TInfo);
       new(Temp^.adr);
       Temp:=Temp^.ADR;
       temp.INF:=TInfo;
       Temp.ADR:=nil;

     end;
     end
     else
     begin
       Rewrite(f);
       ShowMessage('No such file or directiory')
     end;
     close(f)
   end;

   procedure savePriceList(const Head:PriceListADR; Filename:string);
   var
   Temp:PricelistADR;
   f: file of PriceListINF;
   begin
   AssignFile(f,'priceList.brakhmen');
   Rewrite(f);
   Seek(f,Filesize(f));
   temp:=Head.ADR;
   while Temp<> nil do
   begin
     write(f,Temp.INF);
     Temp:=Temp^.ADR;
   end;
   Close(f);
   end;

   procedure insertPriceList(const head:PriceListADR; productCode:Integer);
   var
   temp:PriceListADR;
   content:PricelistINF;
   begin
     temp:=head;
     while temp^.ADR<>nil do
      temp:=temp^.ADR;

      New(temp^.ADR);
      temp:=temp^.ADR;
      temp^.ADR:=nil;
     temp.INF.productCode:=
     InputBox('Enter product code','product code:',IntToStr(random(20000)+2));
     temp.INF.productName:=InputBox
     ('Enter product name' ,'Product name:', 'Shit from ass');
     temp.INF.productPrice:=StrToInt
     (InputBox('Enter price for 1 unit','Price: ','354'));
     temp^.ADR:=nil;
   end;

    procedure writePriceList (const head:PriceListADR; Grid:TStringGrid);
    var i,j: Integer;
    temp:PriceListADR;
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
    Grid.Cells[1,Grid.RowCount-1]:=Temp.INF.productName;
    Grid.Cells[2,Grid.RowCount-1]:=IntToStr(Temp.INF.productPrice);
    Grid.Cells[3,Grid.RowCount-1]:='-';
    Grid.RowCount:= Grid.RowCount+1;
    temp:=temp^.ADR;
    end;
    Grid.RowCount:= Grid.RowCount-1;
    end;
    procedure deletePriceList(const head:PriceListADR; productcode:Integer; grd:TStringGrid;arow:Integer);
    var
    temp: PriceListADR;
    reserve:PriceListADR;
    begin
    temp:=head;
    while (temp^.ADR<>nil) do
    begin
        reserve:=temp^.ADR;
    if (reserve^.INF.productCode = IntToStr(productcode)) then
    begin
      temp^.ADR:=reserve.adr;
      Dispose(reserve);
      grd.Cells[0,arow]:='';
      grd.Cells[1,arow]:='';
      grd.Cells[2,arow]:='';
      //grd.RowCount:=grd.RowCount-1;
      exit;
    end;
    temp:=reserve^.ADR;

    writePriceList(head, grd);
    end;
    end;


end.
