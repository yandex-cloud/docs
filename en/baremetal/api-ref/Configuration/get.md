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
            Value must match the regular expression ` [a-z][a-z0-9]* `.
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
            The maximum string length in characters is 50. Value must match the regular expression ` ([a-z][a-z0-9.-]*)| `.
          pattern: ([a-z][a-z0-9.-]*)|
          type: string
      additionalProperties: false
    body: null
    definitions: null
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
To get the configuration ID, use a [ConfigurationService.List](/docs/baremetal/api-ref/Configuration/list#List) request.

Value must match the regular expression ` [a-z][a-z0-9]* `. ||
|#

## Query parameters {#yandex.cloud.baremetal.v1alpha.GetConfigurationRequest}

#|
||Field | Description ||
|| folderId | **string**

ID of the folder to return a Configuration resource for.
To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request.

The maximum string length in characters is 50. Value must match the regular expression ``` ([a-z][a-z0-9.-]*)| ```. ||
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
    "cores": "string",
    "physicalCores": "string",
    "frequencyMhz": "string",
    "threads": "string"
  },
  "diskDrives": [
    {
      "type": "string",
      "diskCount": "string",
      "diskSizeGib": "string"
    }
  ],
  "networkCapacityGbps": "string",
  "cpuNum": "string",
  "networkInterfaces": [
    {
      "id": "string",
      "name": "string",
      "configurationId": "string",
      "linkSpeedGbps": "string",
      "availableModes": [
        "string"
      ],
      "mcLagOptions": {
        "interfaceCount": "string"
      }
    }
  ],
  "mountingAvailability": "string"
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
|| networkInterfaces[] | **[ConfigurationNetworkInterface](#yandex.cloud.baremetal.v1alpha.ConfigurationNetworkInterface)**

Network interfaces of the configuration. ||
|| mountingAvailability | **enum** (MountingAvailability)

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
|| cores | **string** (int64)

@deprecated. Number of cores. ||
|| physicalCores | **string** (int64)

Number of physical cores per CPU (socket). ||
|| frequencyMhz | **string** (int64)

Frequency of the CPU in megahertz (MHz).

Value must be greater than 0. ||
|| threads | **string** (int64)

Number of threads (logical cores) per CPU (socket). ||
|#

## DiskDriveConfiguration {#yandex.cloud.baremetal.v1alpha.DiskDriveConfiguration}

#|
||Field | Description ||
|| type | **enum** (DiskDriveType)

Type of the disk drive.

- `HDD`: Hard disk drive (magnetic storage).
- `SSD`: Solid state drive with SATA/SAS interface.
- `NVME`: Solid state drive with NVMe interface. ||
|| diskCount | **string** (int64)

Number of disk drives. ||
|| diskSizeGib | **string** (int64)

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
|| configurationId | **string**

Id of the configuration ||
|| linkSpeedGbps | **string** (int64)

Link speed in gigabits per second ||
|| availableModes[] | **enum** (InterfaceMode)

Available modes for the network interface

- `PRIVATE`: Private network interface mode.
- `PUBLIC`: Public network interface mode. ||
|| mcLagOptions | **[MCLagAggregationOptions](#yandex.cloud.baremetal.v1alpha.ConfigurationNetworkInterface.MCLagAggregationOptions)**

MC-LAG configuration options for aggregated interfaces ||
|#

## MCLagAggregationOptions {#yandex.cloud.baremetal.v1alpha.ConfigurationNetworkInterface.MCLagAggregationOptions}

MC-LAG aggregation options for the network interface.

#|
||Field | Description ||
|| interfaceCount | **string** (int64)

Number of interfaces in the MC-LAG aggregation. ||
|#