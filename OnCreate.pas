unit OnCreate;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms,
   Vcl.Dialogs, Vcl.Menus, Vcl.Grids, Vcl.StdCtrls,UPriceList,
   UOrdList,UProductList,Invoice;
type
  Tmode = (ordList,priceList,naclodnaya);
   TForm1 = class(TForm)
    strngrd1: TStringGrid;
    btnAdd: TButton;
    mm1: TMainMenu;
    save1: TMenuItem;
    PriceList1: TMenuItem;
    OrdList1: TMenuItem;
    btn1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure strngrd1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnAddClick(Sender: TObject);
    procedure priceList1Click(Sender: TObject);

    procedure save1Click(Sender: TObject);
    procedure OrdList1Click(Sender: TObject);
    procedure btn1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  mode:Tmode;
  OrderHead, Invtemp:OrdlistADR;
  Form1: TForm1;
  Pricehead:PricelistADR;
implementation

{$R *.dfm}

procedure TForm1.btn1Click(Sender: TObject);
begin
ShowMessage('Input order num');

end;

procedure TForm1.btnAddClick(Sender: TObject);
begin
 case mode of
  priceList:
  begin
   insertPriceList(Pricehead,Random(200));
  writePriceList(Pricehead,strngrd1);
  end;
  ordList:
  begin
    OrdInsert(orderhead);
    OrdWrite(OrderHead, strngrd1);
  end;
 end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  I: Integer;
begin
btn1.Visible:=False;
new(OrderHead);
OrderHead^.ADR:=nil;
OrderHead^.HADR:=nil;      //////////////////////////
invtemp:=OrderHead;
//btnAdd.Visible:=false;
OrdWrite(OrderHead, strngrd1);
new(Pricehead);
 Pricehead^.ADR:=nil;
 ReadPriceList(Pricehead,'priceList.brakhmen');
end;

procedure TForm1.OrdList1Click(Sender: TObject);
begin
mode:=ordList;
OrdWrite(OrderHead, strngrd1);
end;

procedure TForm1.priceList1Click(Sender: TObject);
begin
 mode:=priceList;
 btnAdd.Visible:=True;
 writePriceList(Pricehead,strngrd1);
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
    InsertProductList(OrderHead,pricehead,Arow,strngrd1,sordnum);
    end;
  if  Acol = 4 then
    begin
    sordnum:=Trim(strngrd1.Cells[0,Arow]);
    ProductsWrite(OrderHead,Arow,strngrd1,sordnum);
    end;

   if  Acol = 5 then
    begin
    sordnum:=Trim(strngrd1.Cells[0,Arow]);
    makeNaklodnayaGreatAgain(OrderHead,Pricehead,Arow,strngrd1,sordnum);
    end;

  end;

end;
end;
end.
