---
editable: false
apiPlayground:
  - url: https://baremetal.{{ api-host }}/baremetal/v1alpha/servers/{serverId}:reinstall
    method: post
    path:
      type: object
      properties:
        serverId:
          description: |-
            **string**
            ID of the server to reinstall.
            To get the server ID, use a [ServerService.List](/docs/baremetal/api-ref/Server/list#List) request.
          pattern: '[a-z][a-z0-9]*'
          type: string
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        osSettingsSpec:
          description: |-
            **[OsSettingsSpec](/docs/baremetal/api-ref/Server/create#yandex.cloud.baremetal.v1alpha.OsSettingsSpec)**
            Operating system specific settings for provisioning the server.
          oneOf:
            - type: object
              properties:
                sshPublicKey:
                  description: |-
                    **string**
                    Public SSH key for the server.
                    Includes only one of the fields `sshPublicKey`, `userSshId`.
                    Root user SSH key.
                  type: string
                userSshId:
                  description: |-
                    **string**
                    ID of the user SSH key to use for the server.
                    To get the user SSH key ID, use a [yandex.cloud.organizationmanager.v1.UserSshKeyService.List](/docs/organization/api-ref/UserSshKey/list#List) request.
                    Includes only one of the fields `sshPublicKey`, `userSshId`.
                    Root user SSH key.
                  type: string
            - type: object
              properties:
                passwordPlainText:
                  description: |-
                    **string**
                    Raw password.
                    Includes only one of the fields `passwordPlainText`, `passwordLockboxSecret`.
                    Password for the server.
                  type: string
                passwordLockboxSecret:
                  description: |-
                    **[LockboxSecret](/docs/baremetal/api-ref/Server/create#yandex.cloud.baremetal.v1alpha.LockboxSecret)**
                    Reference to the Lockbox secret used to obtain the password.
                    Includes only one of the fields `passwordPlainText`, `passwordLockboxSecret`.
                    Password for the server.
                  $ref: '#/definitions/LockboxSecret'
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
sourcePath: en/_api-ref/baremetal/v1alpha/api-ref/Server/reinstall.md
---

# BareMetal API, REST: Server.Reinstall

Reinstalls the specified server.

## HTTP request

```
POST https://baremetal.{{ api-host }}/baremetal/v1alpha/servers/{serverId}:reinstall
```

## Path parameters

#|
||Field | Description ||
|| serverId | **string**

Required field. ID of the server to reinstall.

To get the server ID, use a [ServerService.List](/docs/baremetal/api-ref/Server/list#List) request. ||
|#

## Body parameters {#yandex.cloud.baremetal.v1alpha.ReinstallServerRequest}

```json
{
  "osSettingsSpec": {
    "imageId": "string",
    "storages": [
      {
        "partitions": [
          {
            "type": "string",
            "sizeGib": "string",
            "mountPoint": "string"
          }
        ],
        // Includes only one of the fields `disk`, `raid`
        "disk": {
          "id": "string",
          "type": "string",
          "sizeGib": "string"
        },
        "raid": {
          "type": "string",
          "disks": [
            {
              "id": "string",
              "type": "string",
              "sizeGib": "string"
            }
          ]
        }
        // end of the list of possible fields
      }
    ],
    // Includes only one of the fields `sshPublicKey`, `userSshId`
    "sshPublicKey": "string",
    "userSshId": "string",
    // end of the list of possible fields
    // Includes only one of the fields `passwordPlainText`, `passwordLockboxSecret`
    "passwordPlainText": "string",
    "passwordLockboxSecret": {
      "secretId": "string",
      "versionId": "string",
      "key": "string"
    }
    // end of the list of possible fields
  }
}
```

#|
||Field | Description ||
|| osSettingsSpec | **[OsSettingsSpec](#yandex.cloud.baremetal.v1alpha.OsSettingsSpec)**

Operating system specific settings for provisioning the server. ||
|#

## OsSettingsSpec {#yandex.cloud.baremetal.v1alpha.OsSettingsSpec}

#|
||Field | Description ||
|| imageId | **string**

ID of the image that the server was created from. ||
|| storages[] | **[Storage](#yandex.cloud.baremetal.v1alpha.Storage)**

List of storages to be created on the server. If not specified, the default value based on the
selected configuration will be used as the field value. ||
|| sshPublicKey | **string**

Public SSH key for the server.

Includes only one of the fields `sshPublicKey`, `userSshId`.

Root user SSH key. ||
|| userSshId | **string**

ID of the user SSH key to use for the server.

To get the user SSH key ID, use a [yandex.cloud.organizationmanager.v1.UserSshKeyService.List](/docs/organization/api-ref/UserSshKey/list#List) request.

Includes only one of the fields `sshPublicKey`, `userSshId`.

Root user SSH key. ||
|| passwordPlainText | **string**

Raw password.

Includes only one of the fields `passwordPlainText`, `passwordLockboxSecret`.

Password for the server. ||
|| passwordLockboxSecret | **[LockboxSecret](#yandex.cloud.baremetal.v1alpha.LockboxSecret)**

Reference to the Lockbox secret used to obtain the password.

Includes only one of the fields `passwordPlainText`, `passwordLockboxSecret`.

Password for the server. ||
|#

## Storage {#yandex.cloud.baremetal.v1alpha.Storage}

Storage, a OS-level storage entity used for creating partitions. For example, this could
represent a plain disk or a software RAID of disks.

#|
||Field | Description ||
|| partitions[] | **[StoragePartition](#yandex.cloud.baremetal.v1alpha.StoragePartition)**

Array of partitions created on the storage. ||
|| disk | **[Disk](#yandex.cloud.baremetal.v1alpha.Disk)**

Disk storage.

Includes only one of the fields `disk`, `raid`.

Storage type. ||
|| raid | **[Raid](#yandex.cloud.baremetal.v1alpha.Raid)**

RAID storage.

Includes only one of the fields `disk`, `raid`.

Storage type. ||
|#

## StoragePartition {#yandex.cloud.baremetal.v1alpha.StoragePartition}

#|
||Field | Description ||
|| type | **enum** (StoragePartitionType)

Partition type.

- `STORAGE_PARTITION_TYPE_UNSPECIFIED`: Unspecified storage partition type.
- `EXT4`: ext4 file system partition type.
- `SWAP`: Swap partition type.
- `EXT3`: ext3 file system partition type.
- `XFS`: XFS file system partition type. ||
|| sizeGib | **string** (int64)

Size of the storage partition in gibibytes (2^30 bytes). ||
|| mountPoint | **string**

Storage mount point. ||
|#

## Disk {#yandex.cloud.baremetal.v1alpha.Disk}

Disk.

#|
||Field | Description ||
|| id | **string**

ID of the disk. ||
|| type | **enum** (DiskDriveType)

Type of the disk drive.

- `DISK_DRIVE_TYPE_UNSPECIFIED`: Unspecified disk drive type.
- `HDD`: Hard disk drive (magnetic storage).
- `SSD`: Solid state drive with SATA/SAS interface.
- `NVME`: Solid state drive with NVMe interface. ||
|| sizeGib | **string** (int64)

Size of the disk in gibibytes (2^30 bytes). ||
|#

## Raid {#yandex.cloud.baremetal.v1alpha.Raid}

RAID storage.

#|
||Field | Description ||
|| type | **enum** (RaidType)

RAID type.

- `RAID_TYPE_UNSPECIFIED`: Unspecified RAID configuration.
- `RAID0`: RAID0 configuration.
- `RAID1`: RAID1 configuration.
- `RAID10`: RAID10 configuration. ||
|| disks[] | **[Disk](#yandex.cloud.baremetal.v1alpha.Disk)**

Array of disks in the RAID configuration. ||
|#

## LockboxSecret {#yandex.cloud.baremetal.v1alpha.LockboxSecret}

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
    "serverId": "string"
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
|| metadata | **[ReinstallServerMetadata](#yandex.cloud.baremetal.v1alpha.ReinstallServerMetadata)**

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

## ReinstallServerMetadata {#yandex.cloud.baremetal.v1alpha.ReinstallServerMetadata}

#|
||Field | Description ||
|| serverId | **string**

ID of the Server resource that is being reinstalled. ||
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