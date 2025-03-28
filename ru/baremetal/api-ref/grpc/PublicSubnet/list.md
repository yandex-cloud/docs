---
editable: false
sourcePath: en/_api-ref-grpc/baremetal/v1alpha/api-ref/grpc/PublicSubnet/list.md
---

# BareMetal API, gRPC: PublicSubnetService.List

Retrieves the list of PublicSubnet resources in the specified folder.

## gRPC request

**rpc List ([ListPublicSubnetRequest](#yandex.cloud.baremetal.v1alpha.ListPublicSubnetRequest)) returns ([ListPublicSubnetResponse](#yandex.cloud.baremetal.v1alpha.ListPublicSubnetResponse))**

## ListPublicSubnetRequest {#yandex.cloud.baremetal.v1alpha.ListPublicSubnetRequest}

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

ID of the folder to list public subnets in.

To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is greater than `page_size`,
the service returns a [ListPublicSubnetResponse.next_page_token](#yandex.cloud.baremetal.v1alpha.ListPublicSubnetResponse)
that can be used to get the next page of results in subsequent list requests.
Default value is 20. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListPublicSubnetResponse.next_page_token](#yandex.cloud.baremetal.v1alpha.ListPublicSubnetResponse) returned by a previous list request. ||
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
Supported fields: ["id", "name", "zoneId", "hardwarePoolId"].
Both snake_case and camelCase are supported for fields. ||
|#

## ListPublicSubnetResponse {#yandex.cloud.baremetal.v1alpha.ListPublicSubnetResponse}

```json
{
  "public_subnets": [
    {
      "id": "string",
      "cloud_id": "string",
      "folder_id": "string",
      "name": "string",
      "description": "string",
      "zone_id": "string",
      "hardware_pool_ids": [
        "string"
      ],
      "type": "PublicSubnetType",
      "prefix_length": "int64",
      "cidr": "string",
      "dhcp_options": {
        "start_ip": "string",
        "end_ip": "string"
      },
      "gateway_ip": "string",
      "created_at": "google.protobuf.Timestamp",
      "labels": "map<string, string>"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| public_subnets[] | **[PublicSubnet](#yandex.cloud.baremetal.v1alpha.PublicSubnet)**

List of PublicSubnet resources. ||
|| next_page_token | **string**

Token for getting the next page of the list. If the number of results is greater than
[ListPublicSubnetRequest.page_size](#yandex.cloud.baremetal.v1alpha.ListPublicSubnetRequest), use `next_page_token` as the value
for the [ListPublicSubnetRequest.page_token](#yandex.cloud.baremetal.v1alpha.ListPublicSubnetRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## PublicSubnet {#yandex.cloud.baremetal.v1alpha.PublicSubnet}

A PublicSubnet resource.

#|
||Field | Description ||
|| id | **string**

ID of the public subnet. ||
|| cloud_id | **string**

ID of the cloud that the public subnet belongs to. ||
|| folder_id | **string**

ID of the folder that the public subnet belongs to. ||
|| name | **string**

Name of the public subnet.
The name is unique within the folder. ||
|| description | **string**

Optional description of the public subnet. ||
|| zone_id | **string**

ID of the availability zone where the server resides. ||
|| hardware_pool_ids[] | **string**

IDs of the hardware pool that the public subnet belongs to. ||
|| type | enum **PublicSubnetType**

Type of the public subnet (static or ephemeral).

- `PUBLIC_SUBNET_TYPE_UNSPECIFIED`: Unspecified public subnet type.
- `DEDICATED`: Dedicated public subnet.
- `EPHEMERAL`: Ephemeral public subnet. ||
|| prefix_length | **int64**

Prefix length of the public subnet CIDR block. ||
|| cidr | **string**

CIDR block for the public subnet. ||
|| dhcp_options | **[DhcpOptions](#yandex.cloud.baremetal.v1alpha.DhcpOptions)**

DHCP options for the public subnet. ||
|| gateway_ip | **string**

Gateway IP address for the public subnet. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|#

## DhcpOptions {#yandex.cloud.baremetal.v1alpha.DhcpOptions}

DHCP options for a subnet.

#|
||Field | Description ||
|| start_ip | **string**

Start IP address of the DHCP range (inclusive). ||
|| end_ip | **string**

End IP address of the DHCP range (inclusive). ||
|#