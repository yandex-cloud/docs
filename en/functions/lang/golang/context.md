---
title: Go function invocation context in {{ sf-full-name }}
description: In this article, you will learn about the Go function invocation context.
---

# Go function invocation context

_Invocation context_ is an object that is optionally accepted by the [request handler](handler.md). It is a [context.Context](https://pkg.go.dev/context#Context) type object providing an interface you can use to get more information about the Go function version properties:
* `lambdaRuntimeFunctionName`: Function ID (`string`).
* `lambdaRuntimeFunctionVersion`: Function version ID (`string`).
* `lambdaRuntimeMemoryLimit`: Amount of memory specified when creating the version, MB (`int`).
* `lambdaRuntimeRequestID`: Request ID (`string`).

To extract information from the invocation context, use its `Value(key)` method and provide to it as a string one of the keys described above as the `key` parameter.

### Authentication in the {{ yandex-cloud }} API {#token}

If a function has a specified service account, you can use the [SDK](sdk.md) to obtain information that is necessary for authentication on behalf of this service account. To get this information, use the following methods:

```golang
creds := ycsdk.InstanceServiceAccount()
token, err := creds.IAMToken(ctx)
```

The `token.IamToken` field contains the required [IAM token](../../../iam/concepts/authorization/iam-token.md).
The code above works via the [metadata service](../../../compute/operations/vm-connect/auth-inside-vm.md#auth-inside-vm) that is available in the function environment with the specified service account. 
