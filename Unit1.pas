unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, System.Diagnostics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.StrUtils;

type
  TForm1 = class(TForm)
    btn1: TButton;
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses db.tlc;

procedure TForm1.btn1Click(Sender: TObject);
var
  intCount: Integer;
begin
  with TStopwatch.StartNew do
  begin
    intCount     := GetTextLineCount_FS('F:\test\text\test.txt');
    btn1.Caption := Format('用时：%d 毫秒，总行数：%d', [ElapsedMilliseconds, intCount]);
  end;
end;

end.
