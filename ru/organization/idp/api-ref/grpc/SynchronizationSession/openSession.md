---
editable: false
---

# Identity Provider API, gRPC: SynchronizationSessionService.OpenSession

Opens a new synchronization session.

## gRPC request

**rpc OpenSession ([OpenSessionRequest](#yandex.cloud.organizationmanager.v1.idp.OpenSessionRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## OpenSessionRequest {#yandex.cloud.organizationmanager.v1.idp.OpenSessionRequest}

```json
{
  "subject_container_id": "string",
  "agent_id": "string",
  "session_type": "SessionType"
}
```

Request to open a synchronization session.

#|
||Field | Description ||
|| subject_container_id | **string**

Required field. ID of the subject container.

The maximum string length in characters is 50. ||
|| agent_id | **string**

Required field. ID of the agent opening the session.

The maximum string length in characters is 50. ||
|| session_type | enum **SessionType**

Required field. Type of synchronization session.

- `AD_SYNC`: Active Directory synchronization session.
- `AD_PASSWORD_HASH`: Active Directory password hash session.
- `AD_USER_CONTROL`: Active Directory user control session. ||
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
    "result": "OpenSessionResult",
    // Includes only one of the fields `opened_session`, `next_session_at`
    "opened_session": {
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
    },
    "next_session_at": "google.protobuf.Timestamp",
    // end of the list of possible fields
    "replication_token": "string",
    "synchronization_settings": {
      "subject_container_id": "string",
      "filter": {
        "domain": "string",
        "groups": [
          "string"
        ],
        "organization_units": [
          "string"
        ]
      },
      "remove_user_behavior": "RemoveUserBehavior",
      "synchronization_interval": "google.protobuf.Duration",
      "allow_to_capture_users": "bool",
      "allow_to_capture_groups": "bool",
      "user_attribute_mappings": [
        {
          "source": "string",
          "target": "UserTargetAttribute",
          "type": "MappingType"
        }
      ],
      "group_attribute_mappings": [
        {
          "source": "string",
          "target": "GroupTargetAttribute",
          "type": "MappingType"
        }
      ],
      "created_at": "google.protobuf.Timestamp",
      "replacement_domain": "string"
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
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[OpenSessionMetadata](#yandex.cloud.organizationmanager.v1.idp.OpenSessionMetadata)**

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
|| session_id | **string**

ID of the session. ||
|#

## OpenSessionResponse {#yandex.cloud.organizationmanager.v1.idp.OpenSessionResponse}

Response message for [SynchronizationSessionService.OpenSession](#OpenSession).

#|
||Field | Description ||
|| result | enum **OpenSessionResult**

Result of opening the session.

- `SUCCESS`: Session opened successfully.
- `OPENED_SESSION_EXISTS`: A session already exists.
- `TOO_EARLY`: Too early to open a new session. ||
|| opened_session | **[SynchronizationSession](#yandex.cloud.organizationmanager.v1.idp.SynchronizationSession)**

Opened session information.

Includes only one of the fields `opened_session`, `next_session_at`.

Session information or next session time. ||
|| next_session_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp for the next session if too early.

Includes only one of the fields `opened_session`, `next_session_at`.

Session information or next session time. ||
|| replication_token | **string**

Replication token for the session. ||
|| synchronization_settings | **[SynchronizationSettings](#yandex.cloud.organizationmanager.v1.idp.SynchronizationSettings)**

Synchronization settings for the session. ||
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

## SynchronizationSettings {#yandex.cloud.organizationmanager.v1.idp.SynchronizationSettings}

Synchronization settings for a subject container.

#|
||Field | Description ||
|| subject_container_id | **string**

ID of the subject container. ||
|| filter | **[SynchronizationFilter](#yandex.cloud.organizationmanager.v1.idp.SynchronizationFilter)**

Filter configuration for synchronization. ||
|| remove_user_behavior | enum **RemoveUserBehavior**

Behavior when removing users.

- `REMOVE`: Remove the user.
- `BLOCK`: Block the user. ||
|| synchronization_interval | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Interval between synchronization runs. ||
|| allow_to_capture_users | **bool**

Whether users can be captured during synchronization. ||
|| allow_to_capture_groups | **bool**

Whether groups can be captured during synchronization. ||
|| user_attribute_mappings[] | **[UserAttributeMapping](#yandex.cloud.organizationmanager.v1.idp.UserAttributeMapping)**

User attribute mappings. ||
|| group_attribute_mappings[] | **[GroupAttributeMapping](#yandex.cloud.organizationmanager.v1.idp.GroupAttributeMapping)**

Group attribute mappings. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp when the settings were created. ||
|| replacement_domain | **string**

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
|| organization_units[] | **string**

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
|| target | enum **UserTargetAttribute**

Required field. Target attribute to map to.

- `FULL_NAME`: Full name attribute.
- `GIVEN_NAME`: Given name attribute.
- `FAMILY_NAME`: Family name attribute.
- `EMAIL`: Email attribute.
- `PHONE_NUMBER`: Phone number attribute.
- `USERNAME`: Username attribute. ||
|| type | enum **MappingType**

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
|| target | enum **GroupTargetAttribute**

Required field. Target attribute to map to.

- `NAME`: Name attribute.
- `DESCRIPTION`: Description attribute. ||
|| type | enum **MappingType**

Required field. Type of mapping.

- `DIRECT`: Direct mapping from source to target.
- `EMPTY`: Empty mapping (no source attribute). ||
|#