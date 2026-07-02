---
title: Developing in .NET Core in {{ sf-full-name }}. Overview
description: "With {{ sf-name }}, you can run applications written in C# (CSharp) for .NET Core. This service provides the .NET Core 3.1.417 runtime with C#\_8.0 and Ubuntu 18.04."
---

# Developing in .NET Core. Overview

With {{ sf-name }}, you can run applications written in [C#]({{ ms.docs }}/dotnet/csharp/) for [.NET Core]({{ ms.docs }}/dotnet/core/about).

{% include [runtime-introduction](../../../_includes/functions/runtime-introduction.md) %}

| Name | .NET Core version | C# version | Operating <br>system | Preloaded | Supported by {{ sf-name }} |
|----|----|----|----|----|----|
| dotnetcore31 | 3.1.417 | 8.0 | Ubuntu 18.04 | No | No |
| dotnet6 | 6.0.400 | 8.0 | Ubuntu 18.04 | No | Yes |
| dotnet8 | 8.0.100-rc.2 | 12.0 | Ubuntu 22.04 LTS | No | Yes |

You can add an [SDK library](https://github.com/yandex-cloud/dotnet-sdk) to the runtime to work with the {{ yandex-cloud }} API. For more info on how to use the SDK, see [Using the SDK](sdk.md).

When creating a new [function version](../../concepts/function.md#version), the [builder](../../concepts/builder.md) will automatically install all declared dependencies required for the function. For more information about requirements and limitations, see [{#T}](dependencies.md).

The runtime automatically loads your code and invokes the [request handler](handler.md) you specified. It receives the incoming request and the [invocation context](context.md) as arguments. The context contains additional information about the function parameters.

{{ sf-name }} automatically catches the application's standard output streams and sends them to the centralized logging system in {{ yandex-cloud }}. This system also logs entries about the start and end of each function execution, as well as any errors that occur during execution. For more information about the log format, see [{#T}](logging.md).

To learn more about programming in C# or how certain constructs work, we recommend taking a basic [course on Stepik](https://stepik.org/course/4143/promo).
