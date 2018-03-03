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
    btnWrite: TButton;
    procedure FormCreate(Sender: TObject);

    procedure strngrd1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnAddClick(Sender: TObject);
    procedure btnWriteClick(Sender: TObject);
    procedure invoices1Click(Sender: TObject);
    procedure priceList1Click(Sender: TObject);
 //   procedure InvoicesWrite(strngrd1:TStringGrid);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  mode:Tmode;
  Invhead, Invtemp:INVOICEADR;
  ordhead,ordtemp:ORDERLISTADR;
  f: file of TINVOICESINF;
  invtemp2:INVOICEADR;
  Form1: TForm1;

implementation

{$R *.dfm}
procedure OrderWrite(strngrd1:TStringGrid);
begin
strngrd1.RowCount:=2;
strngrd1.ColCount:=3;
ordtemp:=invhead^.HADR;

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
end;
procedure InvoiceWrite(strngrd1:TStringGrid);
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
end;

procedure TForm1.btnAddClick(Sender: TObject);
begin
  case mode of
  ordList:
    begin
    ordtemp:=invhead.HADR;
    while ordtemp^.ADR<>nil do
      ordtemp:=ordtemp^.ADR;           //scroll to free space
    New(ordtemp^.ADR);         //Выделяем место в памяти
    ordtemp:=ordtemp^.ADR;
    ordtemp^.ADR:=nil;
    ordtemp^.INF.orderNum:= InputBox('InsertNum','Please, insert num of the order','635421');
    ordtemp^.INF.productName:=InputBox
    ('InsertName','Insert Name','blinchik s vetchinoi i syrom');
    ordtemp^.INF.productQuantity:=StrToInt(InputBox('InsertReq','Insert Customer requisites','2281488'));
    btnWrite.Visible:=True;
    end;


  invoices:
  begin
  invtemp:=invhead;
  while invtemp^.ADR<>nil do
    invtemp:=invtemp^.ADR;           //scroll to free space
  New(invtemp^.ADR);         //Выделяем место в памяти
  invtemp:=invtemp^.ADR;
  invtemp^.ADR:=nil;
  invtemp^.INF.orderNum:=InputBox('InsertNum','Please, insert num of the order','635421');
  invtemp^.INF.orderDate:=VarToDateTime(InputBox
  ('InsertDate','Insert Date','03.03.2018'));
  invtemp^.INF.cutomerReq:=InputBox('InsertReq','Insert Customer requisites','2281488');
  btnWrite.Visible:=True;
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
btnWrite.Visible:=False;
new(invhead);
invhead^.ADR:=nil;
invhead^.HADR:=nil;
invtemp:=invhead;
new(ordhead);
ordhead^.ADR:=nil;
ordtemp:=ordhead;
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
 btnAdd.Visible:=True;
 OrderWrite(strngrd1);
end;

procedure TForm1.strngrd1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  var i,Acol,Arow:Integer;
  var value: string;

begin
strngrd1.MouseToCell(X,Y,Acol,Arow);
//invtemp:=invhead;
  New(invtemp^.ADR);         //Выделяем место в памяти
  invtemp:=invtemp^.ADR;
  invtemp^.ADR:=nil;
value:=InputBox('Insert string','pls insert data','kek');
invtemp^.INF.orderNum:=value;
strngrd1.cells[Acol,Arow]:=invtemp^.INF.orderNum;


end;


end.


