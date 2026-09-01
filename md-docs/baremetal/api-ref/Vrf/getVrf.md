[Документация Yandex Cloud](../../../index.md) > [Yandex BareMetal](../../index.md) > Концепции > Настройка и управление > Справочник API > API v2 > [REST (англ.)](../index.md) > [Vrf](index.md) > GetVrf

# BareMetal API, REST: Vrf.GetVrf

Returns the specific VRF resource.

To get the list of available VRFs, make a [List] request.


## HTTP request

```
GET https://baremetal.api.cloud.yandex.net/baremetal/v2/clouds/{cloudId}/folders/{folderId}/vrfs/{vrfId}
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
|| vrfId | **string**

Required field. ID of the VRF to return.

To get the VRF ID, use a [VrfService.List] request.

Value must match the regular expression ` [a-z][a-z0-9]* `. ||
|#

## Response {#yandex.cloud.baremetal.v2.Vrf}

**HTTP Code: 200 - OK**

```json
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
```

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