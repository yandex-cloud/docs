---
editable: false
apiPlayground:
  - url: https://baremetal.{{ api-host }}/baremetal/v1alpha/configurations/{configurationId}
    method: get
    path:
      type: object
      properties:
        configurationId:
          description: |-
            **string**
            ID of the Configuration resource to return.
            To get the configuration ID, use a [ConfigurationService.List](/docs/baremetal/api-ref/Configuration/list#List) request.
          pattern: '[a-z][a-z0-9]*'
          type: string
      additionalProperties: false
    query:
      type: object
      properties:
        folderId:
          description: |-
            **string**
            ID of the folder to return a Configuration resource for.
            To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request.
          pattern: '[a-z][a-z0-9.-]*'
          type: string
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/baremetal/v1alpha/api-ref/Configuration/get.md
---

# BareMetal API, REST: Configuration.Get

Returns the specific Configuration resource.

To get the list of available Configuration resources, make a [List](/docs/baremetal/api-ref/Configuration/list#List) request.

## HTTP request

```
GET https://baremetal.{{ api-host }}/baremetal/v1alpha/configurations/{configurationId}
```

## Path parameters

#|
||Field | Description ||
|| configurationId | **string**

Required field. ID of the Configuration resource to return.

To get the configuration ID, use a [ConfigurationService.List](/docs/baremetal/api-ref/Configuration/list#List) request. ||
|#

## Query parameters {#yandex.cloud.baremetal.v1alpha.GetConfigurationRequest}

#|
||Field | Description ||
|| folderId | **string**

ID of the folder to return a Configuration resource for.

To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request. ||
|#

## Response {#yandex.cloud.baremetal.v1alpha.Configuration}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "name": "string",
  "memoryGib": "string",
  "cpu": {
    "name": "string",
    "vendor": "string",
    "cores": "string"
  },
  "diskDrives": [
    {
      "type": "string",
      "diskCount": "string",
      "diskSizeGib": "string"
    }
  ],
  "networkCapacityGbps": "string",
  "cpuNum": "string"
}
```

#|
||Field | Description ||
|| id | **string**

ID of the configuration. ||
|| name | **string**

Name of the configuration. ||
|| memoryGib | **string** (int64)

Random-access memory (RAM) size in gibibytes (2^30 bytes). ||
|| cpu | **[CPU](#yandex.cloud.baremetal.v1alpha.CPU)**

CPU configuration. ||
|| diskDrives[] | **[DiskDriveConfiguration](#yandex.cloud.baremetal.v1alpha.DiskDriveConfiguration)**

Array of disk drive configurations. ||
|| networkCapacityGbps | **string** (int64)

Network capacity or bandwidth in gigabits per second. ||
|| cpuNum | **string** (int64)

Number of cpu. ||
|#

## CPU {#yandex.cloud.baremetal.v1alpha.CPU}

CPU configuration.

#|
||Field | Description ||
|| name | **string**

Name of the CPU. ||
|| vendor | **string**

Vendor of the CPU. ||
|| cores | **string** (int64)

Number of cores. ||
|#

## DiskDriveConfiguration {#yandex.cloud.baremetal.v1alpha.DiskDriveConfiguration}

#|
||Field | Description ||
|| type | **enum** (DiskDriveType)

Type of the disk drive.

- `DISK_DRIVE_TYPE_UNSPECIFIED`: Unspecified disk drive type.
- `HDD`: Hard disk drive (magnetic storage).
- `SSD`: Solid state drive with SATA/SAS interface.
- `NVME`: Solid state drive with NVMe interface. ||
|| diskCount | **string** (int64)

Number of disk drives. ||
|| diskSizeGib | **string** (int64)

Size of a single disk drive in gibibytes (2^30 bytes). ||
|#