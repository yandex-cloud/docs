[Документация Yandex Cloud](../../../index.md) > [Yandex BareMetal](../../index.md) > Концепции > Настройка и управление > Справочник API > API v2 > [REST (англ.)](../index.md) > [PublicSubnet](index.md) > ListPublicSubnets

# BareMetal API, REST: PublicSubnet.ListPublicSubnets

Retrieves the list of PublicSubnet resources in the specified folder.


## HTTP request

```
GET https://baremetal.api.cloud.yandex.net/baremetal/v2/clouds/{cloudId}/folders/{folderId}/publicSubnets
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

## Query parameters {#yandex.cloud.baremetal.v2.ListPublicSubnetsRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is greater than `page_size`,
the service returns a [ListPublicSubnetsResponse.nextPageToken](#yandex.cloud.baremetal.v2.ListPublicSubnetsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value is 20.

The maximum value is 1000. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the
[ListPublicSubnetsResponse.nextPageToken](#yandex.cloud.baremetal.v2.ListPublicSubnetsResponse) returned by a previous list request. ||
|| orderBy | **string**

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

## Response {#yandex.cloud.baremetal.v2.ListPublicSubnetsResponse}

**HTTP Code: 200 - OK**

```json
{
  "publicSubnets": [
    {
      "publicSubnetId": "string",
      "cloudId": "string",
      "folderId": "string",
      "name": "string",
      "description": "string",
      "hardwarePoolIds": [
        "string"
      ],
      "type": "string",
      // Includes only one of the fields `autoAllocation`, `manualAllocation`
      "autoAllocation": {
        "prefixLength": "string"
      },
      "manualAllocation": {
        "cidr": "string",
        "publicPrefixPoolId": "string"
      },
      // end of the list of possible fields
      "prefixLength": "string",
      "cidr": "string",
      "dhcpOptions": {
        "startIp": "string",
        "endIp": "string"
      },
      "gatewayIp": "string",
      "publicPrefixPoolId": "string",
      "createTime": "string",
      "updateTime": "string",
      "annotations": "object",
      "deletionUnlockTime": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| publicSubnets[] | **[PublicSubnet](#yandex.cloud.baremetal.v2.PublicSubnet)**

List of PublicSubnet resources. ||
|| nextPageToken | **string**

Token for getting the next page of the list. If the number of results is greater than
[ListPublicSubnetsRequest.pageSize](#yandex.cloud.baremetal.v2.ListPublicSubnetsRequest), use `next_page_token` as the value
for the [ListPublicSubnetsRequest.pageToken](#yandex.cloud.baremetal.v2.ListPublicSubnetsRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## PublicSubnet {#yandex.cloud.baremetal.v2.PublicSubnet}

A PublicSubnet resource.

#|
||Field | Description ||
|| publicSubnetId | **string**

ID of the public subnet. ||
|| cloudId | **string**

ID of the cloud that the public subnet belongs to. ||
|| folderId | **string**

ID of the folder that the public subnet belongs to. ||
|| name | **string**

Name of the public subnet.
The name is unique within the folder.

The string length in characters must be 2-63. Value must match the regular expression ` [a-z]([-a-z0-9]*[a-z0-9])? `. ||
|| description | **string**

Optional description of the public subnet.

The maximum string length in characters is 1024. ||
|| hardwarePoolIds[] | **string**

IDs of the hardware pool that the public subnet belongs to. ||
|| type | **enum** (Type)

Type of the public subnet (dedicated or ephemeral).

Cannot be set on creation. It's DEDICATED by default. EPHEMERAL networks are created only within the server.
Only EPHEMERAL -> DEDICATED update is possible.

- `DEDICATED`: Dedicated public subnet.
- `EPHEMERAL`: Ephemeral public subnet. ||
|| autoAllocation | **[AutoAllocation](#yandex.cloud.baremetal.v2.PublicSubnet.AutoAllocation)**

Automatic CIDR allocation from the system public prefix pool.

Includes only one of the fields `autoAllocation`, `manualAllocation`.

Method for allocating CIDR block to the public subnet. ||
|| manualAllocation | **[ManualAllocation](#yandex.cloud.baremetal.v2.PublicSubnet.ManualAllocation)**

Manual CIDR allocation with explicit CIDR from user's own public prefix pool (BYOIP).

Includes only one of the fields `autoAllocation`, `manualAllocation`.

Method for allocating CIDR block to the public subnet. ||
|| prefixLength | **string** (int64)

Prefix length of the public subnet CIDR block. ||
|| cidr | **string**

CIDR block for the public subnet. ||
|| dhcpOptions | **[DhcpOptions](#yandex.cloud.baremetal.v2.DhcpOptions)**

DHCP options for the public subnet. ||
|| gatewayIp | **string**

Gateway IP address for the public subnet. ||
|| publicPrefixPoolId | **string**

ID of the public prefix pool that the public subnet belongs to. ||
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
|| deletionUnlockTime | **string** (date-time)

Timestamp when deletion of the public subnet is allowed.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#

## AutoAllocation {#yandex.cloud.baremetal.v2.PublicSubnet.AutoAllocation}

#|
||Field | Description ||
|| prefixLength | **string** (int64)

Prefix length of the public subnet CIDR block.

Acceptable values are 1 to 31, inclusive. ||
|#

## ManualAllocation {#yandex.cloud.baremetal.v2.PublicSubnet.ManualAllocation}

#|
||Field | Description ||
|| cidr | **string**

CIDR block of the public subnet. Must be within the public prefix pool CIDR block. ||
|| publicPrefixPoolId | **string**

ID of the public prefix pool that the CIDR block belongs to.

To get a list of available public prefix pools, use the [PublicPrefixPoolService.List] request. ||
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