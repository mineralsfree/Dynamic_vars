program Project1;

uses
  Vcl.Forms,
  OnCreate in 'OnCreate.pas' {Form1},
  UOrdList in 'UOrdList.pas',
  UPriceList in 'UPriceList.pas',
  UProductList in 'UProductList.pas',
  Invoice in 'Invoice.pas';

{$R *.res}


begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

