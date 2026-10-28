# libcurl 8.22.0 for Object Pascal

An Object Pascal binding for **libcurl 8.22.0**, providing access to libcurl's HTTP and URL transfer capabilities from Pascal applications.

## Features

- HTTP and HTTPS requests.
- Support for libcurl's C-style API.
- Request and response header handling.
- Cross-platform support for Windows, Linux, macOS, iOS, and Android.
- Compatible with Free Pascal and Lazarus.

## Requirements

- Free Pascal Compiler (FPC).
- libcurl 8.22.0 shared library for your target platform.

## Usage

Add the binding units to your project and import the required unit:

```pascal
uses
  libcurl;
```

Ensure the libcurl shared library is available to your application at runtime.

## Curl in Windows

```
git clone --depth 1 https://github.com/Microsoft/vcpkg
cd vcpkg
bootstrap-vcpkg.bat
vcpkg integrate install
vcpkg install curl[tool]
cd installed\x64-windows\tools\curl\
copy libcurl.dll -project
copy z.dll my-project
```

## Building and testing

Requirements: libcurl of the same bitness as your compiler target
(Windows: `libcurl.dll` next to the .exe, or set `CURL_DLL_DIR`;
Debian/Ubuntu: `apt install libcurl4-openssl-dev` because the binding imports `libcurl.so`).
Integration tests need Python 3 (stdlib only) for the echo server and, on Windows, `curl.exe`.

```sh
./build.sh          # build examples + test runners  -> build/fpc/bin
./test.sh           # build, start echo server, run unit + integration + examples
```

```bat
set BDS=C:\Program Files (x86)\Embarcadero\Studio\37.0
build.bat [fpc|delphi|all] [win32|win64]
test.bat  [fpc|delphi]     [win32|win64]
```

Run the examples against the internet instead: `build\fpc\bin\Example.Get` (defaults to
https://httpbin.org) or pass any base URL as the first argument.

## License

**LibCurl4Pascal** is licensed under the LGPL license.
