program HttpGetExample;

{$IFDEF FPC}
  {$MODE DELPHI}
{$ENDIF}

uses
  SysUtils,
  Classes,
  libcurl;

var
  Handle: PCURL;
  ResultCode: CURLcode;
  ResponseCode: Longint;
  ResponseBody: TStringStream;

function WriteBodyCallback(
  Ptr: PChar;
  Size: LongWord;
  Nmemb: LongWord;
  Data: Pointer
): LongWord; cdecl;
var
  Bytes: LongWord;
begin
  Bytes := Size * Nmemb;

  if Bytes > 0 then
    ResponseBody.WriteBuffer(Ptr^, Bytes);

  Result := Bytes;
end;

function WriteHeaderCallback(
  Ptr: PChar;
  Size: LongWord;
  Nmemb: LongWord;
  Data: Pointer
): LongWord; cdecl;
var
  Bytes: LongWord;
  HeaderLine: AnsiString;
begin
  Bytes := Size * Nmemb;

  if Bytes > 0 then
  begin
    SetString(HeaderLine, Ptr, Bytes);
    Write('Header: ', string(HeaderLine));
  end;

  Result := Bytes;
end;

begin
  ResponseBody := TStringStream.Create('');
  Handle := nil;

  try
    curl_global_init(CURL_GLOBAL_DEFAULT);

    Handle := curl_easy_init;
    if Handle = nil then
      raise Exception.Create('Could not initialize libcurl');

    curl_easy_setopt(
      Handle,
      CURLOPT_URL,
      PChar('https://httpbin.org/get')
    );

    curl_easy_setopt(
      Handle,
      CURLOPT_WRITEFUNCTION,
      @WriteBodyCallback
    );

    curl_easy_setopt(
      Handle,
      CURLOPT_HEADERFUNCTION,
      @WriteHeaderCallback
    );

    curl_easy_setopt(
      Handle,
      CURLOPT_FOLLOWLOCATION,
      Longint(1)
    );

    curl_easy_setopt(
      Handle,
      CURLOPT_TIMEOUT,
      Longint(30)
    );

    ResultCode := curl_easy_perform(Handle);

    if ResultCode <> CURLE_OK then
      raise Exception.CreateFmt(
        'HTTP request failed: %d',
        [Ord(ResultCode)]
      );

    curl_easy_getinfo(
      Handle,
      CURLINFO_RESPONSE_CODE,
      @ResponseCode
    );

    WriteLn;
    WriteLn('HTTP Status: ', ResponseCode);
    WriteLn('Response Body:');
    WriteLn(ResponseBody.DataString);

  finally
    if Handle <> nil then
      curl_easy_cleanup(Handle);

    curl_global_cleanup;
    ResponseBody.Free;
  end;
end.