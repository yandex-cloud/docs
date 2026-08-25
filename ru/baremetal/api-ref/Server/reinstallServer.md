---
editable: false
apiPlayground:
  - url: https://baremetal.{{ api-host }}/baremetal/v2/clouds/{cloudId}/folders/{folderId}/servers/{serverId}:reinstall
    method: post
    path:
      type: object
      properties:
        cloudId:
          description: |-
            **string**
            ID of the parent cloud.
            To get the cloud ID, use a [yandex.cloud.resourcemanager.v1.CloudService.List](/docs/resource-manager/api-ref/Cloud/list#List) request.
          type: string
        folderId:
          description: |-
            **string**
            ID of the parent folder.
            To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request.
          type: string
        serverId:
          description: |-
            **string**
            ID of the server to reinstall.
            To get the server ID, use a [ServerService.List] request.
            Value must match the regular expression ` [a-z][a-z0-9]* `.
          pattern: '[a-z][a-z0-9]*'
          type: string
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        osSettings:
          description: |-
            **[OsSettings](#yandex.cloud.baremetal.v2.OsSettings)**
            Operating system specific settings for provisioning the server.
          $ref: '#/definitions/OsSettings'
      additionalProperties: false
    definitions:
      LockboxSecret:
        type: object
        properties:
          secretId:
            description: |-
              **string**
              Required field. The unique identifier for the lockbox secret that contains the user password.
            type: string
          versionId:
            description: |-
              **string**
              The unique identifier for the lockbox version.
              If omitted, the current version of the secret will be used.
            type: string
          key:
            description: |-
              **string**
              Required field. The key used to access a specific secret entry.
            type: string
        required:
          - secretId
          - key
      StoragePartition:
        type: object
        properties:
          type:
            description: |-
              **enum** (StoragePartitionType)
              Partition type.
              - `EXT4`: ext4 file system partition type.
              - `SWAP`: Swap partition type.
              - `EXT3`: ext3 file system partition type.
              - `XFS`: XFS file system partition type.
            type: string
            enum:
              - STORAGE_PARTITION_TYPE_UNSPECIFIED
              - EXT4
              - SWAP
              - EXT3
              - XFS
          sizeBytes:
            description: |-
              **string** (int64)
              Size of the storage partition.
            type: string
            format: int64
          mountPoint:
            description: |-
              **string**
              Storage mount point.
            type: string
      Disk:
        type: object
        properties:
          id:
            description: |-
              **string**
              ID of the disk.
            type: string
          type:
            description: |-
              **enum** (DiskDriveType)
              Type of the disk drive.
              - `HDD`: Hard disk drive.
              - `SSD`: Solid state drive.
              - `NVME`: NVMe Solid state drive.
            type: string
            enum:
              - DISK_DRIVE_TYPE_UNSPECIFIED
              - HDD
              - SSD
              - NVME
          sizeBytes:
            description: |-
              **string** (int64)
              Size of the disk.
            type: string
            format: int64
      Raid:
        type: object
        properties:
          type:
            description: |-
              **enum** (RaidType)
              RAID type.
              - `RAID0`: RAID0 configuration.
              - `RAID1`: RAID1 configuration.
              - `RAID10`: RAID10 configuration.
            type: string
            enum:
              - RAID_TYPE_UNSPECIFIED
              - RAID0
              - RAID1
              - RAID10
          disks:
            description: |-
              **[Disk](#yandex.cloud.baremetal.v2.Disk)**
              Array of disks in the RAID configuration.
            type: array
            items:
              $ref: '#/definitions/Disk'
      Storage:
        type: object
        properties:
          partitions:
            description: |-
              **[StoragePartition](#yandex.cloud.baremetal.v2.StoragePartition)**
              Array of partitions created on the storage.
            type: array
            items:
              $ref: '#/definitions/StoragePartition'
          disk:
            description: |-
              **[Disk](#yandex.cloud.baremetal.v2.Disk)**
              Disk storage.
              Includes only one of the fields `disk`, `raid`.
              Storage type.
            $ref: '#/definitions/Disk'
          raid:
            description: |-
              **[Raid](#yandex.cloud.baremetal.v2.Raid)**
              RAID storage.
              Includes only one of the fields `disk`, `raid`.
              Storage type.
            $ref: '#/definitions/Raid'
        oneOf:
          - required:
              - disk
          - required:
              - raid
      OsSettings:
        type: object
        properties:
          imageId:
            description: |-
              **string**
              ID of the image that the server was created from.
            type: string
          sshPublicKey:
            description: |-
              **string**
              Public SSH key of the server.
            type: string
          sshPublicKeyText:
            description: |-
              **string**
              Public SSH key for the server.
              Input only field.
              The maximum string length in characters is 20000.
              Includes only one of the fields `sshPublicKeyText`, `userSshId`.
              Root user SSH key.
              Input only field. One of elements is required.
            type: string
          userSshId:
            description: |-
              **string**
              ID of the user SSH key to use for the server.
              Input only field. To get the user SSH key ID, use a [yandex.cloud.organizationmanager.v1.UserSshKeyService.List](/docs/organization/api-ref/UserSshKey/list#List) request.
              The maximum string length in characters is 50.
              Includes only one of the fields `sshPublicKeyText`, `userSshId`.
              Root user SSH key.
              Input only field. One of elements is required.
            type: string
          passwordPlainText:
            description: |-
              **string**
              Raw password.
              Input only field.
              The minimum string length in characters is 6.
              Includes only one of the fields `passwordPlainText`, `passwordLockboxSecret`.
              Password for the server.
              Input only field. One of elements is required.
            type: string
          passwordLockboxSecret:
            description: |-
              **[LockboxSecret](#yandex.cloud.baremetal.v2.LockboxSecret)**
              Reference to the Lockbox secret used to obtain the password.
              Input only field.
              Includes only one of the fields `passwordPlainText`, `passwordLockboxSecret`.
              Password for the server.
              Input only field. One of elements is required.
            $ref: '#/definitions/LockboxSecret'
          storages:
            description: |-
              **[Storage](#yandex.cloud.baremetal.v2.Storage)**
              List of storages.
              If not specified, the default value based on the selected configuration will be used as the field value.
            type: array
            items:
              $ref: '#/definitions/Storage'
        allOf:
          - oneOf:
              - required:
                  - sshPublicKeyText
              - required:
                  - userSshId
          - oneOf:
              - required:
                  - passwordPlainText
              - required:
                  - passwordLockboxSecret
---

# BareMetal API, REST: Server.ReinstallServer

Reinstalls the specified server.

https://google.aip.dev/130 --)

Required for backward compatibility with old clients. --)

## HTTP request

```
POST https://baremetal.{{ api-host }}/baremetal/v2/clouds/{cloudId}/folders/{folderId}/servers/{serverId}:reinstall
```

## Path parameters

#|
||Field | Description ||
|| cloudId | **string**

Required field. ID of the parent cloud.

To get the cloud ID, use a [yandex.cloud.resourcemanager.v1.CloudService.List](/docs/resource-manager/api-ref/Cloud/list#List) request. ||
|| folderId | **string**

Required field. ID of the parent folder.

To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request. ||
|| serverId | **string**

Required field. ID of the server to reinstall.

To get the server ID, use a [ServerService.List] request.

Value must match the regular expression ` [a-z][a-z0-9]* `. ||
|#

## Body parameters {#yandex.cloud.baremetal.v2.ReinstallServerRequest}

```json
{
  "osSettings": {
    "imageId": "string",
    "sshPublicKey": "string",
    // Includes only one of the fields `sshPublicKeyText`, `userSshId`
    "sshPublicKeyText": "string",
    "userSshId": "string",
    // end of the list of possible fields
    // Includes only one of the fields `passwordPlainText`, `passwordLockboxSecret`
    "passwordPlainText": "string",
    "passwordLockboxSecret": {
      "secretId": "string",
      "versionId": "string",
      "key": "string"
    },
    // end of the list of possible fields
    "storages": [
      {
        "partitions": [
          {
            "type": "string",
            "sizeBytes": "string",
            "mountPoint": "string"
          }
        ],
        // Includes only one of the fields `disk`, `raid`
        "disk": {
          "id": "string",
          "type": "string",
          "sizeBytes": "string"
        },
        "raid": {
          "type": "string",
          "disks": [
            {
              "id": "string",
              "type": "string",
              "sizeBytes": "string"
            }
          ]
        }
        // end of the list of possible fields
      }
    ]
  }
}
```

#|
||Field | Description ||
|| osSettings | **[OsSettings](#yandex.cloud.baremetal.v2.OsSettings)**

Operating system specific settings for provisioning the server. ||
|#

## OsSettings {#yandex.cloud.baremetal.v2.OsSettings}

#|
||Field | Description ||
|| imageId | **string**

ID of the image that the server was created from. ||
|| sshPublicKey | **string**

Public SSH key of the server. ||
|| sshPublicKeyText | **string**

Public SSH key for the server.

Input only field.

The maximum string length in characters is 20000.

Includes only one of the fields `sshPublicKeyText`, `userSshId`.

Root user SSH key.

Input only field. One of elements is required. ||
|| userSshId | **string**

ID of the user SSH key to use for the server.

Input only field. To get the user SSH key ID, use a [yandex.cloud.organizationmanager.v1.UserSshKeyService.List](/docs/organization/api-ref/UserSshKey/list#List) request.

The maximum string length in characters is 50.

Includes only one of the fields `sshPublicKeyText`, `userSshId`.

Root user SSH key.

Input only field. One of elements is required. ||
|| passwordPlainText | **string**

Raw password.

Input only field.

The minimum string length in characters is 6.

Includes only one of the fields `passwordPlainText`, `passwordLockboxSecret`.

Password for the server.

Input only field. One of elements is required. ||
|| passwordLockboxSecret | **[LockboxSecret](#yandex.cloud.baremetal.v2.LockboxSecret)**

Reference to the Lockbox secret used to obtain the password.

Input only field.

Includes only one of the fields `passwordPlainText`, `passwordLockboxSecret`.

Password for the server.

Input only field. One of elements is required. ||
|| storages[] | **[Storage](#yandex.cloud.baremetal.v2.Storage)**

List of storages.

If not specified, the default value based on the selected configuration will be used as the field value. ||
|#

## LockboxSecret {#yandex.cloud.baremetal.v2.LockboxSecret}

#|
||Field | Description ||
|| secretId | **string**

Required field. The unique identifier for the lockbox secret that contains the user password. ||
|| versionId | **string**

The unique identifier for the lockbox version.
If omitted, the current version of the secret will be used. ||
|| key | **string**

Required field. The key used to access a specific secret entry. ||
|#

## Storage {#yandex.cloud.baremetal.v2.Storage}

Storage, a OS-level storage entity used for creating partitions. For example, this could
represent a plain disk or a software RAID of disks.

#|
||Field | Description ||
|| partitions[] | **[StoragePartition](#yandex.cloud.baremetal.v2.StoragePartition)**

Array of partitions created on the storage. ||
|| disk | **[Disk](#yandex.cloud.baremetal.v2.Disk)**

Disk storage.

Includes only one of the fields `disk`, `raid`.

Storage type. ||
|| raid | **[Raid](#yandex.cloud.baremetal.v2.Raid)**

RAID storage.

Includes only one of the fields `disk`, `raid`.

Storage type. ||
|#

## StoragePartition {#yandex.cloud.baremetal.v2.StoragePartition}

#|
||Field | Description ||
|| type | **enum** (StoragePartitionType)

Partition type.

- `EXT4`: ext4 file system partition type.
- `SWAP`: Swap partition type.
- `EXT3`: ext3 file system partition type.
- `XFS`: XFS file system partition type. ||
|| sizeBytes | **string** (int64)

Size of the storage partition. ||
|| mountPoint | **string**

Storage mount point. ||
|#

## Disk {#yandex.cloud.baremetal.v2.Disk}

Disk.

#|
||Field | Description ||
|| id | **string**

ID of the disk. ||
|| type | **enum** (DiskDriveType)

Type of the disk drive.

- `HDD`: Hard disk drive.
- `SSD`: Solid state drive.
- `NVME`: NVMe Solid state drive. ||
|| sizeBytes | **string** (int64)

Size of the disk. ||
|#

## Raid {#yandex.cloud.baremetal.v2.Raid}

RAID storage.

#|
||Field | Description ||
|| type | **enum** (RaidType)

RAID type.

- `RAID0`: RAID0 configuration.
- `RAID1`: RAID1 configuration.
- `RAID10`: RAID10 configuration. ||
|| disks[] | **[Disk](#yandex.cloud.baremetal.v2.Disk)**

Array of disks in the RAID configuration. ||
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
  "metadata": "object",
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": "object"
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
|| metadata | **object**

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
|| response | **object**

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