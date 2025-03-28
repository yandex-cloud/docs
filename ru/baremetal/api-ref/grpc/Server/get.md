---
editable: false
sourcePath: en/_api-ref-grpc/baremetal/v1alpha/api-ref/grpc/Server/get.md
---

# BareMetal API, gRPC: ServerService.Get

Returns the specific Server resource.

To get the list of available Server resources, make a [List](/docs/baremetal/api-ref/grpc/Server/list#List) request.

## gRPC request

**rpc Get ([GetServerRequest](#yandex.cloud.baremetal.v1alpha.GetServerRequest)) returns ([Server](#yandex.cloud.baremetal.v1alpha.Server))**

## GetServerRequest {#yandex.cloud.baremetal.v1alpha.GetServerRequest}

```json
{
  "server_id": "string"
}
```

#|
||Field | Description ||
|| server_id | **string**

ID of the Server resource to return.

To get the server ID, use a [ServerService.List](/docs/baremetal/api-ref/grpc/Server/list#List) request. ||
|#

## Server {#yandex.cloud.baremetal.v1alpha.Server}

```json
{
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
```

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
|| disks[] | **[Disk](#yandex.cloud.baremetal.v1alpha.Disk)**

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
|| storages[] | **[Storage](#yandex.cloud.baremetal.v1alpha.Storage)**

List of storages. ||
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
- `HDD`: Hard disk drive.
- `SSD`: Solid state drive. ||
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

## NetworkInterface {#yandex.cloud.baremetal.v1alpha.NetworkInterface}

#|
||Field | Description ||
|| id | **string**

ID of the network interface. ||
|| mac_address | **string**

MAC address that is assigned to the network interface. ||
|| ip_address | **string**

IPv4 address that is assigned to the server for this network interface. ||
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