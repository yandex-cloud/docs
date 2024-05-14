# Request handler for a function in Java

A _request handler_ is a method used to process each Java function call. When creating a function version, you should specify the entry point. It consists of the name of the class that contains the handler. e.g., `orgexample.Handler`. The name of the handler file must contain no `.` before the extension, e.g., `.handler.java`.

{% note info %}

At any given time, a single function instance processes only one request. This allows you to use global variables without having to provide data integrity control.

{% endnote %}

Depending on the programming model, the handler can accept and return different data. For more information about this and available ways to set the request handler, see the [Java programming model](model/index.md).