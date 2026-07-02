# C# programming model

{{ sf-name }} provides two models for programming in C#: one is based on the [YcFunction](yc-function.md) interface, the other, on an [independent class](independent-function.md) with a compatible method. Both models require custom implementations of the interfaces and allow the function to accept one argument and one return value of any type. 

The difference between these models is the availability of the [invocation context](../context.md). For example, if you need to work with {{ yandex-cloud }} services using the [SDK](../sdk.md), we recommend opting for [YcFunction](yc-function.md).

No matter which model you select, the project can be uploaded either as a [published](https://docs.microsoft.com/en-us/dotnet/core/tools/dotnet-publish) `csproj` project or as `*cs` files with source code. The second option is suitable for handlers without external dependencies. The class that contains the handler must also meet the following requirements:
1. It must be public.
1. It must have a public no-argument constructor. 
    It is provided by default. However, if you created your own constructor with arguments, you should also create a no-argument one.
1. It must not be [generic](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/generics/).

No matter which model you select, the handler can be an [async method](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/concepts/async/) that returns `Task` or `Task<T>`. For the independent class option, the `async void` return type is also available.

In this case, there are two distinct types: `byte[]` and `String`. They are used slightly differently from other types. If you use them as the handler argument type, the runtime will not convert the incoming request into `JSON` and instead will provide it directly to the user-defined handler, unless [?integration=raw](../../../concepts/function-invoke.md#http) is used.
