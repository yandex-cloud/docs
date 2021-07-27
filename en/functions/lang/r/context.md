---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Invocation context

_Invocation context_ is an object that is optionally accepted by the [request handler](handler.md) if the list of parameters contains ycFunctionContext. It's a list type object with additional information about function version properties:

* `functionId`: Returns the string ID of the function.
* `functionVersion`: Returns the string ID of the function version.
* `memoryLimitInMB`: Returns the amount of memory specified when creating the version, MB.
* `requestId`: Returns the ID of the request being handled.
* `tokenJson`: Returns the parameters required for authentication in the {{ yandex-cloud }} API.

To extract information from the invocation context, use the appropriate method.

