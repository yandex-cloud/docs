---
editable: false
sourcePath: en/_api-ref/mdb/mongodb/v1/api-ref/Cluster/enableSharding.md
---

# Managed Service for MongoDB API, REST: Cluster.EnableSharding {#EnableSharding}

Enables sharding for the cluster:
creates 3 mongoinfra (or 3 mongocfg and 2 mongos) hosts
that would support adding and using shards in the cluster.

## HTTP request

```
POST https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/{clusterId}:enableSharding
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the MongoDB cluster to enable sharding for. ||
|#

## Body parameters {#yandex.cloud.mdb.mongodb.v1.EnableClusterShardingRequest}

```json
{
  "mongocfg": {
    "resources": {
      "resourcePresetId": "string",
      "diskSize": "string",
      "diskTypeId": "string"
    }
  },
  "mongos": {
    "resources": {
      "resourcePresetId": "string",
      "diskSize": "string",
      "diskTypeId": "string"
    }
  },
  "hostSpecs": [
    {
      "zoneId": "string",
      "subnetId": "string",
      "assignPublicIp": "boolean",
      "type": "string",
      "shardName": "string",
      "hidden": "boolean",
      "secondaryDelaySecs": "string",
      "priority": "number",
      "tags": "string"
    }
  ],
  "mongoinfra": {
    "resources": {
      "resourcePresetId": "string",
      "diskSize": "string",
      "diskTypeId": "string"
    }
  }
}
```

#|
||Field | Description ||
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
|| diskSize | **string** (int64)

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
To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/Zone/list#List) request. ||
|| subnetId | **string**

ID of the subnet that the host should belong to. This subnet should be a part
of the network that the cluster belongs to.
The network ID is set in the [Cluster.networkId](/docs/managed-mongodb/api-ref/Cluster/get#yandex.cloud.mdb.mongodb.v1.Cluster) field. ||
|| assignPublicIp | **boolean**

Whether the host should get a public IP address on creation.

After a host has been created, this setting cannot be changed. To remove an assigned public IP, or to assign
a public IP to a host without one, recreate the host with `assignPublicIp` set as needed.

Possible values:
* false - don't assign a public IP to the host.
* true - the host should have a public IP address. ||
|| type | **enum** (Type)

Type of the host to be deployed.

- `TYPE_UNSPECIFIED`: Type of the host is unspecified. Default value.
- `MONGOD`: A mongod host.
- `MONGOS`: A mongos host.
- `MONGOCFG`: A mongocfg host.
- `MONGOINFRA`: A mongoinfra (mongos+mongocfg) host. ||
|| shardName | **string**

Name of the shard that the host belongs to. ||
|| hidden | **boolean**

Is host hidden in replSet ||
|| secondaryDelaySecs | **string** (int64)

The number of seconds "behind" the primary that this replica set member should "lag" ||
|| priority | **number** (double)

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
    "clusterId": "string"
  },
  // Includes only one of the fields `error`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
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
|| metadata | **[EnableClusterShardingMetadata](#yandex.cloud.mdb.mongodb.v1.EnableClusterShardingMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`.

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