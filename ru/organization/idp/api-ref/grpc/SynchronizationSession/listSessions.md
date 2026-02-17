---
editable: false
---

# Identity Provider API, gRPC: SynchronizationSessionService.ListSessions

Lists synchronization sessions for a subject container.

## gRPC request

**rpc ListSessions ([ListSessionsRequest](#yandex.cloud.organizationmanager.v1.idp.ListSessionsRequest)) returns ([ListSessionsResponse](#yandex.cloud.organizationmanager.v1.idp.ListSessionsResponse))**

## ListSessionsRequest {#yandex.cloud.organizationmanager.v1.idp.ListSessionsRequest}

```json
{
  "subject_container_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": "string"
}
```

Request to list synchronization sessions.

#|
||Field | Description ||
|| subject_container_id | **string**

Required field. ID of the subject container.

The maximum string length in characters is 50. ||
|| page_size | **int64**

The maximum number of results per page to return.

Acceptable values are 0 to 1000, inclusive. ||
|| page_token | **string**

Page token for pagination.

The maximum string length in characters is 2000. ||
|| filter | **string**

A filter expression that filters resources listed in the response.

The maximum string length in characters is 1000. ||
|#

## ListSessionsResponse {#yandex.cloud.organizationmanager.v1.idp.ListSessionsResponse}

```json
{
  "sessions": [
    {
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
  ],
  "next_page_token": "string"
}
```

Response message for [SynchronizationSessionService.ListSessions](#ListSessions).

#|
||Field | Description ||
|| sessions[] | **[SynchronizationSession](#yandex.cloud.organizationmanager.v1.idp.SynchronizationSession)**

List of synchronization sessions. ||
|| next_page_token | **string**

Token for getting the next page of the list. ||
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