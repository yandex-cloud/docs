---
editable: false
sourcePath: en/_api-ref-grpc/backup/v1/backup/api-ref/grpc/Resource/listTasks.md
---

# Cloud Backup API, gRPC: ResourceService.ListTasks

List tasks of resources.

## gRPC request

**rpc ListTasks ([ListTasksRequest](#yandex.cloud.backup.v1.ListTasksRequest)) returns ([ListTasksResponse](#yandex.cloud.backup.v1.ListTasksResponse))**

## ListTasksRequest {#yandex.cloud.backup.v1.ListTasksRequest}

```json
{
  "compute_instance_id": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| compute_instance_id | **string**

Required field. Compute Cloud instance ID. ||
|| page_size | **int64**

Number of results per page. ||
|| page_token | **string**

Token for the results page. ||
|#

## ListTasksResponse {#yandex.cloud.backup.v1.ListTasksResponse}

```json
{
  "tasks": [
    {
      "id": "int64",
      "cancellable": "bool",
      "policy_id": "string",
      "type": "Type",
      "progress": {
        "current": "int64",
        "total": "int64"
      },
      "status": "Status",
      "enqueued_at": "google.protobuf.Timestamp",
      "started_at": "google.protobuf.Timestamp",
      "updated_at": "google.protobuf.Timestamp",
      "completed_at": "google.protobuf.Timestamp",
      "compute_instance_id": "string",
      "result_code": "Code",
      "error": "string"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| tasks[] | **[Task](#yandex.cloud.backup.v1.Task)**

Set of tasks parameters. ||
|| next_page_token | **string**

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
|| policy_id | **string**

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
|| enqueued_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| completed_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| compute_instance_id | **string**

Compute Cloud instance ID. ||
|| result_code | enum **Code**

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