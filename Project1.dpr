program Project1;

uses
  Vcl.Forms,
  OnCreate in 'OnCreate.pas' {Form1},
  UOrdList in 'UOrdList.pas',
  UPriceList in 'UPriceList.pas',
  Unit1 in 'Unit1.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
