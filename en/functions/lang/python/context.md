# Python function invocation context

_Invocation context_ is an object that contains certain [execution context](../../concepts/runtime/execution-context.md) parameters as well as invocation parameters for the Python function itself. It is accepted by the [call handler](handler.md) as its second argument.
 
The invocation context contains:
* `function_folder_id`: Folder containing the function.
* `function_name`: Function ID.
* `function_version`: Function version ID.
* `deadline_ms`: Unix timestamp of when the [function](../../concepts/function.md) times out, in ms. The `get_remaining_time_in_millis()` function returns the interval between this timestamp and the current time.
* `memory_limit_in_mb`: Amount of memory specified when creating the version, MB.
* `request_id`: Request ID.
* `token`: Parameters for authentication in the APIs of {{ yandex-cloud }} services.

The context also contains the following helper methods:
* `get_remaining_time_in_millis()`: Returns the remaining time for the current request, in ms.

[Invocation context example](./handler.md#http-req).

## Using the invocation context {#use}

Invocation context is required for a function to have access to environment information so that it can monitor memory usage, track request execution time, and [authenticate](#token) in the {{ yandex-cloud }} service API.

### Authentication in the {{ yandex-cloud }} API {#token}

If you specified a service account for a function, the `token` parameter contains authentication information for that service account:
* `access_token`: [IAM token](../../../iam/concepts/authorization/iam-token.md).
* `expires_in`: Token’s remaining lifetime calculated when calling the function, in seconds.
* `token_type`: Token type, e.g., `Bearer`.

You can also get this information using the metadata service. For more information about this method, see [{#T}](../../../compute/operations/vm-connect/auth-inside-vm.md#auth-inside-vm).
