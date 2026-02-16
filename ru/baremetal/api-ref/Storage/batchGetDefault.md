---
editable: false
apiPlayground:
  - url: https://baremetal.{{ api-host }}/baremetal/v1alpha/storages/default:batchGet
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        configurationIds:
          description: |-
            **string**
            List of configuration IDs.
          pattern: '[a-z][a-z0-9]*'
          uniqueItems: true
          type: array
          items:
            type: string
      additionalProperties: false
    definitions: null
sourcePath: en/_api-ref/baremetal/v1alpha/api-ref/Storage/batchGetDefault.md
---

# BareMetal API, REST: Storage.BatchGetDefault

Returns the default storages for the specified configurations.

## HTTP request

```
POST https://baremetal.{{ api-host }}/baremetal/v1alpha/storages/default:batchGet
```

## Body parameters {#yandex.cloud.baremetal.v1alpha.BatchGetDefaultStoragesRequest}

```json
{
  "configurationIds": [
    "string"
  ]
}
```

#|
||Field | Description ||
|| configurationIds[] | **string**

List of configuration IDs. ||
|#

## Response {#yandex.cloud.baremetal.v1alpha.BatchGetDefaultStoragesResponse}

**HTTP Code: 200 - OK**

```json
{
  "defaultStorages": [
    {
      "configurationId": "string",
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
    }
  ]
}
```

#|
||Field | Description ||
|| defaultStorages[] | **[DefaultStorage](#yandex.cloud.baremetal.v1alpha.DefaultStorage)**

List of default storages. ||
|#

## DefaultStorage {#yandex.cloud.baremetal.v1alpha.DefaultStorage}

#|
||Field | Description ||
|| configurationId | **string**

ID of the configuration.

To get the configuration ID, use a [ConfigurationService.List](/docs/baremetal/api-ref/Configuration/list#List) request. ||
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