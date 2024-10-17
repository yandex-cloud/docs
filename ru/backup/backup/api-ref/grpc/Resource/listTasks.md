---
editable: false
sourcePath: en/_api-ref-grpc/backup/v1/backup/api-ref/grpc/Resource/listTasks.md
---

# Cloud Backup API, gRPC: ResourceService.ListTasks {#ListTasks}

List tasks of resources.

## gRPC request

**rpc ListTasks ([ListTasksRequest](#yandex.cloud.backup.v1.ListTasksRequest)) returns ([ListTasksResponse](#yandex.cloud.backup.v1.ListTasksResponse))**

## ListTasksRequest {#yandex.cloud.backup.v1.ListTasksRequest}

```json
{
  "computeInstanceId": "string",
  "pageSize": "int64",
  "pageToken": "string"
}
```

#|
||Field | Description ||
|| computeInstanceId | **string**

Required field. Compute Cloud instance ID. ||
|| pageSize | **int64**

Number of results per page. ||
|| pageToken | **string**

Token for the results page. ||
|#

## ListTasksResponse {#yandex.cloud.backup.v1.ListTasksResponse}

```json
{
  "tasks": [
    {
      "id": "int64",
      "cancellable": "bool",
      "policyId": "string",
      "type": "Type",
      "progress": {
        "current": "int64",
        "total": "int64"
      },
      "status": "Status",
      "enqueuedAt": "google.protobuf.Timestamp",
      "startedAt": "google.protobuf.Timestamp",
      "updatedAt": "google.protobuf.Timestamp",
      "completedAt": "google.protobuf.Timestamp",
      "computeInstanceId": "string",
      "resultCode": "Code",
      "error": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| tasks[] | **[Task](#yandex.cloud.backup.v1.Task)**

Set of tasks parameters. ||
|| nextPageToken | **string**

Token for the next results page. ||
|#

## Task {#yandex.cloud.backup.v1.Task}

#|
||Field | Description ||
|| id | **int64**

Task ID. ||
|| cancellable | **bool**

Shows whether the task is cancellable.
Note: task cancellation is not supported yet. ||
|| policyId | **string**

Policy ID. ||
|| type | enum **Type**

Type of the task.

- `TYPE_UNSPECIFIED`
- `BACKUP`
- `RETENTION`
- `RECOVERY`
- `APPLY_POLICY`
- `REVOKE_POLICY` ||
|| progress | **[Progress](#yandex.cloud.backup.v1.Progress)**

Task progress. ||
|| status | enum **Status**

Task status.

- `STATUS_UNSPECIFIED`
- `ENQUEUED`
- `ASSIGNED`
- `STARTED`
- `PAUSED`
- `COMPLETED` ||
|| enqueuedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| startedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| updatedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| completedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| computeInstanceId | **string**

Compute Cloud instance ID. ||
|| resultCode | enum **Code**

Task result code.

- `CODE_UNSPECIFIED`
- `OK`
- `ERROR`
- `WARNING`
- `CANCELLED`
- `ABANDONED`
- `TIMEDOUT` ||
|| error | **string**

Task error message if task finished with not OK code ||
|#

## Progress {#yandex.cloud.backup.v1.Progress}

#|
||Field | Description ||
|| current | **int64** ||
|| total | **int64** ||
|#