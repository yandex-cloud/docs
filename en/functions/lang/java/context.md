---
title: "Java function invocation context in {{ sf-full-name }}"
---

# Java function invocation context

_Invocation context_ is an object that is optionally accepted by the [call handler](handler.md) if you are using the [YcFunction interface model](model/yc-function.md). It is a `yandex.cloud.sdk.functions.Context` type object and it provides methods for getting more information about the Java function version properties:
* `getFunctionId()`: Returns the string ID of the function.
* `getFunctionVersionId()`: Returns the string ID of the function version.
* `getMemoryLimitInMB()`: Returns the amount of memory specified when creating the version, MB.
* `getRequestId()`: Returns the ID of the request being handled.
* `getTokenJson()`: Returns the parameters required for authentication in the {{ yandex-cloud }} API.

To extract information from the invocation context, use the appropriate method.
