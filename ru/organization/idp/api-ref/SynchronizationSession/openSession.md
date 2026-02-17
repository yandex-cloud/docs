---
editable: false
apiPlayground:
  - url: https://organization-manager.{{ api-host }}/organization-manager/v1/idp/synchronization-sessions:open
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        subjectContainerId:
          description: |-
            **string**
            Required field. ID of the subject container.
            The maximum string length in characters is 50.
          type: string
        agentId:
          description: |-
            **string**
            Required field. ID of the agent opening the session.
            The maximum string length in characters is 50.
          type: string
        sessionType:
          description: |-
            **enum** (SessionType)
            Required field. Type of synchronization session.
            - `AD_SYNC`: Active Directory synchronization session.
            - `AD_PASSWORD_HASH`: Active Directory password hash session.
            - `AD_USER_CONTROL`: Active Directory user control session.
          type: string
          enum:
            - SESSION_TYPE_UNSPECIFIED
            - AD_SYNC
            - AD_PASSWORD_HASH
            - AD_USER_CONTROL
      required:
        - subjectContainerId
        - agentId
        - sessionType
      additionalProperties: false
    definitions: null
---

# Identity Provider API, REST: SynchronizationSession.OpenSession

Opens a new synchronization session.

## HTTP request

```
POST https://organization-manager.{{ api-host }}/organization-manager/v1/idp/synchronization-sessions:open
```

## Body parameters {#yandex.cloud.organizationmanager.v1.idp.OpenSessionRequest}

```json
{
  "subjectContainerId": "string",
  "agentId": "string",
  "sessionType": "string"
}
```

Request to open a synchronization session.

#|
||Field | Description ||
|| subjectContainerId | **string**

Required field. ID of the subject container.

The maximum string length in characters is 50. ||
|| agentId | **string**

Required field. ID of the agent opening the session.

The maximum string length in characters is 50. ||
|| sessionType | **enum** (SessionType)

Required field. Type of synchronization session.

