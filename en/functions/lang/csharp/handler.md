# {{ sf-name }} call handler in C#

A _call handler_ is a method used to handle each C# function call. When creating a function version, you need to specify the entry point: the name of the class that contains the handler (e.g., `FunctionNamespace.Handler`).


{% note info %}

At any given time, a single function instance processes only one request. This allows you to use global variables without having to provide data integrity control.

{% endnote %}


Depending on the programming model, the handler can accept and return different data. For more detail on this and on available ways to set a call handler, see the [relevant section](model/index.md).




