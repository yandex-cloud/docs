# Java function request handler

A _request handler_ is a method used to handle each Java function invocation. When creating a function version, you should specify the entry point. It consists of the name of the class that contains the handler (for example, `org.example.Handler`).

{% note info %}

At any given time, a single function instance processes only one request. This lets you use global variables without having to provide data integrity control.

{% endnote %}

Depending on the programming model, the handler can accept and return different data. For more information about this and available ways to set the request handler, see the [Java programming model](model/index.md).