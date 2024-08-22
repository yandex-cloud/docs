# Kotlin function error handling

If a [handler](handler.md) reports a function runtime or loading error, the [runtime environment](../../concepts/runtime/index.md) automatically captures the error and returns a JSON document with the error type in the response. For more information about the JSON document format, see [Calling a function](../../concepts/function-invoke.md#error). Error info is written to the [execution log](logging.md).

## Examples of error handling {#examples}

Let's assume a handler returns a sum of numbers. An empty request will cause the handler to throw `IllegalArgumentException`.

Function code:

```kotlin
fun handle(request: IntArray): Int {
    if (request.isEmpty()) throw IllegalArgumentException()
    return request.sum()
}
```

Case 1. When invoking a function, the user provides the `[1, 22, 333]` array:

```bash
curl -H "Authorization: Bearer <IAM_token>" \
     --data "[1, 22, 333]" \
     "https://functions.yandexcloud.net/<finction_ID>?integration=raw"
```

The function returns `356`, which is the sum of these numbers.

Case 2. The user provides an empty array:

```bash
curl -H "Authorization: Bearer <IAM_token>" \
     --data "[]" \
     "https://functions.yandexcloud.net/<function_ID>?integration=raw"
```

The runtime environment captures the exception and generates a JSON document that contains an error message (the `errorMessage` field), error type (the `errorType` field), and [stack trace](https://ru.qwe.wiki/wiki/Stack_trace) (the `stackTrace` field).

JSON document returned:

```json
{
    "errorMessage": "An exception has occurred in the user code, details: java.lang.IllegalArgumentException. [ERR_USER_CODE]",
    "errorType": "IllegalArgumentException",
    "stackTrace": [
        {
            "function": "handle",
            "file": "Handler.kt",
            "line": 2
        },
            ...
    ]
}
```

Case 3. The user provides a string instead of numbers, which results in a deserialization error:

```bash
curl -H "Authorization: Bearer <IAM_token>" \
     --data "notanarray" \
     "https://functions.yandexcloud.net/<function_ID>?integration=raw"
```

JSON document returned:

```json
{
    "errorMessage": "An exception has occurred during request deserialization. Details: com.squareup.moshi.JsonEncodingException: Use JsonReader.setLenient(true) to accept malformed JSON at path $. [ERR_INVALID_REQUEST]",
    "errorType": "FunctionException"
}
```
