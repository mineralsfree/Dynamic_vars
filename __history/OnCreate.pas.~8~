unit OnCreate;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms,
   Vcl.Dialogs, Vcl.Menus, Vcl.Grids, Vcl.StdCtrls,UPriceList,
   UOrdList,UProductList;

type
  Tmode = (ordList,Ords,priceList,naclodnaya);
   TForm1 = class(TForm)
    strngrd1: TStringGrid;
    btnAdd: TButton;
    mm1: TMainMenu;
    Listselection1: TMenuItem;
    save1: TMenuItem;
    stth1: TMenuItem;
    PriceList1: TMenuItem;
    OrdList1: TMenuItem;
    Naklodnaya1: TMenuItem;
    btn1: TButton;
    procedure FormCreate(Sender: TObject);

    procedure strngrd1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnAddClick(Sender: TObject);
    procedure priceList1Click(Sender: TObject);
    procedure Ord1Click(Sender: TObject);
    procedure save1Click(Sender: TObject);
    procedure OrdList1Click(Sender: TObject);
    procedure btn1Click(Sender: TObject);


//    procedure ordListCreate(I:Integer; strngrd1:TStringGrid);
 //   procedure OrdsWrite(strngrd1:TStringGrid);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  mode:Tmode;
  Invhead, Invtemp:OrdlistADR;
  Form1: TForm1;
  Pricehead:PricelistADR;
implementation

{$R *.dfm}








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
  OrdWrite(invhead, strngrd1);
  end;
end;





procedure TForm1.FormCreate(Sender: TObject);
var
  I: Integer;
begin
new(invhead);
invhead^.ADR:=nil;
invhead^.HADR:=nil;      //////////////////////////
invtemp:=invhead;
//btnAdd.Visible:=false;
OrdWrite(invhead, strngrd1);
end;

procedure TForm1.Ord1Click(Sender: TObject);
begin
mode:=Ords;
btnAdd.Visible:=True;
OrdWrite(invhead, strngrd1);
end;

procedure TForm1.OrdList1Click(Sender: TObject);
begin
mode:=ordList;
OrdWrite(invhead, strngrd1);
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
  var sordnum:string;
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

  ordList:
  begin
if Acol = 3 then
  begin
  sordnum:=strngrd1.Cells[0,Arow];
  ReadProductList(invhead,Arow,strngrd1,sordnum);
  end;
if  Acol = 4 then
  begin
  sordnum:=Trim(strngrd1.Cells[0,Arow]);
  ProductsWrite(invhead,Arow,strngrd1,sordnum);
  end;
  end;
end;
end;
end.

{
  сделать две доп колонки для заказа - добавить и посмотреть товары
  соответственно изменить процедуру отрисовки списка товаров



}

