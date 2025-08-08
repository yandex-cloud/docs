---
editable: false
sourcePath: en/_api-ref-grpc/baremetal/v1alpha/api-ref/grpc/Configuration/get.md
---

# BareMetal API, gRPC: ConfigurationService.Get

Returns the specific Configuration resource.

To get the list of available Configuration resources, make a [List](/docs/baremetal/api-ref/grpc/Configuration/list#List) request.

## gRPC request

**rpc Get ([GetConfigurationRequest](#yandex.cloud.baremetal.v1alpha.GetConfigurationRequest)) returns ([Configuration](#yandex.cloud.baremetal.v1alpha.Configuration))**

## GetConfigurationRequest {#yandex.cloud.baremetal.v1alpha.GetConfigurationRequest}

```json
{
  "configuration_id": "string",
  "folder_id": "string"
}
```

#|
||Field | Description ||
|| configuration_id | **string**

ID of the Configuration resource to return.

To get the configuration ID, use a [ConfigurationService.List](/docs/baremetal/api-ref/grpc/Configuration/list#List) request. ||
|| folder_id | **string**

ID of the folder to return a Configuration resource for.

To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|#

## Configuration {#yandex.cloud.baremetal.v1alpha.Configuration}

```json
{
  "id": "string",
  "name": "string",
  "memory_gib": "int64",
  "cpu": {
    "name": "string",
    "vendor": "string",
    "cores": "int64"
  },
  "disk_drives": [
    {
      "type": "DiskDriveType",
      "disk_count": "int64",
      "disk_size_gib": "int64"
    }
  ],
  "network_capacity_gbps": "int64",
  "cpu_num": "int64"
}
```

#|
||Field | Description ||
|| id | **string**

ID of the configuration. ||
|| name | **string**

Name of the configuration. ||
|| memory_gib | **int64**

Random-access memory (RAM) size in gibibytes (2^30 bytes). ||
|| cpu | **[CPU](#yandex.cloud.baremetal.v1alpha.CPU)**

CPU configuration. ||
|| disk_drives[] | **[DiskDriveConfiguration](#yandex.cloud.baremetal.v1alpha.DiskDriveConfiguration)**

Array of disk drive configurations. ||
|| network_capacity_gbps | **int64**

Network capacity or bandwidth in gigabits per second. ||
|| cpu_num | **int64**

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
|| cores | **int64**

Number of cores. ||
|#

## DiskDriveConfiguration {#yandex.cloud.baremetal.v1alpha.DiskDriveConfiguration}

#|
||Field | Description ||
|| type | enum **DiskDriveType**

Type of the disk drive.

- `DISK_DRIVE_TYPE_UNSPECIFIED`: Unspecified disk drive type.
- `HDD`: Hard disk drive (magnetic storage).
- `SSD`: Solid state drive with SATA/SAS interface.
- `NVME`: Solid state drive with NVMe interface. ||
|| disk_count | **int64**

Number of disk drives. ||
|| disk_size_gib | **int64**

Size of a single disk drive in gibibytes (2^30 bytes). ||
|#