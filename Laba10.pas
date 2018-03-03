unit Laba10;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.Grids, Vcl.StdCtrls;

type
  Tmode = (priceList,invoices);
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
    priceList1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure okay(Sender: TObject);
    procedure strngrd1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnAddClick(Sender: TObject);
    procedure btnWriteClick(Sender: TObject);
    procedure invoices1Click(Sender: TObject);
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
procedure InvoicesWrite(strngrd1:TStringGrid);
begin
strngrd1.RowCount:=2;
strngrd1.ColCount:=3;
 Invtemp:=invhead^.ADR;

  while invtemp <> nil do
 begin
  strngrd1.Cells[0,strngrd1.RowCount-1]:=invtemp^.INF.orderNum;
  strngrd1.Cells[1,strngrd1.RowCount-1]:=DateToStr(invtemp^.INF.orderDate);
  strngrd1.Cells[2,strngrd1.RowCount-1]:=invtemp^.INF.cutomerReq;
   strngrd1.RowCount:= strngrd1.RowCount+1;
  invtemp:=invtemp^.ADR;
end;
end;
procedure OrderWrite(strngrd1:TStringGrid);
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

procedure TForm1.btnWriteClick(Sender: TObject);
var listType: INVOICEADR;
begin
   InvoicesWrite(strngrd1);
  end;


procedure TForm1.FormCreate(Sender: TObject);
var
  I: Integer;
begin
btnWrite.Visible:=False;
new(invhead);
invhead^.ADR:=nil;
invtemp:=invhead;
OrderWrite(strngrd1);
end;

procedure TForm1.invoices1Click(Sender: TObject);
begin
mode:=invoices;
InvoicesWrite(strngrd1);
end;

procedure TForm1.okay(Sender: TObject);
var
  I: Integer;
begin



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


end.invinvtemp


