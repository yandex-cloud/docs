---
editable: false
sourcePath: en/_api-ref-grpc/compute/v1/api-ref/grpc/PlacementGroup/list.md
---

# Compute Cloud API, gRPC: PlacementGroupService.List {#List}

Retrieves the list of placement groups in the specified folder.

## gRPC request

**rpc List ([ListPlacementGroupsRequest](#yandex.cloud.compute.v1.ListPlacementGroupsRequest)) returns ([ListPlacementGroupsResponse](#yandex.cloud.compute.v1.ListPlacementGroupsResponse))**

## ListPlacementGroupsRequest {#yandex.cloud.compute.v1.ListPlacementGroupsRequest}

```json
{
  "folderId": "string",
  "pageSize": "int64",
  "pageToken": "string",
  "filter": "string",
  "orderBy": "string"
}
```

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to list placement groups in.

To get the folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| pageSize | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListPlacementGroupsResponse.nextPageToken](#yandex.cloud.compute.v1.ListPlacementGroupsResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token. To get the next page of results,
set `pageToken` to the [ListPlacementGroupsResponse.nextPageToken](#yandex.cloud.compute.v1.ListPlacementGroupsResponse)
returned by a previous list request. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression consists of one or more conditions united by `AND` operator: `<condition1> [AND <condition2> [<...> AND <conditionN>]]`.

Each condition has the form `<field> <operator> <value>`, where:
1. `<field>` is the field name. Currently you can use filtering only on the limited number of fields.
2. `<operator>` is a logical operator, one of `=`, `!=`, `IN`, `NOT IN`.
3. `<value>` represents a value.
String values should be written in double (`"`) or single (`'`) quotes. C-style escape sequences are supported (`\"` turns to `"`, `\'` to `'`, `\\` to backslash). ||
|| orderBy | **string**

By which column the listing should be ordered and in which direction,
format is "createdAt desc". "id asc" if omitted.
The default sorting order is ascending ||
|#

## ListPlacementGroupsResponse {#yandex.cloud.compute.v1.ListPlacementGroupsResponse}

```json
{
  "placementGroups": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "google.protobuf.Timestamp",
      "name": "string",
      "description": "string",
      "labels": "string",
      // Includes only one of the fields `spreadPlacementStrategy`, `partitionPlacementStrategy`
      "spreadPlacementStrategy": "SpreadPlacementStrategy",
      "partitionPlacementStrategy": {
        "partitions": "int64"
      }
      // end of the list of possible fields
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| placementGroups[] | **[PlacementGroup](#yandex.cloud.compute.v1.PlacementGroup)**

Lists placement groups in the specified folder. ||
|| nextPageToken | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListPlacementGroupsRequest.pageSize](#yandex.cloud.compute.v1.ListPlacementGroupsRequest), use `next_page_token` as the value
for the [ListPlacementGroupsRequest.pageToken](#yandex.cloud.compute.v1.ListPlacementGroupsRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## PlacementGroup {#yandex.cloud.compute.v1.PlacementGroup}

#|
||Field | Description ||
|| id | **string**

ID of the placement group. Generated at creation time. ||
|| folderId | **string**

ID of the folder that the placement group belongs to. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| name | **string**

Name of the placement group.
The name is unique within the folder. ||
|| description | **string**

Description of the placement group. 0-256 characters long. ||
|| labels | **string**

Placement group labels as `key:value` pairs. ||
|| spreadPlacementStrategy | **[SpreadPlacementStrategy](#yandex.cloud.compute.v1.SpreadPlacementStrategy)**

Anti-affinity placement strategy (`spread`). Instances are distributed
over distinct failure domains.

Includes only one of the fields `spreadPlacementStrategy`, `partitionPlacementStrategy`.

Placement strategy. To specify a placement strategy, send the corresponding
field containing approriate structure. ||
|| partitionPlacementStrategy | **[PartitionPlacementStrategy](#yandex.cloud.compute.v1.PartitionPlacementStrategy)**

Includes only one of the fields `spreadPlacementStrategy`, `partitionPlacementStrategy`.

Placement strategy. To specify a placement strategy, send the corresponding
field containing approriate structure. ||
|#

## SpreadPlacementStrategy {#yandex.cloud.compute.v1.SpreadPlacementStrategy}

This is an empty structure that must be passed to explicitly
specify the required placement strategy.

#|
||Field | Description ||
|| Empty | > ||
|#

## PartitionPlacementStrategy {#yandex.cloud.compute.v1.PartitionPlacementStrategy}

#|
||Field | Description ||
|| partitions | **int64** ||
|#