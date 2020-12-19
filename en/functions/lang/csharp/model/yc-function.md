# Using the YcFunction interface to set a handler function

You can set a handler function by implementing the [YcFunction](https://github.com/yandex-cloud/dotnet-sdk/blob/master/Yandex.Cloud.SDK/Functions/YcFunction.cs) interface. To do this, add an [SDK](../sdk.md) to the [dependencies](../dependencies.md).

{% note warning %}

You should specify both values for `YcFunction` type parameters: the first one being the input argument type and the second one the type of the return value. The `handle` method also has the second argument: the [invocation context](../context.md).

{% endnote %}

Example of a valid handler:

```C#
public class Handler : YcFunction<int, String> {
  public String FunctionHandler(int i, Context c) {
    return String.valueOf(i);
  }
}
```

Examples of invalid handlers:

```C#
// YcFunction has only one parameter type specified
// Handler should not have any type parameters (see the [handler requirements](index.md))
public class Handler<T> : YcFunction<T, int> {
  public int FunctionHandler(T i, Context c) {
    return 2;
  }
}
```

```C#
// YcFunction doesn't have both parameter types specified
public class Handler : YcFunction {
  public Object FunctionHandler(Object i, Context c) {
    return i;
  }
}
```

You can use any classes as input and return types.

{% note info %}

Fields of these classes may have any [access modifiers](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/classes-and-structs/access-modifiers). If a field is non-public, it requires a public `getter` method. Otherwise, the field won't be included in the response.

{% endnote %}

## Example {#example}

### Function information output {#http-info}

The following function:

1. Receives a number as an input.
1. Outputs the function data obtained from the invocation context to the execution log.
1. Returns data on whether the received number is even.

{% note warning %}

Invoke the function using the [YC CLI](../../../concepts/function-invoke.md) or an HTTP request with the `integration=raw` parameter.

{% endnote %}

The Handler.cs file:

```C#
using Yandex.Cloud.Functions;

public class Handler : YcFunction<int, bool> {

  public bool FunctionHandler(int number, Context c) {
    Console.WriteLine($"Function name: {c.FunctionId}");
    Console.WriteLine($"Function version: {c.FunctionVersion}");
    Console.WriteLine($"Service account token: {c.TokenJson}");
    return number % 2 == 0;
  }
}
```

Example of input data:

```
41
```

The log will contain the following:

```
Function name: <your function name>
Function version: <your function version ID>
Service account token: <token for your service account>
```

Returned string:

```
false
```