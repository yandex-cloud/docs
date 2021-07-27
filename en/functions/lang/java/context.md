---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Invocation context

_Invocation context_ is an object that is optionally accepted by the [request handler](handler.md) in case you use the [YcFunction interface model](model/yc-function.md). The object type is `yandex.cloud.sdk.functions.Context`. It provides methods for getting more information about function version properties:

* `getFunctionId()`: Returns the string ID of the function.
* `getFunctionVersionId()`: Returns the string ID of the function version.
* `getMemoryLimitInMB()`: Returns the amount of memory specified when creating the version, MB.
* `getRequestId()`: Returns the ID of the request being handled.
* `getTokenJson()`: Returns the parameters required for authentication in the {{ yandex-cloud }} API.

To extract information from the invocation context, use the appropriate method.

