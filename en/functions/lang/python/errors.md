# Python function error handling

If a [handler](handler.md) reports a Python function runtime or loading error, the [runtime environment](../../concepts/runtime/index.md) automatically captures the error and returns a JSON document with details of the error type, text, and location in the response. For more information about the JSON document format, see [Calling a function](../../concepts/function-invoke.md#error).

The error info is also written to the [execution log](logging.md). You can [view](../../operations/function/function-logs.md) the log via the [{{ yandex-cloud }} CLI](../../../cli/) or the [management console]({{ link-console-main }}).

#### Example of error handling {#example}

Function code:

```python
def handler(event, context):
    return unknownVariable
```

JSON document returned:

```json
{
    "errorMessage": "name 'unknownVariable' is not defined",
    "errorType": "NameError",
    "stackTrace": [
        "  File \"/function/runtime/runtime.py\", line 155, in handle_event\n    result = h(r.event, r.context)\n",
        "  File \"/function/code/main.py\", line 2, in handler\n    return unknownVariable\n"
    ]
}
```
