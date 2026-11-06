---
editable: false
---

# BareMetal API, gRPC: ImageService.ListCompatibleImages

Lists images available for installation on the selected configuration.



## gRPC request

**rpc ListCompatibleImages ([ListCompatibleImagesRequest](#yandex.cloud.baremetal.v2.ListCompatibleImagesRequest)) returns ([ListCompatibleImagesResponse](#yandex.cloud.baremetal.v2.ListCompatibleImagesResponse))**

## ListCompatibleImagesRequest {#yandex.cloud.baremetal.v2.ListCompatibleImagesRequest}

```json
{
  "folder_id": "string",
  // Includes only one of the fields `stock_configuration_id`, `custom_configuration`
  "stock_configuration_id": "string",
  "custom_configuration": {
    "configuration_id": "string",
    "name": "string",
    "cpu": {
      "id": "string",
      "name": "string",
      "vendor": "string",
      "physical_cores": "int64",
      "frequency_mhz": "int64",
      "count": "int64",
      "threads": "int64"
    },
    "disk_drives": [
      {
        "type": "DiskDriveType",
        "count": "int64",
        "size_bytes": "int64"
      }
    ],
    "ram": {
      "id": "string",
      "size_bytes": "int64"
    },
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
        },
        "main_mode": "InterfaceMode"
      }
    ]
  },
  // end of the list of possible fields
  "image_folder_id": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. Folder of the server being configured. Used to check configuration access. ||
|| stock_configuration_id | **string**

ID of an existing stock configuration.

Includes only one of the fields `stock_configuration_id`, `custom_configuration`.

Exactly one configuration must be provided. ||
|| custom_configuration | **[UserConfiguration](#yandex.cloud.baremetal.v2.UserConfiguration)**

Complete custom configuration, in the same format as for server creation.
The configuration does not need to be saved first.

Includes only one of the fields `stock_configuration_id`, `custom_configuration`.

Exactly one configuration must be provided. ||
|| image_folder_id | **string**

Folder containing images. Defaults to "baremetal-standard-images". ||
|| page_size | **int64**

Maximum number of compatible images to return. Defaults to 20; maximum 1000.

Acceptable values are 0 to 1000, inclusive. ||
|| page_token | **string**

Token from the previous response. Keep the configuration and folders unchanged. ||
|#

## UserConfiguration {#yandex.cloud.baremetal.v2.UserConfiguration}

#|
||Field | Description ||
|| configuration_id | **string**

ID of the configuration. ||
|| name | **string**

Name of the configuration. ||
|| cpu | **[UserCPU](#yandex.cloud.baremetal.v2.UserCPU)**

CPU configuration. ||
|| disk_drives[] | **[DiskDriveConfiguration](#yandex.cloud.baremetal.v2.DiskDriveConfiguration)**

Array of disk drive configurations. ||
|| ram | **[UserRAM](#yandex.cloud.baremetal.v2.UserRAM)**

Random-access memory (RAM). ||
|| network_interfaces[] | **[ConfigurationNetworkInterface](#yandex.cloud.baremetal.v2.ConfigurationNetworkInterface)**

Network interfaces of the custom configuration. ||
|#

## UserCPU {#yandex.cloud.baremetal.v2.UserCPU}

CPU configuration.

#|
||Field | Description ||
|| id | **string**

ID of the CPU from configurator. ||
|| name | **string**

Name of the CPU. ||
|| vendor | **string**

Vendor of the CPU. ||
|| physical_cores | **int64**

Number of physical cores per CPU (socket). ||
|| frequency_mhz | **int64**

Frequency of the CPU in megahertz (MHz). ||
|| count | **int64**

Number of cpu. ||
|| threads | **int64**

Number of threads (logical cores) per CPU (socket). ||
|#

## DiskDriveConfiguration {#yandex.cloud.baremetal.v2.DiskDriveConfiguration}

#|
||Field | Description ||
|| type | enum **DiskDriveType**

Type of the disk drive.

- `HDD`: Hard disk drive.
- `SSD`: Solid state drive.
- `NVME`: NVMe Solid state drive. ||
|| count | **int64**

Number of disk drives. ||
|| size_bytes | **int64**

Size of a single disk drive. ||
|#

## UserRAM {#yandex.cloud.baremetal.v2.UserRAM}

#|
||Field | Description ||
|| id | **string**

ID of the RAM from configurator. ||
|| size_bytes | **int64**

Ram size. ||
|#

## ConfigurationNetworkInterface {#yandex.cloud.baremetal.v2.ConfigurationNetworkInterface}

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
|| mc_lag_options | **[MCLagAggregationOptions](#yandex.cloud.baremetal.v2.ConfigurationNetworkInterface.MCLagAggregationOptions)**

MC-LAG configuration options for aggregated interfaces ||
|| main_mode | enum **InterfaceMode**

Primary mode of the network interface.

- `PRIVATE`: Private network interface mode.
- `PUBLIC`: Public network interface mode. ||
|#

## MCLagAggregationOptions {#yandex.cloud.baremetal.v2.ConfigurationNetworkInterface.MCLagAggregationOptions}

MC-LAG aggregation options for the network interface.

#|
||Field | Description ||
|| interface_count | **int64**

Number of interfaces in the MC-LAG aggregation. ||
|#

## ListCompatibleImagesResponse {#yandex.cloud.baremetal.v2.ListCompatibleImagesResponse}

```json
{
  "images": [
    {
      "image_id": "string",
      "folder_id": "string",
      "name": "string",
      "family": "string",
      "state": "Status",
      "publish_time": "google.protobuf.Timestamp",
      "cloud_id": "string"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| images[] | **[Image](#yandex.cloud.baremetal.v2.Image)**

Available compatible images ordered by image ID ascending.
Empty when installation is forbidden for the configuration or no image matches.
Compatibility is checked again when the server is created or reinstalled. ||
|| next_page_token | **string**

Token for the next page; empty when there are no more compatible images. ||
|#

## Image {#yandex.cloud.baremetal.v2.Image}

An Image resource.

#|
||Field | Description ||
|| image_id | **string**

ID of the image. ||
|| folder_id | **string**

ID of the folder that the image belongs to. ||
|| name | **string**

Name of the image ||
|| family | **string**

Family of the image ||
|| state | enum **Status**

State of the image.

- `IMPORTING`: Image is being imported.
- `IMPORTED`: Image has been imported and is awaiting moderation.
- `PUBLISHED`: Image is published and available to users.
- `DISABLED`: Image is disabled for new installations but preserved for existing servers.
- `ERROR`: Image encountered an error during import. ||
|| publish_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp when the image was published. ||
|| cloud_id | **string**

ID of the cloud that the image belongs to. ||
|#