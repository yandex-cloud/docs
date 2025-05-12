# R function error handling

If a [handler](handler.md) reports a R function runtime or loading error, the [runtime environment](../../concepts/runtime/index.md) automatically captures the error and returns a JSON document with the error type in the response. For more information about the JSON document format, see [Calling a function](../../concepts/function-invoke.md#error).

The error info is also written to the [execution log](logging.md). You can [view](../../operations/function/function-logs.md) the log via the [{{ yandex-cloud }} CLI](../../../cli/index.yaml) or the [management console]({{ link-console-main }}).

#### Examples of error handling {#examples}

Case 1: User code goes outside the array boundaries, resulting in `non-numeric argument to binary operator`. The [runtime environment](../../concepts/runtime/index.md) intercepts the exception and generates a JSON document stating the error message (`errorMessage` field) and error type (`errorType` field).

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

Case 2: User code indicates an error by [throwing](https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/stop) an exception from the function.

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
