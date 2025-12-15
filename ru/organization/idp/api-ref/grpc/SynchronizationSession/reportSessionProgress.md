---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/idp/api-ref/grpc/SynchronizationSession/reportSessionProgress.md
---

# Identity Provider API, gRPC: SynchronizationSessionService.ReportSessionProgress

Reports progress for a synchronization session.

## gRPC request

**rpc ReportSessionProgress ([ReportSessionProgressRequest](#yandex.cloud.organizationmanager.v1.idp.ReportSessionProgressRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## ReportSessionProgressRequest {#yandex.cloud.organizationmanager.v1.idp.ReportSessionProgressRequest}

```json
{
  "session_id": "string",
  "progress_entries": [
    {
      "object_type": "RelatedObjectType",
      "change_info": [
        {
          "change_type": "ChangeType",
          "successful": "int64",
          "failed": "int64"
        }
      ]
    }
  ]
}
```

Request to report session progress.

#|
||Field | Description ||
|| session_id | **string**

Required field. ID of the session.

The maximum string length in characters is 50. ||
|| progress_entries[] | **[ProgressEntry](#yandex.cloud.organizationmanager.v1.idp.ProgressEntry)**

List of progress entries.

The number of elements must be in the range 1-3. ||
|#

## ProgressEntry {#yandex.cloud.organizationmanager.v1.idp.ProgressEntry}

Progress entry for synchronization.

#|
||Field | Description ||
|| object_type | enum **RelatedObjectType**

Required field. Type of object being synchronized.

- `USER`: User object.
- `GROUP`: Group object.
- `MEMBERSHIP`: Membership object. ||
|| change_info[] | **[ChangeInfo](#yandex.cloud.organizationmanager.v1.idp.ChangeInfo)**

List of change information.

The number of elements must be in the range 1-6. ||
|#

## ChangeInfo {#yandex.cloud.organizationmanager.v1.idp.ChangeInfo}

Information about changes during synchronization.

#|
||Field | Description ||
|| change_type | enum **ChangeType**

Type of change.

- `CREATE`: Create operation.
- `UPDATE`: Update operation.
- `DELETE`: Delete operation.
- `ACTIVATE`: Activate operation.
- `DEACTIVATE`: Deactivate operation.
- `PASSWORD_HASH_UPDATE`: Password hash update operation. ||
|| successful | **int64**

Number of successful changes. ||
|| failed | **int64**

Number of failed changes. ||
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
    "session_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "session_id": "string",
    "agent_id": "string",
    "created_at": "google.protobuf.Timestamp",
    "expires_at": "google.protobuf.Timestamp",
    "closed_at": "google.protobuf.Timestamp",
    "sync_mode": "SyncMode",
    "status": "SessionStatus",
    "progress_entries": [
      {
        "object_type": "RelatedObjectType",
        "change_info": [
          {
            "change_type": "ChangeType",
            "successful": "int64",
            "failed": "int64"
          }
        ]
      }
    ],
    "fail_reason": "string",
    "session_type": "SessionType"
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
|| metadata | **[ReportSessionProgressMetadata](#yandex.cloud.organizationmanager.v1.idp.ReportSessionProgressMetadata)**

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
|| response | **[SynchronizationSession](#yandex.cloud.organizationmanager.v1.idp.SynchronizationSession)**

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

## ReportSessionProgressMetadata {#yandex.cloud.organizationmanager.v1.idp.ReportSessionProgressMetadata}

Metadata for the [SynchronizationSessionService.ReportSessionProgress](#ReportSessionProgress) operation.

#|
||Field | Description ||
|| session_id | **string**

ID of the session. ||
|#

## SynchronizationSession {#yandex.cloud.organizationmanager.v1.idp.SynchronizationSession}

Synchronization session information.

#|
||Field | Description ||
|| session_id | **string**

Unique identifier of the session. ||
|| agent_id | **string**

ID of the agent managing the session. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp when the session was created. ||
|| expires_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp when the session expires. ||
|| closed_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp when the session was closed. ||
|| sync_mode | enum **SyncMode**

Synchronization mode.

- `FULL_SYNC`: Full synchronization mode.
- `DELTA`: Delta synchronization mode. ||
|| status | enum **SessionStatus**

Current status of the session.

- `OPENED`: Session is opened.
- `PENDING`: Session is pending.
- `COMPLETED`: Session is completed.
- `FAILED`: Session has failed.
- `EXPIRED`: Session has expired. ||
|| progress_entries[] | **[ProgressEntry](#yandex.cloud.organizationmanager.v1.idp.ProgressEntry2)**

List of progress entries. ||
|| fail_reason | **string**

Reason for session failure, if any. ||
|| session_type | enum **SessionType**

Type of synchronization session.

- `AD_SYNC`: Active Directory synchronization session.
- `AD_PASSWORD_HASH`: Active Directory password hash session.
- `AD_USER_CONTROL`: Active Directory user control session. ||
|#

## ProgressEntry {#yandex.cloud.organizationmanager.v1.idp.ProgressEntry2}

Progress entry for synchronization.

#|
||Field | Description ||
|| object_type | enum **RelatedObjectType**

Required field. Type of object being synchronized.

- `USER`: User object.
- `GROUP`: Group object.
- `MEMBERSHIP`: Membership object. ||
|| change_info[] | **[ChangeInfo](#yandex.cloud.organizationmanager.v1.idp.ChangeInfo2)**

List of change information.

The number of elements must be in the range 1-6. ||
|#

## ChangeInfo {#yandex.cloud.organizationmanager.v1.idp.ChangeInfo2}

Information about changes during synchronization.

#|
||Field | Description ||
|| change_type | enum **ChangeType**

Type of change.

- `CREATE`: Create operation.
- `UPDATE`: Update operation.
- `DELETE`: Delete operation.
- `ACTIVATE`: Activate operation.
- `DEACTIVATE`: Deactivate operation.
- `PASSWORD_HASH_UPDATE`: Password hash update operation. ||
|| successful | **int64**

Number of successful changes. ||
|| failed | **int64**

Number of failed changes. ||
|#