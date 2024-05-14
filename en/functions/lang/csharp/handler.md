# Request handler for a {{ sf-name }} function in C#

A _request handler_ is a method used to process each C# function call. When creating a function version, you should specify the entry point, i.e., the name of the class containing the handler, e.g., `FunctionNamespace.Handler`. The name of the handler file must contain no `.` before the extension and at the beginning of the name of the directory containing the handler file, e.g., `.handler.cs` or `.test/handler.cs`.

{% note info %}

At any given time, a single function instance processes only one request. This allows you to use global variables without having to provide data integrity control.

{% endnote %}

Depending on the programming model, the handler can accept and return different data. For more information about this and available ways to set the request handler, see the [relevant section](model/index.md).
