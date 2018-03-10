unit OnCreate;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.Grids, Vcl.StdCtrls,UPriceList;

type
  Tmode = (ordList,invoices,priceList,naclodnaya);
  TINVOICESINF = record                   //
   orderNum: string[10];
   orderDate:TDateTime;
   cutomerReq:string[12];
   end;
    TORDERLIST = record                 //
    orderNum: string[10];
    productName: string[30];
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
    strngrd1: TStringGrid;
    btnAdd: TButton;
    mm1: TMainMenu;
    Listselection1: TMenuItem;
    save1: TMenuItem;
    stth1: TMenuItem;
    PriceList1: TMenuItem;
    OrdList1: TMenuItem;
    Invoice1: TMenuItem;
    Naklodnaya1: TMenuItem;
    btn1: TButton;
    procedure FormCreate(Sender: TObject);

    procedure strngrd1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnAddClick(Sender: TObject);
    procedure btnWriteClick(Sender: TObject);
    procedure priceList1Click(Sender: TObject);
    procedure Invoice1Click(Sender: TObject);
    procedure save1Click(Sender: TObject);
    procedure OrdList1Click(Sender: TObject);
    procedure btn1Click(Sender: TObject);


//    procedure ordListCreate(I:Integer; strngrd1:TStringGrid);
 //   procedure InvoicesWrite(strngrd1:TStringGrid);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  t:boolean;
  mode:Tmode;
  Invhead, Invtemp:INVOICEADR;
   ordtemp:ORDERLISTADR;
  f: file of TINVOICESINF;
  invtemp2:INVOICEADR;
  Form1: TForm1;
  var Pricehead:PricelistADR;
implementation

{$R *.dfm}
procedure OrderWrite(n:Integer; strngrd1:TStringGrid; ordnum:string);
var i:Integer;
begin
strngrd1.RowCount:=2;
strngrd1.ColCount:=3;
strngrd1.Cells[0,0]:='Order num';
strngrd1.Cells[1,0]:='Product name';
strngrd1.Cells[2,0]:='Quantity';
 Invtemp:=Invhead;
    for i := 1 to n do
    begin
    //ShowMessage(invtemp^.INF.orderNum);
    invtemp:=invtemp^.ADR;   // head of Order
    end;
ordtemp:=invtemp^.HADR;
ordtemp:=ordtemp^.ADR;
  while ordtemp <> nil do
 begin
  strngrd1.Cells[0,strngrd1.RowCount-1]:=ordNum;
  strngrd1.Cells[1,strngrd1.RowCount-1]:=(ordtemp^.INF.productName);
  strngrd1.Cells[2,strngrd1.RowCount-1]:=IntToStr(ordtemp^.INF.productQuantity);
   strngrd1.RowCount:= strngrd1.RowCount+1;
  ordtemp:=ordtemp^.ADR;
end;
strngrd1.RowCount:= strngrd1.RowCount-1;
end;

procedure ordListCreate(n:Integer; strngrd1:TStringGrid; ordnum:string);
var i:Integer;

  begin

  Invtemp:=Invhead;
    invtemp:=invtemp^.ADR;
    while (invtemp^.INF.orderNum<>ordnum) do
      invtemp:=invtemp^.ADR;   // head of Order
    ordtemp:=Invtemp^.HADR;
    while ordTemp^.ADR<>nil do
      ordTemp:=ordTemp^.ADR;


    New(ordtemp^.ADR);
    ordtemp:=ordtemp^.ADR;
    ordtemp^.ADR:=nil;
    ordtemp^.INF.orderNum:= ordnum;
    ordtemp^.INF.productName:=InputBox
    ('InsertName','Insert Name','blinchik s vetchinoi i syrom');
    ordtemp^.INF.productQuantity:=StrToInt(InputBox('InsertQuantity','Insert Quantity','2'));

    //orderwrite(n,strngrd1,ordnum);
   // OrderWrite(strngrd1);
  end;



