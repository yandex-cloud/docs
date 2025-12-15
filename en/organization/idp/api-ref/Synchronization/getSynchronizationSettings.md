---
editable: false
apiPlayground:
  - url: https://organization-manager.{{ api-host }}/organization-manager/v1/idp/synchronization-settings/{subjectContainerId}
    method: get
    path:
      type: object
      properties:
        subjectContainerId:
          description: |-
            **string**
            Required field. ID of the subject container.
            The maximum string length in characters is 50.
          type: string
      required:
        - subjectContainerId
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/organizationmanager/v1/idp/api-ref/Synchronization/getSynchronizationSettings.md
---

# Identity Provider API, REST: Synchronization.GetSynchronizationSettings

Returns synchronization settings for a subject container.

## HTTP request

```
GET https://organization-manager.{{ api-host }}/organization-manager/v1/idp/synchronization-settings/{subjectContainerId}
```

## Path parameters

Request to get synchronization settings.

#|
||Field | Description ||
|| subjectContainerId | **string**

Required field. ID of the subject container.

The maximum string length in characters is 50. ||
|#

## Response {#yandex.cloud.organizationmanager.v1.idp.SynchronizationSettings}

**HTTP Code: 200 - OK**

```json
{
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
```

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