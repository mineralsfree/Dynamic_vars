unit Laba10;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus;

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
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Head, temp:TADR;
  f: file of TINF;
  tempz:TADR;
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
new(Head);
Head^.ADR:=nil;

end;

end.
