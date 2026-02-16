# Builder

A _builder_ is a mechanism used to build a function when creating a new version. It loads the necessary dependencies and, if a compiled programming language is used, compiles the source files into an executable file.

You can add [dynamic libraries](./runtime/environment-variables.md#dynamic-library) by adding them to the ZIP archive.

### Logging {#logging}

Whether the version is successfully created or there is an error, the builder's output data is written to:
* [Default log group](../../logging/concepts/log-group.md), where each record has a `json_payload` parameter set to `source=builder`.
* File the link to which is specified in the operations section.

If the builder reports a project build error, the [runtime environment](runtime/index.md) automatically captures the error and writes detailed information about the error type, text, and location. As a result, the function version creation fails.
