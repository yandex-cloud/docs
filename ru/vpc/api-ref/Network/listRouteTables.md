---
editable: false
apiPlayground:
  - url: https://vpc.{{ api-host }}/vpc/v1/networks/{networkId}/route_tables
    method: get
    path:
      type: object
      properties:
        networkId:
          description: |-
            **string**
            Required field. ID of the Network resource to list route tables for.
          type: string
      required:
        - networkId
      additionalProperties: false
    query:
      type: object
      properties:
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page that should be returned. If the number of available
            results is larger than `pageSize`,
            the service returns a [ListNetworkRouteTablesResponse.nextPageToken](/docs/vpc/api-ref/Network/listRouteTables#yandex.cloud.vpc.v1.ListNetworkRouteTablesResponse)
            that can be used to get the next page of results in subsequent list requests. Default value: 100.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. Set `pageToken`
            to the [ListNetworkRouteTablesResponse.nextPageToken](/docs/vpc/api-ref/Network/listRouteTables#yandex.cloud.vpc.v1.ListNetworkRouteTablesResponse)
            returned by a previous list request to get the next page of results.
          type: string
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/vpc/v1/api-ref/Network/listRouteTables.md
---

# Virtual Private Cloud API, REST: Network.ListRouteTables

Lists route tables from the specified network.

## HTTP request

```
GET https://vpc.{{ api-host }}/vpc/v1/networks/{networkId}/route_tables
```

## Path parameters

#|
||Field | Description ||
|| networkId | **string**

Required field. ID of the Network resource to list route tables for. ||
|#

## Query parameters {#yandex.cloud.vpc.v1.ListNetworkRouteTablesRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page that should be returned. If the number of available
results is larger than `pageSize`,
the service returns a [ListNetworkRouteTablesResponse.nextPageToken](#yandex.cloud.vpc.v1.ListNetworkRouteTablesResponse)
that can be used to get the next page of results in subsequent list requests. Default value: 100. ||
|| pageToken | **string**

Page token. Set `pageToken`
to the [ListNetworkRouteTablesResponse.nextPageToken](#yandex.cloud.vpc.v1.ListNetworkRouteTablesResponse)
returned by a previous list request to get the next page of results. ||
|#

## Response {#yandex.cloud.vpc.v1.ListNetworkRouteTablesResponse}

**HTTP Code: 200 - OK**

```json
{
  "routeTables": [
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
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| routeTables[] | **[RouteTable](#yandex.cloud.vpc.v1.RouteTable)**

List of route tables that belong to the network which is specified in the request. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListNetworkRouteTablesRequest.pageSize](#yandex.cloud.vpc.v1.ListNetworkRouteTablesRequest), use
the `nextPageToken` as the value
for the [ListNetworkRouteTablesRequest.pageToken](#yandex.cloud.vpc.v1.ListNetworkRouteTablesRequest) query parameter
in the next list request. Subsequent list requests will have their own
`nextPageToken` to continue paging through the results. ||
|#

## RouteTable {#yandex.cloud.vpc.v1.RouteTable}

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