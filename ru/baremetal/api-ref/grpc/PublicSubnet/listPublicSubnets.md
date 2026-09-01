---
editable: false
---

# BareMetal API, gRPC: PublicSubnetService.ListPublicSubnets

Retrieves the list of PublicSubnet resources in the specified folder.


## gRPC request

**rpc ListPublicSubnets ([ListPublicSubnetsRequest](#yandex.cloud.baremetal.v2.ListPublicSubnetsRequest)) returns ([ListPublicSubnetsResponse](#yandex.cloud.baremetal.v2.ListPublicSubnetsResponse))**

## ListPublicSubnetsRequest {#yandex.cloud.baremetal.v2.ListPublicSubnetsRequest}

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

To get the cloud ID, use a [yandex.cloud.resourcemanager.v1.CloudService.List](/docs/resource-manager/api-ref/grpc/Cloud/list#List) request. ||
|| folder_id | **string**

ID of the parent folder.

To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is greater than `page_size`,
the service returns a [ListPublicSubnetsResponse.next_page_token](#yandex.cloud.baremetal.v2.ListPublicSubnetsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value is 20.

The maximum value is 1000. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListPublicSubnetsResponse.next_page_token](#yandex.cloud.baremetal.v2.ListPublicSubnetsResponse) returned by a previous list request. ||
|| order_by | **string**

Sorting order for the listing. Follows the [AIP-132](https://google.aip.dev/132) `order_by` format:
```"field [asc|desc]"```, e.g. `"createTime desc"`.

Supported fields: `publicSubnetId`, `createTime`, `updateTime`.
Default order: `publicSubnetId asc`. ||
|| filter | **string**

Filter expression following [AIP-160](https://google.aip.dev/160).

Supported fields and operators:
- `publicSubnetId`, `name` - `=`, `!=`, `:` (contains)
- `state`, `type` - `=`, `!=`
- `hardwarePoolIds` - `:` (contains)

Example: `state = "READY" AND type = "STANDARD"`. ||
|#

## ListPublicSubnetsResponse {#yandex.cloud.baremetal.v2.ListPublicSubnetsResponse}

```json
{
  "public_subnets": [
    {
      "public_subnet_id": "string",
      "cloud_id": "string",
      "folder_id": "string",
      "name": "string",
      "description": "string",
      "hardware_pool_ids": [
        "string"
      ],
      "type": "Type",
      // Includes only one of the fields `auto_allocation`, `manual_allocation`
      "auto_allocation": {
        "prefix_length": "int64"
      },
      "manual_allocation": {
        "cidr": "string",
        "public_prefix_pool_id": "string"
      },
      // end of the list of possible fields
      "prefix_length": "int64",
      "cidr": "string",
      "dhcp_options": {
        "start_ip": "string",
        "end_ip": "string"
      },
      "gateway_ip": "string",
      "public_prefix_pool_id": "string",
      "create_time": "google.protobuf.Timestamp",
      "update_time": "google.protobuf.Timestamp",
      "annotations": "map<string, string>",
      "deletion_unlock_time": "google.protobuf.Timestamp"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| public_subnets[] | **[PublicSubnet](#yandex.cloud.baremetal.v2.PublicSubnet)**

List of PublicSubnet resources. ||
|| next_page_token | **string**

Token for getting the next page of the list. If the number of results is greater than
[ListPublicSubnetsRequest.page_size](#yandex.cloud.baremetal.v2.ListPublicSubnetsRequest), use `next_page_token` as the value
for the [ListPublicSubnetsRequest.page_token](#yandex.cloud.baremetal.v2.ListPublicSubnetsRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## PublicSubnet {#yandex.cloud.baremetal.v2.PublicSubnet}

A PublicSubnet resource.

#|
||Field | Description ||
|| public_subnet_id | **string**

ID of the public subnet. ||
|| cloud_id | **string**

ID of the cloud that the public subnet belongs to. ||
|| folder_id | **string**

ID of the folder that the public subnet belongs to. ||
|| name | **string**

Name of the public subnet.
The name is unique within the folder.

The string length in characters must be 2-63. Value must match the regular expression ` [a-z]([-a-z0-9]*[a-z0-9])? `. ||
|| description | **string**

Optional description of the public subnet.

The maximum string length in characters is 1024. ||
|| hardware_pool_ids[] | **string**

IDs of the hardware pool that the public subnet belongs to. ||
|| type | enum **Type**

Type of the public subnet (dedicated or ephemeral).

Cannot be set on creation. It's DEDICATED by default. EPHEMERAL networks are created only within the server.
Only EPHEMERAL -> DEDICATED update is possible.

- `DEDICATED`: Dedicated public subnet.
- `EPHEMERAL`: Ephemeral public subnet. ||
|| auto_allocation | **[AutoAllocation](#yandex.cloud.baremetal.v2.PublicSubnet.AutoAllocation)**

Automatic CIDR allocation from the system public prefix pool.

Includes only one of the fields `auto_allocation`, `manual_allocation`.

Method for allocating CIDR block to the public subnet. ||
|| manual_allocation | **[ManualAllocation](#yandex.cloud.baremetal.v2.PublicSubnet.ManualAllocation)**

Manual CIDR allocation with explicit CIDR from user's own public prefix pool (BYOIP).

Includes only one of the fields `auto_allocation`, `manual_allocation`.

Method for allocating CIDR block to the public subnet. ||
|| prefix_length | **int64**

Prefix length of the public subnet CIDR block. ||
|| cidr | **string**

CIDR block for the public subnet. ||
|| dhcp_options | **[DhcpOptions](#yandex.cloud.baremetal.v2.DhcpOptions)**

DHCP options for the public subnet. ||
|| gateway_ip | **string**

Gateway IP address for the public subnet. ||
|| public_prefix_pool_id | **string**

ID of the public prefix pool that the public subnet belongs to. ||
|| create_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| update_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Update timestamp. ||
|| annotations | **object** (map<**string**, **string**>)

Resource annotations as `key:value` pairs.

The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource. ||
|| deletion_unlock_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp when deletion of the public subnet is allowed. ||
|#

## AutoAllocation {#yandex.cloud.baremetal.v2.PublicSubnet.AutoAllocation}

#|
||Field | Description ||
|| prefix_length | **int64**

Prefix length of the public subnet CIDR block.

Acceptable values are 1 to 31, inclusive. ||
|#

## ManualAllocation {#yandex.cloud.baremetal.v2.PublicSubnet.ManualAllocation}

#|
||Field | Description ||
|| cidr | **string**

CIDR block of the public subnet. Must be within the public prefix pool CIDR block. ||
|| public_prefix_pool_id | **string**

ID of the public prefix pool that the CIDR block belongs to.

To get a list of available public prefix pools, use the [PublicPrefixPoolService.List] request. ||
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