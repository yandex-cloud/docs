# Python function invocation context

_Invocation context_ is an object that contains certain [execution context](../../concepts/runtime/execution-context.md) parameters as well as invocation parameters for the Python function itself. It is accepted by the [call handler](handler.md) as its second argument.

The invocation context contains:
* `function_name`: Function ID.
* `function_version`: Function version ID.
* `memory_limit_in_mb`: Amount of memory specified at version creation, MB.
* `request_id`: ID of the request being handled.
* `token`: {{ yandex-cloud }} API authentication parameters.

The context also contains the following helper methods:
* `get_remaining_time_in_millis()`: Returns the current request's remaining runtime in milliseconds.

[Invocation context example](./handler.md#http-req).

## Using the invocation context {#use}

Invocation context is required for a function to have access to environment information so that it can monitor memory usage, track request execution time, and [authenticate](#token) in the {{ yandex-cloud }} service API.

### Authentication in the {{ yandex-cloud }} API {#token}

If a function has a service account specified, the `token` parameter contains information for authentication on behalf of this service account:
* `access_token`: [IAM token](../../../iam/concepts/authorization/iam-token.md).
* `expires_in`: Token lifetime in seconds.
* `token_type`: Token type (`Bearer`).

You can also get this information using the metadata service. For more information, see [{#T}](../../../compute/operations/vm-connect/auth-inside-vm.md#auth-inside-vm).