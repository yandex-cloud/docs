---
editable: false
sourcePath: en/_api-ref-grpc/compute/v1/api-ref/grpc/DiskPlacementGroup/list.md
---

# Compute Cloud API, gRPC: DiskPlacementGroupService.List

Retrieves the list of placement groups in the specified folder.

## gRPC request

**rpc List ([ListDiskPlacementGroupsRequest](#yandex.cloud.compute.v1.ListDiskPlacementGroupsRequest)) returns ([ListDiskPlacementGroupsResponse](#yandex.cloud.compute.v1.ListDiskPlacementGroupsResponse))**

## ListDiskPlacementGroupsRequest {#yandex.cloud.compute.v1.ListDiskPlacementGroupsRequest}

```json
{
  "folder_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "filter": "string",
  "order_by": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder to list placement groups in.
To get the folder ID, use [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`,
the service returns a [ListDiskPlacementGroupsResponse.next_page_token](#yandex.cloud.compute.v1.ListDiskPlacementGroupsResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| page_token | **string**

Page token. To get the next page of results,
set `page_token` to the [ListDiskPlacementGroupsResponse.next_page_token](#yandex.cloud.compute.v1.ListDiskPlacementGroupsResponse)
returned by a previous list request. ||
|| filter | **string**

A filter expression that filters resources listed in the response.
The expression consists of one or more conditions united by `AND` operator: `<condition1> [AND <condition2> [<...> AND <conditionN>]]`.

Each condition has the form `<field> <operator> <value>`, where:
1. `<field>` is the field name. Currently you can use filtering only on the limited number of fields.
2. `<operator>` is a logical operator, one of `=`, `!=`, `IN`, `NOT IN`.
3. `<value>` represents a value.
String values should be written in double (`"`) or single (`'`) quotes. C-style escape sequences are supported (`\"` turns to `"`, `\'` to `'`, `\\` to backslash). ||
|| order_by | **string**

By which column the listing should be ordered and in which direction,
format is "createdAt desc". "id asc" if omitted.
The default sorting order is ascending ||
|#

## ListDiskPlacementGroupsResponse {#yandex.cloud.compute.v1.ListDiskPlacementGroupsResponse}

```json
{
  "disk_placement_groups": [
    {
      "id": "string",
      "folder_id": "string",
      "created_at": "google.protobuf.Timestamp",
      "name": "string",
      "description": "string",
      "labels": "string",
      "zone_id": "string",
      "status": "Status",
      // Includes only one of the fields `spread_placement_strategy`, `partition_placement_strategy`
      "spread_placement_strategy": "DiskSpreadPlacementStrategy",
      "partition_placement_strategy": {
        "partitions": "int64"
      }
      // end of the list of possible fields
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| disk_placement_groups[] | **[DiskPlacementGroup](#yandex.cloud.compute.v1.DiskPlacementGroup)**

Lists placement groups for the specified folder. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListDiskPlacementGroupsRequest.page_size](#yandex.cloud.compute.v1.ListDiskPlacementGroupsRequest), use
`next_page_token` as the value
for the [ListDiskPlacementGroupsRequest.page_token](#yandex.cloud.compute.v1.ListDiskPlacementGroupsRequest) query parameter
in the next list request. Each subsequent list request will have its own
`next_page_token` to continue paging through the results. ||
|#

## DiskPlacementGroup {#yandex.cloud.compute.v1.DiskPlacementGroup}

#|
||Field | Description ||
|| id | **string**

ID of the placement group. ||
|| folder_id | **string**

ID of the folder that the placement group belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|| name | **string**

Name of the placement group.
The name is unique within the folder. ||
|| description | **string**

Description of the placement group. ||
|| labels | **string**

Resource labels as `key:value` pairs. ||
|| zone_id | **string**

ID of the availability zone where the placement group resides. ||
|| status | enum **Status**

Current status of the placement group

- `STATUS_UNSPECIFIED`
- `CREATING`
- `READY`
- `DELETING` ||
|| spread_placement_strategy | **[DiskSpreadPlacementStrategy](#yandex.cloud.compute.v1.DiskSpreadPlacementStrategy)**

Distribute disks over distinct failure domains.

Includes only one of the fields `spread_placement_strategy`, `partition_placement_strategy`.

Placement strategy. ||
|| partition_placement_strategy | **[DiskPartitionPlacementStrategy](#yandex.cloud.compute.v1.DiskPartitionPlacementStrategy)**

Distribute disks over partitions.

Includes only one of the fields `spread_placement_strategy`, `partition_placement_strategy`.

Placement strategy. ||
|#

## DiskSpreadPlacementStrategy {#yandex.cloud.compute.v1.DiskSpreadPlacementStrategy}

#|
||Field | Description ||
|| Empty | > ||
|#

## DiskPartitionPlacementStrategy {#yandex.cloud.compute.v1.DiskPartitionPlacementStrategy}

#|
||Field | Description ||
|| partitions | **int64** ||
|#