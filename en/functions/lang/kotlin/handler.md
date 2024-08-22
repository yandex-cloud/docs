# Request handler for a function in Kotlin

A _request handler_ is a method used to process each Kotlin function call. Here is an example of a script with the `handle` method acting as a handler:

```kotlin
data class Response(
    val statusCode: Int,
    val body: String
)

fun handle(request: String): Response {
    return Response(200, request)
}
```

The script processes an [incoming HTTP request](../../concepts/function-invoke.md#http) and outputs its structure and HTTP response code. The script uses a top-level function as the [programming model in Kotlin](model/index.md).

When [creating a function version](../../operations/function/version-manage.md), you specify the entry point, i.e., the function that the [runtime environment](../../concepts/runtime/index.md) calls as a handler. The entry point name depends on the programming model being used:

* For a top-level fuction: `<package_name>.<handler_file_name>::<handler_method_name>`, e.g., `somepackage.Handler::handle_http`.

   When naming the entry point, specify the file name without its extension.

   If your method is `handle`, you may skip it.

* For the YcFunction interface: `<package_name>.<class_name>`, e.g., `somepackage.Handler`.

The name of the handler file must contain no `.` before the extension, e.g., `.Handler.kt`.

{% note info %}

At any given time, a single function instance processes only one request. This allows you to use global variables without having to provide data integrity control.

{% endnote %}
