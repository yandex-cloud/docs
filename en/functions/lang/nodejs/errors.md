# Node.js function error handling

If a [handler](handler.md) reports a Node.js function runtime or loading error, the [runtime environment](../../concepts/runtime/index.md) automatically captures the error and returns a JSON document with details of the error type, text, and location in the response. For more information about the JSON document format, see [Calling a function](../../concepts/function-invoke.md#error).

The error data is also written to the [execution log](logging.md). You can [view it](../../operations/function/function-logs.md) using the [YC CLI](../../../cli/) or [management console]({{ link-console-main }}).

#### Example of error handling {#example}

Function code:

```js
module.exports.handler = function () {
    return unknownVariable;
};
```

JSON document returned:

```json
{
  "errorMessage": "unknownVariable is not defined",
  "errorType": "ReferenceError",
  "stackTrace": [
    ...
  ]
}
```

