---
title: Development on Go in Yandex Cloud Functions. Overview
description: 'With the Cloud Functions service, you can run applications written in Go. The service provides a runtime with different versions.'
---

# Development on Go. Overview

With {{ sf-name }}, you can run applications written in [Go](https://go.dev/doc/). The service provides the [runtime environment](../../concepts/runtime/index.md) with different versions:

| Name | Go version | Operating <br>system | Preloaded |
| ---- | ---- | ---- | ---- |
| golang116 | 1.16.15 | Ubuntu 18.04 LTS | No |
| golang117 | 1.17.8 | Ubuntu 18.04 LTS | No |

You can connect the [SDK library](https://github.com/yandex-cloud/go-sdk) to the runtime to work with the {{ yandex-cloud }} API. For more information about how to use the SDK, see [Using the SDK](sdk.md).

When creating a new [function version](../../concepts/function.md#version) [the builder](../../concepts/builder.md) automatically installs all declared dependencies required for the function to run. For more information about the requirements and restrictions, see [{#T}](dependencies.md).

The runtime environment automatically loads your code and invokes the [request handler](handler.md) you specified. It receives an incoming request and the [invocation context](context.md) as arguments. The context contains additional information about the function parameters.

{{ sf-name }} automatically captures an application's standard output streams and sends them to the centralized logging system available in {{ yandex-cloud }}. This system also logs service records about the start and end of each function and any errors that occur during its execution. For more information about the log format, see [{#T}](logging.md).

To learn more about how to write in Go or how certain statements work, we recommend taking [A Tour of Go](https://go.dev/tour/welcome/1).
