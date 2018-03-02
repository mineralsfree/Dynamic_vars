unit Laba10;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.Grids;

type
  TINF = record
   orderNum: string[10];
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
    procedure FormCreate(Sender: TObject);
    procedure okay(Sender: TObject);
    procedure strngrd1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
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

procedure TForm1.FormCreate(Sender: TObject);
var
  I: Integer;
begin
new(Head);
Head^.ADR:=nil;
temp:=Head;
{for I := 1 to 5 do
  begin
  New(temp^.ADR);         //Выделяем место в памяти
  temp:=temp^.ADR;
  temp^.ADR:=nil;
  temp^.INF.orderNum:='pizdec'+IntToStr(i);
  end;        }
 // stringgr
temp:=Head;
i:=0;
 while temp^.ADR<>nil do
 begin
 Inc(i);
   temp:=temp^.ADR;
  strngrd1.Cells[i,1]:=temp^.INF.orderNum;

  //ShowMessage(temp^.INF.orderNum);
  end;
  strngrd1.Cells[1,0]:='Расчёт';

end;

procedure TForm1.okay(Sender: TObject);
var
  I: Integer;
begin
 i:=1;
 temp:=Head^.ADR;
 while temp<>nil do
 begin
 Inc(i);
  strngrd1.Cells[i,i]:=temp^.INF.orderNum;
  temp:=temp^.ADR;
  //ShowMessage(temp^.INF.orderNum);
  end;


end;

procedure TForm1.strngrd1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  var i,Acol,Arow:Integer;
  var value: string;

begin
strngrd1.MouseToCell(X,Y,Acol,Arow);
temp:=head;
 New(temp^.ADR);         //Выделяем место в памяти
  temp:=temp^.ADR;
  temp^.ADR:=nil;
value:=InputBox('Insert string','pls insert data','02.03.2018');
temp^.INF.orderNum:=value;
strngrd1.cells[Acol,Arow]:=temp^.INF.orderNum;


end;

end.
