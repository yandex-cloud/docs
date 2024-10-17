---
editable: false
sourcePath: en/_api-ref-grpc/mdb/postgresql/v1/api-ref/grpc/Cluster/updateHosts.md
---

# Managed Service for PostgreSQL API, gRPC: ClusterService.UpdateHosts {#UpdateHosts}

Updates the specified hosts.

## gRPC request

**rpc UpdateHosts ([UpdateClusterHostsRequest](#yandex.cloud.mdb.postgresql.v1.UpdateClusterHostsRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateClusterHostsRequest {#yandex.cloud.mdb.postgresql.v1.UpdateClusterHostsRequest}

```json
{
  "clusterId": "string",
  "updateHostSpecs": [
    {
      "hostName": "string",
      "replicationSource": "string",
      "priority": "google.protobuf.Int64Value",
      "configSpec": {
        // Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`
        "postgresqlConfig_9_6": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig9_6",
        "postgresqlConfig_10_1c": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig10_1C",
        "postgresqlConfig_10": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig10",
        "postgresqlConfig_11": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig11",
        "postgresqlConfig_11_1c": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig11_1C",
        "postgresqlConfig_12": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig12",
        "postgresqlConfig_12_1c": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig12_1C",
        "postgresqlConfig_13": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig13",
        "postgresqlConfig_13_1c": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig13_1C",
        "postgresqlConfig_14": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig14",
        "postgresqlConfig_14_1c": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig14_1C",
        "postgresqlConfig_15": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig15",
        "postgresqlConfig_15_1c": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig15_1C",
        "postgresqlConfig_16": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig16",
        "postgresqlConfig_16_1c": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig16_1C"
        // end of the list of possible fields
      },
      "updateMask": "google.protobuf.FieldMask",
      "assignPublicIp": "bool"
    }
  ]
}
```

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the PostgreSQL cluster to update hosts in.
To get the PostgreSQL cluster ID, use a [ClusterService.List](/docs/managed-postgresql/api-ref/grpc/Cluster/list#List) request. ||
|| updateHostSpecs[] | **[UpdateHostSpec](#yandex.cloud.mdb.postgresql.v1.UpdateHostSpec)**

New configurations to apply to hosts. ||
|#

## UpdateHostSpec {#yandex.cloud.mdb.postgresql.v1.UpdateHostSpec}

#|
||Field | Description ||
|| hostName | **string**

Required field. Name of the host to update.
To get the PostgreSQL host name, use a [ClusterService.ListHosts](/docs/managed-postgresql/api-ref/grpc/Cluster/listHosts#ListHosts) request. ||
|| replicationSource | **string**

[Host.name](/docs/managed-postgresql/api-ref/grpc/Cluster/listHosts#yandex.cloud.mdb.postgresql.v1.Host) of the host to be used as the replication source (for cascading replication).
To get the PostgreSQL host name, use a [ClusterService.ListHosts](/docs/managed-postgresql/api-ref/grpc/Cluster/listHosts#ListHosts) request. ||
|| priority | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The host with the highest priority is the synchronous replica. All others are asynchronous.
The synchronous replica replaces the master when needed.

When a replica becomes the master, its priority is ignored. ||
|| configSpec | **[ConfigHostSpec](#yandex.cloud.mdb.postgresql.v1.ConfigHostSpec)**

Configuration of a PostgreSQL server for the host. ||
|| updateMask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask that specifies which fields of the PostgreSQL host should be updated. ||
|| assignPublicIp | **bool**

Whether the host should get a public IP address on creation. ||
|#

## ConfigHostSpec {#yandex.cloud.mdb.postgresql.v1.ConfigHostSpec}

#|
||Field | Description ||
|| postgresqlConfig_9_6 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig9_6](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host9_6.proto)**

Configuration for a host with PostgreSQL 9.6 server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`. ||
|| postgresqlConfig_10_1c | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig10_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host10_1c.proto)**

Configuration for a host with PostgreSQL 10 1C server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`. ||
|| postgresqlConfig_10 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig10](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host10.proto)**

Configuration for a host with PostgreSQL 10 server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`. ||
|| postgresqlConfig_11 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig11](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host11.proto)**

Configuration for a host with PostgreSQL 11 server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`. ||
|| postgresqlConfig_11_1c | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig11_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host11_1c.proto)**

Configuration for a host with PostgreSQL 11 1C server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`. ||
|| postgresqlConfig_12 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig12](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host12.proto)**

Configuration for a host with PostgreSQL 12 server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`. ||
|| postgresqlConfig_12_1c | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig12_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host12_1c.proto)**

Configuration for a host with PostgreSQL 12 1C server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`. ||
|| postgresqlConfig_13 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig13](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host13.proto)**

Configuration for a host with PostgreSQL 13 server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`. ||
|| postgresqlConfig_13_1c | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig13_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host13_1c.proto)**

Configuration for a host with PostgreSQL 13 1C server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`. ||
|| postgresqlConfig_14 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig14](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host14.proto)**

Configuration for a host with PostgreSQL 14 server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`. ||
|| postgresqlConfig_14_1c | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig14_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host14_1c.proto)**

Configuration for a host with PostgreSQL 14 1C server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`. ||
|| postgresqlConfig_15 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig15](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host15.proto)**

Configuration for a host with PostgreSQL 15 server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`. ||
|| postgresqlConfig_15_1c | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig15_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host15_1c.proto)**

Configuration for a host with PostgreSQL 15 1C server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`. ||
|| postgresqlConfig_16 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig16](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host16.proto)**

Configuration for a host with PostgreSQL 16 server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`. ||
|| postgresqlConfig_16_1c | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig16_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host16_1c.proto)**

Configuration for a host with PostgreSQL 16 1C server deployed.

Includes only one of the fields `postgresqlConfig_9_6`, `postgresqlConfig_10_1c`, `postgresqlConfig_10`, `postgresqlConfig_11`, `postgresqlConfig_11_1c`, `postgresqlConfig_12`, `postgresqlConfig_12_1c`, `postgresqlConfig_13`, `postgresqlConfig_13_1c`, `postgresqlConfig_14`, `postgresqlConfig_14_1c`, `postgresqlConfig_15`, `postgresqlConfig_15_1c`, `postgresqlConfig_16`, `postgresqlConfig_16_1c`. ||
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
    "clusterId": "string",
    "hostNames": [
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
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[UpdateClusterHostsMetadata](#yandex.cloud.mdb.postgresql.v1.UpdateClusterHostsMetadata)**

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

## UpdateClusterHostsMetadata {#yandex.cloud.mdb.postgresql.v1.UpdateClusterHostsMetadata}

#|
||Field | Description ||
|| clusterId | **string**

ID of the PostgreSQL cluster to update hosts in. ||
|| hostNames[] | **string**

Names of hosts that are being updated. ||
|#