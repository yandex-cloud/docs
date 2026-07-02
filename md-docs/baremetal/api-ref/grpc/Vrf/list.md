[Документация Yandex Cloud](../../../../index.md) > [Yandex BareMetal](../../../index.md) > Концепции > Настройка и управление > Справочник API > [gRPC (англ.)](../index.md) > [Vrf](index.md) > List

# BareMetal API, gRPC: VrfService.List

Retrieves the list of VRF resources in the specified folder.

## gRPC request

**rpc List ([ListVrfRequest](#yandex.cloud.baremetal.v1alpha.ListVrfRequest)) returns ([ListVrfResponse](#yandex.cloud.baremetal.v1alpha.ListVrfResponse))**

## ListVrfRequest {#yandex.cloud.baremetal.v1alpha.ListVrfRequest}

```json
{
  "folder_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "order_by": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

ID of the folder to list VRFs in.
To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](../../../../resource-manager/api-ref/grpc/Folder/list.md#List) request.

The maximum string length in characters is 50. Value must match the regular expression ` [a-z][a-z0-9.-]* `. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is greater than `page_size`,
the service returns a [ListConfigurationsResponse.next_page_token](../Configuration/list.md#yandex.cloud.baremetal.v1alpha.ListConfigurationsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value is 20.

The maximum value is 1000. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListConfigurationsResponse.next_page_token](../Configuration/list.md#yandex.cloud.baremetal.v1alpha.ListConfigurationsResponse) returned by a previous list request. ||
|| order_by | **string**

By which column the listing should be ordered and in which direction,
format is "createdAt desc". "id asc" if omitted.
Supported fields: ["id", "name", "createdAt"].
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

## ListVrfResponse {#yandex.cloud.baremetal.v1alpha.ListVrfResponse}

```json
{
  "vrfs": [
    {
      "id": "string",
      "cloud_id": "string",
      "folder_id": "string",
      "name": "string",
      "description": "string",
      "status": "Status",
      "static_routes": [
        {
          "destination_cidr": "string",
          "next_hop_ip_address": "string",
          "redistribution_type": "RedistributionType"
        }
      ],
      "created_at": "google.protobuf.Timestamp",
      "labels": "map<string, string>"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| vrfs[] | **[Vrf](#yandex.cloud.baremetal.v1alpha.Vrf)**

List of VRF resources. ||
|| next_page_token | **string**

Token for getting the next page of the list. If the number of results is greater than
[ListVrfRequest.page_size](#yandex.cloud.baremetal.v1alpha.ListVrfRequest), use `next_page_token` as the value
for the [ListVrfRequest.page_token](#yandex.cloud.baremetal.v1alpha.ListVrfRequest) parameter in the next list request.
Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## Vrf {#yandex.cloud.baremetal.v1alpha.Vrf}

#|
||Field | Description ||
|| id | **string**

ID of the VRF. ||
|| cloud_id | **string**

ID of the cloud that the private subnet belongs to. ||
|| folder_id | **string**

ID of the folder that the private subnet belongs to. ||
|| name | **string**

Name of the VRF.
The name is unique within the folder. ||
|| description | **string**

Optional description of the VRF. ||
|| status | enum **Status**

Status of the VRF.

- `ACTIVE`: VRF is ready to use.
- `UPDATING`: VRF is being updated. ||
|| static_routes[] | **[StaticRoute](#yandex.cloud.baremetal.v1alpha.StaticRoute)**

Static routes. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|#

## StaticRoute {#yandex.cloud.baremetal.v1alpha.StaticRoute}

#|
||Field | Description ||
|| destination_cidr | **string**

Destination network CIDR block. ||
|| next_hop_ip_address | **string**

Next hop host IP address. ||
|| redistribution_type | enum **RedistributionType**

Redistribution type.

- `DISABLED`: Static route announcements outside BareMetal VRF disabled.
- `ENABLED`: Static route announcements outside BareMetal VRF enabled. ||
|#