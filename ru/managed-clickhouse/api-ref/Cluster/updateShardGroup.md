---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/{clusterId}/shardGroups/{shardGroupName}
    method: patch
    path:
      type: object
      properties:
        clusterId:
          description: |-
            **string**
            Required field. ID of the ClickHouse cluster that contains the shard group to update.
            To get the cluster ID, make a [ClusterService.List](/docs/managed-clickhouse/api-ref/Cluster/list#List) request.
          type: string
        shardGroupName:
          description: |-
            **string**
            Required field. Name of the shard group that should be updated.
            To get the name, make a [ClusterService.ListShardGroups](/docs/managed-clickhouse/api-ref/Cluster/listShardGroups#ListShardGroups) request.
          pattern: '[a-zA-Z0-9_-]*'
          type: string
      required:
        - clusterId
        - shardGroupName
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        updateMask:
          description: |-
            **string** (field-mask)
            A comma-separated names off ALL fields to be updated.
            Only the specified fields will be changed. The others will be left untouched.
            If the field is specified in `` updateMask `` and no value for that field was sent in the request,
            the field's value will be reset to the default. The default value for most fields is null or 0.
            If `` updateMask `` is not sent in the request, all fields' values will be updated.
            Fields specified in the request will be updated to provided values.
            The rest of the fields will be reset to the default.
          type: string
          format: field-mask
        description:
          description: |-
            **string**
            Updated description of the shard group. 0-256 characters long.
          type: string
        shardNames:
          description: |-
            **string**
            Updated list of shard names that belongs to the shard group.
          type: array
          items:
            type: string
      additionalProperties: false
    definitions: null
sourcePath: en/_api-ref/mdb/clickhouse/v1/api-ref/Cluster/updateShardGroup.md
---

# Managed Service for ClickHouse API, REST: Cluster.UpdateShardGroup

Updates the specified shard group.

## HTTP request

```
PATCH https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/{clusterId}/shardGroups/{shardGroupName}
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the ClickHouse cluster that contains the shard group to update.

To get the cluster ID, make a [ClusterService.List](/docs/managed-clickhouse/api-ref/Cluster/list#List) request. ||
|| shardGroupName | **string**

Required field. Name of the shard group that should be updated.

To get the name, make a [ClusterService.ListShardGroups](/docs/managed-clickhouse/api-ref/Cluster/listShardGroups#ListShardGroups) request. ||
|#

## Body parameters {#yandex.cloud.mdb.clickhouse.v1.UpdateClusterShardGroupRequest}

```json
{
  "updateMask": "string",
  "description": "string",
  "shardNames": [
    "string"
  ]
}
```

#|
||Field | Description ||
|| updateMask | **string** (field-mask)

A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
|| description | **string**

Updated description of the shard group. 0-256 characters long. ||
|| shardNames[] | **string**

Updated list of shard names that belongs to the shard group. ||
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
    "clusterId": "string",
    "shardGroupName": "string"
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
    "name": "string",
    "clusterId": "string",
    "description": "string",
    "shardNames": [
      "string"
    ]
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
|| metadata | **[UpdateClusterShardGroupMetadata](#yandex.cloud.mdb.clickhouse.v1.UpdateClusterShardGroupMetadata)**

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
|| response | **[ShardGroup](#yandex.cloud.mdb.clickhouse.v1.ShardGroup)**

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

## UpdateClusterShardGroupMetadata {#yandex.cloud.mdb.clickhouse.v1.UpdateClusterShardGroupMetadata}

#|
||Field | Description ||
|| clusterId | **string**

ID of the cluster that contains the shard group being updated. ||
|| shardGroupName | **string**

Name of the shard group that is being updated. ||
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

## ShardGroup {#yandex.cloud.mdb.clickhouse.v1.ShardGroup}

#|
||Field | Description ||
|| name | **string**

Name of the shard group. ||
|| clusterId | **string**

ID of the ClickHouse cluster that the shard group belongs to. ||
|| description | **string**

Description of the shard group. 0-256 characters long. ||
|| shardNames[] | **string**

List of shard names contained in the shard group. ||
|#