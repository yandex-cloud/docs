[Документация Yandex Cloud](../../../../index.md) > [Yandex BareMetal](../../../index.md) > Концепции > Настройка и управление > Справочник API > API v2 > [gRPC (англ.)](../index.md) > [Vrf](index.md) > ListVrfs

# BareMetal API, gRPC: VrfService.ListVrfs

Retrieves the list of VRF resources in the specified folder.

https://google.aip.dev/130 --)

## gRPC request

**rpc ListVrfs ([ListVrfsRequest](#yandex.cloud.baremetal.v2.ListVrfsRequest)) returns ([ListVrfsResponse](#yandex.cloud.baremetal.v2.ListVrfsResponse))**

## ListVrfsRequest {#yandex.cloud.baremetal.v2.ListVrfsRequest}

```json
{
  "cloud_id": "string",
  "folder_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "order_by": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| cloud_id | **string**

ID of the parent cloud.

To get the cloud ID, use a [yandex.cloud.resourcemanager.v1.CloudService.List](../../../../resource-manager/api-ref/grpc/Cloud/list.md#List) request. ||
|| folder_id | **string**

ID of the parent folder.

To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](../../../../resource-manager/api-ref/grpc/Folder/list.md#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is greater than `page_size`,
the service returns a [ListVrfsResponse.next_page_token](#yandex.cloud.baremetal.v2.ListVrfsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value is 20.

The maximum value is 1000. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListVrfsResponse.next_page_token](#yandex.cloud.baremetal.v2.ListVrfsResponse) returned by a previous list request. ||
|| order_by | **string**

Sorting order for the listing. Follows the [AIP-132](https://google.aip.dev/132) `order_by` format:
```"field [asc|desc]"```, e.g. `"createTime desc"`.

Supported fields: `vrfId`, `createTime`, `updateTime`.
Default order: `vrfId asc`. ||
|| filter | **string**

Filter expression following [AIP-160](https://google.aip.dev/160).

Supported fields and operators:
- `vrfId`, `name` - `=`, `!=`, `:` (contains)

Example: `name : "prod"`. ||
|#

## ListVrfsResponse {#yandex.cloud.baremetal.v2.ListVrfsResponse}

```json
{
  "vrfs": [
    {
      "vrf_id": "string",
      "cloud_id": "string",
      "folder_id": "string",
      "name": "string",
      "description": "string",
      "state": "State",
      "static_routes": [
        {
          "destination_cidr": "string",
          "next_hop_ip_address": "string",
          "redistribution_type": "RedistributionType"
        }
      ],
      "create_time": "google.protobuf.Timestamp",
      "update_time": "google.protobuf.Timestamp",
      "annotations": "map<string, string>"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| vrfs[] | **[Vrf](#yandex.cloud.baremetal.v2.Vrf)**

List of VRF resources. ||
|| next_page_token | **string**

Token for getting the next page of the list. If the number of results is greater than
[ListVrfRequest.page_size], use `next_page_token` as the value
for the [ListVrfRequest.page_token] parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## Vrf {#yandex.cloud.baremetal.v2.Vrf}

A VRF (Virtual Routing and Forwarding) resource.

#|
||Field | Description ||
|| vrf_id | **string**

ID of the VRF. ||
|| cloud_id | **string**

ID of the cloud that the private subnet belongs to. ||
|| folder_id | **string**

ID of the folder that the private subnet belongs to. ||
|| name | **string**

Name of the VRF. Unique within the folder.

The string length in characters must be 2-63. Value must match the regular expression ` [a-z]([-a-z0-9]*[a-z0-9])? `. ||
|| description | **string**

Optional description of the VRF.

The maximum string length in characters is 1024. ||
|| state | enum **State**

State of the VRF.

- `ACTIVE`: VRF is ready to use.
- `UPDATING`: VRF is being updated. ||
|| static_routes[] | **[StaticRoute](#yandex.cloud.baremetal.v2.StaticRoute)**

Static routes. ||
|| create_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| update_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Last update timestamp. ||
|| annotations | **object** (map<**string**, **string**>)

Resource annotations as `key:value` pairs.

The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource. ||
|#

## StaticRoute {#yandex.cloud.baremetal.v2.StaticRoute}

A static route entry in a VRF.

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