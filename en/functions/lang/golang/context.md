---
title: Go function invocation context in {{ sf-full-name }}
description: In this article, you will learn about the Go function invocation context.
---

# Go function invocation context

_Invocation context_ is an object that is optionally accepted by the [request handler](handler.md). It is a [context.Context](https://pkg.go.dev/context#Context) type object providing an interface you can use to get more information about the Go function version properties:
* `yFunctionFolderID`: Folder containing the function.
* `lambdaRuntimeFunctionName`: Function ID (`string`).
* `lambdaRuntimeFunctionVersion`: Function version ID (`string`).
* `lambdaRuntimeMemoryLimit`: Amount of memory specified when creating the version, in MB (`int`).
* `lambdaRuntimeRequestID`: Request ID (`string`).

To extract information from the invocation context, use its `Value(key)` method and provide to it as a string one of the keys described above as the `key` parameter.

### Authentication with the {{ yandex-cloud }} APIs {#token}

If you specified a service account for the function, you can use the [SDK](sdk.md) to obtain authentication information for that service account. To get this information, use the following methods:

```golang
creds := ycsdk.InstanceServiceAccount()
token, err := creds.IAMToken(ctx)
```

The `token.IamToken` field contains the required [IAM token](../../../iam/concepts/authorization/iam-token.md).
The code above works through the [metadata service](../../../compute/operations/vm-connect/auth-inside-vm.md#auth-inside-vm) that is available in the function environment with the specified service account. 
