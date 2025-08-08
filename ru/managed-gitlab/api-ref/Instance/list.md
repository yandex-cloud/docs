---
editable: false
apiPlayground:
  - url: https://gitlab.{{ api-host }}/gitlab/v1/instances
    method: get
    path: null
    query:
      type: object
      properties:
        folderId:
          description: |-
            **string**
            ID of the folder to list instances in.
          type: string
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page to return. If the number of available
            results is larger than `pageSize`, the service returns a [ListInstancesRequest.next_page_token]
            that can be used to get the next page of results in subsequent list requests.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. To get the next page of results, set `pageToken` to the [ListInstancesRequest.next_page_token]
            returned by the previous list request.
          type: string
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/gitlab/v1/api-ref/Instance/list.md
---

# Managed Service for Gitlab API, REST: Instance.List

Retrieves the list of GitLab instances in the specified folder.

## HTTP request

```
GET https://gitlab.{{ api-host }}/gitlab/v1/instances
```

## Query parameters {#yandex.cloud.gitlab.v1.ListInstancesRequest}

Request message for InstanceService.List.

#|
||Field | Description ||
|| folderId | **string**

ID of the folder to list instances in. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`, the service returns a [ListInstancesRequest.next_page_token]
that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the [ListInstancesRequest.next_page_token]
returned by the previous list request. ||
|#

## Response {#yandex.cloud.gitlab.v1.ListInstancesResponse}

**HTTP Code: 200 - OK**

```json
{
  "instances": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "updatedAt": "string",
      "name": "string",
      "description": "string",
      "labels": "object",
      "resourcePresetId": "string",
      "diskSize": "string",
      "status": "string",
      "adminLogin": "string",
      "adminEmail": "string",
      "domain": "string",
      "subnetId": "string",
      "plannedOperation": {
        "info": "string",
        "delayedUntil": "string",
        "latestMaintenanceTime": "string",
        "nextMaintenanceWindowTime": "string"
      },
      "backupRetainPeriodDays": "string",
      "maintenanceDeleteUntagged": "boolean",
      "deletionProtection": "boolean",
      "approvalRulesId": "string",
      "gitlabVersion": "string"
    }
  ],
  "nextPageToken": "string"
}
```

Response message for InstanceService.List.

#|
||Field | Description ||
|| instances[] | **[Instance](#yandex.cloud.gitlab.v1.Instance)**

List of GitLab instances. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListInstancesRequest.pageSize](#yandex.cloud.gitlab.v1.ListInstancesRequest), use the `nextPageToken` as the value
for the [ListInstancesRequest.pageToken](#yandex.cloud.gitlab.v1.ListInstancesRequest) parameter in the next list request. Each subsequent
list request will have its own `nextPageToken` to continue paging through the results. ||
|#

## Instance {#yandex.cloud.gitlab.v1.Instance}

Instance represents a GitLab instance with its configuration and state.

#|
||Field | Description ||
|| id | **string**

Unique instance ID. ||
|| folderId | **string**

Folder ID where instance resides. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updatedAt | **string** (date-time)

Last update timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Human-readable name. ||
|| description | **string**

Instance description. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as key-value pairs. ||
|| resourcePresetId | **string**

Resource preset ID. ||
|| diskSize | **string** (int64)

Disk size in bytes. ||
|| status | **enum** (Status)

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
|| adminLogin | **string**

Admin username. ||
|| adminEmail | **string**

Admin email. ||
|| domain | **string**

Instance domain. ||
|| subnetId | **string**

Subnet ID. ||
|| plannedOperation | **[MaintenanceOperation](#yandex.cloud.gitlab.v1.MaintenanceOperation)**

Planned maintenance operation. ||
|| backupRetainPeriodDays | **string** (int64)

How long to keep backups (days). ||
|| maintenanceDeleteUntagged | **boolean**

Delete untagged resources during maintenance. ||
|| deletionProtection | **boolean**

Protect from accidental deletion. ||
|| approvalRulesId | **string**

Approval rules ID. ||
|| gitlabVersion | **string**

GitLab version of the instance. ||
|#

## MaintenanceOperation {#yandex.cloud.gitlab.v1.MaintenanceOperation}

#|
||Field | Description ||
|| info | **string**

The description of the operation. ||
|| delayedUntil | **string** (date-time)

Delay time for the maintenance operation.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| latestMaintenanceTime | **string** (date-time)

Time of the last maintenance window.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| nextMaintenanceWindowTime | **string** (date-time)

Time of the next maintenance window.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#