# Node.js function invocation context

_Invocation context_ is an object that is accepted by the [request handler](handler.md) of a function in Node.js as the second argument.

The invocation context provides additional information about a Node.js function version properties:

* `functionFolderId`: Folder containing the function.
* `functionName`: Function ID.
* `functionVersion`: Function version ID.
* `memoryLimitInMB`: Amount of memory specified when creating the version, MB.
* `requestId`: Request ID.
* `token`: Parameters for authentication in the APIs of {{ yandex-cloud }} services.

The context also contains the following helper methods:
* `getRemainingTimeInMillis()`: Returns the remaining time for the current request, in ms.
* `getPayload()`: Returns the request body if [HTTP integration](../../concepts/function-invoke.md#http) is used. By default, HTTP integration is used for all function invocations if `?integration=raw` is not specified.

## Using the invocation context {#use}

You can use the invocation context to authenticate with {{ yandex-cloud }} APIs and manage how the HTTP request `body` is retrieved.

### Authentication in the {{ yandex-cloud }} API {#token}

If you specified a service account for a function, the `token` parameter contains authentication information for that service account:
* `access_token`: [IAM token](../../../iam/concepts/authorization/iam-token.md).
* `expires_in`: Token lifetime in seconds.
* `token_type`: Token type, e.g.,`Bearer`.

You can also get this information using the metadata service. For more information about this method, see [{#T}](../../../compute/operations/vm-connect/auth-inside-vm.md#auth-inside-vm).

### Getting the request body {#getpayload}

`getPayload()` is a helper method that simplifies getting the request `body`. Depending on the content of the request body and header, the function uses different methods to process data:
* If the request body is a JSON document and the header is `Content-Type: application/json`, the function returns the result of `JSON.parse` executed over the request body data.
* If the request body contains form parameters and the header is `Content-Type: application/x-www-form-urlencoded`, the function returns the result of `querystring.parse`, which is an object with field keys and values.
