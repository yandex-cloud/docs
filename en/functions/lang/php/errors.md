# PHP function error handling

If a [handler](handler.md) reports a PHP function runtime or loading error, the [runtime environment](../../concepts/runtime/index.md) automatically captures the error and returns a JSON document with details of the error type, text, and location in the response. For more information about the JSON document format, see [Calling a function](../../concepts/function-invoke.md#error).

The error data is also written to the [execution log](logging.md). You can [view](../../operations/function/function-logs.md) it using the [{{ yandex-cloud }} CLI](../../../cli/index.yaml) or the [management console]({{ link-console-main }}).

#### Example of error handling {#example}

Function code:

```php
<?php

function myHandler ($event, $context) {
    return undefinedFunction();
}
```

JSON document returned:

```json
{
  "errorMessage": "Call to undefined function undefinedFunction()",
  "errorType": "Error",
  "stackTrace": [
    ...
  ]
}
```
