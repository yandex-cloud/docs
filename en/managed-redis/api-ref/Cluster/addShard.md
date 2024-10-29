---
editable: false
sourcePath: en/_api-ref/mdb/redis/v1/api-ref/Cluster/addShard.md
---

# Managed Service for Redis API, REST: Cluster.AddShard {#AddShard}

Creates a new shard.

## HTTP request

```
POST https://{{ api-host-mdb }}/managed-redis/v1/clusters/{clusterId}/shards
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the Redis cluster to create a shard in.
To get the cluster ID use a [ClusterService.List](/docs/managed-redis/api-ref/Cluster/list#List) request. ||
|#

## Body parameters {#yandex.cloud.mdb.redis.v1.AddClusterShardRequest}

```json
{
  "shardName": "string",
  "hostSpecs": [
    {
      "zoneId": "string",
      "subnetId": "string",
      "shardName": "string",
      "replicaPriority": "string",
      "assignPublicIp": "boolean"
    }
  ]
}
```

#|
||Field | Description ||
|| shardName | **string**

Required field. Name of the shard.
The name must be unique within the cluster. ||
|| hostSpecs[] | **[HostSpec](#yandex.cloud.mdb.redis.v1.HostSpec)**

Configurations for Redis hosts that should be created with the shard.
Must contain at least one element. ||
|#

## HostSpec {#yandex.cloud.mdb.redis.v1.HostSpec}

#|
||Field | Description ||
|| zoneId | **string**

ID of the availability zone where the host resides.
To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/Zone/list#List) request. ||
|| subnetId | **string**

ID of the subnet that the host should belong to. This subnet should be a part
of the network that the cluster belongs to.
The ID of the network is set in the field [Cluster.networkId](/docs/managed-redis/api-ref/Cluster/get#yandex.cloud.mdb.redis.v1.Cluster). ||
|| shardName | **string**

ID of the Redis shard the host belongs to.
To get the shard ID use a [ClusterService.ListShards](/docs/managed-redis/api-ref/Cluster/listShards#ListShards) request. ||
|| replicaPriority | **string** (int64)

A replica with a low priority number is considered better for promotion.
A replica with priority of 0 will never be selected by Redis Sentinel for promotion.
Works only for non-sharded clusters. Default value is 100. ||
|| assignPublicIp | **boolean**

Whether the host should get a public IP address on creation.

Possible values:
* false - don't assign a public IP to the host.
* true - the host should have a public IP address. ||
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
    "shardName": "string"
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
    "clusterId": "string"
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
|| metadata | **[AddClusterShardMetadata](#yandex.cloud.mdb.redis.v1.AddClusterShardMetadata)**

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
|| response | **[Shard](#yandex.cloud.mdb.redis.v1.Shard)**

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

## AddClusterShardMetadata {#yandex.cloud.mdb.redis.v1.AddClusterShardMetadata}

#|
||Field | Description ||
|| clusterId | **string**

ID of the Redis cluster that a shard is being added to. ||
|| shardName | **string**

Name of the Redis shard that is being created. ||
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

## Shard {#yandex.cloud.mdb.redis.v1.Shard}

#|
||Field | Description ||
|| name | **string**

Name of the Redis shard. The shard name is assigned by user at creation time, and cannot be changed.
1-63 characters long. ||
|| clusterId | **string**

ID of the Redis cluster the shard belongs to. The ID is assigned by MDB at creation time. ||
|#