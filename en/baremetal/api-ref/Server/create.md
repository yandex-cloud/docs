---
editable: false
apiPlayground:
  - url: https://baremetal.{{ api-host }}/baremetal/v1alpha/servers
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        folderId:
          description: |-
            **string**
            ID of the folder to create server in.
            To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request.
          pattern: '[a-z][a-z0-9.-]*'
          type: string
        name:
          description: |-
            **string**
            Name of the server.
            The name must be unique within the folder.
          pattern: '[a-z]([-a-z0-9]*[a-z0-9])?'
          type: string
        description:
          description: |-
            **string**
            Description of the server.
          type: string
        hardwarePoolId:
          description: |-
            **string**
            ID of the hardware pool that the server belongs to.
            To get the hardware pool ID, use a [HardwarePoolService.List](/docs/baremetal/api-ref/HardwarePool/list#List) request.
          type: string
        configurationId:
          description: |-
            **string**
            ID of the configuration to use for the server.
            To get the configuration ID, use a [ConfigurationService.List](/docs/baremetal/api-ref/Configuration/list#List) request.
          pattern: '[a-z][a-z0-9]*'
          type: string
        rentalPeriodId:
          description: |-
            **string**
            A period of time for which the server is rented.
          type: string
        networkInterfaces:
          description: |-
            **[NetworkInterfaceSpec](/docs/baremetal/api-ref/Server/create#yandex.cloud.baremetal.v1alpha.NetworkInterfaceSpec)**
            Network configuration for the server. Specifies how the network interface is configured
            to interact with other servers on the internal network and on the internet.
            Currently up to 2 network interfaces are supported: required private network interface and
            optional public network interface.
          type: array
          items:
            oneOf:
              - type: object
                properties:
                  privateSubnet:
                    description: |-
                      **[PrivateSubnetNetworkInterface](/docs/baremetal/api-ref/Server/get#yandex.cloud.baremetal.v1alpha.PrivateSubnetNetworkInterface)**
                      Private subnet.
                      Includes only one of the fields `privateSubnet`, `publicSubnet`.
                      Subnet that the network interface belongs to.
                    $ref: '#/definitions/PrivateSubnetNetworkInterface'
                  publicSubnet:
                    description: |-
                      **[PublicSubnetNetworkInterface](/docs/baremetal/api-ref/Server/get#yandex.cloud.baremetal.v1alpha.PublicSubnetNetworkInterface)**
                      Public subnet.
                      Includes only one of the fields `privateSubnet`, `publicSubnet`.
                      Subnet that the network interface belongs to.
                    $ref: '#/definitions/PublicSubnetNetworkInterface'
        osSettingsSpec:
          description: |-
            **[OsSettingsSpec](/docs/baremetal/api-ref/Server/create#yandex.cloud.baremetal.v1alpha.OsSettingsSpec)**
            Operating system specific settings for provisioning the server. Optional, if omitted, the
            server will be created without an operating system.
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
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            Resource labels as `key:value` pairs.
          pattern: '[a-z][-_0-9a-z]*'
          type: string
      additionalProperties: false
    definitions:
      PrivateSubnetNetworkInterface:
        type: object
        properties:
          privateSubnetId:
            description: |-
              **string**
              ID of the private subnet.
            type: string
      PublicSubnetNetworkInterface:
        type: object
        properties:
          publicSubnetId:
            description: |-
              **string**
              ID of the public subnet.
              A new ephemeral public subnet will be created if not specified.
            type: string
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
sourcePath: en/_api-ref/baremetal/v1alpha/api-ref/Server/create.md
---

# BareMetal API, REST: Server.Create

Creates a server in the specified folder.

## HTTP request

```
POST https://baremetal.{{ api-host }}/baremetal/v1alpha/servers
```

## Body parameters {#yandex.cloud.baremetal.v1alpha.CreateServerRequest}

```json
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "hardwarePoolId": "string",
  "configurationId": "string",
  "rentalPeriodId": "string",
  "networkInterfaces": [
    {
      "id": "string",
      // Includes only one of the fields `privateSubnet`, `publicSubnet`
      "privateSubnet": {
        "privateSubnetId": "string"
      },
      "publicSubnet": {
        "publicSubnetId": "string"
      }
      // end of the list of possible fields
    }
  ],
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
  },
  "labels": "object"
}
```

#|
||Field | Description ||
|| folderId | **string**

ID of the folder to create server in.

To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request. ||
|| name | **string**

Name of the server.
The name must be unique within the folder. ||
|| description | **string**

Description of the server. ||
|| hardwarePoolId | **string**

ID of the hardware pool that the server belongs to.

To get the hardware pool ID, use a [HardwarePoolService.List](/docs/baremetal/api-ref/HardwarePool/list#List) request. ||
|| configurationId | **string**

ID of the configuration to use for the server.

To get the configuration ID, use a [ConfigurationService.List](/docs/baremetal/api-ref/Configuration/list#List) request. ||
|| rentalPeriodId | **string**

A period of time for which the server is rented. ||
|| networkInterfaces[] | **[NetworkInterfaceSpec](#yandex.cloud.baremetal.v1alpha.NetworkInterfaceSpec)**

Network configuration for the server. Specifies how the network interface is configured
to interact with other servers on the internal network and on the internet.
Currently up to 2 network interfaces are supported: required private network interface and
optional public network interface. ||
|| osSettingsSpec | **[OsSettingsSpec](#yandex.cloud.baremetal.v1alpha.OsSettingsSpec)**

Operating system specific settings for provisioning the server. Optional, if omitted, the
server will be created without an operating system. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|#

## NetworkInterfaceSpec {#yandex.cloud.baremetal.v1alpha.NetworkInterfaceSpec}

#|
||Field | Description ||
|| id | **string**

ID of the network interface. Should not be specified when creating a server. ||
|| privateSubnet | **[PrivateSubnetNetworkInterface](#yandex.cloud.baremetal.v1alpha.PrivateSubnetNetworkInterface)**

Private subnet.

Includes only one of the fields `privateSubnet`, `publicSubnet`.

Subnet that the network interface belongs to. ||
|| publicSubnet | **[PublicSubnetNetworkInterface](#yandex.cloud.baremetal.v1alpha.PublicSubnetNetworkInterface)**

Public subnet.

Includes only one of the fields `privateSubnet`, `publicSubnet`.

Subnet that the network interface belongs to. ||
|#

## PrivateSubnetNetworkInterface {#yandex.cloud.baremetal.v1alpha.PrivateSubnetNetworkInterface}

#|
||Field | Description ||
|| privateSubnetId | **string**

ID of the private subnet. ||
|#

## PublicSubnetNetworkInterface {#yandex.cloud.baremetal.v1alpha.PublicSubnetNetworkInterface}

#|
||Field | Description ||
|| publicSubnetId | **string**

ID of the public subnet.

A new ephemeral public subnet will be created if not specified. ||
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
    "cloudId": "string",
    "folderId": "string",
    "name": "string",
    "description": "string",
    "zoneId": "string",
    "hardwarePoolId": "string",
    "status": "string",
    "osSettings": {
      "imageId": "string",
      "sshPublicKey": "string",
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
      ]
    },
    "networkInterfaces": [
      {
        "id": "string",
        "macAddress": "string",
        "ipAddress": "string",
        // Includes only one of the fields `privateSubnet`, `publicSubnet`
        "privateSubnet": {
          "privateSubnetId": "string"
        },
        "publicSubnet": {
          "publicSubnetId": "string"
        }
        // end of the list of possible fields
      }
    ],
    "configurationId": "string",
    "disks": [
      {
        "id": "string",
        "type": "string",
        "sizeGib": "string"
      }
    ],
    "createdAt": "string",
    "labels": "object"
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
|| metadata | **[CreateServerMetadata](#yandex.cloud.baremetal.v1alpha.CreateServerMetadata)**

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
|| response | **[Server](#yandex.cloud.baremetal.v1alpha.Server)**

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

## CreateServerMetadata {#yandex.cloud.baremetal.v1alpha.CreateServerMetadata}

#|
||Field | Description ||
|| serverId | **string**

ID of the server that is being created. ||
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

## Server {#yandex.cloud.baremetal.v1alpha.Server}

A Server resource.

#|
||Field | Description ||
|| id | **string**

ID of the server. ||
|| cloudId | **string**

ID of the cloud that the server belongs to. ||
|| folderId | **string**

ID of the folder that the server belongs to. ||
|| name | **string**

Name of the server.
The name is unique within the folder. ||
|| description | **string**

Description of the server. ||
|| zoneId | **string**

ID of the availability zone where the server is resides. ||
|| hardwarePoolId | **string**

ID of the hardware pool that the server belongs to. ||
|| status | **enum** (Status)

Status of the server.

- `STATUS_UNSPECIFIED`: Unspecified server status.
- `PROVISIONING`: Server is waiting for to be allocated from the hardware pool.
- `STOPPING`: Server is being stopped.
- `STOPPED`: Server has been stopped.
- `STARTING`: Server is being started.
- `RESTARTING`: Server is being restarted.
- `ERROR`: Server encountered a problem and cannot operate.
- `DELETING`: Server is being deleted.
- `REINSTALLING`: Server operating system is being reinstalled.
- `UPDATING`: Server is being updated.
- `QUARANTINED`: Server has been quarantined
- `RUNNING`: Server is running normaly ||
|| osSettings | **[OsSettings](#yandex.cloud.baremetal.v1alpha.OsSettings)**

Operating system specific settings of the server. Optional, will be empty if the server is
provisioned without an operating system. ||
|| networkInterfaces[] | **[NetworkInterface](#yandex.cloud.baremetal.v1alpha.NetworkInterface)**

Array of network interfaces that are attached to the instance. ||
|| configurationId | **string**

ID of the configuration that was used to create the server. ||
|| disks[] | **[Disk](#yandex.cloud.baremetal.v1alpha.Disk2)**

Array of disks that are attached to the server. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|#

## OsSettings {#yandex.cloud.baremetal.v1alpha.OsSettings}

#|
||Field | Description ||
|| imageId | **string**

ID of the image that the server was created from. ||
|| sshPublicKey | **string**

Public SSH key of the server. ||
|| storages[] | **[Storage](#yandex.cloud.baremetal.v1alpha.Storage2)**

List of storages. ||
|#

## Storage {#yandex.cloud.baremetal.v1alpha.Storage2}

Storage, a OS-level storage entity used for creating partitions. For example, this could
represent a plain disk or a software RAID of disks.

#|
||Field | Description ||
|| partitions[] | **[StoragePartition](#yandex.cloud.baremetal.v1alpha.StoragePartition2)**

Array of partitions created on the storage. ||
|| disk | **[Disk](#yandex.cloud.baremetal.v1alpha.Disk2)**

Disk storage.

Includes only one of the fields `disk`, `raid`.

Storage type. ||
|| raid | **[Raid](#yandex.cloud.baremetal.v1alpha.Raid2)**

RAID storage.

Includes only one of the fields `disk`, `raid`.

Storage type. ||
|#

## StoragePartition {#yandex.cloud.baremetal.v1alpha.StoragePartition2}

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

## Disk {#yandex.cloud.baremetal.v1alpha.Disk2}

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

## Raid {#yandex.cloud.baremetal.v1alpha.Raid2}

RAID storage.

#|
||Field | Description ||
|| type | **enum** (RaidType)

RAID type.

- `RAID_TYPE_UNSPECIFIED`: Unspecified RAID configuration.
- `RAID0`: RAID0 configuration.
- `RAID1`: RAID1 configuration.
- `RAID10`: RAID10 configuration. ||
|| disks[] | **[Disk](#yandex.cloud.baremetal.v1alpha.Disk2)**

Array of disks in the RAID configuration. ||
|#

## NetworkInterface {#yandex.cloud.baremetal.v1alpha.NetworkInterface}

#|
||Field | Description ||
|| id | **string**

ID of the network interface. ||
|| macAddress | **string**

MAC address that is assigned to the network interface. ||
|| ipAddress | **string**

IPv4 address that is assigned to the server for this network interface. ||
|| privateSubnet | **[PrivateSubnetNetworkInterface](#yandex.cloud.baremetal.v1alpha.PrivateSubnetNetworkInterface2)**

Private subnet.

Includes only one of the fields `privateSubnet`, `publicSubnet`.

Subnet that the network interface belongs to. ||
|| publicSubnet | **[PublicSubnetNetworkInterface](#yandex.cloud.baremetal.v1alpha.PublicSubnetNetworkInterface2)**

Public subnet.

Includes only one of the fields `privateSubnet`, `publicSubnet`.

Subnet that the network interface belongs to. ||
|#

## PrivateSubnetNetworkInterface {#yandex.cloud.baremetal.v1alpha.PrivateSubnetNetworkInterface2}

#|
||Field | Description ||
|| privateSubnetId | **string**

ID of the private subnet. ||
|#

## PublicSubnetNetworkInterface {#yandex.cloud.baremetal.v1alpha.PublicSubnetNetworkInterface2}

#|
||Field | Description ||
|| publicSubnetId | **string**

ID of the public subnet.

A new ephemeral public subnet will be created if not specified. ||
|#