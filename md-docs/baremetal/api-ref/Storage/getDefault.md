# BareMetal API, REST: Storage.GetDefault

Returns the default storage for the specified configuration.

## HTTP request

```
GET https://baremetal.api.cloud.yandex.net/baremetal/v1alpha/storages/default/{configurationId}
```

## Path parameters

#|
||Field | Description ||
|| configurationId | **string**

Required field. ID of the configuration.

Value must match the regular expression ` [a-z][a-z0-9]* `. ||
|#

## Response {#yandex.cloud.baremetal.v1alpha.DefaultStorage}

**HTTP Code: 200 - OK**

```json
{
  "configurationId": "string",
  "storages": [
    {
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
      },
      // end of the list of possible fields
      "partitions": [
        {
          "type": "string",
          "sizeGib": "string",
          "mountPoint": "string"
        }
      ]
    }
  ]
}
```

#|
||Field | Description ||
|| configurationId | **string**

ID of the configuration.
To get the configuration ID, use a [ConfigurationService.List](../Configuration/list.md#List) request. ||
|| storages[] | **[Storage](#yandex.cloud.baremetal.v1alpha.Storage)**

List of default storages. ||
|#

## Storage {#yandex.cloud.baremetal.v1alpha.Storage}

Storage, a OS-level storage entity used for creating partitions. For example, this could
represent a plain disk or a software RAID of disks.

#|
||Field | Description ||
|| disk | **[Disk](#yandex.cloud.baremetal.v1alpha.Disk)**

Disk storage.

Includes only one of the fields `disk`, `raid`.

Storage type. ||
|| raid | **[Raid](#yandex.cloud.baremetal.v1alpha.Raid)**

RAID storage.

Includes only one of the fields `disk`, `raid`.

Storage type. ||
|| partitions[] | **[StoragePartition](#yandex.cloud.baremetal.v1alpha.StoragePartition)**

Array of partitions created on the storage. ||
|#

## Disk {#yandex.cloud.baremetal.v1alpha.Disk}

Disk.

#|
||Field | Description ||
|| id | **string**

ID of the disk. ||
|| type | **enum** (DiskDriveType)

Type of the disk drive.

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

- `RAID0`: RAID0 configuration.
- `RAID1`: RAID1 configuration.
- `RAID10`: RAID10 configuration. ||
|| disks[] | **[Disk](#yandex.cloud.baremetal.v1alpha.Disk)**

Array of disks in the RAID configuration. ||
|#

## StoragePartition {#yandex.cloud.baremetal.v1alpha.StoragePartition}

#|
||Field | Description ||
|| type | **enum** (StoragePartitionType)

Partition type.

- `EXT4`: ext4 file system partition type.
- `SWAP`: Swap partition type.
- `EXT3`: ext3 file system partition type.
- `XFS`: XFS file system partition type. ||
|| sizeGib | **string** (int64)

Size of the storage partition in gibibytes (2^30 bytes). ||
|| mountPoint | **string**

Storage mount point. ||
|#