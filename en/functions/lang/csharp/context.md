---
title: .NET Core function invocation context in {{ sf-full-name }}
description: In this article, you will learn about the .NET Core function invocation context.
---

# .NET Core function invocation context

_Invocation context_ is an object that can be optionally accepted by the [request handler](handler.md) if the [YcFunction interface model](model/yc-function.md) is used. It is a `Yandex.Cloud.Functions.Context` type object providing properties you can use to get more information about the C# function version:
* `FunctionId`: Returns the string ID of the function.
* `FunctionVersion`: Returns the string ID of the function version.
* `MemoryLimitInMB`: Returns the amount of memory specified when creating the version, MB.
* `RequestId`: Returns the request ID.
* `TokenJson`: Returns the parameters for authentication in the {{ yandex-cloud }} API.
