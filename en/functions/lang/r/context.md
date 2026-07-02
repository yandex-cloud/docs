---
title: R function invocation context in {{ sf-full-name }}
description: In this article, you will learn about the R function invocation context.
---

# R function invocation context

_Invocation context_ is an object that is optionally accepted by the [request handler](handler.md) if the list of parameters contains `ycFunctionContext`. It is a list-type object with additional information about the R function's version properties:
* `functionFolderId`: Returns the folder containing the function.
* `functionId`: Returns the string ID of the function.
* `functionVersion`: Returns the string ID of the function version.
* `memoryLimitInMB`: Returns the amount of memory specified when creating the version, in MB.
* `requestId`: Returns the request ID.
* `tokenJson`: Returns the parameters for authentication with the {{ yandex-cloud }} APIs.

To extract information from the invocation context, use the appropriate method.
