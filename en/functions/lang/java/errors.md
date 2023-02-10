# Java function error handling

If a [handler](handler.md) reports a Java function runtime or loading error, the [runtime environment](../../concepts/runtime/index.md) automatically captures the error and returns a JSON document with the error type in the response. For more information about the JSON document format, see [Calling a function](../../concepts/function-invoke.md#error).

The error data is also written to the [execution log](logging.md). You can [view it](../../operations/function/function-logs.md) using the [YC CLI](../../../cli/) or [management console]({{ link-console-main }}).

#### Examples of error handling {#examples}

Case 1: user code goes outside the array boundaries, an `ArrayIndexOutOfBoundsException` is thrown. [The runtime environment](../../concepts/runtime/index.md) captures the exception and generates a JSON document that contains an error message (the `errorMessage` field), error type (the `errorType` field), and [stack trace](https://en.wikipedia.org/wiki/Stack_trace) (the `stackTrace` field).

Function code:

```java
import java.util.function.Function;

public class Handler implements Function<byte[], Integer> {
  @Override
  public Integer apply(byte[] input) {
    final var array = new int[]{1, 2, 3, 4, 5};
    // at this point, the function throws an ArrayIndexOutOfBoundsException
    return array[15];
  }
}
```

JSON document returned:

```json
{
  "errorMessage": "Index 15 out of bounds for length 5",
  "errorType": "ArrayIndexOutOfBoundsException",
  "stackTrace": [
    ...
  ]
}
```

Case 2: user code indicates an error by [throwing](https://docs.oracle.com/javase/tutorial/essential/exceptions/throwing.html) an exception from the function.

Function code:

```java
import java.util.function.Function;

public class Handler implements Function<byte[], Integer> {
  @Override
  public Integer apply(byte[] input) {
    throw new RuntimeException("Some error message");
  }
}
```

JSON document returned:

```json
{
  "errorMessage": "Some error message",
  "errorType": "RuntimeException",
  "stackTrace": [
    ...
  ]
}
```

