# What is tracing?

When operating distributed systems, you need to be able to analyze requests that pass through several different services or infrastructure components. For example, to understand which service is responsible for the error, how long it took each one of them to complete the request, how a particular request was executed, and which services have contributed to the process. In cases like these, metrics and logs are not enough: they do not get you the full request execution context, because the request has to go through several infrastructure layers before the response is returned to the client.

## Basic terms in {#terms}

{% include [tracing-terms](../../_includes/monium/tracing-terms.md) %}

## Assigning tracing {#purpose}

You can use a trace to get answers to the following questions:

* Which service or component threw an error when processing a distributed request?
* Which operations or services have slowed down the request?
* How did the execution of a particular distributed request proceed?
