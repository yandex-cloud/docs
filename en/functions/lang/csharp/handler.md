# Request handler for a .NET Core function in {{ sf-name }}

A _request handler_ is a method used to process each .NET Core function call. When creating a function version, you should specify the entry point, i.e., the name of the class containing the handler, e.g., `FunctionNamespace.Handler`. The handler file name must not have the `.` character before the extension and preceding the name of the directory the handler resides in, e.g., `.handler.cs` or `.test/handler.cs`.

{% note info %}

At any given time, a single function instance processes only one request. This allows you to use global variables without having to provide data integrity control.

{% endnote %}

Depending on the programming model, the handler can accept and return different data. For more information about this and available ways to set the request handler, see the [relevant section](model/index.md).
