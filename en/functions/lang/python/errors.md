# Python function error handling

If the [handler](handler.md) reports a Python function execution or loading error, the [runtime](../../concepts/runtime/index.md) automatically catches the error and returns a JSON document with details of the error type, text, and location. For more information about the JSON document format, see [Invoking a function](../../concepts/function-invoke.md#error).

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
