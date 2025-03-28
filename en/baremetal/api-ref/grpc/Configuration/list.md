---
editable: false
sourcePath: en/_api-ref-grpc/baremetal/v1alpha/api-ref/grpc/Configuration/list.md
---

# BareMetal API, gRPC: ConfigurationService.List

Retrieves the list of Configuration resources.

## gRPC request

**rpc List ([ListConfigurationsRequest](#yandex.cloud.baremetal.v1alpha.ListConfigurationsRequest)) returns ([ListConfigurationsResponse](#yandex.cloud.baremetal.v1alpha.ListConfigurationsResponse))**

## ListConfigurationsRequest {#yandex.cloud.baremetal.v1alpha.ListConfigurationsRequest}

```json
{
  "page_size": "int64",
  "page_token": "string",
  "order_by": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is greater than `page_size`,
the service returns a [ListConfigurationsResponse.next_page_token](#yandex.cloud.baremetal.v1alpha.ListConfigurationsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value is 20. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListConfigurationsResponse.next_page_token](#yandex.cloud.baremetal.v1alpha.ListConfigurationsResponse) returned by a previous list request. ||
|| order_by | **string**

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
|#

## ListConfigurationsResponse {#yandex.cloud.baremetal.v1alpha.ListConfigurationsResponse}

```json
{
  "configurations": [
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
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| configurations[] | **[Configuration](#yandex.cloud.baremetal.v1alpha.Configuration)**

List of Configuration resources. ||
|| next_page_token | **string**

Token for getting the next page of the list. If the number of results is greater than
[ListConfigurationsRequest.page_size](#yandex.cloud.baremetal.v1alpha.ListConfigurationsRequest), use `next_page_token` as the value
for the [ListConfigurationsRequest.page_token](#yandex.cloud.baremetal.v1alpha.ListConfigurationsRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## Configuration {#yandex.cloud.baremetal.v1alpha.Configuration}

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
- `HDD`: Hard disk drive.
- `SSD`: Solid state drive. ||
|| disk_count | **int64**

Number of disk drives. ||
|| disk_size_gib | **int64**

Size of a single disk drive in gibibytes (2^30 bytes). ||
|#