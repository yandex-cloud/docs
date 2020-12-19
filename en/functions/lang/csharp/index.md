# Overview

With {{ sf-name }}, you can run applications written in [C#](https://docs.microsoft.com/en-us/dotnet/csharp/) for [.NET Core](https://docs.microsoft.com/en-us/dotnet/core/about). The service provides the [runtime environment](../../concepts/runtime/index.md) .NET Core 3.1.401 with C# 8.0 and Ubuntu 18.04 LTS.

You can connect the [SDK library](https://github.com/yandex-cloud/dotnet-sdk) to the runtime to work with the {{ yandex-cloud }} API. For more information about how to use the SDK, see [Using the SDK](sdk.md).

When creating a new [function version](../../concepts/function.md#version) [the builder](../../concepts/builder.md) automatically installs all declared dependencies required for the function to run. For more information about the requirements and restrictions, see [{#T}](dependencies.md).

The runtime environment automatically loads your code and invokes the [request handler](handler.md) you specified. It receives an incoming request and the [invocation context](context.md) as arguments. The context contains additional information about the function parameters.

{{ sf-name }} automatically captures an application's standard output streams and sends them to the centralized logging system available in {{ yandex-cloud }}. This system also logs service records about the start and end of each function and any errors that occur during its execution. For more information about the log format, see [{#T}](logging.md).

If you want to learn more about how to write in C# or how certain statements work, we recommend taking a basic [course on Stepik](https://stepik.org/course/4143/promo).