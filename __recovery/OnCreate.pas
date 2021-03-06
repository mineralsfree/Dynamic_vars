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
    btn2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure strngrd1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnAddClick(Sender: TObject);
    procedure priceList1Click(Sender: TObject);
    procedure save1Click(Sender: TObject);
    procedure OrdList1Click(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);

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


  procedure TForm1.btn1Click(Sender: TObject);
  begin
  SortListOrd(OrderHead);
  OrdWrite(OrderHead,strngrd1);

  end;

procedure TForm1.btn2Click(Sender: TObject);
begin
writesearchord(OrderHead,InputBox('','','Blin'));

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
  function factorial(i:integer):Int64;
begin
    if i = 0  then
      result:=1
      else
   result:=i*factorial(i-1);
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  I: Integer;
begin
btn1.Visible:=True  ;
//ShowMessage(IntToStr(factorial(StrToInt(inputbox('Input','count factorial','2')))));
new(OrderHead);
OrderHead^.ADR:=nil;
OrderHead^.HADR:=nil;

readOrdlist(OrderHead,'OrdList.brakmen');
readproductlist(OrderHead,'kek.brakhmen');
OrdWrite(OrderHead, strngrd1);

new(Pricehead);
 Pricehead^.ADR:=nil;
 ReadPriceList(Pricehead,'priceList.brakhmen');

end;

procedure TForm1.OrdList1Click(Sender: TObject);
begin
mode:=ordList;
 btn1.Visible:=true;
btnAdd.Visible:=True;
OrdWrite(OrderHead, strngrd1);
end;

procedure TForm1.priceList1Click(Sender: TObject);
begin
 mode:=priceList;
 btn1.Visible:=false;
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
    saveOrdList(OrderHead,'OrdList.brakhmen');
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
 if Arow<>0 then
 begin
case mode of
  priceList:
  begin
   if Acol = 4 then
   begin
     // if MessageDlg('Точно?',mtCustom, mbYesNo, 0) = mrYes then
      begin
        prodname:=strngrd1.Cells[1,Arow];
       ordnum:=strtoint(strngrd1.Cells[0,Arow]);
       if ProdlistObjAdrOfcode(OrderHead,prodname)=nil then
       deletePriceList(Pricehead,ordnum)
       else
       ShowMessage('You are trying to delete Item, that is used in order!!!!');
       writePriceList(Pricehead,strngrd1);
      end;
   end;
   if (Acol =2) or (Acol = 1) or  (Acol = 0) then
   begin
     prodname:=strngrd1.Cells[1,Arow];
    if ((ProdlistObjAdrOfcode(OrderHead,prodname)=nil) or (Acol<>1)) then
    begin
     ordnum:=strtoint(strngrd1.Cells[0,Arow]);
     editpricelist(Pricehead,ordnum,Acol);
     writePriceList(Pricehead,strngrd1);
    end
    else ShowMessage('You are trying to rewrite Product, used in order');
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
     btn1.Visible:=false;
    btnAdd.Visible:=False;
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
   // if MessageDlg('Точно?',mtCustom, mbYesNo, 0) = mrYes then
    begin
      sordnum:=Trim(strngrd1.Cells[0,Arow]);
      DeleteOrdList(OrderHead,sordnum);
      OrdWrite(OrderHead,strngrd1);
    end;
    end
  end;
  prodlist:
    begin
      if Acol = 3 then
      begin
      //if MessageDlg('Точно?',mtCustom, mbYesNo, 0) = mrYes then
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
 end;
end;
end.
