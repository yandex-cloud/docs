# Kotlin function error handling

If the [handler](handler.md) reports a function execution or loading error, the [runtime](../../concepts/runtime/index.md) automatically catches the error and returns a JSON document with information about the error type. For more information about the JSON document format, see [Invoking a function](../../concepts/function-invoke.md#error). Error details are written to the [execution log](logging.md).

## Examples of error handling {#examples}

Let's assume the handler returns the sum of numbers. An empty request will cause the handler to throw `IllegalArgumentException`.

Function code:

```kotlin
fun handle(request: IntArray): Int {
    if (request.isEmpty()) throw IllegalArgumentException()
    return request.sum()
}
```

Case 1. When invoking a function, the user provides the `[1, 22, 333]` array:

```bash
curl \
     --header "Authorization: Bearer <IAM_token>" \
     --data "[1, 22, 333]" \
     "https://functions.yandexcloud.net/<function_ID>?integration=raw"
```

The function returns `356`, the sum of the numbers.

Case 2. The user provides an empty array:

```bash
curl \
     --header "Authorization: Bearer <IAM_token>" \
     --data "[]" \
     "https://functions.yandexcloud.net/<function_ID>?integration=raw"
```

The runtime catches the exception and generates a JSON document containing the error message (the `errorMessage` field), error type (the `errorType` field), and [stack trace](https://ru.qwe.wiki/wiki/Stack_trace) (the `stackTrace` field).

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
curl \
     --header "Authorization: Bearer <IAM_token>" \
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
