---
editable: false
apiPlayground:
  - url: https://compute.{{ api-host }}/compute/v1/placementGroups
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        folderId:
          description: |-
            **string**
            ID of the folder to create a placement group in.
            To get a folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request.
          type: string
        name:
          description: |-
            **string**
            Name of the placement group.
          type: string
        description:
          description: |-
            **string**
            Description of the placement group.
          type: string
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            Resource labels as `key:value` pairs.
          type: object
          additionalProperties:
            type: string
        spreadPlacementStrategy:
          description: |-
            **object**
            Anti-affinity placement strategy (`spread`). Instances are distributed over distinct failure domains.
            Includes only one of the fields `spreadPlacementStrategy`, `partitionPlacementStrategy`.
            Placement strategy.
          $ref: '#/definitions/SpreadPlacementStrategy'
        partitionPlacementStrategy:
          description: |-
            **[PartitionPlacementStrategy](#yandex.cloud.compute.v1.PartitionPlacementStrategy)**
            Includes only one of the fields `spreadPlacementStrategy`, `partitionPlacementStrategy`.
            Placement strategy.
          $ref: '#/definitions/PartitionPlacementStrategy'
      additionalProperties: false
      oneOf:
        - required:
            - spreadPlacementStrategy
        - required:
            - partitionPlacementStrategy
    definitions:
      SpreadPlacementStrategy:
        type: object
        properties: {}
      PartitionPlacementStrategy:
        type: object
        properties:
          partitions:
            description: '**string** (int64)'
            type: string
            format: int64
sourcePath: en/_api-ref/compute/v1/api-ref/PlacementGroup/create.md
---

# Compute Cloud API, REST: PlacementGroup.Create

Creates a placement group in the specified folder.

## HTTP request

```
POST https://compute.{{ api-host }}/compute/v1/placementGroups
```

## Body parameters {#yandex.cloud.compute.v1.CreatePlacementGroupRequest}

```json
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "object",
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
|| folderId | **string**

ID of the folder to create a placement group in.

To get a folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request. ||
|| name | **string**

Name of the placement group. ||
|| description | **string**

Description of the placement group. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|| spreadPlacementStrategy | **object**

Anti-affinity placement strategy (`spread`). Instances are distributed over distinct failure domains.

Includes only one of the fields `spreadPlacementStrategy`, `partitionPlacementStrategy`.

Placement strategy. ||
|| partitionPlacementStrategy | **[PartitionPlacementStrategy](#yandex.cloud.compute.v1.PartitionPlacementStrategy)**

Includes only one of the fields `spreadPlacementStrategy`, `partitionPlacementStrategy`.

Placement strategy. ||
|#

## PartitionPlacementStrategy {#yandex.cloud.compute.v1.PartitionPlacementStrategy}

#|
||Field | Description ||
|| partitions | **string** (int64) ||
|#

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": {
    "placementGroupId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
    "id": "string",
    "folderId": "string",
    "createdAt": "string",
    "name": "string",
    "description": "string",
    "labels": "object",
    // Includes only one of the fields `spreadPlacementStrategy`, `partitionPlacementStrategy`
    "spreadPlacementStrategy": "object",
    "partitionPlacementStrategy": {
      "partitions": "string"
    }
    // end of the list of possible fields
  }
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreatePlacementGroupMetadata](#yandex.cloud.compute.v1.CreatePlacementGroupMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[PlacementGroup](#yandex.cloud.compute.v1.PlacementGroup)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## CreatePlacementGroupMetadata {#yandex.cloud.compute.v1.CreatePlacementGroupMetadata}

#|
||Field | Description ||
|| placementGroupId | **string**

ID of the placement group that is being created. ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#

## PlacementGroup {#yandex.cloud.compute.v1.PlacementGroup}

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
|| labels | **object** (map<**string**, **string**>)

Placement group labels as `key:value` pairs. ||
|| spreadPlacementStrategy | **object**

Anti-affinity placement strategy (`spread`). Instances are distributed
over distinct failure domains.

Includes only one of the fields `spreadPlacementStrategy`, `partitionPlacementStrategy`.

Placement strategy. To specify a placement strategy, send the corresponding
field containing approriate structure. ||
|| partitionPlacementStrategy | **[PartitionPlacementStrategy](#yandex.cloud.compute.v1.PartitionPlacementStrategy2)**

Includes only one of the fields `spreadPlacementStrategy`, `partitionPlacementStrategy`.

Placement strategy. To specify a placement strategy, send the corresponding
field containing approriate structure. ||
|#

## PartitionPlacementStrategy {#yandex.cloud.compute.v1.PartitionPlacementStrategy2}

#|
||Field | Description ||
|| partitions | **string** (int64) ||
|#