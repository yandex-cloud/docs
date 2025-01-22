---
title: Java function invocation context in {{ sf-full-name }}
description: In this article, you will learn about the Java function invocation context.
---

# Java function invocation context

_Invocation context_ is an object that is optionally accepted by the [request handler](handler.md) if using the [YcFunction interface](model/yc-function.md) as the programming model. Invocation context is a `yandex.cloud.sdk.functions.Context` type object providing the following methods for getting information about function version properties:

* `getFunctionId()`: Returns the string ID of the function.
* `getFunctionVersionId()`: Returns the string ID of the function version.
* `getMemoryLimitInMB()`: Returns the amount of memory specified when creating the version, MB.
* `getRequestId()`: Returns the request ID.
* `getTokenJson()`: Returns the parameters for authentication in the {{ yandex-cloud }} API.

To get information from the invocation context, use one of the above functions in the handler method.
