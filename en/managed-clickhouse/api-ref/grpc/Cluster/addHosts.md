---
editable: false
sourcePath: en/_api-ref-grpc/mdb/clickhouse/v1/api-ref/grpc/Cluster/addHosts.md
---

# Managed Service for ClickHouse API, gRPC: ClusterService.AddHosts

Creates new hosts for a cluster.

## gRPC request

**rpc AddHosts ([AddClusterHostsRequest](#yandex.cloud.mdb.clickhouse.v1.AddClusterHostsRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## AddClusterHostsRequest {#yandex.cloud.mdb.clickhouse.v1.AddClusterHostsRequest}

```json
{
  "cluster_id": "string",
  "host_specs": [
    {
      "zone_id": "string",
      "type": "Type",
      "subnet_id": "string",
      "assign_public_ip": "bool",
      "shard_name": "string"
    }
  ],
  "copy_schema": "google.protobuf.BoolValue"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the ClickHouse cluster to add hosts to.
To get the ClickHouse cluster ID, use a [ClusterService.List](/docs/managed-clickhouse/api-ref/grpc/Cluster/list#List) request. ||
|| host_specs[] | **[HostSpec](#yandex.cloud.mdb.clickhouse.v1.HostSpec)**

Configurations for ClickHouse hosts that should be added to the cluster. ||
|| copy_schema | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Whether to copy schema to new ClickHouse hosts from replicas. ||
|#

## HostSpec {#yandex.cloud.mdb.clickhouse.v1.HostSpec}

#|
||Field | Description ||
|| zone_id | **string**

ID of the availability zone where the host resides.
To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/Zone/list#List) request. ||
|| type | enum **Type**

Required field. Type of the host to be deployed.

- `TYPE_UNSPECIFIED`: Host type is unspecified. Default value.
- `CLICKHOUSE`: ClickHouse host.
- `ZOOKEEPER`: ZooKeeper host. ||
|| subnet_id | **string**

ID of the subnet that the host should belong to. This subnet should be a part
of the network that the cluster belongs to.
The ID of the network is set in the [Cluster.network_id](/docs/managed-clickhouse/api-ref/grpc/Cluster/get#yandex.cloud.mdb.clickhouse.v1.Cluster) field. ||
|| assign_public_ip | **bool**

Whether the host should get a public IP address on creation.

After a host has been created, this setting cannot be changed. To remove an assigned public IP, or to assign
a public IP to a host without one, recreate the host with `assign_public_ip` set as needed.

Possible values:
* false - don't assign a public IP to the host.
* true - the host should have a public IP address. ||
|| shard_name | **string**

Name of the shard that the host is assigned to. ||
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
    "host_names": [
      "string"
    ]
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
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[AddClusterHostsMetadata](#yandex.cloud.mdb.clickhouse.v1.AddClusterHostsMetadata)**

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

## AddClusterHostsMetadata {#yandex.cloud.mdb.clickhouse.v1.AddClusterHostsMetadata}

#|
||Field | Description ||
|| cluster_id | **string**

ID of the ClickHouse cluster to which the hosts are being added. ||
|| host_names[] | **string**

Names of hosts that are being added to the cluster. ||
|#