# R function error handling

If the [handler](handler.md) reports an R function execution or loading error, the [runtime](../../concepts/runtime/index.md) automatically catches the error and returns a JSON document with information about the error type. For more information about the JSON document format, see [Invoking a function](../../concepts/function-invoke.md#error).

The error info is also written to the [execution log](logging.md). You can [view](../../operations/function/function-logs.md) the log via the [{{ yandex-cloud }} CLI](../../../cli/index.yaml) or the [management console]({{ link-console-main }}).

#### Examples of error handling {#examples}

Case 1: User code goes outside the array boundaries, causing the function to throw `non-numeric argument to binary operator`. The [runtime](../../concepts/runtime/index.md) catches the exception and generates a JSON document containing the error message (the `errorMessage` field) and error type (the `errorType` field).

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
