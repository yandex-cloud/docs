# Using the Function interface to set a handler in C#

You can set a handler in C# without inheriting from [SDK](https://github.com/yandex-cloud/dotnet-sdk) classes.

{% note warning %}

The handler method must be public, named `FunctionHandler`, and have a single input parameter.

{% endnote %}

{% include [examples-simple](../../../../_includes/functions/csharp-handler-examples-simple.md) %}

You can use any classes as input and return types.

{% note info %}

Fields of these classes can have any [access modifiers](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/classes-and-structs/access-modifiers). If a field is non-public, it requires the `getter` public method. Otherwise, the field will not be included in the response.

{% endnote %}


{% include [examples](../../../../_includes/functions/csharp-handler-examples.md) %}
