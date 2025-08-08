---
editable: false
apiPlayground:
  - url: https://baremetal.{{ api-host }}/baremetal/v1alpha/configurations
    method: get
    path: null
    query:
      type: object
      properties:
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page to return. If the number of available
            results is greater than `page_size`,
            the service returns a [ListConfigurationsResponse.nextPageToken](/docs/baremetal/api-ref/Configuration/list#yandex.cloud.baremetal.v1alpha.ListConfigurationsResponse)
            that can be used to get the next page of results in subsequent list requests.
            Default value is 20.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. To get the next page of results, set `page_token` to the
            [ListConfigurationsResponse.nextPageToken](/docs/baremetal/api-ref/Configuration/list#yandex.cloud.baremetal.v1alpha.ListConfigurationsResponse) returned by a previous list request.
          type: string
        orderBy:
          description: |-
            **string**
            By which column the listing should be ordered and in which direction,
            format is "createdAt desc". "id asc" if omitted.
            Supported fields: ["id", "name"].
            Both snake_case and camelCase are supported for fields.
          type: string
        filter:
          description: |-
            **string**
            A filter expression that filters resources listed in the response.
            The expression consists of one or more conditions united by `AND` operator: `<condition1> [AND <condition2> [<...> AND <conditionN>]]`.
            Each condition has the form `<field> <operator> <value>`, where:
            1. `<field>` is the field name. Currently you can use filtering only on the limited number of fields.
            2. `<operator>` is a logical operator, one of `=` (equal), `:` (substring).
            3. `<value>` represents a value.
            String values should be written in double (`"`) or single (`'`) quotes. C-style escape sequences are supported (`\"` turns to `"`, `\'` to `'`, `\\` to backslash).
            Example: "key1='value' AND key2='value'"
            Supported operators: ["AND"].
            Supported fields: ["id", "name"].
            Both snake_case and camelCase are supported for fields.
          type: string
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
sourcePath: en/_api-ref/baremetal/v1alpha/api-ref/Configuration/list.md
---

# BareMetal API, REST: Configuration.List

Retrieves the list of Configuration resources.

## HTTP request

```
GET https://baremetal.{{ api-host }}/baremetal/v1alpha/configurations
```

## Query parameters {#yandex.cloud.baremetal.v1alpha.ListConfigurationsRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is greater than `page_size`,
the service returns a [ListConfigurationsResponse.nextPageToken](#yandex.cloud.baremetal.v1alpha.ListConfigurationsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value is 20. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the
[ListConfigurationsResponse.nextPageToken](#yandex.cloud.baremetal.v1alpha.ListConfigurationsResponse) returned by a previous list request. ||
|| orderBy | **string**

By which column the listing should be ordered and in which direction,
format is "createdAt desc". "id asc" if omitted.
Supported fields: ["id", "name"].
Both snake_case and camelCase are supported for fields. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression consists of one or more conditions united by `AND` operator: `<condition1> [AND <condition2> [<...> AND <conditionN>]]`.

Each condition has the form `<field> <operator> <value>`, where:
1. `<field>` is the field name. Currently you can use filtering only on the limited number of fields.
2. `<operator>` is a logical operator, one of `=` (equal), `:` (substring).
3. `<value>` represents a value.
String values should be written in double (`"`) or single (`'`) quotes. C-style escape sequences are supported (`\"` turns to `"`, `\'` to `'`, `\\` to backslash).
Example: "key1='value' AND key2='value'"
Supported operators: ["AND"].
Supported fields: ["id", "name"].
Both snake_case and camelCase are supported for fields. ||
|| folderId | **string**

ID of the folder to return a Configuration resource for.

To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request. ||
|#

## Response {#yandex.cloud.baremetal.v1alpha.ListConfigurationsResponse}

**HTTP Code: 200 - OK**

```json
{
  "configurations": [
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
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| configurations[] | **[Configuration](#yandex.cloud.baremetal.v1alpha.Configuration)**

List of Configuration resources. ||
|| nextPageToken | **string**

Token for getting the next page of the list. If the number of results is greater than
[ListConfigurationsRequest.pageSize](#yandex.cloud.baremetal.v1alpha.ListConfigurationsRequest), use `next_page_token` as the value
for the [ListConfigurationsRequest.pageToken](#yandex.cloud.baremetal.v1alpha.ListConfigurationsRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## Configuration {#yandex.cloud.baremetal.v1alpha.Configuration}

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