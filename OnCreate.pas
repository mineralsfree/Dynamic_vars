unit OnCreate;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms,
   Vcl.Dialogs, Vcl.Menus, Vcl.Grids, Vcl.StdCtrls,UPriceList,
   UOrdList,UProductList,Invoice;
type
  Tmode = (ordList,priceList,naclodnaya,prodlist);
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

  private
    { Private declarations }
  public
    { Public declarations }
      end;
var
  k:Integer;
  mode:Tmode;
  OrderHead:OrdlistADR;
  Pricehead:PricelistADR;
  DeleteHead:ProdListADR;
  Form1: TForm1;
implementation

{$R *.dfm}


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
OrderHead^.HADR:=nil;

readOrdlist(OrderHead,'OrdList.brakmen');
readproductlist(OrderHead,'ProductList.brakhmen');
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
case mode of
  priceList:
  begin
  savePricelist(Pricehead,'priceList.brakhmen');
  ShowMessage('PriceList Saved');
  end;
  ordList:
  begin
    saveOrdList(OrderHead);
    saveProductList(OrderHead,'kek.brakhmen');
    ShowMessage('OrdList and ProdList saved');
  end;
end;
end;

procedure TForm1.strngrd1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  var i,Acol,Arow:Integer;
  var ordnum:integer;
  var sordnum:string;
  var prodname:string;

begin
strngrd1.MouseToCell(X,Y,Acol,Arow);
case mode of
  priceList:
  begin
   if Acol = 3 then
   begin
   ordnum:=strtoint(strngrd1.Cells[0,Arow]);
   deletePriceList(Pricehead,ordnum);
   writePriceList(Pricehead,strngrd1);
   end;
   if (Acol =2) or (Acol = 1) or  (Acol = 0) then
   begin
   ordnum:=strtoint(strngrd1.Cells[0,Arow]);
   editpricelist(Pricehead,ordnum,Acol);
   writePriceList(Pricehead,strngrd1);
   end;
  end;

  ordList:
  begin
  if (Acol =2) or (Acol = 1) or  (Acol = 0) then
   begin
   ordnum:=strtoint(strngrd1.Cells[0,Arow]);
   editordlist(OrderHead,IntToStr(ordnum),Acol);
   OrdWrite(orderhead,strngrd1);              // zagatovka
   end;
  if Acol = 3 then
    begin
    sordnum:=strngrd1.Cells[0,Arow];
    InsertProductList(OrderHead,pricehead,Arow,strngrd1,sordnum);
    end;
  if  Acol = 4 then
    begin
    mode:=prodlist;
    sordnum:=Trim(strngrd1.Cells[0,Arow]);
    k:=Arow;
    ProductsWrite(OrderHead,Arow,strngrd1,sordnum);
    end;

   if  Acol = 5 then
    begin
    sordnum:=Trim(strngrd1.Cells[0,Arow]);
    makeNaklodnayaGreatAgain(OrderHead,Pricehead,Arow,strngrd1,sordnum);
    end;
    if  Acol = 6 then
    begin
    sordnum:=Trim(strngrd1.Cells[0,Arow]);
    DeleteOrdList(OrderHead,sordnum);
    OrdWrite(OrderHead,strngrd1);
    end
  end;
  prodlist:
    begin
      if Acol = 3 then
      begin
      ordnum:=StrToInt(strngrd1.Cells[2,Arow]);
      sordnum:=IntToStr(ordnum);
      prodname:=strngrd1.Cells[1,Arow];
      Deleteproduct(OrderHead,ordnum,prodname,k);
      ProductsWrite(OrderHead,k,strngrd1,strngrd1.Cells[0,Arow]);

      end;

    end;

end;
end;
end.
