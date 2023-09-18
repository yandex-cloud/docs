# C# function error handling

If a [handler](handler.md) reports a C# function runtime or loading error, the [runtime environment](../../concepts/runtime/index.md) automatically captures the error and returns a JSON document with the error type in the response. For more information about the JSON document format, see [Calling a function](../../concepts/function-invoke.md#error).

The error data is also written to the [execution log](logging.md). You can [view](../../operations/function/function-logs.md) it using the [{{ yandex-cloud }} CLI](../../../cli/index.yaml) or the [management console]({{ link-console-main }}).

#### Examples of error handling {#examples}

Case 1: user code goes outside the array boundaries, an `IndexOutOfRangeException` is thrown. The [runtime environment](../../concepts/runtime/index.md) captures the exception and generates a JSON document that contains an error message (the `errorMessage` field), error type (the `errorType` field), and [stack trace](https://en.qwe.wiki/wiki/Stack_trace) (the `stackTrace` field).

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

Case 2: user code indicates an error by [throwing](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/keywords/throw) an exception from the function.

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
