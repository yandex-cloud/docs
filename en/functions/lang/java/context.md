---
title: Java function invocation context in {{ sf-full-name }}
---

# Java function invocation context

_Invocation context_ is an object that is optionally accepted by the [request handler](handler.md) if using the [YcFunction interface](model/yc-function.md) as the programming model. Invocation context is an object of the `yandex.cloud.sdk.functions.Context` type. It provides the following methods for getting information about function version properties:

* `getFunctionId()`: Returns the string ID of the function.
* `getFunctionVersionId()`: Returns the string ID of the function version.
* `getMemoryLimitInMB()`: Returns the amount of memory specified when creating the version, MB.
* `getRequestId()`: Returns the ID of the request being handled.
* `getTokenJson()`: Returns the parameters required for authentication in the {{ yandex-cloud }} API.

To get information from the invocation context, use one of the above functions in the handler method.
