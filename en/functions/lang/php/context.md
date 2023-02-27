# PHP function invocation context

_Invocation context_ is an object that is accepted by the [request handler](handler.md) of a PHP function as the second argument.

An invocation context is an object that provides additional information about a PHP function version properties. To get this information in your program, use the following methods:
* `getFunctionId()`: Returns the string ID of the function.
* `getFunctionVersionId()`: Returns the string ID of the function version.
* `getMemoryLimitInMB()`: Returns the amount of memory specified when creating the version, MB.
* `getRequestId()`: Returns the ID of the request being handled.
* `getToken()`: Returns the parameters required for authentication in the {{ yandex-cloud }} API.

## Using the invocation context {#use}

You can use the invocation context to authenticate in the {{ yandex-cloud }} API.

### Authentication in the {{ yandex-cloud }} API {#token}

If a function has a specified service account, the `getToken()` method returns a structure that contains information for authentication on behalf of this service account and provides the following set of methods to get this information:
* `getAccessToken()`: The [IAM token](../../../iam/concepts/authorization/iam-token.md).
* `getExpiresIn()`: The token lifetime in seconds.
* `getTokenType()`: The token type (`Bearer`).

You can also get this information using the metadata service. For more information, see [{#T}](../../../compute/operations/vm-connect/auth-inside-vm.md#auth-inside-vm).
