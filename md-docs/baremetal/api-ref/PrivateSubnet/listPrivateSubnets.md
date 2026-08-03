[Документация Yandex Cloud](../../../index.md) > [Yandex BareMetal](../../index.md) > Концепции > Настройка и управление > Справочник API > API v2 > [REST (англ.)](../index.md) > [PrivateSubnet](index.md) > ListPrivateSubnets

# BareMetal API, REST: PrivateSubnet.ListPrivateSubnets

Retrieves the list of PrivateSubnet resources in the specified folder.

https://google.aip.dev/130 --)

## HTTP request

```
GET https://baremetal.api.cloud.yandex.net/baremetal/v2/clouds/{cloudId}/folders/{folderId}/privateSubnets
```

## Path parameters

#|
||Field | Description ||
|| cloudId | **string**

Required field. ID of the parent cloud.

To get the cloud ID, use a [yandex.cloud.resourcemanager.v1.CloudService.List](../../../resource-manager/api-ref/Cloud/list.md#List) request. ||
|| folderId | **string**

Required field. ID of the parent folder.

To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](../../../resource-manager/api-ref/Folder/list.md#List) request. ||
|#

## Query parameters {#yandex.cloud.baremetal.v2.ListPrivateSubnetsRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is greater than `page_size`,
the service returns a [ListPrivateSubnetsResponse.nextPageToken](#yandex.cloud.baremetal.v2.ListPrivateSubnetsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value is 20.

The maximum value is 1000. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the
[ListPrivateSubnetsResponse.nextPageToken](#yandex.cloud.baremetal.v2.ListPrivateSubnetsResponse) returned by a previous list request. ||
|| orderBy | **string**

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

## Response {#yandex.cloud.baremetal.v2.ListPrivateSubnetsResponse}

**HTTP Code: 200 - OK**

```json
{
  "privateSubnets": [
    {
      "privateSubnetId": "string",
      "cloudId": "string",
      "folderId": "string",
      "name": "string",
      "description": "string",
      "state": "string",
      "hardwarePoolId": "string",
      "vrfOptions": {
        "vrfId": "string",
        "cidr": "string",
        "dhcpOptions": {
          "startIp": "string",
          "endIp": "string"
        },
        "gatewayIp": "string"
      },
      "createTime": "string",
      "updateTime": "string",
      "annotations": "object",
      "zoneId": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| privateSubnets[] | **[PrivateSubnet](#yandex.cloud.baremetal.v2.PrivateSubnet)**

List of PrivateSubnet resources. ||
|| nextPageToken | **string**

Token for getting the next page of the list. If the number of results is greater than
[ListPrivateSubnetsRequest.pageSize](#yandex.cloud.baremetal.v2.ListPrivateSubnetsRequest), use `next_page_token` as the value
for the [ListPrivateSubnetsRequest.pageToken](#yandex.cloud.baremetal.v2.ListPrivateSubnetsRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## PrivateSubnet {#yandex.cloud.baremetal.v2.PrivateSubnet}

A PrivateSubnet resource.

#|
||Field | Description ||
|| privateSubnetId | **string**

ID of the private subnet. ||
|| cloudId | **string**

ID of the cloud that the private subnet belongs to. ||
|| folderId | **string**

ID of the folder that the private subnet belongs to. ||
|| name | **string**

Name of the public subnet.
The name is unique within the folder.

The string length in characters must be 2-63. Value must match the regular expression ` [a-z]([-a-z0-9]*[a-z0-9])? `. ||
|| description | **string**

Optional description of the private subnet.

The maximum string length in characters is 1024. ||
|| state | **enum** (State)

State of the private subnet.

- `CREATING`: Private subnet is being created.
- `READY`: Private subnet is ready to use.
- `UPDATING`: Private subnet is being updated.
- `DELETING`: Private subnet is being deleted.
- `ERROR`: Private subnet encountered a problem and cannot operate. ||
|| hardwarePoolId | **string**

ID of the hardware pool that the private subnet belongs to.

The maximum string length in characters is 20. ||
|| vrfOptions | **[VrfOptions](#yandex.cloud.baremetal.v2.PrivateSubnet.VrfOptions)**

Optional VRF options for the private subnet. If missing, the private subnet will be unrouted,
i.e. it will lack a DHCP server and routing capabilities between this subnet and other private
subnets. ||
|| createTime | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updateTime | **string** (date-time)

Update timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| annotations | **object** (map<**string**, **string**>)

Resource annotations as `key:value` pairs.

The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource. ||
|| zoneId | **string**

ID of the availability zone where the server resides. ||
|#

## VrfOptions {#yandex.cloud.baremetal.v2.PrivateSubnet.VrfOptions}

VRF options for the private subnet.

#|
||Field | Description ||
|| vrfId | **string**

ID of the VRF. ||
|| cidr | **string**

CIDR block for the subnet. ||
|| dhcpOptions | **[DhcpOptions](#yandex.cloud.baremetal.v2.DhcpOptions)**

DHCP options for the subnet. ||
|| gatewayIp | **string**

Gateway IP address for the subnet. ||
|#

## DhcpOptions {#yandex.cloud.baremetal.v2.DhcpOptions}

DHCP options for a subnet.

#|
||Field | Description ||
|| startIp | **string**

Start IP address of the DHCP range (inclusive). ||
|| endIp | **string**

End IP address of the DHCP range (inclusive). ||
|#