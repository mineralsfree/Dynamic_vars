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

    procedure writePriceList (const head:PriceListADR; Grid:TStringGrid);
    procedure SavePricelist(const Head:PriceListADR; Filename:string);
    procedure readPriceList(const Head:PriceListADR; Filename:string);
  implementation
   procedure SavePricelist(const Head:PriceListADR; Filename:string);
   var
   Temp:PricelistADR;
   Info:PricelistINF;

   TInfo:PricelistINF;
   f: file of PriceListINF;
   begin
   AssignFile(f,FileName);
   if fileExists(FileName) then
      begin
     Reset(f);
     Head^.ADR:=nil;
     temp:=Head;
     while not(Eof) do
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

   procedure readPriceList(const Head:PriceListADR; Filename:string);
   var
   Temp:PricelistADR;
   f: file of PriceListINF;
   begin
   AssignFile(f,'priceList.brakhmen');
   Rewrite(f);
   //Seek(f,Filesize(f));
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
     temp:=head^.ADR;
     while temp^.ADR<>nil do
      temp:=temp^.ADR;
     temp.INF.productCode:=
     InputBox('Enter product code','product code:',IntToStr(random(20000)+2));
     temp.INF.productName:=InputBox
     ('Enter product name' ,'Product name:', 'Shit from ass');
     temp.INF.productPrice:=StrToInt
     (InputBox('Enter price for 1 unit','Price: ','3,54'));

   end;

    procedure writePriceList (const head:PriceListADR; Grid:TStringGrid);
    var i,j: Integer;
    temp:PriceListADR;
    begin
    Grid.Cells[0,0]:='Product Code';
    Grid.Cells[1,0]:='Product Name';
    Grid.Cells[2,0]:='Product Price';
    Grid.Cells[3,0]:='Add product';
    Grid.Cells[4,0]:='watch product';
    temp:=head^.adr;
    while temp^.ADR<>nil do
    begin

    end;
    end;

end.
