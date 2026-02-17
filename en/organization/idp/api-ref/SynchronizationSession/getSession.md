---
editable: false
apiPlayground:
  - url: https://organization-manager.{{ api-host }}/organization-manager/v1/idp/synchronization-sessions/{sessionId}
    method: get
    path:
      type: object
      properties:
        sessionId:
          description: |-
            **string**
            Required field. ID of the session to return.
            The maximum string length in characters is 50.
          type: string
      required:
        - sessionId
      additionalProperties: false
    query: null
    body: null
    definitions: null
---

# Identity Provider API, REST: SynchronizationSession.GetSession

Returns the specified synchronization session.

## HTTP request

```
GET https://organization-manager.{{ api-host }}/organization-manager/v1/idp/synchronization-sessions/{sessionId}
```

## Path parameters

Request to get a synchronization session.

#|
||Field | Description ||
|| sessionId | **string**

Required field. ID of the session to return.

The maximum string length in characters is 50. ||
|#

## Response {#yandex.cloud.organizationmanager.v1.idp.GetSessionResponse}

**HTTP Code: 200 - OK**

```json
{
  "session": {
    "sessionId": "string",
    "agentId": "string",
    "createdAt": "string",
    "expiresAt": "string",
    "closedAt": "string",
    "syncMode": "string",
    "status": "string",
    "progressEntries": [
      {
        "objectType": "string",
        "changeInfo": [
          {
            "changeType": "string",
            "successful": "string",
            "failed": "string"
          }
        ]
      }
    ],
    "failReason": "string",
    "sessionType": "string"
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
|| sessionId | **string**

Unique identifier of the session. ||
|| agentId | **string**

ID of the agent managing the session. ||
|| createdAt | **string** (date-time)

Timestamp when the session was created.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| expiresAt | **string** (date-time)

Timestamp when the session expires.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| closedAt | **string** (date-time)

Timestamp when the session was closed.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| syncMode | **enum** (SyncMode)

Synchronization mode.

- `FULL_SYNC`: Full synchronization mode.
- `DELTA`: Delta synchronization mode. ||
|| status | **enum** (SessionStatus)

Current status of the session.

- `OPENED`: Session is opened.
- `PENDING`: Session is pending.
- `COMPLETED`: Session is completed.
- `FAILED`: Session has failed.
- `EXPIRED`: Session has expired. ||
|| progressEntries[] | **[ProgressEntry](#yandex.cloud.organizationmanager.v1.idp.ProgressEntry)**

List of progress entries. ||
|| failReason | **string**

Reason for session failure, if any. ||
|| sessionType | **enum** (SessionType)

Type of synchronization session.

- `AD_SYNC`: Active Directory synchronization session.
- `AD_PASSWORD_HASH`: Active Directory password hash session.
- `AD_USER_CONTROL`: Active Directory user control session. ||
|#

## ProgressEntry {#yandex.cloud.organizationmanager.v1.idp.ProgressEntry}

Progress entry for synchronization.

#|
||Field | Description ||
|| objectType | **enum** (RelatedObjectType)

Required field. Type of object being synchronized.

- `USER`: User object.
- `GROUP`: Group object.
- `MEMBERSHIP`: Membership object. ||
|| changeInfo[] | **[ChangeInfo](#yandex.cloud.organizationmanager.v1.idp.ChangeInfo)**

List of change information.

The number of elements must be in the range 1-6. ||
|#

## ChangeInfo {#yandex.cloud.organizationmanager.v1.idp.ChangeInfo}

Information about changes during synchronization.

#|
||Field | Description ||
|| changeType | **enum** (ChangeType)

Type of change.

- `CREATE`: Create operation.
- `UPDATE`: Update operation.
- `DELETE`: Delete operation.
- `ACTIVATE`: Activate operation.
- `DEACTIVATE`: Deactivate operation.
- `PASSWORD_HASH_UPDATE`: Password hash update operation. ||
|| successful | **string** (int64)

Number of successful changes. ||
|| failed | **string** (int64)

Number of failed changes. ||
|#