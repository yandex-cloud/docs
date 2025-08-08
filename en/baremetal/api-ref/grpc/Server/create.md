---
editable: false
sourcePath: en/_api-ref-grpc/baremetal/v1alpha/api-ref/grpc/Server/create.md
---

# BareMetal API, gRPC: ServerService.Create

Creates a server in the specified folder.

## gRPC request

**rpc Create ([CreateServerRequest](#yandex.cloud.baremetal.v1alpha.CreateServerRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateServerRequest {#yandex.cloud.baremetal.v1alpha.CreateServerRequest}

```json
{
  "folder_id": "string",
  "name": "string",
  "description": "string",
  "hardware_pool_id": "string",
  "configuration_id": "string",
  "rental_period_id": "string",
  "network_interfaces": [
    {
      "id": "string",
      // Includes only one of the fields `private_subnet`, `public_subnet`
      "private_subnet": {
        "private_subnet_id": "string"
      },
      "public_subnet": {
        "public_subnet_id": "string"
      }
      // end of the list of possible fields
    }
  ],
  "os_settings_spec": {
    "image_id": "string",
    "storages": [
      {
        "partitions": [
          {
            "type": "StoragePartitionType",
            "size_gib": "int64",
            "mount_point": "string"
          }
        ],
        // Includes only one of the fields `disk`, `raid`
        "disk": {
          "id": "string",
          "type": "DiskDriveType",
          "size_gib": "int64"
        },
        "raid": {
          "type": "RaidType",
          "disks": [
            {
              "id": "string",
              "type": "DiskDriveType",
              "size_gib": "int64"
            }
          ]
        }
        // end of the list of possible fields
      }
    ],
    // Includes only one of the fields `ssh_public_key`, `user_ssh_id`
    "ssh_public_key": "string",
    "user_ssh_id": "string",
    // end of the list of possible fields
    // Includes only one of the fields `password_plain_text`, `password_lockbox_secret`
    "password_plain_text": "string",
    "password_lockbox_secret": {
      "secret_id": "string",
      "version_id": "string",
      "key": "string"
    }
    // end of the list of possible fields
  },
  "labels": "map<string, string>"
}
```

#|
||Field | Description ||
|| folder_id | **string**

ID of the folder to create server in.

To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| name | **string**

Name of the server.
The name must be unique within the folder. ||
|| description | **string**

Description of the server. ||
|| hardware_pool_id | **string**

ID of the hardware pool that the server belongs to.

To get the hardware pool ID, use a [HardwarePoolService.List](/docs/baremetal/api-ref/grpc/HardwarePool/list#List) request. ||
|| configuration_id | **string**

ID of the configuration to use for the server.

To get the configuration ID, use a [ConfigurationService.List](/docs/baremetal/api-ref/grpc/Configuration/list#List) request. ||
|| rental_period_id | **string**

A period of time for which the server is rented. ||
|| network_interfaces[] | **[NetworkInterfaceSpec](#yandex.cloud.baremetal.v1alpha.NetworkInterfaceSpec)**

Network configuration for the server. Specifies how the network interface is configured
to interact with other servers on the internal network and on the internet.
Currently up to 2 network interfaces are supported: required private network interface and
optional public network interface. ||
|| os_settings_spec | **[OsSettingsSpec](#yandex.cloud.baremetal.v1alpha.OsSettingsSpec)**

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
|| private_subnet | **[PrivateSubnetNetworkInterface](#yandex.cloud.baremetal.v1alpha.PrivateSubnetNetworkInterface)**

Private subnet.

Includes only one of the fields `private_subnet`, `public_subnet`.

Subnet that the network interface belongs to. ||
|| public_subnet | **[PublicSubnetNetworkInterface](#yandex.cloud.baremetal.v1alpha.PublicSubnetNetworkInterface)**

Public subnet.

Includes only one of the fields `private_subnet`, `public_subnet`.

Subnet that the network interface belongs to. ||
|#

## PrivateSubnetNetworkInterface {#yandex.cloud.baremetal.v1alpha.PrivateSubnetNetworkInterface}

#|
||Field | Description ||
|| private_subnet_id | **string**

ID of the private subnet. ||
|#

## PublicSubnetNetworkInterface {#yandex.cloud.baremetal.v1alpha.PublicSubnetNetworkInterface}

#|
||Field | Description ||
|| public_subnet_id | **string**

ID of the public subnet.

A new ephemeral public subnet will be created if not specified. ||
|#

## OsSettingsSpec {#yandex.cloud.baremetal.v1alpha.OsSettingsSpec}

#|
||Field | Description ||
|| image_id | **string**

ID of the image that the server was created from. ||
|| storages[] | **[Storage](#yandex.cloud.baremetal.v1alpha.Storage)**

List of storages to be created on the server. If not specified, the default value based on the
selected configuration will be used as the field value. ||
|| ssh_public_key | **string**

Public SSH key for the server.

Includes only one of the fields `ssh_public_key`, `user_ssh_id`.

Root user SSH key. ||
|| user_ssh_id | **string**

ID of the user SSH key to use for the server.

To get the user SSH key ID, use a [yandex.cloud.organizationmanager.v1.UserSshKeyService.List](/docs/organization/api-ref/grpc/UserSshKey/list#List) request.

Includes only one of the fields `ssh_public_key`, `user_ssh_id`.

Root user SSH key. ||
|| password_plain_text | **string**

Raw password.

Includes only one of the fields `password_plain_text`, `password_lockbox_secret`.

Password for the server. ||
|| password_lockbox_secret | **[LockboxSecret](#yandex.cloud.baremetal.v1alpha.LockboxSecret)**

Reference to the Lockbox secret used to obtain the password.

Includes only one of the fields `password_plain_text`, `password_lockbox_secret`.

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
|| type | enum **StoragePartitionType**

Partition type.

- `STORAGE_PARTITION_TYPE_UNSPECIFIED`: Unspecified storage partition type.
- `EXT4`: ext4 file system partition type.
- `SWAP`: Swap partition type.
- `EXT3`: ext3 file system partition type.
- `XFS`: XFS file system partition type. ||
|| size_gib | **int64**

Size of the storage partition in gibibytes (2^30 bytes). ||
|| mount_point | **string**

Storage mount point. ||
|#

## Disk {#yandex.cloud.baremetal.v1alpha.Disk}

Disk.

#|
||Field | Description ||
|| id | **string**

ID of the disk. ||
|| type | enum **DiskDriveType**

Type of the disk drive.

- `DISK_DRIVE_TYPE_UNSPECIFIED`: Unspecified disk drive type.
- `HDD`: Hard disk drive (magnetic storage).
- `SSD`: Solid state drive with SATA/SAS interface.
- `NVME`: Solid state drive with NVMe interface. ||
|| size_gib | **int64**

Size of the disk in gibibytes (2^30 bytes). ||
|#

## Raid {#yandex.cloud.baremetal.v1alpha.Raid}

RAID storage.

#|
||Field | Description ||
|| type | enum **RaidType**

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
|| secret_id | **string**

Required field. The unique identifier for the lockbox secret that contains the user password. ||
|| version_id | **string**

The unique identifier for the lockbox version.
If omitted, the current version of the secret will be used. ||
|| key | **string**

Required field. The key used to access a specific secret entry. ||
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
    "server_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "cloud_id": "string",
    "folder_id": "string",
    "name": "string",
    "description": "string",
    "zone_id": "string",
    "hardware_pool_id": "string",
    "status": "Status",
    "os_settings": {
      "image_id": "string",
      "ssh_public_key": "string",
      "storages": [
        {
          "partitions": [
            {
              "type": "StoragePartitionType",
              "size_gib": "int64",
              "mount_point": "string"
            }
          ],
          // Includes only one of the fields `disk`, `raid`
          "disk": {
            "id": "string",
            "type": "DiskDriveType",
            "size_gib": "int64"
          },
          "raid": {
            "type": "RaidType",
            "disks": [
              {
                "id": "string",
                "type": "DiskDriveType",
                "size_gib": "int64"
              }
            ]
          }
          // end of the list of possible fields
        }
      ]
    },
    "network_interfaces": [
      {
        "id": "string",
        "mac_address": "string",
        "ip_address": "string",
        // Includes only one of the fields `private_subnet`, `public_subnet`
        "private_subnet": {
          "private_subnet_id": "string"
        },
        "public_subnet": {
          "public_subnet_id": "string"
        }
        // end of the list of possible fields
      }
    ],
    "configuration_id": "string",
    "disks": [
      {
        "id": "string",
        "type": "DiskDriveType",
        "size_gib": "int64"
      }
    ],
    "created_at": "google.protobuf.Timestamp",
    "labels": "map<string, string>"
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
|| metadata | **[CreateServerMetadata](#yandex.cloud.baremetal.v1alpha.CreateServerMetadata)**

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
|| server_id | **string**

ID of the server that is being created. ||
|#

## Server {#yandex.cloud.baremetal.v1alpha.Server}

A Server resource.

#|
||Field | Description ||
|| id | **string**

ID of the server. ||
|| cloud_id | **string**

ID of the cloud that the server belongs to. ||
|| folder_id | **string**

ID of the folder that the server belongs to. ||
|| name | **string**

Name of the server.
The name is unique within the folder. ||
|| description | **string**

Description of the server. ||
|| zone_id | **string**

ID of the availability zone where the server is resides. ||
|| hardware_pool_id | **string**

ID of the hardware pool that the server belongs to. ||
|| status | enum **Status**

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
|| os_settings | **[OsSettings](#yandex.cloud.baremetal.v1alpha.OsSettings)**

Operating system specific settings of the server. Optional, will be empty if the server is
provisioned without an operating system. ||
|| network_interfaces[] | **[NetworkInterface](#yandex.cloud.baremetal.v1alpha.NetworkInterface)**

Array of network interfaces that are attached to the instance. ||
|| configuration_id | **string**

ID of the configuration that was used to create the server. ||
|| disks[] | **[Disk](#yandex.cloud.baremetal.v1alpha.Disk2)**

Array of disks that are attached to the server. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|#

## OsSettings {#yandex.cloud.baremetal.v1alpha.OsSettings}

#|
||Field | Description ||
|| image_id | **string**

ID of the image that the server was created from. ||
|| ssh_public_key | **string**

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
|| type | enum **StoragePartitionType**

Partition type.

- `STORAGE_PARTITION_TYPE_UNSPECIFIED`: Unspecified storage partition type.
- `EXT4`: ext4 file system partition type.
- `SWAP`: Swap partition type.
- `EXT3`: ext3 file system partition type.
- `XFS`: XFS file system partition type. ||
|| size_gib | **int64**

Size of the storage partition in gibibytes (2^30 bytes). ||
|| mount_point | **string**

Storage mount point. ||
|#

## Disk {#yandex.cloud.baremetal.v1alpha.Disk2}

Disk.

#|
||Field | Description ||
|| id | **string**

ID of the disk. ||
|| type | enum **DiskDriveType**

Type of the disk drive.

- `DISK_DRIVE_TYPE_UNSPECIFIED`: Unspecified disk drive type.
- `HDD`: Hard disk drive (magnetic storage).
- `SSD`: Solid state drive with SATA/SAS interface.
- `NVME`: Solid state drive with NVMe interface. ||
|| size_gib | **int64**

Size of the disk in gibibytes (2^30 bytes). ||
|#

## Raid {#yandex.cloud.baremetal.v1alpha.Raid2}

RAID storage.

#|
||Field | Description ||
|| type | enum **RaidType**

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
|| mac_address | **string**

MAC address that is assigned to the network interface. ||
|| ip_address | **string**

IPv4 address that is assigned to the server for this network interface. ||
|| private_subnet | **[PrivateSubnetNetworkInterface](#yandex.cloud.baremetal.v1alpha.PrivateSubnetNetworkInterface2)**

Private subnet.

Includes only one of the fields `private_subnet`, `public_subnet`.

Subnet that the network interface belongs to. ||
|| public_subnet | **[PublicSubnetNetworkInterface](#yandex.cloud.baremetal.v1alpha.PublicSubnetNetworkInterface2)**

Public subnet.

Includes only one of the fields `private_subnet`, `public_subnet`.

Subnet that the network interface belongs to. ||
|#

## PrivateSubnetNetworkInterface {#yandex.cloud.baremetal.v1alpha.PrivateSubnetNetworkInterface2}

#|
||Field | Description ||
|| private_subnet_id | **string**

ID of the private subnet. ||
|#

## PublicSubnetNetworkInterface {#yandex.cloud.baremetal.v1alpha.PublicSubnetNetworkInterface2}

#|
||Field | Description ||
|| public_subnet_id | **string**

ID of the public subnet.

A new ephemeral public subnet will be created if not specified. ||
|#