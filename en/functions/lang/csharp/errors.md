# .NET Core function error handling

If the [handler](handler.md) reports a .NET Core function execution or loading error, the [runtime](../../concepts/runtime/index.md) automatically catches the error and returns a JSON document with information about the error type. For more information about the JSON document format, see [Invoking a function](../../concepts/function-invoke.md#error).

The error info is also written to the [execution log](logging.md). You can [view](../../operations/function/function-logs.md) the log via the [{{ yandex-cloud }} CLI](../../../cli/index.yaml) or the [management console]({{ link-console-main }}).

#### Examples of error handling {#examples}

Case 1: User code goes outside the array boundaries, causing the function to throw `IndexOutOfRangeException`. The [runtime](../../concepts/runtime/index.md) catches the exception and generates a JSON document containing the error message (the `errorMessage` field), error type (the `errorType` field), and [stack trace](https://en.qwe.wiki/wiki/Stack_trace) (the `stackTrace` field).

Function code:

```C#
public class Handler {
  public int FunctionHandler(byte[] input) {
    readonly var array = new int[]{1, 2, 3, 4, 5};
    // At this point, the function throws IndexOutOfRangeException.
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