procedure InvoiceWrite(strngrd1:TStringGrid);
var i:Integer;
begin
strngrd1.RowCount:=2;
strngrd1.ColCount:=5;
strngrd1.Cells[0,0]:='Order num';
strngrd1.Cells[1,0]:='Order date';
strngrd1.Cells[2,0]:='Customer Requisites';
strngrd1.Cells[3,0]:='Add product';
strngrd1.Cells[4,0]:='watch product';
 invtemp:=invhead^.ADR;

 while invtemp<>nil do
 begin
  strngrd1.Cells[0,strngrd1.RowCount-1]:=invtemp^.INF.orderNum;
  strngrd1.Cells[1,strngrd1.RowCount-1]:=DateToStr(invtemp^.INF.orderDate);
  strngrd1.Cells[2,strngrd1.RowCount-1]:=invtemp^.INF.cutomerReq;
  strngrd1.Cells[3,strngrd1.RowCount-1]:='+';
  strngrd1.Cells[4,strngrd1.RowCount-1]:='watch';
   // strngrd1.colWidth[4]:= 50;
   strngrd1.RowCount:= strngrd1.RowCount+1;
  invtemp:=invtemp^.ADR;

end;
strngrd1.RowCount:= strngrd1.RowCount-1;
end;


procedure TForm1.btn1Click(Sender: TObject);
var num:Integer;
begin
  num:=strtoint(inputbox('','','21'));
  deletePriceList(Pricehead,num);
  writePriceList(Pricehead,strngrd1);

end;

procedure TForm1.btnAddClick(Sender: TObject);

begin

if mode = priceList then
  begin

  insertPriceList(Pricehead,Random(200));
  writePriceList(Pricehead,strngrd1);

  end
else
  begin
  invtemp:=invhead;
  while invtemp^.ADR<>nil do
    invtemp:=invtemp^.ADR;           //scroll to free space
  New(Invtemp^.ADR);
         // //////////////////
  //ordhead:=Invtemp^.HADR;   //  //////////////////
  invtemp:=invtemp^.ADR;
  New(Invtemp^.HADR);
  Invtemp^.HADR.ADR:=nil;
  invtemp^.ADR:=nil;

  invtemp^.INF.orderNum:=InputBox('InsertNum','Please, insert num of the order',IntToStr(Random(1000000)));
  invtemp^.INF.orderDate:=VarToDateTime(InputBox
  ('InsertDate','Insert Date','03.03.'+IntToStr(Random(2018)+1)));
  invtemp^.INF.cutomerReq:=InputBox('InsertReq','Insert Customer requisites','2281488');
  InvoiceWrite(strngrd1);
  end;
end;

procedure TForm1.btnWriteClick(Sender: TObject);
var listType: INVOICEADR;
begin
   case mode of
   invoices: InvoiceWrite(strngrd1);
   //ordList: OrderWrite(strngrd1);
   end;

  end;



procedure TForm1.FormCreate(Sender: TObject);
var
  I: Integer;
begin
//mode:=invoices;
t:=True;
new(invhead);
invhead^.ADR:=nil;
invhead^.HADR:=nil;      //////////////////////////
invtemp:=invhead;
//btnAdd.Visible:=false;
InvoiceWrite(strngrd1)

//InvoiceWrite(strngrd1);
end;

procedure TForm1.Invoice1Click(Sender: TObject);
begin
mode:=invoices;
btnAdd.Visible:=True;
InvoiceWrite(strngrd1);
end;

procedure TForm1.OrdList1Click(Sender: TObject);
begin
mode:=ordList;
InvoiceWrite(strngrd1);

end;

procedure TForm1.priceList1Click(Sender: TObject);
begin
 mode:=priceList;
 btnAdd.Visible:=True;
 new(Pricehead);
 Pricehead^.ADR:=nil;
 readPriceList(Pricehead,'priceList.brakhmen');
 writePriceList(Pricehead,strngrd1);

 //OrderWrite(strngrd1);
end;

procedure TForm1.save1Click(Sender: TObject);
begin
savePricelist(Pricehead,'priceList.brakhmen');
ShowMessage('Saved');
end;

procedure TForm1.strngrd1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  var i,Acol,Arow:Integer;
  var ordnum:integer;
begin
strngrd1.MouseToCell(X,Y,Acol,Arow);
case mode of
  priceList:
  begin
   if Acol = 3 then
   ordnum:=strtoint(strngrd1.Cells[0,Arow]);
   deletePriceList(Pricehead,ordnum);
   writePriceList(Pricehead,strngrd1);
  end;

 { ordList:
  begin
if Acol = 3 then
  begin
  ordnum:=strngrd1.Cells[0,Arow];
  ordListCreate(Arow,strngrd1,ordnum);
  end;
if  Acol = 4 then
  begin
  ordnum:=Trim(strngrd1.Cells[0,Arow]);
  orderwrite(Arow,strngrd1,ordnum);
  end;
  end;  }
end;
end;
end.

{
  сделать две доп колонки для заказа - добавить и посмотреть товары
  соответственно изменить процедуру отрисовки списка товаров



}
