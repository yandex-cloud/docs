---
editable: false
sourcePath: en/_api-ref-grpc/gitlab/v1/api-ref/grpc/Instance/start.md
---

# Managed Service for Gitlab API, gRPC: InstanceService.Start

Starts the specified GitLab instance.

## gRPC request

**rpc Start ([StartInstanceRequest](#yandex.cloud.gitlab.v1.StartInstanceRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## StartInstanceRequest {#yandex.cloud.gitlab.v1.StartInstanceRequest}

```json
{
  "instance_id": "string"
}
```

Request message for InstanceService.Start.

#|
||Field | Description ||
|| instance_id | **string**

ID of the GitLab instance to start. ||
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
    "instance_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "folder_id": "string",
    "created_at": "google.protobuf.Timestamp",
    "updated_at": "google.protobuf.Timestamp",
    "name": "string",
    "description": "string",
    "labels": "map<string, string>",
    "resource_preset_id": "string",
    "disk_size": "int64",
    "status": "Status",
    "admin_login": "string",
    "admin_email": "string",
    "domain": "string",
    "subnet_id": "string",
    "planned_operation": {
      "info": "string",
      "delayed_until": "google.protobuf.Timestamp",
      "latest_maintenance_time": "google.protobuf.Timestamp",
      "next_maintenance_window_time": "google.protobuf.Timestamp"
    },
    "backup_retain_period_days": "int64",
    "maintenance_delete_untagged": "bool",
    "deletion_protection": "bool",
    "approval_rules_id": "string",
    "gitlab_version": "string"
  }
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
|| metadata | **[StartInstanceMetadata](#yandex.cloud.gitlab.v1.StartInstanceMetadata)**

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
|| response | **[Instance](#yandex.cloud.gitlab.v1.Instance)**

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

## StartInstanceMetadata {#yandex.cloud.gitlab.v1.StartInstanceMetadata}

Metadata message for InstanceService.Start.

#|
||Field | Description ||
|| instance_id | **string**

ID of the GitLab instance being started. ||
|#

## Instance {#yandex.cloud.gitlab.v1.Instance}

Instance represents a GitLab instance with its configuration and state.

#|
||Field | Description ||
|| id | **string**

Unique instance ID. ||
|| folder_id | **string**

Folder ID where instance resides. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Last update timestamp. ||
|| name | **string**

Human-readable name. ||
|| description | **string**

Instance description. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as key-value pairs. ||
|| resource_preset_id | **string**

Resource preset ID. ||
|| disk_size | **int64**

Disk size in bytes. ||
|| status | enum **Status**

Current instance status.

- `STATUS_UNSPECIFIED`: Default state.
- `CREATING`: Instance is being created.
- `RUNNING`: Instance is running normally.
- `UPDATING`: Instance is being updated.
- `ERROR`: Instance is in error state.
- `DELETING`: Instance is being deleted.
- `BACKUP_CREATING`: Backup is being created.
- `BACKUP_RESTORING`: Backup is being restored.
- `STARTING`: Instance is starting.
- `STOPPING`: Instance is stopping.
- `STOPPED`: Instance is stopped.
- `BACKGROUND_MIGRATIONS`: Background migrations in progress.
- `OBJECT_STORAGE_MIGRATIONS`: Object storage migrations in progress.
- `SNAPSHOT_RESTORING`: Snapshot is being restored. ||
|| admin_login | **string**

Admin username. ||
|| admin_email | **string**

Admin email. ||
|| domain | **string**

Instance domain. ||
|| subnet_id | **string**

Subnet ID. ||
|| planned_operation | **[MaintenanceOperation](#yandex.cloud.gitlab.v1.MaintenanceOperation)**

Planned maintenance operation. ||
|| backup_retain_period_days | **int64**

How long to keep backups (days). ||
|| maintenance_delete_untagged | **bool**

Delete untagged resources during maintenance. ||
|| deletion_protection | **bool**

Protect from accidental deletion. ||
|| approval_rules_id | **string**

Approval rules ID. ||
|| gitlab_version | **string**

GitLab version of the instance. ||
|#

## MaintenanceOperation {#yandex.cloud.gitlab.v1.MaintenanceOperation}

#|
||Field | Description ||
|| info | **string**

The description of the operation. ||
|| delayed_until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Delay time for the maintenance operation. ||
|| latest_maintenance_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time of the last maintenance window. ||
|| next_maintenance_window_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time of the next maintenance window. ||
|#