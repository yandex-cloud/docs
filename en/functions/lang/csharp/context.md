# Invocation context

_Invocation context_ is an object that is optionally accepted by the [request handler](handler.md) in case you use the [YcFunction interface model](model/yc-function.md). The object type is `Yandex.Cloud.Functions.Context`. It provides properties for getting more information about the function version:

* `FunctionId`: Returns the string ID of the function.
* `FunctionVersion`: Returns the string ID of the function version.
* `MemoryLimitInMB`: Returns the amount of memory specified when creating the version, MB.
* `RequestId`: Returns the ID of the request being handled.
* `TokenJson`: Returns the parameters required for authentication in the {{ yandex-cloud }} API.