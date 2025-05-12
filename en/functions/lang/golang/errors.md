# Go function error handling

If a [handler](handler.md) reports a Go function runtime or loading error, the [runtime environment](../../concepts/runtime/index.md) automatically captures the error and returns a JSON document with the error type in the response. For more information about the JSON document format, see [Calling a function](../../concepts/function-invoke.md#error).

The error info is also written to the [execution log](logging.md). You can [view](../../operations/function/function-logs.md) the log via the [{{ yandex-cloud }} CLI](../../../cli/index.yaml) or the [management console]({{ link-console-main }}).

#### Examples of error handling {#examples}

Case 1: User code goes outside the array boundaries; `panic` is expected. In fact, the [handler](handler.md) captures `panic` automatically, aggregates information about it, and generates a JSON document stating an error message (`errorMessage` field), error type (`errorType` field), and [stack trace](https://en.qwe.wiki/wiki/Stack_trace) (`stackTrace` field).

Function code:

```golang
package main

func Handler () (int, error) {
  array := []int{1, 2, 3, 4, 5}
  return array[15], nil
}
```

JSON document returned:

```json
{
  "errorMessage": "user code execution causes panic: runtime error: index out of range [15] with length 5",
  "errorType": "UserCodePanic",
  "stackTrace": [
    ...
  ]
}
```

Case 2: User code reports an error by returning it from the function. In this case, the [handler](handler.md) detects this error and generates a JSON document stating a custom error message (`errorMessage` field) and its type (`errorType` field).

Function code:

```golang
package main

import "fmt"

func Handler () (int, error) {
  return 0, fmt.Errorf("an error")
}
```

JSON document returned:

```json
{
  "errorMessage": "an error",
  "errorType": "UserCodeError"
}
```
