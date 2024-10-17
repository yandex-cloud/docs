---
editable: false
sourcePath: en/_api-ref-grpc/vpc/v1/api-ref/grpc/Network/listRouteTables.md
---

# Virtual Private Cloud API, gRPC: NetworkService.ListRouteTables {#ListRouteTables}

Lists route tables from the specified network.

## gRPC request

**rpc ListRouteTables ([ListNetworkRouteTablesRequest](#yandex.cloud.vpc.v1.ListNetworkRouteTablesRequest)) returns ([ListNetworkRouteTablesResponse](#yandex.cloud.vpc.v1.ListNetworkRouteTablesResponse))**

## ListNetworkRouteTablesRequest {#yandex.cloud.vpc.v1.ListNetworkRouteTablesRequest}

```json
{
  "networkId": "string",
  "pageSize": "int64",
  "pageToken": "string"
}
```

#|
||Field | Description ||
|| networkId | **string**

Required field. ID of the Network resource to list route tables for. ||
|| pageSize | **int64**

The maximum number of results per page that should be returned. If the number of available
results is larger than `pageSize`,
the service returns a [ListNetworkRouteTablesResponse.nextPageToken](#yandex.cloud.vpc.v1.ListNetworkRouteTablesResponse)
that can be used to get the next page of results in subsequent list requests. Default value: 100. ||
|| pageToken | **string**

Page token. Set `pageToken`
to the [ListNetworkRouteTablesResponse.nextPageToken](#yandex.cloud.vpc.v1.ListNetworkRouteTablesResponse)
returned by a previous list request to get the next page of results. ||
|#

## ListNetworkRouteTablesResponse {#yandex.cloud.vpc.v1.ListNetworkRouteTablesResponse}

```json
{
  "routeTables": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "google.protobuf.Timestamp",
      "name": "string",
      "description": "string",
      "labels": "string",
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
          "labels": "string"
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
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|| name | **string**

Name of the route table.
The name must be unique within the folder.
Value must match the regular expression `\|[a-zA-Z]([-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])?`. ||
|| description | **string**

Optional description of the route table. 0-256 characters long. ||
|| labels | **string**

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
|| labels | **string**

Resource labels as `` key:value `` pairs. Maximum of 64 per resource. ||
|#