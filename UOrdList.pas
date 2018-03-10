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
   cutomerReq:string[12];
   end;
    OrdListADR=^TSP1;
    TSP1 = record                           //  ������ � ����� � �������
    INF: TOrdINF;                     //
    ADR:OrdListADR;                        //
    HADR:ProdListADR;     //  ������ ������ �� ������ ������ �������
    end;
procedure OrdWrite(head:OrdListADR; strngrd1:TStringGrid);
implementation
procedure OrdWrite(head:OrdListADR; strngrd1:TStringGrid);

var i:Integer;
temp:OrdListADR;
begin
temp:=head^.ADR;
strngrd1.RowCount:=2;
strngrd1.ColCount:=5;
strngrd1.Cells[0,0]:='Order num';
strngrd1.Cells[1,0]:='Order date';
strngrd1.Cells[2,0]:='Customer Requisites';
strngrd1.Cells[3,0]:='Add product';
strngrd1.Cells[4,0]:='watch product';


 while temp<>nil do
 begin
  strngrd1.Cells[0,strngrd1.RowCount-1]:=temp^.INF.orderNum;
  strngrd1.Cells[1,strngrd1.RowCount-1]:=DateToStr(temp^.INF.orderDate);
  strngrd1.Cells[2,strngrd1.RowCount-1]:=temp^.INF.cutomerReq;
  strngrd1.Cells[3,strngrd1.RowCount-1]:='+';
  strngrd1.Cells[4,strngrd1.RowCount-1]:='watch';
   // strngrd1.colWidth[4]:= 50;
   strngrd1.RowCount:= strngrd1.RowCount+1;
  temp:=temp^.ADR;

end;
strngrd1.RowCount:= strngrd1.RowCount-1;
end;
end.
