---
editable: false
sourcePath: en/_api-ref-grpc/backup/v1/backup/api-ref/grpc/Backup/startFilesRecovery.md
---

# Cloud Backup API, gRPC: BackupService.StartFilesRecovery {#StartFilesRecovery}

StartFilesRecovery runs recovery process of selected files to specific Compute Cloud instance.

## gRPC request

**rpc StartFilesRecovery ([StartFilesRecoveryRequest](#yandex.cloud.backup.v1.StartFilesRecoveryRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## StartFilesRecoveryRequest {#yandex.cloud.backup.v1.StartFilesRecoveryRequest}

```json
{
  "computeInstanceId": "string",
  "backupId": "string",
  "opts": {
    "overwrite": "Overwrite",
    "rebootIfNeeded": "bool",
    // Includes only one of the fields `original`, `custom`
    "original": "TargetPathOriginal",
    "custom": {
      "path": "string"
    }
    // end of the list of possible fields
  },
  "sourceIds": [
    "string"
  ]
}
```

#|
||Field | Description ||
|| computeInstanceId | **string**

Required field. Destination instance ID. ||
|| backupId | **string**

Required field. Backup ID. ||
|| opts | **[FilesRecoveryOptions](#yandex.cloud.backup.v1.FilesRecoveryOptions)**

Required field.  ||
|| sourceIds[] | **string** ||
|#

## FilesRecoveryOptions {#yandex.cloud.backup.v1.FilesRecoveryOptions}

#|
||Field | Description ||
|| overwrite | enum **Overwrite**

Overwrite options declares the behavior for files that already exists on the file system.

- `OVERWRITE_UNSPECIFIED`: Unspecified value treated as Overwrite all
- `OVERWRITE_ALL`: All overwrites all existing files by recovered ones.
- `OVERWRITE_OLDER`: Older overwrites older files only.
- `OVERWRITE_NONE`: None does not overwrites files at all. ||
|| rebootIfNeeded | **bool**

specifies whether the recovery plan is able to reboot host if needed. ||
|| original | **[TargetPathOriginal](#yandex.cloud.backup.v1.TargetPathOriginal)**

Keep original paths of files.

Includes only one of the fields `original`, `custom`.

Path strategy for selected files. ||
|| custom | **[TargetPathCustom](#yandex.cloud.backup.v1.TargetPathCustom)**

Set custom folder for file recovery.

Includes only one of the fields `original`, `custom`.

Path strategy for selected files. ||
|#

## TargetPathOriginal {#yandex.cloud.backup.v1.TargetPathOriginal}

#|
||Field | Description ||
|| Empty | > ||
|#

## TargetPathCustom {#yandex.cloud.backup.v1.TargetPathCustom}

#|
||Field | Description ||
|| path | **string**

Custom folder for file recovery. ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "google.protobuf.Timestamp",
  "createdBy": "string",
  "modifiedAt": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "progressPercentage": "double",
    "computeInstanceId": "string",
    "backupId": "string",
    "sourceIds": [
      "string"
    ]
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": "google.protobuf.Empty"
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[StartFilesRecoveryMetadata](#yandex.cloud.backup.v1.StartFilesRecoveryMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## StartFilesRecoveryMetadata {#yandex.cloud.backup.v1.StartFilesRecoveryMetadata}

#|
||Field | Description ||
|| progressPercentage | **double** ||
|| computeInstanceId | **string**

Required field. Destination instance ID. ||
|| backupId | **string**

Required field. Backup ID. ||
|| sourceIds[] | **string** ||
|#