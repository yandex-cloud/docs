---
editable: false
sourcePath: en/_api-ref-grpc/mdb/redis/v1/api-ref/grpc/Cluster/addShard.md
---

# Managed Service for Redis API, gRPC: ClusterService.AddShard

Creates a new shard.

## gRPC request

**rpc AddShard ([AddClusterShardRequest](#yandex.cloud.mdb.redis.v1.AddClusterShardRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## AddClusterShardRequest {#yandex.cloud.mdb.redis.v1.AddClusterShardRequest}

```json
{
  "cluster_id": "string",
  "shard_name": "string",
  "host_specs": [
    {
      "zone_id": "string",
      "subnet_id": "string",
      "shard_name": "string",
      "replica_priority": "google.protobuf.Int64Value",
      "assign_public_ip": "bool"
    }
  ]
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the Redis cluster to create a shard in.
To get the cluster ID use a [ClusterService.List](/docs/managed-redis/api-ref/grpc/Cluster/list#List) request. ||
|| shard_name | **string**

Required field. Name of the shard.
The name must be unique within the cluster. ||
|| host_specs[] | **[HostSpec](#yandex.cloud.mdb.redis.v1.HostSpec)**

Configurations for Redis hosts that should be created with the shard.
Must contain at least one element. ||
|#

## HostSpec {#yandex.cloud.mdb.redis.v1.HostSpec}

#|
||Field | Description ||
|| zone_id | **string**

ID of the availability zone where the host resides.
To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/Zone/list#List) request. ||
|| subnet_id | **string**

ID of the subnet that the host should belong to. This subnet should be a part
of the network that the cluster belongs to.
The ID of the network is set in the field [Cluster.network_id](/docs/managed-redis/api-ref/grpc/Cluster/get#yandex.cloud.mdb.redis.v1.Cluster). ||
|| shard_name | **string**

ID of the Redis shard the host belongs to.
To get the shard ID use a [ClusterService.ListShards](/docs/managed-redis/api-ref/grpc/Cluster/listShards#ListShards) request. ||
|| replica_priority | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

A replica with a low priority number is considered better for promotion.
A replica with priority of 0 will never be selected by Redis Sentinel for promotion.
Works only for non-sharded clusters. Default value is 100. ||
|| assign_public_ip | **bool**

Whether the host should get a public IP address on creation.

Possible values:
* false - don't assign a public IP to the host.
* true - the host should have a public IP address. ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "cluster_id": "string",
    "shard_name": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "name": "string",
    "cluster_id": "string"
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
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[AddClusterShardMetadata](#yandex.cloud.mdb.redis.v1.AddClusterShardMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

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
|| cluster_id | **string**

ID of the Redis cluster that a shard is being added to. ||
|| shard_name | **string**

Name of the Redis shard that is being created. ||
|#

## Shard {#yandex.cloud.mdb.redis.v1.Shard}

#|
||Field | Description ||
|| name | **string**

Name of the Redis shard. The shard name is assigned by user at creation time, and cannot be changed.
1-63 characters long. ||
|| cluster_id | **string**

ID of the Redis cluster the shard belongs to. The ID is assigned by MDB at creation time. ||
|#