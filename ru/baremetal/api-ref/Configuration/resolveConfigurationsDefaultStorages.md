---
editable: false
apiPlayground:
  - url: https://baremetal.{{ api-host }}/baremetal/v2/configurations:resolveDefaultStorages
    method: get
    path: null
    query:
      type: object
      properties:
        configurationIds:
          description: |-
            **string**
            List of configuration IDs.
            Each value must match the regular expression ` [a-z][a-z0-9]* `. The number of elements must be in the range 1-100.
          pattern: '[a-z][a-z0-9]*'
          uniqueItems: true
          type: array
          items:
            type: string
      additionalProperties: false
    body: null
    definitions: null
---

# BareMetal API, REST: Configuration.ResolveConfigurationsDefaultStorages

Returns the default storages for the specified configurations.

https://google.aip.dev/130 --)

https://google.aip.dev/130 --)

https://google.aip.dev/130 --)

## HTTP request

```
GET https://baremetal.{{ api-host }}/baremetal/v2/configurations:resolveDefaultStorages
```

## Query parameters {#yandex.cloud.baremetal.v2.ResolveConfigurationsDefaultStoragesRequest}

#|
||Field | Description ||
|| configurationIds[] | **string**

List of configuration IDs.

Each value must match the regular expression ` [a-z][a-z0-9]* `. The number of elements must be in the range 1-100. ||
|#

## Response {#yandex.cloud.baremetal.v2.ResolveConfigurationsDefaultStoragesResponse}

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
  ]
}
```

#|
||Field | Description ||
|| defaultStorages[] | **[DefaultStorage](#yandex.cloud.baremetal.v2.DefaultStorage)**

List of default storages. ||
|#

## DefaultStorage {#yandex.cloud.baremetal.v2.DefaultStorage}

#|
||Field | Description ||
|| configurationId | **string**

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