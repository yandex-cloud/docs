# Request handler for a function in R

A _request handler_ is a function used to process each R function call. When creating a function version, you must specify the entry point, which consists of the file name and the name of the R function that receives the request (see example for the handler in the `function.R` or `function.handler` file).

{% note info %}

At any given time, a single function instance processes only one request.

{% endnote %}

The handler can accept and return various types of data. For more information about this and available ways to set a request handler, see [this guide](model/).
