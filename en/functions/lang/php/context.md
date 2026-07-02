# PHP function invocation context

_Invocation context_ is an object that is accepted by the [request handler](handler.md) of a function in PHP as the second argument.

This object provides additional information about a PHP function version properties. To get this information in your program, use the following methods:
* `getFunctionFolderId()`: Returns the folder containing the function.
* `getFunctionId()`: Returns the string ID of the function.
* `getFunctionVersionId()`: Returns the string ID of the function version.
* `getMemoryLimitInMB()`: Returns the amount of memory specified when creating the version, in MB.
* `getRequestId()`: Returns the request ID.
* `getToken()`: Returns the parameters for authentication with the {{ yandex-cloud }} APIs.

## Using the invocation context {#use}

You can use the invocation context to authenticate with the {{ yandex-cloud }} APIs.

### Authentication with the {{ yandex-cloud }} APIs {#token}

If you specified a service account for the function, the `getToken()` method will return a structure with authentication information for that account. You can use the following methods to get this information:
* `getAccessToken()`: [IAM token](../../../iam/concepts/authorization/iam-token.md).
* `getExpiresIn()`: Token lifetime, in seconds.
* `getTokenType()`: Token type, e.g.,`Bearer`.

You can also get this information using the metadata service. For more information about this method, see [{#T}](../../../compute/operations/vm-connect/auth-inside-vm.md#auth-inside-vm).
