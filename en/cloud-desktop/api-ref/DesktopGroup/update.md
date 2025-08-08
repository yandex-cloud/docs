---
editable: false
apiPlayground:
  - url: https://cloud-desktop.{{ api-host }}/cloud-desktop/v1/desktopGroups/{desktopGroupId}
    method: patch
    path:
      type: object
      properties:
        desktopGroupId:
          description: |-
            **string**
            Required field. 
          type: string
      required:
        - desktopGroupId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        updateMask:
          description: |-
            **string** (field-mask)
            A comma-separated names off ALL fields to be updated.
            Only the specified fields will be changed. The others will be left untouched.
            If the field is specified in `` updateMask `` and no value for that field was sent in the request,
            the field's value will be reset to the default. The default value for most fields is null or 0.
            If `` updateMask `` is not sent in the request, all fields' values will be updated.
            Fields specified in the request will be updated to provided values.
            The rest of the fields will be reset to the default.
          type: string
          format: field-mask
        desktopImageId:
          description: '**string**'
          type: string
        name:
          description: '**string**'
          pattern: '|[a-z]([-a-z0-9]{0,61}[a-z0-9])'
          type: string
        description:
          description: '**string**'
          type: string
        labels:
          description: '**object** (map<**string**, **string**>)'
          pattern: '[a-z][-_0-9a-z]*'
          type: string
        resourcesSpec:
          description: '**[ResourcesSpec](/docs/cloud-desktop/api-ref/DesktopGroup/get#yandex.cloud.clouddesktop.v1.api.ResourcesSpec)**'
          $ref: '#/definitions/ResourcesSpec'
        groupConfig:
          description: |-
            **[DesktopGroupConfiguration](/docs/cloud-desktop/api-ref/DesktopGroup/get#yandex.cloud.clouddesktop.v1.api.DesktopGroupConfiguration)**
            Configuration of the desktop group.
          $ref: '#/definitions/DesktopGroupConfiguration'
        bootDiskSpec:
          description: |-
            **[DiskSpec](/docs/cloud-desktop/api-ref/DesktopGroup/get#yandex.cloud.clouddesktop.v1.api.DiskSpec)**
            Boot disk specification of the desktop group.
          $ref: '#/definitions/DiskSpec'
        dataDiskSpec:
          description: |-
            **[DiskSpec](/docs/cloud-desktop/api-ref/DesktopGroup/get#yandex.cloud.clouddesktop.v1.api.DiskSpec)**
            Data disk specification of the desktop group.
          $ref: '#/definitions/DiskSpec'
        autoUpdatePolicy:
          description: |-
            **object**
            Includes only one of the fields `autoUpdatePolicy`, `manualUpdatePolicy`.
            Update policy of the desktop group.
          $ref: '#/definitions/AutoUpdatePolicy'
        manualUpdatePolicy:
          description: |-
            **object**
            Includes only one of the fields `autoUpdatePolicy`, `manualUpdatePolicy`.
            Update policy of the desktop group.
          $ref: '#/definitions/ManualUpdatePolicy'
      additionalProperties: false
    definitions:
      ResourcesSpec:
        type: object
        properties:
          memory:
            description: |-
              **string** (int64)
              RAM volume, in bytes.
            type: string
            format: int64
          cores:
            description: |-
              **string** (int64)
              Number of CPU cores.
            type: string
            format: int64
          coreFraction:
            description: |-
              **string** (int64)
              Baseline level of CPU performance with the ability to burst performance above that baseline level.
              This field sets baseline performance for each core.
            type: string
            format: int64
      Subject:
        type: object
        properties:
          id:
            description: |-
              **string**
              Required field. ID of the subject.
              It can contain one of the following values:
              * `allAuthenticatedUsers`: A special public group that represents anyone
              who is authenticated. It can be used only if the [type](/docs/cloud-desktop/api-ref/DesktopGroup/get#yandex.cloud.clouddesktop.v1.api.DiskSpec) is `system`.
              * `allUsers`: A special public group that represents anyone. No authentication is required.
              For example, you don't need to specify the IAM token in an API query.
              It can be used only if the [type](/docs/cloud-desktop/api-ref/DesktopGroup/get#yandex.cloud.clouddesktop.v1.api.DiskSpec) is `system`.
              * `group:organization:<id>:users`: A special system group that represents all members of organization
              with given <id>. It can be used only if the [type](/docs/cloud-desktop/api-ref/DesktopGroup/get#yandex.cloud.clouddesktop.v1.api.DiskSpec) is `system`.
              * `group:federation:<id>:users`: A special system group that represents all users of federation
              with given <id>. It can be used only if the [type](/docs/cloud-desktop/api-ref/DesktopGroup/get#yandex.cloud.clouddesktop.v1.api.DiskSpec) is `system`.
              * `<cloud generated id>`: An identifier that represents a user account.
              It can be used only if the [type](/docs/cloud-desktop/api-ref/DesktopGroup/get#yandex.cloud.clouddesktop.v1.api.DiskSpec) is `userAccount`, `federatedUser` or `serviceAccount`.
            type: string
          type:
            description: |-
              **string**
              Required field. Type of the subject.
              It can contain one of the following values:
              * `userAccount`: An account on Yandex or Yandex Connect, added to Yandex Cloud.
              * `serviceAccount`: A service account. This type represents the [yandex.cloud.iam.v1.ServiceAccount](/docs/iam/api-ref/ServiceAccount/get#yandex.cloud.iam.v1.ServiceAccount) resource.
              * `federatedUser`: A federated account. This type represents a user from an identity federation, like Active Directory.
              * `system`: System group. This type represents several accounts with a common system identifier.
              For more information, see [Subject to which the role is assigned](/docs/iam/concepts/access-control/#subject).
            type: string
        required:
          - id
          - type
      DesktopGroupConfiguration:
        type: object
        properties:
          minReadyDesktops:
            description: |-
              **string** (int64)
              Minimum number of ready desktops.
            type: string
            format: int64
          maxDesktopsAmount:
            description: |-
              **string** (int64)
              Maximum number of desktops.
            type: string
            format: int64
          desktopType:
            description: |-
              **enum** (DesktopType)
              Type of the desktop.
              - `DESKTOP_TYPE_UNSPECIFIED`
              - `PERSISTENT`
              - `NON_PERSISTENT`
            type: string
            enum:
              - DESKTOP_TYPE_UNSPECIFIED
              - PERSISTENT
              - NON_PERSISTENT
          members:
            description: |-
              **`Subject`**
              List of members of the desktop group.
            type: array
            items:
              $ref: '#/definitions/Subject'
      DiskSpec:
        type: object
        properties:
          type:
            description: |-
              **enum** (Type)
              Required field. Type of disk.
              - `TYPE_UNSPECIFIED`: Disk type is not specified.
              - `HDD`: HDD disk type.
              - `SSD`: SSD disk type.
            type: string
            enum:
              - TYPE_UNSPECIFIED
              - HDD
              - SSD
          size:
            description: |-
              **string** (int64)
              Size of disk.
            type: string
            format: int64
        required:
          - type
      AutoUpdatePolicy:
        type: object
        properties: {}
      ManualUpdatePolicy:
        type: object
        properties: {}
sourcePath: en/_api-ref/clouddesktop/v1/api-ref/DesktopGroup/update.md
---

# Cloud Desktop API, REST: DesktopGroup.Update

Updates desktop group properties

## HTTP request

```
PATCH https://cloud-desktop.{{ api-host }}/cloud-desktop/v1/desktopGroups/{desktopGroupId}
```

## Path parameters

#|
||Field | Description ||
|| desktopGroupId | **string**

Required field.  ||
|#

## Body parameters {#yandex.cloud.clouddesktop.v1.api.UpdateDesktopGroupRequest}

```json
{
  "updateMask": "string",
  "desktopImageId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "resourcesSpec": {
    "memory": "string",
    "cores": "string",
    "coreFraction": "string"
  },
  "groupConfig": {
    "minReadyDesktops": "string",
    "maxDesktopsAmount": "string",
    "desktopType": "string",
    "members": [
      {
        "id": "string",
        "type": "string"
      }
    ]
  },
  "bootDiskSpec": {
    "type": "string",
    "size": "string"
  },
  "dataDiskSpec": {
    "type": "string",
    "size": "string"
  },
  // Includes only one of the fields `autoUpdatePolicy`, `manualUpdatePolicy`
  "autoUpdatePolicy": "object",
  "manualUpdatePolicy": "object"
  // end of the list of possible fields
}
```

#|
||Field | Description ||
|| updateMask | **string** (field-mask)

A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
|| desktopImageId | **string** ||
|| name | **string** ||
|| description | **string** ||
|| labels | **object** (map<**string**, **string**>) ||
|| resourcesSpec | **[ResourcesSpec](#yandex.cloud.clouddesktop.v1.api.ResourcesSpec)** ||
|| groupConfig | **[DesktopGroupConfiguration](#yandex.cloud.clouddesktop.v1.api.DesktopGroupConfiguration)**

Configuration of the desktop group. ||
|| bootDiskSpec | **[DiskSpec](#yandex.cloud.clouddesktop.v1.api.DiskSpec)**

Boot disk specification of the desktop group. ||
|| dataDiskSpec | **[DiskSpec](#yandex.cloud.clouddesktop.v1.api.DiskSpec)**

Data disk specification of the desktop group. ||
|| autoUpdatePolicy | **object**

Includes only one of the fields `autoUpdatePolicy`, `manualUpdatePolicy`.

Update policy of the desktop group. ||
|| manualUpdatePolicy | **object**

Includes only one of the fields `autoUpdatePolicy`, `manualUpdatePolicy`.

Update policy of the desktop group. ||
|#

## ResourcesSpec {#yandex.cloud.clouddesktop.v1.api.ResourcesSpec}

#|
||Field | Description ||
|| memory | **string** (int64)

RAM volume, in bytes. ||
|| cores | **string** (int64)

Number of CPU cores. ||
|| coreFraction | **string** (int64)

Baseline level of CPU performance with the ability to burst performance above that baseline level.
This field sets baseline performance for each core. ||
|#

## DesktopGroupConfiguration {#yandex.cloud.clouddesktop.v1.api.DesktopGroupConfiguration}

#|
||Field | Description ||
|| minReadyDesktops | **string** (int64)

Minimum number of ready desktops. ||
|| maxDesktopsAmount | **string** (int64)

Maximum number of desktops. ||
|| desktopType | **enum** (DesktopType)

Type of the desktop.

- `DESKTOP_TYPE_UNSPECIFIED`
- `PERSISTENT`
- `NON_PERSISTENT` ||
|| members[] | **[Subject](#yandex.cloud.access.Subject)**

List of members of the desktop group. ||
|#

## Subject {#yandex.cloud.access.Subject}

#|
||Field | Description ||
|| id | **string**

Required field. ID of the subject.

It can contain one of the following values:
* `allAuthenticatedUsers`: A special public group that represents anyone
who is authenticated. It can be used only if the `type` is `system`.
* `allUsers`: A special public group that represents anyone. No authentication is required.
For example, you don't need to specify the IAM token in an API query.
It can be used only if the `type` is `system`.
* `group:organization:<id>:users`: A special system group that represents all members of organization
with given <id>. It can be used only if the `type` is `system`.
* `group:federation:<id>:users`: A special system group that represents all users of federation
with given <id>. It can be used only if the `type` is `system`.
* `<cloud generated id>`: An identifier that represents a user account.
It can be used only if the `type` is `userAccount`, `federatedUser` or `serviceAccount`. ||
|| type | **string**

Required field. Type of the subject.

It can contain one of the following values:
* `userAccount`: An account on Yandex or Yandex Connect, added to Yandex Cloud.
* `serviceAccount`: A service account. This type represents the [yandex.cloud.iam.v1.ServiceAccount](/docs/iam/api-ref/ServiceAccount/get#yandex.cloud.iam.v1.ServiceAccount) resource.
* `federatedUser`: A federated account. This type represents a user from an identity federation, like Active Directory.
* `system`: System group. This type represents several accounts with a common system identifier.

For more information, see [Subject to which the role is assigned](/docs/iam/concepts/access-control/#subject). ||
|#

## DiskSpec {#yandex.cloud.clouddesktop.v1.api.DiskSpec}

Disk specificaton.

#|
||Field | Description ||
|| type | **enum** (Type)

Required field. Type of disk.

- `TYPE_UNSPECIFIED`: Disk type is not specified.
- `HDD`: HDD disk type.
- `SSD`: SSD disk type. ||
|| size | **string** (int64)

Size of disk. ||
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
    "desktopGroupId": "string"
  },
  // Includes only one of the fields `error`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
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
|| metadata | **[UpdateDesktopGroupMetadata](#yandex.cloud.clouddesktop.v1.api.UpdateDesktopGroupMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## UpdateDesktopGroupMetadata {#yandex.cloud.clouddesktop.v1.api.UpdateDesktopGroupMetadata}

#|
||Field | Description ||
|| desktopGroupId | **string**

ID of the desktop group that is being updated. ||
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