---
editable: false
sourcePath: en/_api-ref/vpc/v1/api-ref/RouteTable/get.md
---

# Virtual Private Cloud API, REST: RouteTable.Get

Returns the specified RouteTable resource.

To get the list of available RouteTable resources, make a [List](/docs/vpc/api-ref/RouteTable/list#List) request.

## HTTP request

```
GET https://vpc.{{ api-host }}/vpc/v1/routeTables/{routeTableId}
```

## Path parameters

#|
||Field | Description ||
|| routeTableId | **string**

Required field. ID of the RouteTable resource to return.
To get the route table ID use a [RouteTableService.List](/docs/vpc/api-ref/RouteTable/list#List) request. ||
|#

## Response {#yandex.cloud.vpc.v1.RouteTable}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
  "networkId": "string",
  "staticRoutes": [
    {
      // Includes only one of the fields `destinationPrefix`
      "destinationPrefix": "string",
      // end of the list of possible fields
      // Includes only one of the fields `nextHopAddress`, `gatewayId`
      "nextHopAddress": "string",
      "gatewayId": "string",
      // end of the list of possible fields
      "labels": "object"
    }
  ]
}
```

A RouteTable resource. For more information, see [Static Routes](/docs/vpc/concepts/routing).

#|
||Field | Description ||
|| id | **string**

ID of the route table. ||
|| folderId | **string**

ID of the folder that the route table belongs to. ||
|| createdAt | **string** (date-time)

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the route table.
The name must be unique within the folder.
Value must match the regular expression `\|[a-zA-Z]([-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])?`. ||
|| description | **string**

Optional description of the route table. 0-256 characters long. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels, `key:value` pairs.
No more than 64 per resource.
The string length in characters for each key must be 1-63.
Each value must match the regular expression `[-_0-9a-z]*`.
Each key must match the regular expression `[a-z][-_0-9a-z]*`. ||
|| networkId | **string**

ID of the network the route table belongs to. ||
|| staticRoutes[] | **[StaticRoute](#yandex.cloud.vpc.v1.StaticRoute)**

List of static routes. ||
|#

## StaticRoute {#yandex.cloud.vpc.v1.StaticRoute}

A StaticRoute resource. For more information, see [Static Routes](/docs/vpc/concepts/routing).

#|
||Field | Description ||
|| destinationPrefix | **string**

Destination subnet in CIDR notation

Includes only one of the fields `destinationPrefix`. ||
|| nextHopAddress | **string**

Next hop IP address

Includes only one of the fields `nextHopAddress`, `gatewayId`. ||
|| gatewayId | **string**

Next hop gateway id

Includes only one of the fields `nextHopAddress`, `gatewayId`. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `` key:value `` pairs. Maximum of 64 per resource. ||
|#