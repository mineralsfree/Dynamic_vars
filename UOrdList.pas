unit UOrdList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils,
   System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   Vcl.Menus, Vcl.Grids, Vcl.StdCtrls;
  type
   ProductlistINF = record
   orderNum: string[10];
   productName:string[30];
   productQuantity:Integer;
   end;
   ProdListADR=^TSP2;
     TSP2 = record
      INF:ProductlistINF;
      ADR:ProdListADR;
    end;
   TOrdINF = record                   //
   orderNum: string[10];
   orderDate:TDateTime;
   cutomerReq:string[20];
   end;
    OrdListADR=^TSP1;
    TSP1 = record                           //  запись с инфой и адресом
    INF: TOrdINF;                     //
    ADR:OrdListADR;                        //
    HADR:ProdListADR;     //  храним ссылку на голову списка товаров
    end;
     procedure DeleteOrdList(const head:OrdListADR; Ordcode:string);
    function ObjAdrOfcode(const head: OrdListADR; name: string):OrdListADR;
    procedure readOrdlist(const Head:OrdListADR; Filename:string);
    procedure OrdInsert(const head:OrdListADR);
    procedure OrdWrite(head:OrdListADR; strngrd1:TStringGrid);
    procedure saveOrdList(const Head:OrdListADR);
implementation
procedure OrdWrite(head:OrdListADR; strngrd1:TStringGrid);

var i:Integer;
temp:OrdListADR;
begin
temp:=head^.ADR;
strngrd1.RowCount:=2;
strngrd1.ColCount:=7;
strngrd1.Cells[0,0]:='Order num';
strngrd1.Cells[1,0]:='Order date';
strngrd1.Cells[2,0]:='Customer Requisites';
strngrd1.Cells[3,0]:='Add product';
strngrd1.Cells[4,0]:='watch product';
strngrd1.Cells[5,0]:='make naklodnaya';
strngrd1.Cells[6,0]:='Delete';
 while temp<>nil do
 begin
  strngrd1.Cells[0,strngrd1.RowCount-1]:=temp^.INF.orderNum;
  strngrd1.Cells[1,strngrd1.RowCount-1]:=DateToStr(temp^.INF.orderDate);
  strngrd1.Cells[2,strngrd1.RowCount-1]:=temp^.INF.cutomerReq;
  strngrd1.Cells[3,strngrd1.RowCount-1]:='+';
  strngrd1.Cells[4,strngrd1.RowCount-1]:='watch';
  strngrd1.Cells[5,strngrd1.RowCount-1]:='great again';
  strngrd1.Cells[6,strngrd1.RowCount-1]:='-';
   strngrd1.RowCount:= strngrd1.RowCount+1;
  temp:=temp^.ADR;

end;
strngrd1.RowCount:= strngrd1.RowCount-1;
end;

procedure OrdInsert(const head:OrdListADR);
var
  temp:OrdListADR;
  kek:Integer;
  OrderNum:string;
  begin
  kek:=1000;
  temp:=Head;
  while temp^.ADR<>nil do
  begin
  temp:=temp^.ADR;
  inc(kek);
  end;
  //scroll to free space

  OrderNum:=InputBox('InsertNum','Please, insert num of the order',IntToStr(kek));
  if  ObjAdrOfcode(head, Ordernum)=nil then
    begin
    New(temp^.ADR);
    temp:=temp^.ADR;
    New(temp^.HADR);
    temp^.HADR.ADR:=nil;
    temp^.ADR:=nil;
    temp^.INF.orderNum:=OrderNum;
    temp^.INF.orderDate:=VarToDateTime(InputBox
    ('InsertDate','Insert Date','03.03.'+IntToStr(2000+Random(18))));
    temp^.INF.cutomerReq:=InputBox('InsertReq','Insert Customer requisites','+375296836944');
    end
    else
    begin
      ShowMessage('kek');
    end;

  end;

  procedure readOrdlist(const Head:OrdListADR; Filename:string);
   var
   Temp:ordlistADR;
   Info:TOrdINF;
   TInfo:TordINF;
   f: file of TOrdINF;
   begin
    AssignFile(f,FileName);
   if fileExists(FileName) then
     begin
     Reset(f);          //!!!!!! smeni na reset chtob sochranit'
     Head^.ADR:=nil;
     temp:=Head;
     while not(Eof(f)) do
     begin
       read(f,TInfo);
       new(Temp^.adr);
       Temp:=Temp^.ADR;
       New(temp^.HADR);
       temp^.HADR.ADR:=nil;
       Temp.ADR:=nil;
       temp.INF:=TInfo;
     end;
     end
     else
     begin
       Rewrite(f);
       ShowMessage('No such file or directiory');
       readOrdlist(Head,Filename);
     end;
     close(f)
   end;

   procedure saveOrdList(const Head:OrdListADR);
   var
   Temp:OrdlistADR;
   f: file of TOrdINF;
   begin
   AssignFile(f,'OrdList.brakmen');
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
   procedure DeleteOrdList(const head:OrdListADR; Ordcode:string);
   var
    temp: OrdListADR;
    temp2:OrdListADR;
    begin
     temp:=head;
    while (temp^.ADR<>nil) do
    begin
       temp2:=temp^.ADR;
    if (temp2^.INF.orderNum = Ordcode) then
    begin
      temp^.ADR:=temp2^.adr;
      Dispose(temp2);
    end
    else
    temp:=temp^.ADR;
    end;
    end;
function ObjAdrOfcode(const head: OrdListADR; name: string):OrdListADR;
  var
  temp: OrdListADR;
  begin
    temp := head;
    Result := nil;
    while(temp <> nil) do
    begin
      if temp^.INF.orderNum = name then
        Result:=temp;
      temp := temp^.Adr;
    end;
  end;

end.
