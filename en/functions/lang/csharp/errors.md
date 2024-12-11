# .NET Core function error handling

If a [handler](handler.md) reports a .NET Core function runtime or loading error, the [runtime environment](../../concepts/runtime/index.md) automatically intercepts the error and responds by returning a JSON document with the error type info. For more information about the JSON document format, see [Calling a function](../../concepts/function-invoke.md#error).

The error info is also written to the [execution log](logging.md). You can [view](../../operations/function/function-logs.md) the log via the [{{ yandex-cloud }} CLI](../../../cli/index.yaml) or the [management console]({{ link-console-main }}).

#### Examples of error handling {#examples}

Case 1: User code goes outside the array boundaries, resulting in `IndexOutOfRangeException`. The [runtime environment](../../concepts/runtime/index.md) intercepts the exception and generates a JSON document stating the error message (`errorMessage` field), error type (`errorType` field), and [stack trace](https://en.qwe.wiki/wiki/Stack_trace) (`stackTrace` field).

Function code:

```C#
public class Handler {
  public int FunctionHandler(byte[] input) {
    readonly var array = new int[]{1, 2, 3, 4, 5};
    // at this point, the function throws an IndexOutOfRangeException
    return array[15];
  }
}
```

JSON document returned:

```json
{
  "errorMessage": "Index was outside the bounds of the array",
  "errorType": "System.IndexOutOfRangeException",
  "stackTrace": [
    ...
  ]
}
```

Case 2: User code indicates an error by [throwing](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/throw) an exception from the function.

Function code:

```C#
public class Handler {
  public int FunctionHandler(byte[] input) {
    throw new SystemException("Some error message");
  }
}
```

JSON document returned:

```json
{
  "errorMessage": "Some error message",
  "errorType": "System.SystemException",
  "stackTrace": [
    ...
  ]
}
```
