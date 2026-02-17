---
editable: false
---

# Identity Provider API, gRPC: SynchronizationService.UpdateSynchronizationSettings

Updates synchronization settings for a subject container.

## gRPC request

**rpc UpdateSynchronizationSettings ([UpdateSynchronizationSettingsRequest](#yandex.cloud.organizationmanager.v1.idp.UpdateSynchronizationSettingsRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateSynchronizationSettingsRequest {#yandex.cloud.organizationmanager.v1.idp.UpdateSynchronizationSettingsRequest}

```json
{
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
  "replacement_domain": "string",
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
  "update_mask": "google.protobuf.FieldMask"
}
```

Request to update synchronization settings.

#|
||Field | Description ||
|| subject_container_id | **string**

Required field. ID of the subject container.

The maximum string length in characters is 50. ||
|| filter | **[SynchronizationFilter](#yandex.cloud.organizationmanager.v1.idp.SynchronizationFilter)**

Filter configuration for synchronization. ||
|| replacement_domain | **string**

Domain replacement configuration.

The string length in characters must be 0-253. ||
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

User attribute mappings.

The maximum number of elements is 50. ||
|| group_attribute_mappings[] | **[GroupAttributeMapping](#yandex.cloud.organizationmanager.v1.idp.GroupAttributeMapping)**

Group attribute mappings.

The maximum number of elements is 50. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask that specifies which fields are going to be updated. ||
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
    "subject_container_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
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
|| metadata | **[UpdateSynchronizationSettingsMetadata](#yandex.cloud.organizationmanager.v1.idp.UpdateSynchronizationSettingsMetadata)**

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
|| response | **[SynchronizationSettings](#yandex.cloud.organizationmanager.v1.idp.SynchronizationSettings)**

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

## UpdateSynchronizationSettingsMetadata {#yandex.cloud.organizationmanager.v1.idp.UpdateSynchronizationSettingsMetadata}

Metadata for the [SynchronizationService.UpdateSynchronizationSettings](#UpdateSynchronizationSettings) operation.

#|
||Field | Description ||
|| subject_container_id | **string**

ID of the subject container. ||
|#

## SynchronizationSettings {#yandex.cloud.organizationmanager.v1.idp.SynchronizationSettings}

Synchronization settings for a subject container.

#|
||Field | Description ||
|| subject_container_id | **string**

ID of the subject container. ||
|| filter | **[SynchronizationFilter](#yandex.cloud.organizationmanager.v1.idp.SynchronizationFilter2)**

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
|| user_attribute_mappings[] | **[UserAttributeMapping](#yandex.cloud.organizationmanager.v1.idp.UserAttributeMapping2)**

User attribute mappings. ||
|| group_attribute_mappings[] | **[GroupAttributeMapping](#yandex.cloud.organizationmanager.v1.idp.GroupAttributeMapping2)**

Group attribute mappings. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp when the settings were created. ||
|| replacement_domain | **string**

Domain replacement configuration. ||
|#

## SynchronizationFilter {#yandex.cloud.organizationmanager.v1.idp.SynchronizationFilter2}

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

## UserAttributeMapping {#yandex.cloud.organizationmanager.v1.idp.UserAttributeMapping2}

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

## GroupAttributeMapping {#yandex.cloud.organizationmanager.v1.idp.GroupAttributeMapping2}

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