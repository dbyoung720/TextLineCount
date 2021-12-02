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

uses db.TextLineCount;

procedure TForm1.btn1Click(Sender: TObject);
var
  intCount: Integer;
begin
  with TStopwatch.StartNew do
  begin
    intCount     := GetTextLineCount_FS('F:\Github\SFFS2\bin\Win32\F_Files.dat');
    btn1.Caption := Format('��ʱ��%d ���룬��������%d', [ElapsedMilliseconds, intCount]);
  end;
end;

end.
