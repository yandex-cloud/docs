---
editable: false
sourcePath: en/_api-ref/kms/v1/api-ref/SymmetricKey/index.md
---

# Key Management Service API, REST: SymmetricKey

Set of methods for managing symmetric KMS keys.

## Methods

#|
||Method | Description ||
|| [Create](create.md) | Creates a symmetric KMS key in the specified folder. ||
|| [Get](get.md) | Returns the specified symmetric KMS key. ||
|| [List](list.md) | Returns the list of symmetric KMS keys in the specified folder. ||
|| [ListVersions](listVersions.md) | Returns the list of versions of the specified symmetric KMS key. ||
|| [Update](update.md) | Updates the specified symmetric KMS key. ||
|| [Delete](delete.md) | Deletes the specified symmetric KMS key. This action also automatically schedules ||
|| [SetPrimaryVersion](setPrimaryVersion.md) | Sets the primary version for the specified key. The primary version is used ||
|| [ScheduleVersionDestruction](scheduleVersionDestruction.md) | Schedules the specified key version for destruction. ||
|| [CancelVersionDestruction](cancelVersionDestruction.md) | Cancels previously scheduled version destruction, if the version hasn't been destroyed yet. ||
|| [Rotate](rotate.md) | Rotates the specified key: creates a new key version and makes it the primary version. ||
|| [ListOperations](listOperations.md) | Lists operations for the specified symmetric KMS key. ||
|| [ListAccessBindings](listAccessBindings.md) | Lists existing access bindings for the specified key. ||
|| [SetAccessBindings](setAccessBindings.md) | Sets access bindings for the key. ||
|| [UpdateAccessBindings](updateAccessBindings.md) | Updates access bindings for the specified key. ||
|#