- `AD_SYNC`: Active Directory synchronization session.
- `AD_PASSWORD_HASH`: Active Directory password hash session.
- `AD_USER_CONTROL`: Active Directory user control session. ||
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
    "result": "string",
    // Includes only one of the fields `openedSession`, `nextSessionAt`
    "openedSession": {
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
    },
    "nextSessionAt": "string",
    // end of the list of possible fields
    "replicationToken": "string",
    "synchronizationSettings": {
      "subjectContainerId": "string",
      "filter": {
        "domain": "string",
        "groups": [
          "string"
        ],
        "organizationUnits": [
          "string"
        ]
      },
      "removeUserBehavior": "string",
      "synchronizationInterval": "string",
      "allowToCaptureUsers": "boolean",
      "allowToCaptureGroups": "boolean",
      "userAttributeMappings": [
        {
          "source": "string",
          "target": "string",
          "type": "string"
        }
      ],
      "groupAttributeMappings": [
        {
          "source": "string",
          "target": "string",
          "type": "string"
        }
      ],
      "createdAt": "string",
      "replacementDomain": "string"
    }
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
|| metadata | **[OpenSessionMetadata](#yandex.cloud.organizationmanager.v1.idp.OpenSessionMetadata)**

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
|| response | **[OpenSessionResponse](#yandex.cloud.organizationmanager.v1.idp.OpenSessionResponse)**

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

## OpenSessionMetadata {#yandex.cloud.organizationmanager.v1.idp.OpenSessionMetadata}

Metadata for the [SynchronizationSessionService.OpenSession](#OpenSession) operation.

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

## OpenSessionResponse {#yandex.cloud.organizationmanager.v1.idp.OpenSessionResponse}

Response message for [SynchronizationSessionService.OpenSession](#OpenSession).

#|
||Field | Description ||
|| result | **enum** (OpenSessionResult)

Result of opening the session.

- `SUCCESS`: Session opened successfully.
- `OPENED_SESSION_EXISTS`: A session already exists.
- `TOO_EARLY`: Too early to open a new session. ||
|| openedSession | **[SynchronizationSession](#yandex.cloud.organizationmanager.v1.idp.SynchronizationSession)**

Opened session information.

Includes only one of the fields `openedSession`, `nextSessionAt`.

Session information or next session time. ||
|| nextSessionAt | **string** (date-time)

Timestamp for the next session if too early.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits).

Includes only one of the fields `openedSession`, `nextSessionAt`.

Session information or next session time. ||
|| replicationToken | **string**

Replication token for the session. ||
|| synchronizationSettings | **[SynchronizationSettings](#yandex.cloud.organizationmanager.v1.idp.SynchronizationSettings)**

Synchronization settings for the session. ||
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

## SynchronizationSettings {#yandex.cloud.organizationmanager.v1.idp.SynchronizationSettings}

Synchronization settings for a subject container.

#|
||Field | Description ||
|| subjectContainerId | **string**

ID of the subject container. ||
|| filter | **[SynchronizationFilter](#yandex.cloud.organizationmanager.v1.idp.SynchronizationFilter)**

Filter configuration for synchronization. ||
|| removeUserBehavior | **enum** (RemoveUserBehavior)

Behavior when removing users.

- `REMOVE`: Remove the user.
- `BLOCK`: Block the user. ||
|| synchronizationInterval | **string** (duration)

Interval between synchronization runs. ||
|| allowToCaptureUsers | **boolean**

Whether users can be captured during synchronization. ||
|| allowToCaptureGroups | **boolean**

Whether groups can be captured during synchronization. ||
|| userAttributeMappings[] | **[UserAttributeMapping](#yandex.cloud.organizationmanager.v1.idp.UserAttributeMapping)**

User attribute mappings. ||
|| groupAttributeMappings[] | **[GroupAttributeMapping](#yandex.cloud.organizationmanager.v1.idp.GroupAttributeMapping)**

Group attribute mappings. ||
|| createdAt | **string** (date-time)

Timestamp when the settings were created.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| replacementDomain | **string**

Domain replacement configuration. ||
|#

## SynchronizationFilter {#yandex.cloud.organizationmanager.v1.idp.SynchronizationFilter}

Filter configuration for synchronization.

#|
||Field | Description ||
|| domain | **string**

Required field. Domain to synchronize.

The string length in characters must be 1-253. ||
|| groups[] | **string**

List of groups to synchronize.

The string length in characters for each value must be 1-253. The maximum number of elements is 10. ||
|| organizationUnits[] | **string**

List of organizational units to synchronize.

The string length in characters for each value must be 1-253. The maximum number of elements is 10. ||
|#

## UserAttributeMapping {#yandex.cloud.organizationmanager.v1.idp.UserAttributeMapping}

User attribute mapping configuration.

#|
||Field | Description ||
|| source | **string**

Source attribute name.

The string length in characters must be 0-253. ||
|| target | **enum** (UserTargetAttribute)

Required field. Target attribute to map to.

- `FULL_NAME`: Full name attribute.
- `GIVEN_NAME`: Given name attribute.
- `FAMILY_NAME`: Family name attribute.
- `EMAIL`: Email attribute.
- `PHONE_NUMBER`: Phone number attribute.
- `USERNAME`: Username attribute. ||
|| type | **enum** (MappingType)

Required field. Type of mapping.

- `DIRECT`: Direct mapping from source to target.
- `EMPTY`: Empty mapping (no source attribute). ||
|#

## GroupAttributeMapping {#yandex.cloud.organizationmanager.v1.idp.GroupAttributeMapping}

Group attribute mapping configuration.

#|
||Field | Description ||
|| source | **string**

Source attribute name.

The string length in characters must be 0-253. ||
|| target | **enum** (GroupTargetAttribute)

Required field. Target attribute to map to.

- `NAME`: Name attribute.
- `DESCRIPTION`: Description attribute. ||
|| type | **enum** (MappingType)

Required field. Type of mapping.

- `DIRECT`: Direct mapping from source to target.
- `EMPTY`: Empty mapping (no source attribute). ||
|#