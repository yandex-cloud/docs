# Overview

With {{ sf-name }}, you can run applications written in [Go](https://golang.org/doc/). The service provides the [runtime environment](../../concepts/function-invoke.md) version 1.14 and Ubuntu 18.04 LTS.

To access the Yandex.Cloud API, you can add the [SDK library](https://github.com/yandex-cloud/go-sdk) to your runtime environment. For more information about how to use the SDK, see [Using the SDK](sdk.md).

When creating a new [function version](../../concepts/function.md#version) [the builder](../../concepts/builder.md) automatically installs all declared dependencies required for the function to run. For more information about the requirements and restrictions, see [{#T}](dependencies.md).

The runtime environment automatically loads your code and invokes the [request handler](handler.md) you specified. It receives an incoming request and the [invocation context](context.md) as arguments. The context contains additional information about the function parameters.

{{ sf-name }} automatically captures standard application output streams and sends them to the centralized logging system available in Yandex.Cloud. This system also logs service records about the start and end of each function and any errors that occur during its execution. For more information about the log format, see [{#T}](logging.md).

To learn more about how to write in Go or how certain constructs work, we recommend taking [A Tour of Go](https://tour.golang.org/).

