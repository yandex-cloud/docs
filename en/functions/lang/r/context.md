---
title: R function invocation context in {{ sf-full-name }}
---

# R function invocation context

An _invocation context_ is an object that is optionally accepted by the [call handler](handler.md) if the list of parameters contains ycFunctionContext. It is a list type object containing additional information about the R function's version properties:
* `functionId`: Returns the string ID of the function.
* `functionVersion`: Returns the string ID of the function version.
* `memoryLimitInMB`: Returns the amount of memory specified when creating the version, MB.
* `requestId`: Returns the ID of the request being handled.
* `tokenJson`: Returns the parameters required for authentication in the {{ yandex-cloud }} API.

To extract information from the invocation context, use the appropriate method.
