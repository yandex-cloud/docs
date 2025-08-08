---
editable: false
apiPlayground:
  - url: https://backup.{{ api-host }}/backup/v1/resources/{computeInstanceId}/tasks
    method: get
    path:
      type: object
      properties:
        computeInstanceId:
          description: |-
            **string**
            Required field. Compute Cloud instance ID.
          type: string
      required:
        - computeInstanceId
      additionalProperties: false
    query:
      type: object
      properties:
        pageSize:
          description: |-
            **string** (int64)
            Number of results per page.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Token for the results page.
          type: string
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/backup/v1/backup/api-ref/Resource/listTasks.md
---

# Cloud Backup API, REST: Resource.ListTasks

List tasks of resources.

## HTTP request

```
GET https://backup.{{ api-host }}/backup/v1/resources/{computeInstanceId}/tasks
```

## Path parameters

#|
||Field | Description ||
|| computeInstanceId | **string**

Required field. Compute Cloud instance ID. ||
|#

## Query parameters {#yandex.cloud.backup.v1.ListTasksRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

Number of results per page. ||
|| pageToken | **string**

Token for the results page. ||
|#

## Response {#yandex.cloud.backup.v1.ListTasksResponse}

**HTTP Code: 200 - OK**

```json
{
  "tasks": [
    {
      "id": "string",
      "cancellable": "boolean",
      "policyId": "string",
      "type": "string",
      "progress": {
        "current": "string",
        "total": "string"
      },
      "status": "string",
      "enqueuedAt": "string",
      "startedAt": "string",
      "updatedAt": "string",
      "completedAt": "string",
      "computeInstanceId": "string",
      "resultCode": "string",
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
|| id | **string** (int64)

Task ID. ||
|| cancellable | **boolean**

Shows whether the task is cancellable.
Note: task cancellation is not supported yet. ||
|| policyId | **string**

Policy ID. ||
|| type | **enum** (Type)

Type of the task.

- `TYPE_UNSPECIFIED`
- `BACKUP`
- `RETENTION`
- `RECOVERY`
- `APPLY_POLICY`
- `REVOKE_POLICY` ||
|| progress | **[Progress](#yandex.cloud.backup.v1.Progress)**

Task progress. ||
|| status | **enum** (Status)

Task status.

- `STATUS_UNSPECIFIED`
- `ENQUEUED`
- `ASSIGNED`
- `STARTED`
- `PAUSED`
- `COMPLETED` ||
|| enqueuedAt | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| startedAt | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updatedAt | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| completedAt | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| computeInstanceId | **string**

Compute Cloud instance ID. ||
|| resultCode | **enum** (Code)

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
|| current | **string** (int64) ||
|| total | **string** (int64) ||
|#