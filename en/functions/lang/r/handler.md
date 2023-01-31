# R function request handler

A _request handler_ is a function that is used to handle each R function invocation. When creating a function version, you should specify the entry point. It consists of the file name and the name of the R function where requests are sent (see example for the handler in the `function.R` or `function.handler` file).

{% note info %}

At any given time, a single function instance processes only one request.

{% endnote %}

The handler can accept and return various data. For more information about this and available ways to set the request handler, see the [relevant section](model/).
