---
editable: false
sourcePath: en/_api-ref-grpc/lockbox/v1/api-ref/grpc/Secret/index.md
---

# Lockbox API, gRPC: SecretService

A set of methods for managing secrets.

## Methods

#|
||Method | Description ||
|| [Get](get.md) | Returns the specified secret. ||
|| [List](list.md) | Retrieves the list of secrets in the specified folder. ||
|| [Create](create.md) | Creates a secret in the specified folder. ||
|| [Update](update.md) | Updates the specified secret. ||
|| [Delete](delete.md) | Deletes the specified secret. ||
|| [Activate](activate.md) | Activates the specified secret. ||
|| [Deactivate](deactivate.md) | Deactivates the specified secret. ||
|| [ListVersions](listVersions.md) | Retrieves the list of versions of the specified secret. ||
|| [AddVersion](addVersion.md) | Adds new version based on a previous one. ||
|| [ScheduleVersionDestruction](scheduleVersionDestruction.md) | Schedules the specified version for destruction. ||
|| [CancelVersionDestruction](cancelVersionDestruction.md) | Cancels previously scheduled version destruction, if the version hasn't been destroyed yet. ||
|| [ListOperations](listOperations.md) | Lists operations for the specified secret. ||
|| [ListAccessBindings](listAccessBindings.md) | Lists existing access bindings for the specified secret. ||
|| [SetAccessBindings](setAccessBindings.md) | Sets access bindings for the secret. ||
|| [UpdateAccessBindings](updateAccessBindings.md) | Updates access bindings for the secret. ||
|#