# R function error handling

If a [handler](handler.md) reports a R function runtime or loading error, the [runtime environment](../../concepts/runtime/index.md) automatically captures the error and returns a JSON document with the error type in the response. For more information about the JSON document format, see [Calling a function](../../concepts/function-invoke.md#error).

The error data is also written to the [execution log](logging.md). You can [view](../../operations/function/function-logs.md) it using the [{{ yandex-cloud }} CLI](../../../cli/index.yaml) or the [management console]({{ link-console-main }}).

#### Examples of error handling {#examples}

Case 1: user code goes outside the array boundaries, the `non-numeric argument to binary operator` error is returned. The [runtime environment](../../concepts/runtime/index.md) captures the error and generates a JSON document that contains the error message (the `errorMessage` field) and its type (the `errorType` field).

Function code:

```R
handler <-function() {
  return(paste0('{"result":"', "1" + 2,'"}'))
}
```

JSON document returned:

```json
{
  "errorMessage": "Error in a + b: non-numeric argument to binary operator\n",
  "errorType": "simpleError",
}
```

Case 2: user code indicates an error by [stopping](https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/stop) function execution.

Function code:

```R
handler <- function() {
  stop("Some error message")
}
```

JSON document returned:

```json
{
  "errorMessage": "Error in handler(): Some error message\n",
  "errorType": "simpleError",
}
```
