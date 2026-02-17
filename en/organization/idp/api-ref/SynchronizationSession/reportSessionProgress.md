---
editable: false
apiPlayground:
  - url: https://organization-manager.{{ api-host }}/organization-manager/v1/idp/synchronization-sessions/{sessionId}:reportProgress
    method: post
    path:
      type: object
      properties:
        sessionId:
          description: |-
            **string**
            Required field. ID of the session.
            The maximum string length in characters is 50.
          type: string
      required:
        - sessionId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        progressEntries:
          description: |-
            **[ProgressEntry](#yandex.cloud.organizationmanager.v1.idp.ProgressEntry)**
            List of progress entries.
            The number of elements must be in the range 1-3.
          type: array
          items:
            $ref: '#/definitions/ProgressEntry'
      additionalProperties: false
    definitions:
      ChangeInfo:
        type: object
        properties:
          changeType:
            description: |-
              **enum** (ChangeType)
              Type of change.
              - `CREATE`: Create operation.
              - `UPDATE`: Update operation.
              - `DELETE`: Delete operation.
              - `ACTIVATE`: Activate operation.
              - `DEACTIVATE`: Deactivate operation.
              - `PASSWORD_HASH_UPDATE`: Password hash update operation.
            type: string
            enum:
              - CHANGE_TYPE_UNSPECIFIED
              - CREATE
              - UPDATE
              - DELETE
              - ACTIVATE
              - DEACTIVATE
              - PASSWORD_HASH_UPDATE
          successful:
            description: |-
              **string** (int64)
              Number of successful changes.
            type: string
            format: int64
          failed:
            description: |-
              **string** (int64)
              Number of failed changes.
            type: string
            format: int64
      ProgressEntry:
        type: object
        properties:
          objectType:
            description: |-
              **enum** (RelatedObjectType)
              Required field. Type of object being synchronized.
              - `USER`: User object.
              - `GROUP`: Group object.
              - `MEMBERSHIP`: Membership object.
            type: string
            enum:
              - RELATED_OBJECT_TYPE_UNSPECIFIED
              - USER
              - GROUP
              - MEMBERSHIP
          changeInfo:
            description: |-
              **[ChangeInfo](#yandex.cloud.organizationmanager.v1.idp.ChangeInfo)**
              List of change information.
              The number of elements must be in the range 1-6.
            type: array
            items:
              $ref: '#/definitions/ChangeInfo'
        required:
          - objectType
---

# Identity Provider API, REST: SynchronizationSession.ReportSessionProgress

Reports progress for a synchronization session.

## HTTP request

```
POST https://organization-manager.{{ api-host }}/organization-manager/v1/idp/synchronization-sessions/{sessionId}:reportProgress
```

## Path parameters

Request to report session progress.

#|
||Field | Description ||
|| sessionId | **string**

Required field. ID of the session.

The maximum string length in characters is 50. ||
|#

## Body parameters {#yandex.cloud.organizationmanager.v1.idp.ReportSessionProgressRequest}

```json
{
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
  ]
}
```

Request to report session progress.

#|
||Field | Description ||
|| progressEntries[] | **[ProgressEntry](#yandex.cloud.organizationmanager.v1.idp.ProgressEntry)**

List of progress entries.

The number of elements must be in the range 1-3. ||
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

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": {
    "sessionId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
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
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[ReportSessionProgressMetadata](#yandex.cloud.organizationmanager.v1.idp.ReportSessionProgressMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

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
|| sessionId | **string**

ID of the session. ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
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
|| progressEntries[] | **[ProgressEntry](#yandex.cloud.organizationmanager.v1.idp.ProgressEntry2)**

List of progress entries. ||
|| failReason | **string**

Reason for session failure, if any. ||
|| sessionType | **enum** (SessionType)

Type of synchronization session.

- `AD_SYNC`: Active Directory synchronization session.
- `AD_PASSWORD_HASH`: Active Directory password hash session.
- `AD_USER_CONTROL`: Active Directory user control session. ||
|#

## ProgressEntry {#yandex.cloud.organizationmanager.v1.idp.ProgressEntry2}

Progress entry for synchronization.

#|
||Field | Description ||
|| objectType | **enum** (RelatedObjectType)

Required field. Type of object being synchronized.

- `USER`: User object.
- `GROUP`: Group object.
- `MEMBERSHIP`: Membership object. ||
|| changeInfo[] | **[ChangeInfo](#yandex.cloud.organizationmanager.v1.idp.ChangeInfo2)**

List of change information.

The number of elements must be in the range 1-6. ||
|#

## ChangeInfo {#yandex.cloud.organizationmanager.v1.idp.ChangeInfo2}

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