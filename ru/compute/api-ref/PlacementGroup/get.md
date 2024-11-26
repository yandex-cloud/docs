---
editable: false
sourcePath: en/_api-ref/compute/v1/api-ref/PlacementGroup/get.md
---

# Compute Cloud API, REST: PlacementGroup.Get

Returns the specified placement group.

To get the list of all available placement groups, make a [List](/docs/compute/api-ref/PlacementGroup/list#List) request.

## HTTP request

```
GET https://compute.{{ api-host }}/compute/v1/placementGroups/{placementGroupId}
```

## Path parameters

#|
||Field | Description ||
|| placementGroupId | **string**

Required field. ID of the placement group to return.

To get a placement group ID make a [PlacementGroupService.List](/docs/compute/api-ref/PlacementGroup/list#List) request. ||
|#

## Response {#yandex.cloud.compute.v1.PlacementGroup}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "name": "string",
  "description": "string",
  "labels": "string",
  // Includes only one of the fields `spreadPlacementStrategy`, `partitionPlacementStrategy`
  "spreadPlacementStrategy": "object",
  "partitionPlacementStrategy": {
    "partitions": "string"
  }
  // end of the list of possible fields
}
```

#|
||Field | Description ||
|| id | **string**

ID of the placement group. Generated at creation time. ||
|| folderId | **string**

ID of the folder that the placement group belongs to. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| name | **string**

Name of the placement group.
The name is unique within the folder. ||
|| description | **string**

Description of the placement group. 0-256 characters long. ||
|| labels | **string**

Placement group labels as `key:value` pairs. ||
|| spreadPlacementStrategy | **object**

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

## PartitionPlacementStrategy {#yandex.cloud.compute.v1.PartitionPlacementStrategy}

#|
||Field | Description ||
|| partitions | **string** (int64) ||
|#