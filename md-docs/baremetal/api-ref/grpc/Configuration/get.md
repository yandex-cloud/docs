[Документация Yandex Cloud](../../../../index.md) > [Yandex BareMetal](../../../index.md) > Концепции > Настройка и управление > Справочник API > [gRPC (англ.)](../index.md) > [Configuration](index.md) > Get

# BareMetal API, gRPC: ConfigurationService.Get

Returns the specific Configuration resource.
To get the list of available Configuration resources, make a [List](list.md#List) request.

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
To get the configuration ID, use a [ConfigurationService.List](list.md#List) request.

Value must match the regular expression ` [a-z][a-z0-9]* `. ||
|| folder_id | **string**

ID of the folder to return a Configuration resource for.
To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](../../../../resource-manager/api-ref/grpc/Folder/list.md#List) request.

The maximum string length in characters is 50. Value must match the regular expression ``` ([a-z][a-z0-9.-]*)| ```. ||
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
    "cores": "int64",
    "physical_cores": "int64",
    "frequency_mhz": "int64",
    "threads": "int64"
  },
  "disk_drives": [
    {
      "type": "DiskDriveType",
      "disk_count": "int64",
      "disk_size_gib": "int64"
    }
  ],
  "network_capacity_gbps": "int64",
  "cpu_num": "int64",
  "network_interfaces": [
    {
      "id": "string",
      "name": "string",
      "configuration_id": "string",
      "link_speed_gbps": "int64",
      "available_modes": [
        "InterfaceMode"
      ],
      "mc_lag_options": {
        "interface_count": "int64"
      }
    }
  ],
  "mounting_availability": "MountingAvailability"
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
|| network_interfaces[] | **[ConfigurationNetworkInterface](#yandex.cloud.baremetal.v1alpha.ConfigurationNetworkInterface)**

Network interfaces of the configuration. ||
|| mounting_availability | enum **MountingAvailability**

Indicates whether the mounting option is available or not for this configuration.

- `AVAILABLE`: Mounting is available.
- `UNAVAILABLE`: Mounting is unavailable. ||
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

@deprecated. Number of cores. ||
|| physical_cores | **int64**

Number of physical cores per CPU (socket). ||
|| frequency_mhz | **int64**

Frequency of the CPU in megahertz (MHz).

Value must be greater than 0. ||
|| threads | **int64**

Number of threads (logical cores) per CPU (socket). ||
|#

## DiskDriveConfiguration {#yandex.cloud.baremetal.v1alpha.DiskDriveConfiguration}

#|
||Field | Description ||
|| type | enum **DiskDriveType**

Type of the disk drive.

- `HDD`: Hard disk drive (magnetic storage).
- `SSD`: Solid state drive with SATA/SAS interface.
- `NVME`: Solid state drive with NVMe interface. ||
|| disk_count | **int64**

Number of disk drives. ||
|| disk_size_gib | **int64**

Size of a single disk drive in gibibytes (2^30 bytes). ||
|#

## ConfigurationNetworkInterface {#yandex.cloud.baremetal.v1alpha.ConfigurationNetworkInterface}

#|
||Field | Description ||
|| id | **string**

Id of the network interface
Not used while creating interfaces ||
|| name | **string**

Name of the network interface ||
|| configuration_id | **string**

Id of the configuration ||
|| link_speed_gbps | **int64**

Link speed in gigabits per second ||
|| available_modes[] | enum **InterfaceMode**

Available modes for the network interface

- `PRIVATE`: Private network interface mode.
- `PUBLIC`: Public network interface mode. ||
|| mc_lag_options | **[MCLagAggregationOptions](#yandex.cloud.baremetal.v1alpha.ConfigurationNetworkInterface.MCLagAggregationOptions)**

MC-LAG configuration options for aggregated interfaces ||
|#

## MCLagAggregationOptions {#yandex.cloud.baremetal.v1alpha.ConfigurationNetworkInterface.MCLagAggregationOptions}

MC-LAG aggregation options for the network interface.

#|
||Field | Description ||
|| interface_count | **int64**

Number of interfaces in the MC-LAG aggregation. ||
|#