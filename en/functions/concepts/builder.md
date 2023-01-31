# Builder

_A builder_ is a mechanism used to build a function when creating a new version. It loads the necessary dependencies and, if a compiled programming language is used, compiles the source files into an executable file.

You can add [dynamic libraries](./runtime/environment-variables.md#dynamic-library) by adding them to the ZIP archive.

### Logging {#logging}

The builder's output data is written to a file and returned to the user both if the version is created successfully and if it's not. You can find a link to this file in the operations section.

If the builder reports a project build error, the [runtime environment](runtime/index.md) automatically captures the error, writes detailed information about the error type, text, and location to a log file and returns a link to this file in the response. As a result, the function version **creation fails**.
