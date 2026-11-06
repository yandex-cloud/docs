[Документация Yandex Cloud](../../../index.md) > [Yandex BareMetal](../../index.md) > Концепции > Настройка и управление > Справочник API > API v2 > [REST (англ.)](../index.md) > [Image](index.md) > ListCompatibleImages

# BareMetal API, REST: Image.ListCompatibleImages

Lists images available for installation on the selected configuration.



## HTTP request

```
POST https://baremetal.api.cloud.yandex.net/baremetal/v2/folders/{folderId}/images:listCompatible
```

## Path parameters

#|
||Field | Description ||
|| folderId | **string**

Required field. Folder of the server being configured. Used to check configuration access. ||
|#

## Body parameters {#yandex.cloud.baremetal.v2.ListCompatibleImagesRequest}

```json
{
  // Includes only one of the fields `stockConfigurationId`, `customConfiguration`
  "stockConfigurationId": "string",
  "customConfiguration": {
    "configurationId": "string",
    "name": "string",
    "cpu": {
      "id": "string",
      "name": "string",
      "vendor": "string",
      "physicalCores": "string",
      "frequencyMhz": "string",
      "count": "string",
      "threads": "string"
    },
    "diskDrives": [
      {
        "type": "string",
        "count": "string",
        "sizeBytes": "string"
      }
    ],
    "ram": {
      "id": "string",
      "sizeBytes": "string"
    },
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
        },
        "mainMode": "string"
      }
    ]
  },
  // end of the list of possible fields
  "imageFolderId": "string",
  "pageSize": "string",
  "pageToken": "string"
}
```

#|
||Field | Description ||
|| stockConfigurationId | **string**

ID of an existing stock configuration.

Includes only one of the fields `stockConfigurationId`, `customConfiguration`.

Exactly one configuration must be provided. ||
|| customConfiguration | **[UserConfiguration](#yandex.cloud.baremetal.v2.UserConfiguration)**

Complete custom configuration, in the same format as for server creation.
The configuration does not need to be saved first.

Includes only one of the fields `stockConfigurationId`, `customConfiguration`.

Exactly one configuration must be provided. ||
|| imageFolderId | **string**

Folder containing images. Defaults to "baremetal-standard-images". ||
|| pageSize | **string** (int64)

Maximum number of compatible images to return. Defaults to 20; maximum 1000.

Acceptable values are 0 to 1000, inclusive. ||
|| pageToken | **string**

Token from the previous response. Keep the configuration and folders unchanged. ||
|#

## UserConfiguration {#yandex.cloud.baremetal.v2.UserConfiguration}

#|
||Field | Description ||
|| configurationId | **string**

ID of the configuration. ||
|| name | **string**

Name of the configuration. ||
|| cpu | **[UserCPU](#yandex.cloud.baremetal.v2.UserCPU)**

CPU configuration. ||
|| diskDrives[] | **[DiskDriveConfiguration](#yandex.cloud.baremetal.v2.DiskDriveConfiguration)**

Array of disk drive configurations. ||
|| ram | **[UserRAM](#yandex.cloud.baremetal.v2.UserRAM)**

Random-access memory (RAM). ||
|| networkInterfaces[] | **[ConfigurationNetworkInterface](#yandex.cloud.baremetal.v2.ConfigurationNetworkInterface)**

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
|| physicalCores | **string** (int64)

Number of physical cores per CPU (socket). ||
|| frequencyMhz | **string** (int64)

Frequency of the CPU in megahertz (MHz). ||
|| count | **string** (int64)

Number of cpu. ||
|| threads | **string** (int64)

Number of threads (logical cores) per CPU (socket). ||
|#

## DiskDriveConfiguration {#yandex.cloud.baremetal.v2.DiskDriveConfiguration}

#|
||Field | Description ||
|| type | **enum** (DiskDriveType)

Type of the disk drive.

- `HDD`: Hard disk drive.
- `SSD`: Solid state drive.
- `NVME`: NVMe Solid state drive. ||
|| count | **string** (int64)

Number of disk drives. ||
|| sizeBytes | **string** (int64)

Size of a single disk drive. ||
|#

## UserRAM {#yandex.cloud.baremetal.v2.UserRAM}

#|
||Field | Description ||
|| id | **string**

ID of the RAM from configurator. ||
|| sizeBytes | **string** (int64)

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
|| configurationId | **string**

Id of the configuration ||
|| linkSpeedGbps | **string** (int64)

Link speed in gigabits per second ||
|| availableModes[] | **enum** (InterfaceMode)

Available modes for the network interface

- `PRIVATE`: Private network interface mode.
- `PUBLIC`: Public network interface mode. ||
|| mcLagOptions | **[MCLagAggregationOptions](#yandex.cloud.baremetal.v2.ConfigurationNetworkInterface.MCLagAggregationOptions)**

MC-LAG configuration options for aggregated interfaces ||
|| mainMode | **enum** (InterfaceMode)

Primary mode of the network interface.

- `PRIVATE`: Private network interface mode.
- `PUBLIC`: Public network interface mode. ||
|#

## MCLagAggregationOptions {#yandex.cloud.baremetal.v2.ConfigurationNetworkInterface.MCLagAggregationOptions}

MC-LAG aggregation options for the network interface.

#|
||Field | Description ||
|| interfaceCount | **string** (int64)

Number of interfaces in the MC-LAG aggregation. ||
|#

## Response {#yandex.cloud.baremetal.v2.ListCompatibleImagesResponse}

**HTTP Code: 200 - OK**

```json
{
  "images": [
    {
      "imageId": "string",
      "folderId": "string",
      "name": "string",
      "family": "string",
      "state": "string",
      "publishTime": "string",
      "cloudId": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| images[] | **[Image](#yandex.cloud.baremetal.v2.Image)**

Available compatible images ordered by image ID ascending.
Empty when installation is forbidden for the configuration or no image matches.
Compatibility is checked again when the server is created or reinstalled. ||
|| nextPageToken | **string**

Token for the next page; empty when there are no more compatible images. ||
|#

## Image {#yandex.cloud.baremetal.v2.Image}

An Image resource.

#|
||Field | Description ||
|| imageId | **string**

ID of the image. ||
|| folderId | **string**

ID of the folder that the image belongs to. ||
|| name | **string**

Name of the image ||
|| family | **string**

Family of the image ||
|| state | **enum** (Status)

State of the image.

- `IMPORTING`: Image is being imported.
- `IMPORTED`: Image has been imported and is awaiting moderation.
- `PUBLISHED`: Image is published and available to users.
- `DISABLED`: Image is disabled for new installations but preserved for existing servers.
- `ERROR`: Image encountered an error during import. ||
|| publishTime | **string** (date-time)

Timestamp when the image was published.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| cloudId | **string**

ID of the cloud that the image belongs to. ||
|#