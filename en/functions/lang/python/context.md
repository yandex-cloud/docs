---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Invocation context

_Invocation context_ is an object that contains certain parameters of the [execution context](../../concepts/runtime/execution-context.md) and parameters for invoking the function itself. It's accepted by the [request handler](handler.md) as the second argument.

The invocation context contains:

* `function_name`: Function ID.
* `function_version`: Function version ID.
* `memory_limit_in_mb`: The amount of memory specified when creating the version, MB.
* `request_id`: ID of the request being handled.
* `token`: The parameters required for authentification in the {{ yandex-cloud }} API.

The context also contains the following helper methods:

* `get_remaining_time_in_millis()`: Returns the time, in ms, remaining to complete the current request.

## Using the invocation context {#use}

The invocation context is necessary for the function to have access to information about the environment as to monitor memory usage, track the request execution time, and [authenticate](#token) in the {{ yandex-cloud }} API.

### Authentication in the {{ yandex-cloud }} API {#token}

If a function has a specified service account, the `token` parameter contains information for authentication on behalf of this service account:

* `access_token`: The [IAM token](../../../iam/concepts/authorization/iam-token.md).
* `expires_in`: The token lifetime in seconds.
* `token_type`: The token type (`Bearer`).

You can also get this information using the metadata service. For more information, see [{#T}](../../../compute/operations/vm-connect/auth-inside-vm.md#auth-inside-vm).

