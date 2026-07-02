# Python function invocation context

_Invocation context_ is an object that contains certain [execution context](../../concepts/runtime/execution-context.md) parameters as well as the parameters for invoking the Python function itself. It is provided to the [request handler](handler.md) as the second argument.
 
The invocation context contains:
* `function_folder_id`: Folder containing the function.
* `function_name`: Function ID.
* `function_version`: Function version ID.
* `deadline_ms`: Unix timestamp of when the [function](../../concepts/function.md) times out, in ms. The `get_remaining_time_in_millis()` function returns the interval between this timestamp and the current time.
* `memory_limit_in_mb`: Amount of memory specified when creating the version, in MB.
* `request_id`: Request ID.
* `token`: Parameters for authentication with the {{ yandex-cloud }} APIs.

The context also contains the following helper methods:
* `get_remaining_time_in_millis()`: Returns the remaining time for the current request, in ms.

You can find an invocation context example [here](./handler.md#http-req).

## Using the invocation context {#use}

The invocation context provides the function with access to environment information, enabling it to monitor memory usage, track request execution time, and [authenticate](#token) with the {{ yandex-cloud }} APIs.

### Authentication with the {{ yandex-cloud }} APIs {#token}

If you specified a service account for the function, the `token` parameter contains authentication information for that service account:
* `access_token`: [IAM token](../../../iam/concepts/authorization/iam-token.md).
* `expires_in`: Token’s remaining lifetime calculated when calling the function, in seconds.
* `token_type`: Token type, e.g., `Bearer`.

You can also get this information using the metadata service. For more information about this method, see [{#T}](../../../compute/operations/vm-connect/auth-inside-vm.md#auth-inside-vm).
