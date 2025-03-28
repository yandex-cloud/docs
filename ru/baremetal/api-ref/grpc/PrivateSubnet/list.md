---
editable: false
sourcePath: en/_api-ref-grpc/baremetal/v1alpha/api-ref/grpc/PrivateSubnet/list.md
---

# BareMetal API, gRPC: PrivateSubnetService.List

Retrieves the list of PrivateSubnet resources in the specified folder.

## gRPC request

**rpc List ([ListPrivateSubnetRequest](#yandex.cloud.baremetal.v1alpha.ListPrivateSubnetRequest)) returns ([ListPrivateSubnetResponse](#yandex.cloud.baremetal.v1alpha.ListPrivateSubnetResponse))**

## ListPrivateSubnetRequest {#yandex.cloud.baremetal.v1alpha.ListPrivateSubnetRequest}

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

ID of the folder to list private subnets in.

To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is greater than `page_size`,
the service returns a [ListConfigurationsResponse.next_page_token](/docs/baremetal/api-ref/grpc/Configuration/list#yandex.cloud.baremetal.v1alpha.ListConfigurationsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value is 20. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListConfigurationsResponse.next_page_token](/docs/baremetal/api-ref/grpc/Configuration/list#yandex.cloud.baremetal.v1alpha.ListConfigurationsResponse) returned by a previous list request. ||
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

## ListPrivateSubnetResponse {#yandex.cloud.baremetal.v1alpha.ListPrivateSubnetResponse}

```json
{
  "private_subnets": [
    {
      "id": "string",
      "cloud_id": "string",
      "folder_id": "string",
      "name": "string",
      "description": "string",
      "status": "Status",
      "zone_id": "string",
      "hardware_pool_id": "string",
      "vrf_options": {
        "vrf_id": "string",
        "cidr": "string",
        "dhcp_options": {
          "start_ip": "string",
          "end_ip": "string"
        },
        "gateway_ip": "string"
      },
      "created_at": "google.protobuf.Timestamp",
      "labels": "map<string, string>"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| private_subnets[] | **[PrivateSubnet](#yandex.cloud.baremetal.v1alpha.PrivateSubnet)**

List of PrivateSubnet resources. ||
|| next_page_token | **string**

Token for getting the next page of the list. If the number of results is greater than
[ListImagesRequest.page_size](/docs/baremetal/api-ref/grpc/Image/list#yandex.cloud.baremetal.v1alpha.ListImagesRequest), use `next_page_token` as the value
for the [ListImagesRequest.page_token](/docs/baremetal/api-ref/grpc/Image/list#yandex.cloud.baremetal.v1alpha.ListImagesRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## PrivateSubnet {#yandex.cloud.baremetal.v1alpha.PrivateSubnet}

A PrivateSubnet resource.

#|
||Field | Description ||
|| id | **string**

ID of the private subnet. ||
|| cloud_id | **string**

ID of the cloud that the private subnet belongs to. ||
|| folder_id | **string**

ID of the folder that the private subnet belongs to. ||
|| name | **string**

Name of the private subnet.
The name is unique within the folder. ||
|| description | **string**

Optional description of the private subnet. ||
|| status | enum **Status**

Status of the private subnet.

- `STATUS_UNSPECIFIED`: Unspecified private subnet status.
- `CREATING`: Private subnet is being created.
- `READY`: Private subnet is ready to use.
- `UPDATING`: Private subnet is being updated.
- `DELETING`: Private subnet is being deleted.
- `ERROR`: Private subnet encountered a problem and cannot operate. ||
|| zone_id | **string**

ID of the availability zone where the server resides. ||
|| hardware_pool_id | **string**

ID of the hardware pool that the private subnet belongs to. ||
|| vrf_options | **[VrfOptions](#yandex.cloud.baremetal.v1alpha.PrivateSubnet.VrfOptions)**

Optional VRF options for the private subnet. If missing, the private subnet will be unrouted,
i.e. it will lack a DHCP server and routing capabilities between this subnet and other private
subnets. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|#

## VrfOptions {#yandex.cloud.baremetal.v1alpha.PrivateSubnet.VrfOptions}

VRF options for the private subnet.

#|
||Field | Description ||
|| vrf_id | **string**

ID of the VRF. ||
|| cidr | **string**

CIDR block for the subnet. ||
|| dhcp_options | **[DhcpOptions](#yandex.cloud.baremetal.v1alpha.DhcpOptions)**

DHCP options for the subnet. ||
|| gateway_ip | **string**

Gateway IP address for the subnet. ||
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