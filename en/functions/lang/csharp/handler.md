# Request handler of a C# function in {{ sf-name }}

A _request handler_ is a method used to handle each C# function invocation. When creating a function version, you should specify the name of the class that contains the handler (for example, `FunctionNamespace.Handler`) as the entry point.


{% note info %}

At any given time, a single function instance processes only one request. This lets you use global variables without having to provide data integrity control.

{% endnote %}


Depending on the programming model, the handler can accept and return different data. For more detail on this and on available ways to set the request handler, see the [relevant section](model/index.md).




