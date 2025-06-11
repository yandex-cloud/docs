---
editable: false
sourcePath: en/_api-ref-grpc/gitlab/v1/api-ref/grpc/Instance/get.md
---

# Managed Service for Gitlab API, gRPC: InstanceService.Get

Returns the specified GitLab instance.

## gRPC request

**rpc Get ([GetInstanceRequest](#yandex.cloud.gitlab.v1.GetInstanceRequest)) returns ([Instance](#yandex.cloud.gitlab.v1.Instance))**

## GetInstanceRequest {#yandex.cloud.gitlab.v1.GetInstanceRequest}

```json
{
  "instance_id": "string"
}
```

Request message for InstanceService.Get

#|
||Field | Description ||
|| instance_id | **string**

ID of the GitLab instance to return ||
|#

## Instance {#yandex.cloud.gitlab.v1.Instance}

```json
{
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
```

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