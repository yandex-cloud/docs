---
editable: false
apiPlayground:
  - url: https://cloud-desktop.{{ api-host }}/cloud-desktop/v1/desktopGroups
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        folderId:
          description: |-
            **string**
            Required field. ID of the folder to create a DesktopGroup in.
            To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request.
          type: string
        desktopImageId:
          description: |-
            **string**
            Required field. An image used to create a desktop boot disk
          type: string
        name:
          description: |-
            **string**
            Name of the DesktopGroup.
            The name must be unique within the folder.
          pattern: '[a-z]([-a-z0-9]{0,61}[a-z0-9])'
          type: string
        description:
          description: |-
            **string**
            Description of the DesktopGroup.
          type: string
        resourcesSpec:
          description: |-
            **[ResourcesSpec](/docs/cloud-desktop/api-ref/DesktopGroup/get#yandex.cloud.clouddesktop.v1.api.ResourcesSpec)**
            Resource specification of the desktop group.
          $ref: '#/definitions/ResourcesSpec'
        networkInterfaceSpec:
          description: |-
            **[NetworkInterfaceSpec](/docs/cloud-desktop/api-ref/DesktopGroup/get#yandex.cloud.clouddesktop.v1.api.NetworkInterfaceSpec)**
            Network interface specification of the desktop group.
          $ref: '#/definitions/NetworkInterfaceSpec'
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
        groupConfig:
          description: |-
            **[DesktopGroupConfiguration](/docs/cloud-desktop/api-ref/DesktopGroup/get#yandex.cloud.clouddesktop.v1.api.DesktopGroupConfiguration)**
            Configuration of the desktop group.
          $ref: '#/definitions/DesktopGroupConfiguration'
      required:
        - folderId
        - desktopImageId
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
      NetworkInterfaceSpec:
        type: object
        properties:
          networkId:
            description: |-
              **string**
              Required field. ID of the network interface specification.
            type: string
          subnetIds:
            description: |-
              **string**
              List of subnet IDs.
            uniqueItems: true
            type: array
            items:
              type: string
        required:
          - networkId
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
sourcePath: en/_api-ref/clouddesktop/v1/api-ref/DesktopGroup/create.md
---

# Cloud Desktop API, REST: DesktopGroup.Create

Creates desktop group in the specified folder.

## HTTP request

```
POST https://cloud-desktop.{{ api-host }}/cloud-desktop/v1/desktopGroups
```

## Body parameters {#yandex.cloud.clouddesktop.v1.api.CreateDesktopGroupRequest}

```json
{
  "folderId": "string",
  "desktopImageId": "string",
  "name": "string",
  "description": "string",
  "resourcesSpec": {
    "memory": "string",
    "cores": "string",
    "coreFraction": "string"
  },
  "networkInterfaceSpec": {
    "networkId": "string",
    "subnetIds": [
      "string"
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
  }
}
```

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to create a DesktopGroup in.

To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request. ||
|| desktopImageId | **string**

Required field. An image used to create a desktop boot disk ||
|| name | **string**

Name of the DesktopGroup.
The name must be unique within the folder. ||
|| description | **string**

Description of the DesktopGroup. ||
|| resourcesSpec | **[ResourcesSpec](#yandex.cloud.clouddesktop.v1.api.ResourcesSpec)**

Resource specification of the desktop group. ||
|| networkInterfaceSpec | **[NetworkInterfaceSpec](#yandex.cloud.clouddesktop.v1.api.NetworkInterfaceSpec)**

Network interface specification of the desktop group. ||
|| bootDiskSpec | **[DiskSpec](#yandex.cloud.clouddesktop.v1.api.DiskSpec)**

Boot disk specification of the desktop group. ||
|| dataDiskSpec | **[DiskSpec](#yandex.cloud.clouddesktop.v1.api.DiskSpec)**

Data disk specification of the desktop group. ||
|| groupConfig | **[DesktopGroupConfiguration](#yandex.cloud.clouddesktop.v1.api.DesktopGroupConfiguration)**

Configuration of the desktop group. ||
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

## NetworkInterfaceSpec {#yandex.cloud.clouddesktop.v1.api.NetworkInterfaceSpec}

#|
||Field | Description ||
|| networkId | **string**

Required field. ID of the network interface specification. ||
|| subnetIds[] | **string**

List of subnet IDs. ||
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
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
    "id": "string",
    "folderId": "string",
    "createdAt": "string",
    "status": "string",
    "name": "string",
    "description": "string",
    "resourcesSpec": {
      "memory": "string",
      "cores": "string",
      "coreFraction": "string"
    },
    "networkInterfaceSpec": {
      "networkId": "string",
      "subnetIds": [
        "string"
      ]
    },
    "labels": "object",
    "bootDiskSpec": {
      "type": "string",
      "size": "string"
    },
    "dataDiskSpec": {
      "type": "string",
      "size": "string"
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
    // Includes only one of the fields `autoUpdatePolicy`, `manualUpdatePolicy`
    "autoUpdatePolicy": "object",
    "manualUpdatePolicy": "object"
    // end of the list of possible fields
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
|| metadata | **[CreateDesktopGroupMetadata](#yandex.cloud.clouddesktop.v1.api.CreateDesktopGroupMetadata)**

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
|| response | **[DesktopGroup](#yandex.cloud.clouddesktop.v1.api.DesktopGroup)**

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

## CreateDesktopGroupMetadata {#yandex.cloud.clouddesktop.v1.api.CreateDesktopGroupMetadata}

#|
||Field | Description ||
|| desktopGroupId | **string**

ID of the desktop group that is being created. ||
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

## DesktopGroup {#yandex.cloud.clouddesktop.v1.api.DesktopGroup}

A desktop group resource.

#|
||Field | Description ||
|| id | **string**

Desktop group ID. ||
|| folderId | **string**

ID of the folder that the desktop group belongs to. ||
|| createdAt | **string** (date-time)

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| status | **enum** (Status)

Status of the desktop group.

- `STATUS_UNSPECIFIED`
- `CREATING`: Desktop group is being created.
- `ACTIVE`: Desktop group is ready to use.
- `DELETING`: Desktop group is being deleted. ||
|| name | **string**

Name of the desktop group. ||
|| description | **string**

Description of the desktop group. ||
|| resourcesSpec | **[ResourcesSpec](#yandex.cloud.clouddesktop.v1.api.ResourcesSpec2)**

Resource specification of the desktop group. ||
|| networkInterfaceSpec | **[NetworkInterfaceSpec](#yandex.cloud.clouddesktop.v1.api.NetworkInterfaceSpec2)**

Network interface specification of the desktop group. ||
|| labels | **object** (map<**string**, **string**>)

Labels of the desktop group. ||
|| bootDiskSpec | **[DiskSpec](#yandex.cloud.clouddesktop.v1.api.DiskSpec2)**

Boot disk specification of the desktop group. ||
|| dataDiskSpec | **[DiskSpec](#yandex.cloud.clouddesktop.v1.api.DiskSpec2)**

Data disk specification of the desktop group. ||
|| groupConfig | **[DesktopGroupConfiguration](#yandex.cloud.clouddesktop.v1.api.DesktopGroupConfiguration2)**

Desktop group configuration. ||
|| autoUpdatePolicy | **object**

Includes only one of the fields `autoUpdatePolicy`, `manualUpdatePolicy`.

Desktop group update policy. ||
|| manualUpdatePolicy | **object**

Includes only one of the fields `autoUpdatePolicy`, `manualUpdatePolicy`.

Desktop group update policy. ||
|#

## ResourcesSpec {#yandex.cloud.clouddesktop.v1.api.ResourcesSpec2}

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

## NetworkInterfaceSpec {#yandex.cloud.clouddesktop.v1.api.NetworkInterfaceSpec2}

#|
||Field | Description ||
|| networkId | **string**

Required field. ID of the network interface specification. ||
|| subnetIds[] | **string**

List of subnet IDs. ||
|#

## DiskSpec {#yandex.cloud.clouddesktop.v1.api.DiskSpec2}

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

## DesktopGroupConfiguration {#yandex.cloud.clouddesktop.v1.api.DesktopGroupConfiguration2}

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
|| members[] | **[Subject](#yandex.cloud.access.Subject2)**

List of members of the desktop group. ||
|#

## Subject {#yandex.cloud.access.Subject2}

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