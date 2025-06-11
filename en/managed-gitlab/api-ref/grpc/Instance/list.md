---
editable: false
sourcePath: en/_api-ref-grpc/gitlab/v1/api-ref/grpc/Instance/list.md
---

# Managed Service for Gitlab API, gRPC: InstanceService.List

Retrieves the list of GitLab instances in the specified folder.

## gRPC request

**rpc List ([ListInstancesRequest](#yandex.cloud.gitlab.v1.ListInstancesRequest)) returns ([ListInstancesResponse](#yandex.cloud.gitlab.v1.ListInstancesResponse))**

## ListInstancesRequest {#yandex.cloud.gitlab.v1.ListInstancesRequest}

```json
{
  "folder_id": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

Request message for InstanceService.List.

#|
||Field | Description ||
|| folder_id | **string**

ID of the folder to list instances in. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListInstancesRequest.next_page_token]
that can be used to get the next page of results in subsequent list requests. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the [ListInstancesRequest.next_page_token]
returned by the previous list request. ||
|#

## ListInstancesResponse {#yandex.cloud.gitlab.v1.ListInstancesResponse}

```json
{
  "instances": [
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
  ],
  "next_page_token": "string"
}
```

Response message for InstanceService.List.

#|
||Field | Description ||
|| instances[] | **[Instance](#yandex.cloud.gitlab.v1.Instance)**

List of GitLab instances. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListInstancesRequest.page_size](#yandex.cloud.gitlab.v1.ListInstancesRequest), use the `next_page_token` as the value
for the [ListInstancesRequest.page_token](#yandex.cloud.gitlab.v1.ListInstancesRequest) parameter in the next list request. Each subsequent
list request will have its own `next_page_token` to continue paging through the results. ||
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