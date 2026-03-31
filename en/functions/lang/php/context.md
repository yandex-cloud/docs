# PHP function invocation context

_Invocation context_ is an object that is accepted by the [request handler](handler.md) of a PHP function as the second argument.

An invocation context is an object that provides additional information about a PHP function version properties. To get this information in your program, use the following methods:
* `getFunctionFolderId()`: Returns the folder containing the function.
* `getFunctionId()`: Returns the string ID of the function.
* `getFunctionVersionId()`: Returns the string ID of the function version.
* `getMemoryLimitInMB()`: Returns the amount of memory specified when creating the version, MB.
* `getRequestId()`: Returns the request ID.
* `getToken()`: Returns the parameters for authentication in the {{ yandex-cloud }} API.

## Using the invocation context {#use}

You can use the invocation context to authenticate in the {{ yandex-cloud }} API.

### Authentication in the {{ yandex-cloud }} API {#token}

If a function specifies a service account, the `getToken()` method will return a structure with information for account authentication. You can use the following methods to get this information:
* `getAccessToken()`: [IAM token](../../../iam/concepts/authorization/iam-token.md).
* `getExpiresIn()`: Token lifetime in seconds.
* `getTokenType()`: Token type, e.g.,`Bearer`.

You can also get this information using the metadata service. For more information about this method, see [{#T}](../../../compute/operations/vm-connect/auth-inside-vm.md#auth-inside-vm).
