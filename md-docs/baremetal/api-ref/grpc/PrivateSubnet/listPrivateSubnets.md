[Документация Yandex Cloud](../../../../index.md) > [Yandex BareMetal](../../../index.md) > Концепции > Настройка и управление > Справочник API > API v2 > [gRPC (англ.)](../index.md) > [PrivateSubnet](index.md) > ListPrivateSubnets

# BareMetal API, gRPC: PrivateSubnetService.ListPrivateSubnets

Retrieves the list of PrivateSubnet resources in the specified folder.

https://google.aip.dev/130 --)

## gRPC request

**rpc ListPrivateSubnets ([ListPrivateSubnetsRequest](#yandex.cloud.baremetal.v2.ListPrivateSubnetsRequest)) returns ([ListPrivateSubnetsResponse](#yandex.cloud.baremetal.v2.ListPrivateSubnetsResponse))**

## ListPrivateSubnetsRequest {#yandex.cloud.baremetal.v2.ListPrivateSubnetsRequest}

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
the service returns a [ListPrivateSubnetsResponse.next_page_token](#yandex.cloud.baremetal.v2.ListPrivateSubnetsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value is 20.

The maximum value is 1000. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListPrivateSubnetsResponse.next_page_token](#yandex.cloud.baremetal.v2.ListPrivateSubnetsResponse) returned by a previous list request. ||
|| order_by | **string**

Sorting order for the listing. Follows the [AIP-132](https://google.aip.dev/132) `order_by` format:
```"field [asc|desc]"```, e.g. `"createTime desc"`.

Supported fields: `privateSubnetId`, `createTime`, `updateTime`.
Default order: `privateSubnetId asc`. ||
|| filter | **string**

Filter expression following [AIP-160](https://google.aip.dev/160).

Supported fields and operators:
- `privateSubnetId`, `name`, `hardwarePoolId` - `=`, `!=`, `:` (contains)
- `state` - `=`, `!=`
- `vrfOptions.vrfId` - `=`, `!=`, `:` (contains)

Example: `state = "READY" AND vrfOptions.vrfId = "enp1234abcd"`. ||
|#

## ListPrivateSubnetsResponse {#yandex.cloud.baremetal.v2.ListPrivateSubnetsResponse}

```json
{
  "private_subnets": [
    {
      "private_subnet_id": "string",
      "cloud_id": "string",
      "folder_id": "string",
      "name": "string",
      "description": "string",
      "state": "State",
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
      "create_time": "google.protobuf.Timestamp",
      "update_time": "google.protobuf.Timestamp",
      "annotations": "map<string, string>",
      "zone_id": "string"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| private_subnets[] | **[PrivateSubnet](#yandex.cloud.baremetal.v2.PrivateSubnet)**

List of PrivateSubnet resources. ||
|| next_page_token | **string**

Token for getting the next page of the list. If the number of results is greater than
[ListPrivateSubnetsRequest.page_size](#yandex.cloud.baremetal.v2.ListPrivateSubnetsRequest), use `next_page_token` as the value
for the [ListPrivateSubnetsRequest.page_token](#yandex.cloud.baremetal.v2.ListPrivateSubnetsRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## PrivateSubnet {#yandex.cloud.baremetal.v2.PrivateSubnet}

A PrivateSubnet resource.

#|
||Field | Description ||
|| private_subnet_id | **string**

ID of the private subnet. ||
|| cloud_id | **string**

ID of the cloud that the private subnet belongs to. ||
|| folder_id | **string**

ID of the folder that the private subnet belongs to. ||
|| name | **string**

Name of the public subnet.
The name is unique within the folder.

The string length in characters must be 2-63. Value must match the regular expression ` [a-z]([-a-z0-9]*[a-z0-9])? `. ||
|| description | **string**

Optional description of the private subnet.

The maximum string length in characters is 1024. ||
|| state | enum **State**

State of the private subnet.

- `CREATING`: Private subnet is being created.
- `READY`: Private subnet is ready to use.
- `UPDATING`: Private subnet is being updated.
- `DELETING`: Private subnet is being deleted.
- `ERROR`: Private subnet encountered a problem and cannot operate. ||
|| hardware_pool_id | **string**

ID of the hardware pool that the private subnet belongs to.

The maximum string length in characters is 20. ||
|| vrf_options | **[VrfOptions](#yandex.cloud.baremetal.v2.PrivateSubnet.VrfOptions)**

Optional VRF options for the private subnet. If missing, the private subnet will be unrouted,
i.e. it will lack a DHCP server and routing capabilities between this subnet and other private
subnets. ||
|| create_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| update_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Update timestamp. ||
|| annotations | **object** (map<**string**, **string**>)

Resource annotations as `key:value` pairs.

The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource. ||
|| zone_id | **string**

ID of the availability zone where the server resides. ||
|#

## VrfOptions {#yandex.cloud.baremetal.v2.PrivateSubnet.VrfOptions}

VRF options for the private subnet.

#|
||Field | Description ||
|| vrf_id | **string**

ID of the VRF. ||
|| cidr | **string**

CIDR block for the subnet. ||
|| dhcp_options | **[DhcpOptions](#yandex.cloud.baremetal.v2.DhcpOptions)**

DHCP options for the subnet. ||
|| gateway_ip | **string**

Gateway IP address for the subnet. ||
|#

## DhcpOptions {#yandex.cloud.baremetal.v2.DhcpOptions}

DHCP options for a subnet.

#|
||Field | Description ||
|| start_ip | **string**

Start IP address of the DHCP range (inclusive). ||
|| end_ip | **string**

End IP address of the DHCP range (inclusive). ||
|#