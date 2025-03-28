---
editable: false
sourcePath: en/_api-ref-grpc/baremetal/v1alpha/api-ref/grpc/Storage/batchGetDefault.md
---

# BareMetal API, gRPC: StorageService.BatchGetDefault

Returns the default storages for the specified configurations.

## gRPC request

**rpc BatchGetDefault ([BatchGetDefaultStoragesRequest](#yandex.cloud.baremetal.v1alpha.BatchGetDefaultStoragesRequest)) returns ([BatchGetDefaultStoragesResponse](#yandex.cloud.baremetal.v1alpha.BatchGetDefaultStoragesResponse))**

## BatchGetDefaultStoragesRequest {#yandex.cloud.baremetal.v1alpha.BatchGetDefaultStoragesRequest}

```json
{
  "configuration_ids": [
    "string"
  ]
}
```

#|
||Field | Description ||
|| configuration_ids[] | **string**

List of configuration IDs. ||
|#

## BatchGetDefaultStoragesResponse {#yandex.cloud.baremetal.v1alpha.BatchGetDefaultStoragesResponse}

```json
{
  "default_storages": [
    {
      "configuration_id": "string",
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
    }
  ]
}
```

#|
||Field | Description ||
|| default_storages[] | **[DefaultStorage](#yandex.cloud.baremetal.v1alpha.DefaultStorage)**

List of default storages. ||
|#

## DefaultStorage {#yandex.cloud.baremetal.v1alpha.DefaultStorage}

#|
||Field | Description ||
|| configuration_id | **string**

ID of the configuration.

To get the configuration ID, use a [ConfigurationService.List](/docs/baremetal/api-ref/grpc/Configuration/list#List) request. ||
|| storages[] | **[Storage](#yandex.cloud.baremetal.v1alpha.Storage)**

List of default storages. ||
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