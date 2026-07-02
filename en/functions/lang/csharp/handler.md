# Request handler for a .NET Core function in {{ sf-name }}

A _request handler_ is a method used to process each .NET Core function call. When creating a function version, you must specify the entry point, i.e., the name of the class containing the handler, e.g., `FunctionNamespace.Handler`. The handler file name must not contain any `.` before the extension or at the beginning of the handler directory name, e.g., `.handler.cs` or `.test/handler.cs`.

{% note info %}

At any given time, a single function instance processes only one request. This allows you to use global variables without the need to ensure data integrity control.

{% endnote %}

Depending on the programming model, the handler can accept and return different types of data. For more information about this and available ways to set a request handler, see [this guide](model/index.md).
