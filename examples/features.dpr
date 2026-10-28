program ListCurlFeatures;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  Classes,
  libcurl
  ;

procedure DisplayCurlInfo;
var
  Info: Pcurl_version_info_data;
  ProtoPtr: PPUTF8Char;
begin
  try
    Info := curl_version_info(CURLversion(CURLVERSION_NOW));
    if Info = nil then
    begin
      Writeln('Failed to retrieve libcurl version info.');
      Exit;
    end;

    // 1. Print Core Version and SSL info
    Writeln('=== libcurl Information ===');
    Writeln(Format('Version:     %s', [UnicodeString(Info.version)]));
    if Info.ssl_version <> nil then
      Writeln(Format('SSL Backend: %s', [UnicodeString(Info.ssl_version)]));

    // 2. Loop through and list enabled Protocols
    Writeln;
    Writeln('=== Enabled Protocols ===');
    if Info.protocols <> nil then
    begin
      ProtoPtr := Info.protocols;
      while ProtoPtr^ <> nil do
      begin
        Writeln(Format('  - %s', [UnicodeString(ProtoPtr^)]));
        Inc(ProtoPtr); // Shift array pointer forward
      end;
    end;

    // 3. Inspect the bitmask to list enabled Features
    Writeln;
    Writeln('=== Enabled Features ===');
    if (Info.features and CURL_VERSION_SSL) <> 0         then Writeln('  - SSL/TLS');
    if (Info.features and CURL_VERSION_IPV6) <> 0        then Writeln('  - IPv6');
    if (Info.features and CURL_VERSION_HTTP2) <> 0       then Writeln('  - HTTP2');
    if (Info.features and CURL_VERSION_HTTP3) <> 0       then Writeln('  - HTTP3');
    if (Info.features and CURL_VERSION_ASYNCHDNS) <> 0   then Writeln('  - Asynchronous DNS');
    if (Info.features and CURL_VERSION_IDN) <> 0         then Writeln('  - IDN (Internationalized Domain Names)');
    if (Info.features and CURL_VERSION_LARGEFILE) <> 0   then Writeln('  - Largefile (>2GB files)');
    if (Info.features and CURL_VERSION_NTLM) <> 0        then Writeln('  - NTLM Authentication');
    if (Info.features and CURL_VERSION_ALTSVC) <> 0      then Writeln('  - Alt-Svc');
    if (Info.features and CURL_VERSION_HSTS) <> 0        then Writeln('  - HSTS');
    if (Info.features and CURL_VERSION_BROTLI) <> 0      then Writeln('  - Brotli Compression');
    if (Info.features and CURL_VERSION_ZSTD) <> 0        then Writeln('  - Zstd Compression');

  except
    on E: Exception do
      Writeln('Error: ' + E.Message);
  end;
end;

begin
  DisplayCurlInfo;
  // Keep console open for scanning output
  Write(#10'Press [Enter] to exit...');
  Readln;
end.
