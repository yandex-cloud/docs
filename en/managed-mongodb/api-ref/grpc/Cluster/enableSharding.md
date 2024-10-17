---
editable: false
sourcePath: en/_api-ref-grpc/mdb/mongodb/v1/api-ref/grpc/Cluster/enableSharding.md
---

# Managed Service for MongoDB API, gRPC: ClusterService.EnableSharding {#EnableSharding}

Enables sharding for the cluster:
creates 3 mongoinfra (or 3 mongocfg and 2 mongos) hosts
that would support adding and using shards in the cluster.

## gRPC request

**rpc EnableSharding ([EnableClusterShardingRequest](#yandex.cloud.mdb.mongodb.v1.EnableClusterShardingRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## EnableClusterShardingRequest {#yandex.cloud.mdb.mongodb.v1.EnableClusterShardingRequest}

```json
{
  "clusterId": "string",
  "mongocfg": {
    "resources": {
      "resourcePresetId": "string",
      "diskSize": "int64",
      "diskTypeId": "string"
    }
  },
  "mongos": {
    "resources": {
      "resourcePresetId": "string",
      "diskSize": "int64",
      "diskTypeId": "string"
    }
  },
  "hostSpecs": [
    {
      "zoneId": "string",
      "subnetId": "string",
      "assignPublicIp": "bool",
      "type": "Type",
      "shardName": "string",
      "hidden": "google.protobuf.BoolValue",
      "secondaryDelaySecs": "google.protobuf.Int64Value",
      "priority": "google.protobuf.DoubleValue",
      "tags": "string"
    }
  ],
  "mongoinfra": {
    "resources": {
      "resourcePresetId": "string",
      "diskSize": "int64",
      "diskTypeId": "string"
    }
  }
}
```

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the MongoDB cluster to enable sharding for. ||
|| mongocfg | **[MongoCfg](#yandex.cloud.mdb.mongodb.v1.EnableClusterShardingRequest.MongoCfg)**

mongocfg specification for sharding. ||
|| mongos | **[Mongos](#yandex.cloud.mdb.mongodb.v1.EnableClusterShardingRequest.Mongos)**

mongos specification for sharding. ||
|| hostSpecs[] | **[HostSpec](#yandex.cloud.mdb.mongodb.v1.HostSpec)**

Configurations for mongos and mongocfg hosts. ||
|| mongoinfra | **[MongoInfra](#yandex.cloud.mdb.mongodb.v1.EnableClusterShardingRequest.MongoInfra)**

mongos specification for sharding. ||
|#

## MongoCfg {#yandex.cloud.mdb.mongodb.v1.EnableClusterShardingRequest.MongoCfg}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Required field. Resources for mongocfg hosts. ||
|#

## Resources {#yandex.cloud.mdb.mongodb.v1.Resources}

#|
||Field | Description ||
|| resourcePresetId | **string**

ID of the preset for computational resources available to a host (CPU, memory etc.).
All available presets are listed in the [documentation](/docs/managed-mongodb/concepts/instance-types). ||
|| diskSize | **int64**

Volume of the storage available to a host, in bytes. ||
|| diskTypeId | **string**

Type of the storage environment for the host.
Possible values:
* network-hdd - network HDD drive,
* network-ssd - network SSD drive,
* local-ssd - local SSD storage. ||
|#

## Mongos {#yandex.cloud.mdb.mongodb.v1.EnableClusterShardingRequest.Mongos}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Required field. Resources for mongos hosts. ||
|#

## HostSpec {#yandex.cloud.mdb.mongodb.v1.HostSpec}

#|
||Field | Description ||
|| zoneId | **string**

ID of the availability zone where the host resides.
To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/Zone/list#List) request. ||
|| subnetId | **string**

ID of the subnet that the host should belong to. This subnet should be a part
of the network that the cluster belongs to.
The network ID is set in the [Cluster.networkId](/docs/managed-mongodb/api-ref/grpc/Cluster/get#yandex.cloud.mdb.mongodb.v1.Cluster) field. ||
|| assignPublicIp | **bool**

Whether the host should get a public IP address on creation.

After a host has been created, this setting cannot be changed. To remove an assigned public IP, or to assign
a public IP to a host without one, recreate the host with `assignPublicIp` set as needed.

Possible values:
* false - don't assign a public IP to the host.
* true - the host should have a public IP address. ||
|| type | enum **Type**

Type of the host to be deployed.

- `TYPE_UNSPECIFIED`: Type of the host is unspecified. Default value.
- `MONGOD`: A mongod host.
- `MONGOS`: A mongos host.
- `MONGOCFG`: A mongocfg host.
- `MONGOINFRA`: A mongoinfra (mongos+mongocfg) host. ||
|| shardName | **string**

Name of the shard that the host belongs to. ||
|| hidden | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Is host hidden in replSet ||
|| secondaryDelaySecs | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The number of seconds "behind" the primary that this replica set member should "lag" ||
|| priority | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

Priority of host for the election in replSet ||
|| tags | **string**

Host tags ||
|#

## MongoInfra {#yandex.cloud.mdb.mongodb.v1.EnableClusterShardingRequest.MongoInfra}

#|
||Field | Description ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Required field. Resources for mongoinfra (mongos+mongocfg) hosts. ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "google.protobuf.Timestamp",
  "createdBy": "string",
  "modifiedAt": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "clusterId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": "google.protobuf.Empty"
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
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[EnableClusterShardingMetadata](#yandex.cloud.mdb.mongodb.v1.EnableClusterShardingMetadata)**

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
|| response | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**

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

## EnableClusterShardingMetadata {#yandex.cloud.mdb.mongodb.v1.EnableClusterShardingMetadata}

#|
||Field | Description ||
|| clusterId | **string**

ID of the MongoDB cluster that sharding is being enabled for. ||
|#