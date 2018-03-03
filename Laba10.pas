unit Laba10;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.Grids, Vcl.StdCtrls;

type
  Tmode = (ordList,invoices);
  TINVOICESINF = record                   //
   orderNum: string[10];
   orderDate:TDateTime;
   cutomerReq:string[12];
   end;
    TORDERLIST = record                 //
    orderNum: string[10];
    productName: string[20];
    productQuantity: integer;
    end;
   ORDERLISTADR=^TSP2;                    //         магическое мышление
   INVOICEADR=^TSP1;                           //   магическое мышление
   TSP1 = record                           //  запись с инфой и адресом
    INF: TINVOICESINF;                     //
    ADR:INVOICEADR;                        //
    HADR:ORDERLISTADR;     //  храним ссылку на голову списка товаров
    end;

    TSP2 = record
      INF:TORDERLIST;
      ADR:ORDERLISTADR;
    end;






   TForm1 = class(TForm)
    mm1: TMainMenu;
    invoices1: TMenuItem;
    strngrd1: TStringGrid;
    btnAdd: TButton;
    procedure FormCreate(Sender: TObject);

    procedure strngrd1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnAddClick(Sender: TObject);
    procedure btnWriteClick(Sender: TObject);
    procedure invoices1Click(Sender: TObject);
    procedure priceList1Click(Sender: TObject);
//    procedure ordListCreate(I:Integer; strngrd1:TStringGrid);
 //   procedure InvoicesWrite(strngrd1:TStringGrid);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  mode:Tmode;
  Invhead, Invtemp:INVOICEADR;
  ordtemp:ORDERLISTADR;
  f: file of TINVOICESINF;
  invtemp2:INVOICEADR;
  Form1: TForm1;

implementation

{$R *.dfm}
procedure OrderWrite(strngrd1:TStringGrid);
var i:integer;
begin

strngrd1.RowCount:=2;
strngrd1.ColCount:=3;
Invtemp:=Invhead;    // head of Order
invtemp:=invtemp^.ADR;
ordtemp:=invtemp^.HADR;
strngrd1.Cells[0,0]:='Order num';
strngrd1.Cells[1,0]:='Product name';
strngrd1.Cells[2,0]:='Quantity';
  while ordtemp <> nil do
 begin
  strngrd1.Cells[0,strngrd1.RowCount-1]:=ordtemp^.INF.orderNum;
  strngrd1.Cells[1,strngrd1.RowCount-1]:=(ordtemp^.INF.productName);
  strngrd1.Cells[2,strngrd1.RowCount-1]:=IntToStr(ordtemp^.INF.productQuantity);
   strngrd1.RowCount:= strngrd1.RowCount+1;
  ordtemp:=ordtemp^.ADR;
end;
strngrd1.RowCount:= strngrd1.RowCount-1;
end;
procedure InvoiceWrite(strngrd1:TStringGrid);
var i:Integer;
begin
strngrd1.RowCount:=2;
strngrd1.ColCount:=3;
strngrd1.Cells[0,0]:='Order num';
strngrd1.Cells[1,0]:='Order date';
strngrd1.Cells[2,0]:='Customer Requisites';
 invtemp:=invhead^.ADR;

 while invtemp<>nil do
 begin
  strngrd1.Cells[0,strngrd1.RowCount-1]:=invtemp^.INF.orderNum;
  strngrd1.Cells[1,strngrd1.RowCount-1]:=DateToStr(invtemp^.INF.orderDate);
  strngrd1.Cells[2,strngrd1.RowCount-1]:=invtemp^.INF.cutomerReq;
   strngrd1.RowCount:= strngrd1.RowCount+1;
  invtemp:=invtemp^.ADR;
end;
strngrd1.RowCount:= strngrd1.RowCount-1;
end;
procedure ordListCreate(I:Integer; strngrd1:TStringGrid; ordnum:string);
  begin

    Invtemp:=Invhead;
    while (invtemp^.ADR<>nil) or  (invtemp^.INF.orderNum<>ordnum) do
    begin
    if (invtemp^.INF.orderNum=ordnum) then        Exit;

    ShowMessage(invtemp^.INF.orderNum);
    invtemp:=invtemp^.ADR;   // head of Order
    end;
                                 //Next block
    New(Invtemp^.HADR);           //create OrderList block
    Invtemp^.HADR.ADR:=nil;                     //
    ordtemp:=Invtemp^.HADR;
    ordtemp^.INF.orderNum:= InputBox('InsertNum','Please, insert num of the order','635421');
    ordtemp^.INF.productName:=InputBox
    ('InsertName','Insert Name','blinchik s vetchinoi i syrom');
    ordtemp^.INF.productQuantity:=StrToInt(InputBox('InsertQuantity','Insert Quantity','2'));
   // OrderWrite(strngrd1);
  end;

procedure TForm1.btnAddClick(Sender: TObject);
begin
  case mode of
  ordList:
    begin
     //ordListCreate(1, strngrd1);
    end;


  invoices:
  begin
  invtemp:=invhead;
  while invtemp^.ADR<>nil do
    invtemp:=invtemp^.ADR;           //scroll to free space
  New(invtemp^.ADR);         //¬ыдел€ем место в пам€ти
  invtemp:=invtemp^.ADR;
  invtemp^.ADR:=nil;
  invtemp^.INF.orderNum:=InputBox('InsertNum','Please, insert num of the order',IntToStr(Random(1000000)));
  invtemp^.INF.orderDate:=VarToDateTime(InputBox
  ('InsertDate','Insert Date','03.03.'+IntToStr(Random(2018)+1)));
  invtemp^.INF.cutomerReq:=InputBox('InsertReq','Insert Customer requisites','2281488');

  InvoiceWrite(strngrd1);
  end;

  end;


end;

procedure TForm1.btnWriteClick(Sender: TObject);
var listType: INVOICEADR;
begin
   case mode of
   invoices: InvoiceWrite(strngrd1);
   ordList: OrderWrite(strngrd1);
   end;

  end;



procedure TForm1.FormCreate(Sender: TObject);
var
  I: Integer;
begin
//mode:=invoices;

new(invhead);
invhead^.ADR:=nil;
invhead^.HADR:=nil;
invtemp:=invhead;
btnAdd.Visible:=false;

//InvoiceWrite(strngrd1);
end;

procedure TForm1.invoices1Click(Sender: TObject);
begin
mode:=invoices;
btnAdd.Visible:=True;
InvoiceWrite(strngrd1);
end;


procedure TForm1.priceList1Click(Sender: TObject);
begin
 mode:=ordList;
 btnAdd.Visible:=False;
 OrderWrite(strngrd1);
end;

procedure TForm1.strngrd1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  var i,Acol,Arow:Integer;
  var ordnum:string[10];
begin
strngrd1.MouseToCell(X,Y,Acol,Arow);
if Acol = 0 then
  begin
  ordnum:=strngrd1.Cells[Acol,Arow];
  ordListCreate(Arow,strngrd1,ordnum);
  end;
end;
end.


