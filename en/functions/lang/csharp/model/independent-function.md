# Using the Function interface to set a handler function in C#

You can set a handler function in C# without [SDK](https://github.com/yandex-cloud/dotnet-sdk) class inheritance.

{% note warning %}

The handler method must be public, be named `FunctionHandler`, and have one input parameter.

{% endnote %}

{% include [examples-simple](../../../../_includes/functions/csharp-handler-examples-simple.md) %}

You can use any classes as input and return types.

{% note info %}

Fields of these classes may have any [access modifiers](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/classes-and-structs/access-modifiers). If a field is non-public, it requires a public `getter` method. Otherwise, the field won't be included in the response.

{% endnote %}


{% include [examples](../../../../_includes/functions/csharp-handler-examples.md) %}
