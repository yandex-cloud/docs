---
editable: false
---

# Identity Provider API, gRPC: SynchronizationService.GetSynchronizationSettings

Returns synchronization settings for a subject container.

## gRPC request

**rpc GetSynchronizationSettings ([GetSynchronizationSettingsRequest](#yandex.cloud.organizationmanager.v1.idp.GetSynchronizationSettingsRequest)) returns ([SynchronizationSettings](#yandex.cloud.organizationmanager.v1.idp.SynchronizationSettings))**

## GetSynchronizationSettingsRequest {#yandex.cloud.organizationmanager.v1.idp.GetSynchronizationSettingsRequest}

```json
{
  "subject_container_id": "string"
}
```

Request to get synchronization settings.

#|
||Field | Description ||
|| subject_container_id | **string**

Required field. ID of the subject container.

The maximum string length in characters is 50. ||
|#

## SynchronizationSettings {#yandex.cloud.organizationmanager.v1.idp.SynchronizationSettings}

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
```

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