unit db.TextLineCount;
{
  Func: 统计文本文件行数
  Name: dbyoung@sina.com
  Date: 2021-12-02
  Vers: Delphi 11
}

{
  Test：
  30M  TEXT FILE:
  GetTextLineCount_SL  828125   987ms
  GetTextLineCount_TF  828092   484ms
  GetTextLineCount_FS  828125    96ms

  600M TEXT FILE:
  GetTextLineCount_SL  < NOT SUPPORT >
  GetTextLineCount_TF  14177571   8758ms
  GetTextLineCount_FS  14181548   1659ms
}

interface

function GetTextLineCount_SL(const strFileName: string): UInt64;
function GetTextLineCount_TF(const strFileName: string): UInt64;
function GetTextLineCount_FS(const strFileName: string): UInt64;

implementation

uses System.SysUtils, System.Classes;

const
  c_intLength = 64 * 1024 * 1024;

var
  Buffer: array [0 .. c_intLength - 1] of AnsiChar;

function GetTextLineCount_SL(const strFileName: string): UInt64;
begin
  with TStringList.Create do
  begin
    LoadFromFile(strFileName);
    Result := Count;
    Free;
  end;
end;

function GetTextLineCount_TF(const strFileName: string): UInt64;
var
  F: TextFile;
begin
  Result := 0;
  AssignFile(F, strFileName);
  SetTextBuf(F, Buffer);
  Reset(F);
  while not eof(F) do
  begin
    Readln(F);
    Inc(Result);
  end;
  CloseFile(F);
end;

function GetTextLineCount_FS(const strFileName: string): UInt64;
var
  FS      : TFileStream;
  I, Count: Integer;
  startPos: Integer;
  partXPos: Integer;
begin
  Result   := 0;
  startPos := 0;
  partXPos := 0;
  FS       := TFileStream.Create(strFileName, fmOpenRead);
  try
    Count := FS.Size;
    while FS.Position < Count do
    begin
      FS.Read(Buffer[0], c_intLength);
      startPos := startPos + c_intLength;
      if startPos > Count then
        partXPos := startPos - Count;

      for I := 0 to c_intLength - 1 - partXPos do
      begin
        if (Buffer[I] = #13) and (Buffer[I + 1] = #10) then
          Inc(Result)
        else if (Buffer[I] = #13) and (Buffer[I + 1] <> #10) then
          Inc(Result)
        else if (Buffer[I] <> #13) and (Buffer[I + 1] = #10) then
          Inc(Result);
      end;
    end;
  finally
    FS.Free;
  end;
end;

end.
