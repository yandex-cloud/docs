# BareMetal API, REST: Vrf.Get

Returns the specific VRF resource.
To get the list of available VRFs, make a [List](list.md#List) request.

## HTTP request

```
GET https://baremetal.api.cloud.yandex.net/baremetal/v1alpha/vrfs/{vrfId}
```

## Path parameters

#|
||Field | Description ||
|| vrfId | **string**

Required field. ID of the VRF to return.
To get the VRF ID, use a [VrfService.List](list.md#List) request.

Value must match the regular expression ` [a-z][a-z0-9]* `. ||
|#

## Response {#yandex.cloud.baremetal.v1alpha.Vrf}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "cloudId": "string",
  "folderId": "string",
  "name": "string",
  "description": "string",
  "status": "string",
  "staticRoutes": [
    {
      "destinationCidr": "string",
      "nextHopIpAddress": "string",
      "redistributionType": "string"
    }
  ],
  "createdAt": "string",
  "labels": "object"
}
```

#|
||Field | Description ||
|| id | **string**

ID of the VRF. ||
|| cloudId | **string**

ID of the cloud that the private subnet belongs to. ||
|| folderId | **string**

ID of the folder that the private subnet belongs to. ||
|| name | **string**

Name of the VRF.
The name is unique within the folder. ||
|| description | **string**

Optional description of the VRF. ||
|| status | **enum** (Status)

Status of the VRF.

- `ACTIVE`: VRF is ready to use.
- `UPDATING`: VRF is being updated. ||
|| staticRoutes[] | **[StaticRoute](#yandex.cloud.baremetal.v1alpha.StaticRoute)**

Static routes. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|#

## StaticRoute {#yandex.cloud.baremetal.v1alpha.StaticRoute}

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