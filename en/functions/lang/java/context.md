---
title: Java function invocation context in {{ sf-full-name }}
description: In this article, you will learn about the Java function invocation context.
---

# Java function invocation context

_Invocation context_ is the current function invocation metadata comprising function ID, function version ID, function version RAM size, request ID, and {{ yandex-cloud }} API authentication parameters.

The availability of the invocation context from within the function and the method of obtaining it depend on the Java [programming model](./model/index.md) used.

## YcFunction interface {#yc-function}

If you are using the [YcFunction interface](model/yc-function.md) as your programming model, the invocation context is a `yandex.cloud.sdk.functions.Context` class object. To get information about the function version properties, use this object's methods in the handler method:

* `getFunctionId()`: Returns the string ID of the function.
* `getFunctionVersionId()`: Returns the string ID of the function version.
* `getMemoryLimitInMB()`: Returns the amount of memory specified when creating the version, MB.
* `getRequestId()`: Returns the request ID.
* `getTokenJson()`: Returns the parameters for authentication in the {{ yandex-cloud }} API.

For more information, see [Using the YcFunction interface for a Java handler](./model/yc-function.md#http-info).

## HttpServlet class {#httpservlet}

If you are using the [HttpServlet class](./model/servlet-api.md) as your programming model, you can get the invocation context in HTTP headers together with the information on the HTTP request used to invoke the function:

* `Lambda-Runtime-Function-Name`: Function string ID.
* `Lambda-Runtime-Function-Version`: Function version string ID.
* `Lambda-Runtime-Memory-Limit`: Amount of memory specified when creating the version, MB.
* `Lambda-Runtime-Aws-Request-Id`: Request ID.
* `Lambda-Runtime-Token-Json`: Parameters for authentication in the APIs of {{ yandex-cloud }} services.

For more information, see [Using the HttpServlet class to specify a Java handler](./model/servlet-api.md#get-context).