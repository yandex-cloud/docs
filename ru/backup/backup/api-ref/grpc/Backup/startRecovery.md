---
editable: false
sourcePath: en/_api-ref-grpc/backup/v1/backup/api-ref/grpc/Backup/startRecovery.md
---

# Cloud Backup API, gRPC: BackupService.StartRecovery

Start recovery process of specified backup to specific Compute Cloud instance.

For details, see [Restoring a VM from a backup](/docs/backup/operations/backup-vm/recover).

## gRPC request

**rpc StartRecovery ([StartRecoveryRequest](#yandex.cloud.backup.v1.StartRecoveryRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## StartRecoveryRequest {#yandex.cloud.backup.v1.StartRecoveryRequest}

```json
{
  "compute_instance_id": "string",
  "backup_id": "string"
}
```

#|
||Field | Description ||
|| compute_instance_id | **string**

Required field. Destination Compute Cloud instance ID to which backup should be applied. ||
|| backup_id | **string**

Required field. Backup ID that will be applied to destination Compute Cloud instance. ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "progress_percentage": "double",
    "src_backup_id": "string",
    "dst_compute_instance_id": "string"
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
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[StartRecoveryMetadata](#yandex.cloud.backup.v1.StartRecoveryMetadata)**

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

## StartRecoveryMetadata {#yandex.cloud.backup.v1.StartRecoveryMetadata}

#|
||Field | Description ||
|| progress_percentage | **double**

Progress of the backup process. ||
|| src_backup_id | **string**

Source Backup ID that will be applied. ||
|| dst_compute_instance_id | **string**

Destination Compute Cloud instance ID to which backup will be applied. ||
|#