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

## License

This binding follows the licensing terms of the project. **libcurl is licensed under the LGPL license.**
