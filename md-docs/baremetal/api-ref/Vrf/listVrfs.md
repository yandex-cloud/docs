[Документация Yandex Cloud](../../../index.md) > [Yandex BareMetal](../../index.md) > Концепции > Настройка и управление > Справочник API > API v2 > [REST (англ.)](../index.md) > [Vrf](index.md) > ListVrfs

# BareMetal API, REST: Vrf.ListVrfs

Retrieves the list of VRF resources in the specified folder.

https://google.aip.dev/130 --)

## HTTP request

```
GET https://baremetal.api.cloud.yandex.net/baremetal/v2/clouds/{cloudId}/folders/{folderId}/vrfs
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

## Query parameters {#yandex.cloud.baremetal.v2.ListVrfsRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is greater than `page_size`,
the service returns a [ListVrfsResponse.nextPageToken](#yandex.cloud.baremetal.v2.ListVrfsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value is 20.

The maximum value is 1000. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the
[ListVrfsResponse.nextPageToken](#yandex.cloud.baremetal.v2.ListVrfsResponse) returned by a previous list request. ||
|| orderBy | **string**

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

## Response {#yandex.cloud.baremetal.v2.ListVrfsResponse}

**HTTP Code: 200 - OK**

```json
{
  "vrfs": [
    {
      "vrfId": "string",
      "cloudId": "string",
      "folderId": "string",
      "name": "string",
      "description": "string",
      "state": "string",
      "staticRoutes": [
        {
          "destinationCidr": "string",
          "nextHopIpAddress": "string",
          "redistributionType": "string"
        }
      ],
      "createTime": "string",
      "updateTime": "string",
      "annotations": "object"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| vrfs[] | **[Vrf](#yandex.cloud.baremetal.v2.Vrf)**

List of VRF resources. ||
|| nextPageToken | **string**

Token for getting the next page of the list. If the number of results is greater than
[ListVrfRequest.page_size], use `next_page_token` as the value
for the [ListVrfRequest.page_token] parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## Vrf {#yandex.cloud.baremetal.v2.Vrf}

A VRF (Virtual Routing and Forwarding) resource.

#|
||Field | Description ||
|| vrfId | **string**

ID of the VRF. ||
|| cloudId | **string**

ID of the cloud that the private subnet belongs to. ||
|| folderId | **string**

ID of the folder that the private subnet belongs to. ||
|| name | **string**

Name of the VRF. Unique within the folder.

The string length in characters must be 2-63. Value must match the regular expression ` [a-z]([-a-z0-9]*[a-z0-9])? `. ||
|| description | **string**

Optional description of the VRF.

The maximum string length in characters is 1024. ||
|| state | **enum** (State)

State of the VRF.

- `ACTIVE`: VRF is ready to use.
- `UPDATING`: VRF is being updated. ||
|| staticRoutes[] | **[StaticRoute](#yandex.cloud.baremetal.v2.StaticRoute)**

Static routes. ||
|| createTime | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updateTime | **string** (date-time)

Last update timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| annotations | **object** (map<**string**, **string**>)

Resource annotations as `key:value` pairs.

The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource. ||
|#

## StaticRoute {#yandex.cloud.baremetal.v2.StaticRoute}

A static route entry in a VRF.

#|
||Field | Description ||
|| destinationCidr | **string**

Destination network CIDR block. ||
|| nextHopIpAddress | **string**

Next hop host IP address. ||
|| redistributionType | **enum** (RedistributionType)

Redistribution type.

- `DISABLED`: Static route announcements outside BareMetal VRF disabled.
- `ENABLED`: Static route announcements outside BareMetal VRF enabled. ||
|#