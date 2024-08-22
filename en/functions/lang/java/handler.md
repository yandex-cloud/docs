# Request handler for a function in Java

A _request handler_ is a method used to process each Java function call.

When [creating a function version](../../operations/function/version-manage.md), you specify the entry point, i.e., the function that the [runtime environment](../../concepts/runtime/index.md) calls as a handler. The entry point name consists of the name of the class containing the handler, e.g., `orgexample.Handler`.

The name of the handler file must contain no `.` before the extension, e.g., `.handler.java`.

{% note info %}

At any given time, a single function instance processes only one request. This allows you to use global variables without having to provide data integrity control.

{% endnote %}

Depending on the programming model, the handler can accept and return different data. For more information about this and available ways to set a request handler, see the [Java programming model](model/index.md) section.
