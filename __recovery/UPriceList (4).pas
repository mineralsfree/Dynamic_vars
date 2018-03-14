unit UPriceList;

interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.Grids, Vcl.StdCtrls;
 type
  PricelistINF = record
   productCode: Integer;
   productName:string[30];
   productPrice:Integer;
   end;
   PriceListADR=^TSP3;
    TSP3= record
    INF: PricelistINF;
    ADR: PriceListADR;
    end;
    procedure editPricelist(const head:PriceListADR; productcode:Integer; Fieldnum:Integer);
    function getPrice(const head:PriceListADR; name:string):Integer;
    function ObjAdrOfcode(const head: PriceListADR; name: string):PriceListADR;
    procedure deletePriceList(const head:PriceListADR; productcode:Integer);
    function ObjAdrOfname(const head: PriceListADR; name: string):PriceListADR;
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

   if fileExists('Filename') then
     begin
       AssignFile(f,'Filename');
     Reset(f);
     Head^.ADR:=nil;
     temp:=Head;
     while not(Eof(f)) do
     begin
       read(f,TInfo);
       new(Temp^.adr);
       Temp:=Temp^.ADR;
       Temp.ADR:=nil;
       temp.INF:=TInfo;
     end;
     end
     else
     begin
       Rewrite(f);
       ShowMessage('No such file or directiory');
       readPricelist(Head,'priceList.brakhmen');
     end;
     close(f)
   end;

   procedure savePriceList(const Head:PriceListADR; Filename:string);
   var
   Temp:PricelistADR;
   f: file of PriceListINF;
   begin
   AssignFile(f,'Filename');
   Rewrite(f);
   Seek(f,Filesize(f));
   if Head.ADR<>nil then
     begin
     temp:=Head.ADR;
     while Temp<> nil do
       begin
         write(f,Temp.INF);
         Temp:=Temp^.ADR;
       end;
     end;
   Close(f);
   end;

   procedure insertPriceList(const head:PriceListADR; productCode:Integer);
   var
   temp:PriceListADR;
   temp2:PriceListADR;
   name:string;
   kek:Integer;
   code:string;
   begin
      kek:=10000001;
     temp:=head;
     while temp^.ADR<>nil do
     begin
     temp:=temp^.ADR;
     Inc(kek);
     end;
     code:=InputBox
     ('Enter product code','product code:',IntToStr(kek));
     name:=InputBox
     ('Enter product name' ,'Product name:', 'Xiaomi redmi bomjbook '+IntToStr(kek-10000000)+' pro');
     if ((objadrofname(head, name)=nil)
     and  (objadrofcode(head, code)=nil))
     and  (name<>'')
     and (code<>'')
     then
     begin
      New(temp^.ADR);
      temp:=temp^.ADR;
      temp^.ADR:=nil;
      temp.INF.productName:=name;
      temp.INF.productCode:=StrToInt(code);
     end
     else
     begin
      ShowMessage('Error!' +#10#13+ 'Redeclaration of product or same productCode');
      Exit;
     end;
     temp.INF.productPrice:=StrToInt(Abs(InputBox('Enter price for 1 unit','Price: ',inttostr(1000))));

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
    Grid.Cells[0,Grid.RowCount-1]:=IntToStr(Temp.INF.productCode);
    Grid.Cells[1,Grid.RowCount-1]:=Temp.INF.productName;
    Grid.Cells[2,Grid.RowCount-1]:=IntToStr(Temp.INF.productPrice);
    Grid.Cells[3,Grid.RowCount-1]:='-';
    Grid.RowCount:= Grid.RowCount+1;
    temp:=temp^.ADR;
    end;
    Grid.RowCount:= Grid.RowCount-1;
    end;

    function ObjAdrOfname(const head: PriceListADR; name: string):PriceListADR;
  var
  temp: PricelistADR;
  begin
    temp := head;
    Result := nil;
    while(temp <> nil) do
    begin
      if temp^.INF.productName = name then
        Result:=temp;
      temp := temp^.Adr;
    end;
  end;

    function ObjAdrOfcode(const head: PriceListADR; name: string):PriceListADR;
  var
  temp: PricelistADR;
  begin
    temp := head;
    Result := nil;
    while(temp <> nil) do
    begin
      if temp^.INF.productCode = StrToInt(name) then
        Result:=temp;
      temp := temp^.Adr;
    end;
  end;

    procedure deletePriceList(const head:PriceListADR; productcode:Integer);
    var
    temp: PriceListADR;
    temp2:PriceListADR;
    begin
     temp:=head;
    while (temp^.ADR<>nil) do
    begin
       temp2:=temp^.ADR;
    if (temp2^.INF.productCode = productcode) then
    begin
      temp^.ADR:=temp2^.adr;
      Dispose(temp2);
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

procedure editPricelist(const head:PriceListADR; productcode:Integer; Fieldnum:Integer);
    var temp:PriceListADR;
  begin
  temp:=head^.ADR;
  while (temp<>nil) do
  begin
    if temp^.INF.productCode =productcode then
    begin
      case Fieldnum of
        0:temp.INF.productCode:=StrToInt(InputBox('Input changes','Input changes',IntToStr(temp.INF.productCode)));
        1:temp.INF.productName:=InputBox('Input changes','Input changes',temp.INF.productName);
        2:temp.INF.productPrice:=StrToInt(InputBox('','',IntToStr(temp.INF.productPrice)));
      end;
    end;
    temp:=temp^.ADR
  end;
  end;
end.
