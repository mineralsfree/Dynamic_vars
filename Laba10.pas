unit Laba10;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.Grids, Vcl.StdCtrls;

type
  TINF = record
   orderNum: string[10];
   orderDate:TDateTime;
   cutomerReq:string[12];
   end;
   TADR=^TSP;
   TSP = record
    INF: TINF;
    ADR:TADR;
    end;
   TForm1 = class(TForm)
    mm1: TMainMenu;
    invoices1: TMenuItem;
    strngrd1: TStringGrid;
    btn1: TButton;
    btn2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure okay(Sender: TObject);
    procedure strngrd1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Head, temp:TADR;
  f: file of TINF;
  temp2:TADR;
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btn1Click(Sender: TObject);
begin
  temp:=Head;
 while temp^.ADR<>nil do
 temp:=temp^.ADR;           //scroll to free space

  New(temp^.ADR);         //�������� ����� � ������
  temp:=temp^.ADR;
  temp^.ADR:=nil;
  temp^.INF.orderNum:=InputBox('InsertNum','Please,insert num of the order','635421');
  temp^.INF.orderDate:=VarToDateTime(InputBox
  ('InsertDate','Please,insert num of the order','03.03.2018'));
  temp^.INF.cutomerReq:=InputBox('InsertReq','Please,insert Customer requisites','2281488');
  btn2.Visible:=True;
end;

procedure TForm1.btn2Click(Sender: TObject);
begin
strngrd1.RowCount:=2;
strngrd1.ColCount:=3;
 temp:=Head^.ADR;

 while temp<>nil do
 begin
  strngrd1.Cells[0,strngrd1.RowCount-1]:=temp^.INF.orderNum;
  strngrd1.Cells[1,strngrd1.RowCount-1]:=DateToStr(temp^.INF.orderDate);
  strngrd1.Cells[2,strngrd1.RowCount-1]:=temp^.INF.cutomerReq;
   strngrd1.RowCount:= strngrd1.RowCount+1;
  temp:=temp^.ADR;
  //ShowMessage(temp^.INF.orderNum);
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  I: Integer;
begin
btn2.Visible:=False;
new(Head);
Head^.ADR:=nil;
temp:=Head;      {
for I := 1 to 5 do
  begin
  New(temp^.ADR);         //�������� ����� � ������
  temp:=temp^.ADR;
  temp^.ADR:=nil;
  temp^.INF.orderNum:='pizdec'+IntToStr(i);
  end;        }
 // stringgr
{temp:=Head;
i:=0;
 while temp^.ADR<>nil do
 begin
 Inc(i);
   temp:=temp^.ADR;
  strngrd1.Cells[i,1]:=temp^.INF.orderNum;

  //ShowMessage(temp^.INF.orderNum);
  end;     }
  strngrd1.Cells[0,0]:='Order num';
  strngrd1.Cells[1,0]:='Order date';
  strngrd1.Cells[2,0]:='Customer Requisites';
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
//temp:=head;
 New(temp^.ADR);         //�������� ����� � ������
  temp:=temp^.ADR;
  temp^.ADR:=nil;
value:=InputBox('Insert string','pls insert data','kek');
temp^.INF.orderNum:=value;
strngrd1.cells[Acol,Arow]:=temp^.INF.orderNum;


end;

end.
