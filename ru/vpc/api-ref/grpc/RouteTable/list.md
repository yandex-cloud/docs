---
editable: false
sourcePath: en/_api-ref-grpc/vpc/v1/api-ref/grpc/RouteTable/list.md
---

# Virtual Private Cloud API, gRPC: RouteTableService.List

Retrieves the list of RouteTable resources in the specified folder.

## gRPC request

**rpc List ([ListRouteTablesRequest](#yandex.cloud.vpc.v1.ListRouteTablesRequest)) returns ([ListRouteTablesResponse](#yandex.cloud.vpc.v1.ListRouteTablesResponse))**

## ListRouteTablesRequest {#yandex.cloud.vpc.v1.ListRouteTablesRequest}

```json
{
  "folder_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder that the route table belongs to.
To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`,
the service returns a [ListRouteTablesResponse.next_page_token](#yandex.cloud.vpc.v1.ListRouteTablesResponse)
that can be used to get the next page of results in subsequent list requests. Default value: 100. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListRouteTablesResponse.next_page_token](#yandex.cloud.vpc.v1.ListRouteTablesResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression must specify:
1. The field name. Currently you can use filtering only on [RouteTable.name](#yandex.cloud.vpc.v1.RouteTable) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. ||
|#

## ListRouteTablesResponse {#yandex.cloud.vpc.v1.ListRouteTablesResponse}

```json
{
  "route_tables": [
    {
      "id": "string",
      "folder_id": "string",
      "created_at": "google.protobuf.Timestamp",
      "name": "string",
      "description": "string",
      "labels": "map<string, string>",
      "network_id": "string",
      "static_routes": [
        {
          // Includes only one of the fields `destination_prefix`
          "destination_prefix": "string",
          // end of the list of possible fields
          // Includes only one of the fields `next_hop_address`, `gateway_id`
          "next_hop_address": "string",
          "gateway_id": "string",
          // end of the list of possible fields
          "labels": "map<string, string>"
        }
      ]
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| route_tables[] | **[RouteTable](#yandex.cloud.vpc.v1.RouteTable)**

List of RouteTable resources. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListRouteTablesRequest.page_size](#yandex.cloud.vpc.v1.ListRouteTablesRequest), use
the `next_page_token` as the value
for the [ListRouteTablesRequest.page_token](#yandex.cloud.vpc.v1.ListRouteTablesRequest) query parameter
in the next list request. Subsequent list requests will have their own
`next_page_token` to continue paging through the results. ||
|#

## RouteTable {#yandex.cloud.vpc.v1.RouteTable}

A RouteTable resource. For more information, see [Static Routes](/docs/vpc/concepts/routing).

#|
||Field | Description ||
|| id | **string**

ID of the route table. ||
|| folder_id | **string**

ID of the folder that the route table belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
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
|| network_id | **string**

ID of the network the route table belongs to. ||
|| static_routes[] | **[StaticRoute](#yandex.cloud.vpc.v1.StaticRoute)**

List of static routes. ||
|#

## StaticRoute {#yandex.cloud.vpc.v1.StaticRoute}

A StaticRoute resource. For more information, see [Static Routes](/docs/vpc/concepts/routing).

#|
||Field | Description ||
|| destination_prefix | **string**

Destination subnet in CIDR notation

Includes only one of the fields `destination_prefix`. ||
|| next_hop_address | **string**

Next hop IP address

Includes only one of the fields `next_hop_address`, `gateway_id`. ||
|| gateway_id | **string**

Next hop gateway id

Includes only one of the fields `next_hop_address`, `gateway_id`. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `` key:value `` pairs. Maximum of 64 per resource. ||
|#