---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/idp/api-ref/grpc/SynchronizationSession/getSession.md
---

# Identity Provider API, gRPC: SynchronizationSessionService.GetSession

Returns the specified synchronization session.

## gRPC request

**rpc GetSession ([GetSessionRequest](#yandex.cloud.organizationmanager.v1.idp.GetSessionRequest)) returns ([GetSessionResponse](#yandex.cloud.organizationmanager.v1.idp.GetSessionResponse))**

## GetSessionRequest {#yandex.cloud.organizationmanager.v1.idp.GetSessionRequest}

```json
{
  "session_id": "string"
}
```

Request to get a synchronization session.

#|
||Field | Description ||
|| session_id | **string**

Required field. ID of the session to return.

The maximum string length in characters is 50. ||
|#

## GetSessionResponse {#yandex.cloud.organizationmanager.v1.idp.GetSessionResponse}

```json
{
  "session": {
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
}
```

Response message for [SynchronizationSessionService.GetSession](#GetSession).

#|
||Field | Description ||
|| session | **[SynchronizationSession](#yandex.cloud.organizationmanager.v1.idp.SynchronizationSession)**

Synchronization session information. ||
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
|| progress_entries[] | **[ProgressEntry](#yandex.cloud.organizationmanager.v1.idp.ProgressEntry)**

List of progress entries. ||
|| fail_reason | **string**

Reason for session failure, if any. ||
|| session_type | enum **SessionType**

Type of synchronization session.

- `AD_SYNC`: Active Directory synchronization session.
- `AD_PASSWORD_HASH`: Active Directory password hash session.
- `AD_USER_CONTROL`: Active Directory user control session. ||
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