---
editable: false
---

# BareMetal API, gRPC: ConfigurationService.ResolveConfigurationDefaultStorage

Returns the default storage for the specified configuration.



## gRPC request

**rpc ResolveConfigurationDefaultStorage ([ResolveConfigurationDefaultStorageRequest](#yandex.cloud.baremetal.v2.ResolveConfigurationDefaultStorageRequest)) returns ([DefaultStorage](#yandex.cloud.baremetal.v2.DefaultStorage))**

## ResolveConfigurationDefaultStorageRequest {#yandex.cloud.baremetal.v2.ResolveConfigurationDefaultStorageRequest}

```json
{
  "configuration_id": "string"
}
```

#|
||Field | Description ||
|| configuration_id | **string**

ID of the configuration.

Value must match the regular expression ` [a-z][a-z0-9]* `. ||
|#

## DefaultStorage {#yandex.cloud.baremetal.v2.DefaultStorage}

```json
{
  "configuration_id": "string",
  "storages": [
    {
      "partitions": [
        {
          "type": "StoragePartitionType",
          "size_bytes": "int64",
          "mount_point": "string"
        }
      ],
      // Includes only one of the fields `disk`, `raid`
      "disk": {
        "id": "string",
        "type": "DiskDriveType",
        "size_bytes": "int64"
      },
      "raid": {
        "type": "RaidType",
        "disks": [
          {
            "id": "string",
            "type": "DiskDriveType",
            "size_bytes": "int64"
          }
        ]
      }
      // end of the list of possible fields
    }
  ]
}
```

#|
||Field | Description ||
|| configuration_id | **string**

ID of the configuration.
To get the configuration ID, use a [ConfigurationService.List] request. ||
|| storages[] | **[Storage](#yandex.cloud.baremetal.v2.Storage)**

List of default storages. ||
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
|| type | enum **StoragePartitionType**

Partition type.

- `EXT4`: ext4 file system partition type.
- `SWAP`: Swap partition type.
- `EXT3`: ext3 file system partition type.
- `XFS`: XFS file system partition type. ||
|| size_bytes | **int64**

Size of the storage partition. ||
|| mount_point | **string**

Storage mount point. ||
|#

## Disk {#yandex.cloud.baremetal.v2.Disk}

Disk.

#|
||Field | Description ||
|| id | **string**

ID of the disk. ||
|| type | enum **DiskDriveType**

Type of the disk drive.

- `HDD`: Hard disk drive.
- `SSD`: Solid state drive.
- `NVME`: NVMe Solid state drive. ||
|| size_bytes | **int64**

Size of the disk. ||
|#

## Raid {#yandex.cloud.baremetal.v2.Raid}

RAID storage.

#|
||Field | Description ||
|| type | enum **RaidType**

RAID type.

- `RAID0`: RAID0 configuration.
- `RAID1`: RAID1 configuration.
- `RAID10`: RAID10 configuration. ||
|| disks[] | **[Disk](#yandex.cloud.baremetal.v2.Disk)**

Array of disks in the RAID configuration. ||
|#