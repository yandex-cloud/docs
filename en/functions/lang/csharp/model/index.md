# C# programming model

{{ sf-name }} provides two models for programming in C#: using the [YcFunction](yc-function.md) interface and an [independent class](independent-function.md) with a compatible method. Both models involve writing their own interface implementations and let you provide a function with one argument and one return value of any type.

The difference between these models is in the [invocation context](../context.md) that is either available or not. If, for example, you need to interact with {{ yandex-cloud }} services using the [SDK](../sdk.md), we recommend choosing [YcFunction](yc-function.md).

Regardless of the selected model, a project is uploaded in one of the following ways: as a [published](https://docs.microsoft.com/en-us/dotnet/core/tools/dotnet-publish) `csproj` project or as a set of `*cs` files with source code. The second option is suitable for handlers that have no external dependencies. In addition, the following requirements apply to a class that contains a handler function:

1. It must be public.
1. It must have a public constructor with no arguments.
   By default, it is present. But if you created your own constructor that accepts arguments, you should also create a constructor that doesn't accept any arguments.
1. It shouldn't be [generic](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/generics/).

Regardless of the selected model, the handler can be an [async method](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/concepts/async/) that returns a `Task` or `Task<T>`. For the option with the independent class, the `async void` value can be returned.

In this case, there are two separate types: `byte[]` and `String`. Using them is slightly different from using other types. If you use them as the handler function argument type, the runtime doesn't convert an incoming request to a `JSON` interpretation for these types and passes it directly to the user handler function. The exception is when the parameter [integration=raw](../../../concepts/function-invoke.md#http) is used.

