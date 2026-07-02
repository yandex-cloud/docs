# Using a top-level function for a handler in Kotlin

To create a [handler](../handler.md) in Kotlin, you can set a [top-level function](https://kotlinlang.org/docs/functions.html#function-scope). This is a function declared within a package and requiring no class for its creation.

Here is an example of a handler that accepts a number and returns it:

```kotlin
fun handle(s: Int): Int = s
```

{% note warning %}

For top-level functions, provide only one parameter.

{% endnote %}

You can test the function from the above example in the following ways:

* In the [management console]({{ link-console-main }}), on the **{{ ui-key.yacloud.serverless-functions.item.testing.label_title }}** tab of the function page.
* Using the following HTTPS request with the [?integration=raw](../../../concepts/function-invoke.md#http) parameter:

   ```bash
   curl \
        --header "Authorization: Bearer <IAM_token>" \
        --data "<number>" \
        "https://functions.yandexcloud.net/<function_ID>?integration=raw"
   ```

   In the `--data` parameter, specify the function’s return value.

## Examples {#examples}

### Processing an HTTP request {#handle-http-request}

The script below processes an [incoming HTTP request](../../../concepts/function-invoke.md#http) and outputs the results: the HTTP status code and the response body.

`Handler.kt`:

```kotlin
data class Request(
    val httpMethod: String?,
    val headers: Map<String, String> = mapOf(),
    val body: String = ""
)

data class Response(
    val statusCode: Int,
    val body: String
)

fun handle(request: Request): Response {
    return Response(200, "Hello World!")
}
```

The result format depends on whether the user provided `?integration=raw` in the request:

* If `?integration=raw` was provided:

    ```json
    {
        "statusCode": 200,
        "body": "Hello World!"
    }
    ```

* If `?integration=raw` was not provided:

    ```text
    "Hello World!"
    ```

    The `200` code will be returned not as part of the response body, as with the `?integration=raw` parameter, but as the HTTP status code.

### HTTP request structure output {#http-request-structure}

The script below processes an incoming HTTP request and outputs its structure and the HTTP status code.

`Handler.kt`:

```kotlin
data class Response(
    val statusCode: Int,
    val body: String
)

fun handle(request: String): Response {
    return Response(200, request)
}
```
