# Go function invocation context

_Invocation context_ is an object that is optionally accepted by the [request handler](handler.md). The object type is `context.Context`. It provides an interface for getting more information about Go function version properties:
* `lambdaRuntimeFunctionName`: The function ID (`string`).
* `lambdaRuntimeFunctionVersion`: The function version ID (`string`).
* `lambdaRuntimeMemoryLimit`: The amount of memory specified when creating the function version, MB (`int`).
* `lambdaRuntimeRequestID`: The ID of the request being handled (`string`).

To extract information from the invocation context, use its `Value(key)` method and pass it in the `key` parameter as a string with one of the keys described above.



### Authentication in the {{ yandex-cloud }} API {#token}

If a function has a specified service account, you can use the [SDK](sdk.md) to obtain information that is necessary for authentication on behalf of this service account. To get this information, use the following methods:

```golang
creds := ycsdk.InstanceServiceAccount()
token, err := creds.IAMToken(ctx)
```

The `token.IamToken` field contains the required [IAM token](../../../iam/concepts/authorization/iam-token.md).
The code above works via the [metadata service](../../../compute/operations/vm-connect/auth-inside-vm.md#auth-inside-vm) that is available in the function environment with the specified service account.
