# Node.js function invocation context

_Invocation context_ is an object that is accepted by the [request handler](handler.md) as the second argument.

The invocation context provides additional information about a Node.js function version properties:
* `functionName`: The function ID.
* `functionVersion`: The ID of the function version.
* `memoryLimitInMB`: The amount of memory specified when creating the version, MB.
* `requestId`: The ID of the request being handled.
* `token`: {{ yandex-cloud }} API authentication parameters.

The context also contains the following helper methods:
* `getRemainingTimeInMillis()`: Returns the time, in ms, remaining to complete the current request.
* `getPayload()`: Returns the request body if [HTTP integration](../../concepts/function-invoke.md#http) is used. By default, HTTP integration is used for all functions invoked if no `integration=raw` parameter is specified.

## Using the invocation context {#use}

You can use the invocation context to authenticate in the {{ yandex-cloud }} API and manage the process of getting the HTTP request body (the `body` parameter).

### Authentication in the {{ yandex-cloud }} API {#token}

If a function has a service account specified, the `token` parameter contains information for authentication on behalf of this service account:
* `access_token`: [IAM token](../../../iam/concepts/authorization/iam-token.md).
* `expires_in`: Token lifetime in seconds.
* `token_type`: Token type (`Bearer`).

You can also get this information using the metadata service. For more information, see [{#T}](../../../compute/operations/vm-connect/auth-inside-vm.md#auth-inside-vm).

### Getting the request body {#getpayload}

`getPayload()` is a helper method that makes it easier to get the request body (the `body` parameter). Depending on the content of the request body and header, the function handles data using different methods:
* If a JSON document is passed as the request body and the header is set to `Content-Type: application/json`, the function returns the result of executing the `JSON.parse` method over the data that is passed in the request body.
* If form parameters are passed as the request body and the header is set to `Content-Type: application/x-www-form-urlencoded`, the function returns the result of executing the `querystring.parse` method: an object containing field keys and passed values.
