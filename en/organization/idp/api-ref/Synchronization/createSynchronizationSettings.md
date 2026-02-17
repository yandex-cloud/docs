---
editable: false
apiPlayground:
  - url: https://organization-manager.{{ api-host }}/organization-manager/v1/idp/synchronization-settings
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
        filter:
          description: |-
            **[SynchronizationFilter](#yandex.cloud.organizationmanager.v1.idp.SynchronizationFilter)**
            Required field. Filter configuration for synchronization.
          $ref: '#/definitions/SynchronizationFilter'
        replacementDomain:
          description: |-
            **string**
            Domain replacement configuration.
            The string length in characters must be 0-253.
          type: string
        removeUserBehavior:
          description: |-
            **enum** (RemoveUserBehavior)
            Behavior when removing users.
            - `REMOVE`: Remove the user.
            - `BLOCK`: Block the user.
          type: string
          enum:
            - REMOVE_USER_BEHAVIOR_UNSPECIFIED
            - REMOVE
            - BLOCK
        synchronizationInterval:
          description: |-
            **string** (duration)
            Interval between synchronization runs.
          type: string
          format: duration
        allowToCaptureUsers:
          description: |-
            **boolean**
            Whether users can be captured during synchronization.
          type: boolean
        allowToCaptureGroups:
          description: |-
            **boolean**
            Whether groups can be captured during synchronization.
          type: boolean
        userAttributeMappings:
          description: |-
            **[UserAttributeMapping](#yandex.cloud.organizationmanager.v1.idp.UserAttributeMapping)**
            User attribute mappings.
            The maximum number of elements is 50.
          type: array
          items:
            $ref: '#/definitions/UserAttributeMapping'
        groupAttributeMappings:
          description: |-
            **[GroupAttributeMapping](#yandex.cloud.organizationmanager.v1.idp.GroupAttributeMapping)**
            Group attribute mappings.
            The maximum number of elements is 50.
          type: array
          items:
            $ref: '#/definitions/GroupAttributeMapping'
      required:
        - subjectContainerId
        - filter
      additionalProperties: false
    definitions:
      SynchronizationFilter:
        type: object
        properties:
          domain:
            description: |-
              **string**
              Required field. Domain to synchronize.
              The string length in characters must be 1-253.
            type: string
          groups:
            description: |-
              **string**
              List of groups to synchronize.
              The string length in characters for each value must be 1-253. The maximum number of elements is 10.
            type: array
            items:
              type: string
          organizationUnits:
            description: |-
              **string**
              List of organizational units to synchronize.
              The string length in characters for each value must be 1-253. The maximum number of elements is 10.
            type: array
            items:
              type: string
        required:
          - domain
      UserAttributeMapping:
        type: object
        properties:
          source:
            description: |-
              **string**
              Source attribute name.
              The string length in characters must be 0-253.
            type: string
          target:
            description: |-
              **enum** (UserTargetAttribute)
              Required field. Target attribute to map to.
              - `FULL_NAME`: Full name attribute.
              - `GIVEN_NAME`: Given name attribute.
              - `FAMILY_NAME`: Family name attribute.
              - `EMAIL`: Email attribute.
              - `PHONE_NUMBER`: Phone number attribute.
              - `USERNAME`: Username attribute.
            type: string
            enum:
              - USER_TARGET_ATTRIBUTE_UNSPECIFIED
              - FULL_NAME
              - GIVEN_NAME
              - FAMILY_NAME
              - EMAIL
              - PHONE_NUMBER
              - USERNAME
          type:
            description: |-
              **enum** (MappingType)
              Required field. Type of mapping.
              - `DIRECT`: Direct mapping from source to target.
              - `EMPTY`: Empty mapping (no source attribute).
            type: string
            enum:
              - MAPPING_TYPE_UNSPECIFIED
              - DIRECT
              - EMPTY
        required:
          - target
          - type
      GroupAttributeMapping:
        type: object
        properties:
          source:
            description: |-
              **string**
              Source attribute name.
              The string length in characters must be 0-253.
            type: string
          target:
            description: |-
              **enum** (GroupTargetAttribute)
              Required field. Target attribute to map to.
              - `NAME`: Name attribute.
              - `DESCRIPTION`: Description attribute.
            type: string
            enum:
              - GROUP_TARGET_ATTRIBUTE_UNSPECIFIED
              - NAME
              - DESCRIPTION
          type:
            description: |-
              **enum** (MappingType)
              Required field. Type of mapping.
              - `DIRECT`: Direct mapping from source to target.
              - `EMPTY`: Empty mapping (no source attribute).
            type: string
            enum:
              - MAPPING_TYPE_UNSPECIFIED
              - DIRECT
              - EMPTY
        required:
          - target
          - type
---

# Identity Provider API, REST: Synchronization.CreateSynchronizationSettings

Creates synchronization settings for a subject container.

## HTTP request

```
POST https://organization-manager.{{ api-host }}/organization-manager/v1/idp/synchronization-settings
```

## Body parameters {#yandex.cloud.organizationmanager.v1.idp.CreateSynchronizationSettingsRequest}

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
  "replacementDomain": "string",
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
  ]
}
```

Request to create synchronization settings.

#|
||Field | Description ||
|| subjectContainerId | **string**

Required field. ID of the subject container.

The maximum string length in characters is 50. ||
|| filter | **[SynchronizationFilter](#yandex.cloud.organizationmanager.v1.idp.SynchronizationFilter)**

Required field. Filter configuration for synchronization. ||
|| replacementDomain | **string**

Domain replacement configuration.

The string length in characters must be 0-253. ||
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

User attribute mappings.

The maximum number of elements is 50. ||
|| groupAttributeMappings[] | **[GroupAttributeMapping](#yandex.cloud.organizationmanager.v1.idp.GroupAttributeMapping)**

Group attribute mappings.

The maximum number of elements is 50. ||
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
    "subjectContainerId": "string"
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
|| metadata | **[CreateSynchronizationSettingsMetadata](#yandex.cloud.organizationmanager.v1.idp.CreateSynchronizationSettingsMetadata)**

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

## CreateSynchronizationSettingsMetadata {#yandex.cloud.organizationmanager.v1.idp.CreateSynchronizationSettingsMetadata}

Metadata for the [SynchronizationService.CreateSynchronizationSettings](#CreateSynchronizationSettings) operation.

#|
||Field | Description ||
|| subjectContainerId | **string**

ID of the subject container. ||
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

## SynchronizationSettings {#yandex.cloud.organizationmanager.v1.idp.SynchronizationSettings}

Synchronization settings for a subject container.

#|
||Field | Description ||
|| subjectContainerId | **string**

ID of the subject container. ||
|| filter | **[SynchronizationFilter](#yandex.cloud.organizationmanager.v1.idp.SynchronizationFilter2)**

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
|| userAttributeMappings[] | **[UserAttributeMapping](#yandex.cloud.organizationmanager.v1.idp.UserAttributeMapping2)**

User attribute mappings. ||
|| groupAttributeMappings[] | **[GroupAttributeMapping](#yandex.cloud.organizationmanager.v1.idp.GroupAttributeMapping2)**

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
|| organizationUnits[] | **string**

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

## GroupAttributeMapping {#yandex.cloud.organizationmanager.v1.idp.GroupAttributeMapping2}

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