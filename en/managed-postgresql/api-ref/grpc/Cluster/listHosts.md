---
editable: false
sourcePath: en/_api-ref-grpc/mdb/postgresql/v1/api-ref/grpc/Cluster/listHosts.md
---

# Managed Service for PostgreSQL API, gRPC: ClusterService.ListHosts

Retrieves a list of hosts for the specified cluster.

## gRPC request

**rpc ListHosts ([ListClusterHostsRequest](#yandex.cloud.mdb.postgresql.v1.ListClusterHostsRequest)) returns ([ListClusterHostsResponse](#yandex.cloud.mdb.postgresql.v1.ListClusterHostsResponse))**

## ListClusterHostsRequest {#yandex.cloud.mdb.postgresql.v1.ListClusterHostsRequest}

```json
{
  "cluster_id": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| cluster_id | **string**

Required field. ID of the PostgreSQL cluster.
To get the PostgreSQL cluster ID use a [ClusterService.List](/docs/managed-postgresql/api-ref/grpc/Cluster/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListClusterHostsResponse.next_page_token](#yandex.cloud.mdb.postgresql.v1.ListClusterHostsResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| page_token | **string**

Page token.  To get the next page of results, set `page_token` to the [ListClusterHostsResponse.next_page_token](#yandex.cloud.mdb.postgresql.v1.ListClusterHostsResponse)
returned by the previous list request. ||
|#

## ListClusterHostsResponse {#yandex.cloud.mdb.postgresql.v1.ListClusterHostsResponse}

```json
{
  "hosts": [
    {
      "name": "string",
      "cluster_id": "string",
      "zone_id": "string",
      "resources": {
        "resource_preset_id": "string",
        "disk_size": "int64",
        "disk_type_id": "string"
      },
      "role": "Role",
      "health": "Health",
      "services": [
        {
          "type": "Type",
          "health": "Health"
        }
      ],
      "subnet_id": "string",
      "replication_source": "string",
      "priority": "google.protobuf.Int64Value",
      "config": {
        // Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`
        "postgresql_config_9_6": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig9_6",
        "postgresql_config_10_1c": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig10_1C",
        "postgresql_config_10": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig10",
        "postgresql_config_11": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig11",
        "postgresql_config_11_1c": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig11_1C",
        "postgresql_config_12": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig12",
        "postgresql_config_12_1c": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig12_1C",
        "postgresql_config_13": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig13",
        "postgresql_config_13_1c": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig13_1C",
        "postgresql_config_14": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig14",
        "postgresql_config_14_1c": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig14_1C",
        "postgresql_config_15": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig15",
        "postgresql_config_15_1c": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig15_1C",
        "postgresql_config_16": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig16",
        "postgresql_config_16_1c": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig16_1C",
        "postgresql_config_17": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig17",
        "postgresql_config_17_1c": "yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig17_1C"
        // end of the list of possible fields
      },
      "assign_public_ip": "bool",
      "replica_type": "ReplicaType"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| hosts[] | **[Host](#yandex.cloud.mdb.postgresql.v1.Host)**

List of Host resources. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListClusterHostsRequest.page_size](#yandex.cloud.mdb.postgresql.v1.ListClusterHostsRequest), use the `next_page_token` as the value
for the [ListClusterHostsRequest.page_token](#yandex.cloud.mdb.postgresql.v1.ListClusterHostsRequest) query parameter in the next list request.
Each subsequent list request will have its own `next_page_token` to continue paging through the results. ||
|#

## Host {#yandex.cloud.mdb.postgresql.v1.Host}

#|
||Field | Description ||
|| name | **string**

Name of the PostgreSQL host. The host name is assigned by MDB at creation time, and cannot be changed.
1-63 characters long.

The name is unique across all MDB hosts that exist on the platform, as it defines the FQDN of the host. ||
|| cluster_id | **string**

ID of the PostgreSQL host. The ID is assigned by MDB at creation time. ||
|| zone_id | **string**

ID of the availability zone where the PostgreSQL host resides. ||
|| resources | **[Resources](#yandex.cloud.mdb.postgresql.v1.Resources)**

Resources allocated to the PostgreSQL host. ||
|| role | enum **Role**

Role of the host in the cluster. If the field has default value, it is not returned in the response.

- `ROLE_UNKNOWN`: Role of the host in the cluster is unknown. Default value.
- `MASTER`: Host is the master PostgreSQL server in the cluster.
- `REPLICA`: Host is a replica (standby) PostgreSQL server in the cluster. ||
|| health | enum **Health**

Aggregated health of the host. If the field has default value, it is not returned in the response.

- `HEALTH_UNKNOWN`: Health of the host is unknown. Default value.
- `ALIVE`: The host is performing all its functions normally.
- `DEAD`: The host is inoperable, and cannot perform any of its essential functions.
- `DEGRADED`: The host is degraded, and can perform only some of its essential functions.
- `READONLY`: The host is alive, but in read-only mode. ||
|| services[] | **[Service](#yandex.cloud.mdb.postgresql.v1.Service)**

Services provided by the host. ||
|| subnet_id | **string**

ID of the subnet that the host belongs to. ||
|| replication_source | **string**

Name of the host to be used as the replication source for cascading replication. ||
|| priority | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Priority of the host as a replica. Higher value means higher priority.

The host with the highest priority is the synchronous replica. All others are asynchronous.
The synchronous replica replaces the master when needed.

When a replica becomes the master, its priority is ignored. ||
|| config | **[HostConfig](#yandex.cloud.mdb.postgresql.v1.HostConfig)**

Configuration of a PostgreSQL server for the host. ||
|| assign_public_ip | **bool**

Flag showing public IP assignment status to this host. ||
|| replica_type | enum **ReplicaType**

- `REPLICA_TYPE_UNKNOWN`: Replica type is unknown (we have no data) or it's master
- `ASYNC`
- `SYNC`
- `QUORUM` ||
|#

## Resources {#yandex.cloud.mdb.postgresql.v1.Resources}

#|
||Field | Description ||
|| resource_preset_id | **string**

ID of the preset for computational resources available to a host (CPU, memory etc.).
All available presets are listed in the [documentation](/docs/managed-postgresql/concepts/instance-types). ||
|| disk_size | **int64**

Volume of the storage available to a host, in bytes. ||
|| disk_type_id | **string**

Type of the storage environment for the host.
Possible values:
* network-hdd - network HDD drive,
* network-ssd - network SSD drive,
* local-ssd - local SSD storage. ||
|#

## Service {#yandex.cloud.mdb.postgresql.v1.Service}

#|
||Field | Description ||
|| type | enum **Type**

Type of the service provided by the host. If the field has default value, it is not returned in the response.

- `TYPE_UNSPECIFIED`: Service type of the host is unspecified. Default value.
- `POSTGRESQL`: The host is a PostgreSQL server.
- `POOLER`: The host is a PgBouncer server. ||
|| health | enum **Health**

Aggregated health of the service. If the field has default value, it is not returned in the response.

- `HEALTH_UNKNOWN`: Health of the server is unknown. Default value.
- `ALIVE`: The server is working normally.
- `DEAD`: The server is dead or unresponsive.
- `READONLY`: The server is in read-only mode. ||
|#

## HostConfig {#yandex.cloud.mdb.postgresql.v1.HostConfig}

#|
||Field | Description ||
|| postgresql_config_9_6 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig9_6](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host9_6.proto)**

Configuration for a host with PostgreSQL 9.6 server deployed.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`.

Configuration of a PostgreSQL server for the host. ||
|| postgresql_config_10_1c | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig10_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host10_1c.proto)**

Configuration for a host with PostgreSQL 10 1C server deployed.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`.

Configuration of a PostgreSQL server for the host. ||
|| postgresql_config_10 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig10](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host10.proto)**

Configuration for a host with PostgreSQL 10 server deployed.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`.

Configuration of a PostgreSQL server for the host. ||
|| postgresql_config_11 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig11](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host11.proto)**

Configuration for a host with PostgreSQL 11 server deployed.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`.

Configuration of a PostgreSQL server for the host. ||
|| postgresql_config_11_1c | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig11_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host11_1c.proto)**

Configuration for a host with PostgreSQL 11 1C server deployed.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`.

Configuration of a PostgreSQL server for the host. ||
|| postgresql_config_12 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig12](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host12.proto)**

Configuration for a host with PostgreSQL 12 server deployed.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`.

Configuration of a PostgreSQL server for the host. ||
|| postgresql_config_12_1c | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig12_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host12_1c.proto)**

Configuration for a host with PostgreSQL 12 1C server deployed.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`.

Configuration of a PostgreSQL server for the host. ||
|| postgresql_config_13 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig13](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host13.proto)**

Configuration for a host with PostgreSQL 13 server deployed.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`.

Configuration of a PostgreSQL server for the host. ||
|| postgresql_config_13_1c | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig13_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host13_1c.proto)**

Configuration for a host with PostgreSQL 13 1C server deployed.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`.

Configuration of a PostgreSQL server for the host. ||
|| postgresql_config_14 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig14](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host14.proto)**

Configuration for a host with PostgreSQL 14 server deployed.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`.

Configuration of a PostgreSQL server for the host. ||
|| postgresql_config_14_1c | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig14_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host14_1c.proto)**

Configuration for a host with PostgreSQL 14 1C server deployed.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`.

Configuration of a PostgreSQL server for the host. ||
|| postgresql_config_15 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig15](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host15.proto)**

Configuration for a host with PostgreSQL 15 server deployed.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`.

Configuration of a PostgreSQL server for the host. ||
|| postgresql_config_15_1c | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig15_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host15_1c.proto)**

Configuration for a host with PostgreSQL 15 1C server deployed.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`.

Configuration of a PostgreSQL server for the host. ||
|| postgresql_config_16 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig16](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host16.proto)**

Configuration for a host with PostgreSQL 16 server deployed.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`.

Configuration of a PostgreSQL server for the host. ||
|| postgresql_config_16_1c | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig16_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host16_1c.proto)**

Configuration for a host with PostgreSQL 16 1C server deployed.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`.

Configuration of a PostgreSQL server for the host. ||
|| postgresql_config_17 | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig17](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host17.proto)**

Configuration for a host with PostgreSQL 17 server deployed.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`.

Configuration of a PostgreSQL server for the host. ||
|| postgresql_config_17_1c | **[yandex.cloud.mdb.postgresql.v1.config.PostgresqlHostConfig17_1C](https://github.com/yandex-cloud/cloudapi/blob/master/yandex/cloud/mdb/postgresql/v1/config/host17_1c.proto)**

Configuration for a host with PostgreSQL 17 1C server deployed.

Includes only one of the fields `postgresql_config_9_6`, `postgresql_config_10_1c`, `postgresql_config_10`, `postgresql_config_11`, `postgresql_config_11_1c`, `postgresql_config_12`, `postgresql_config_12_1c`, `postgresql_config_13`, `postgresql_config_13_1c`, `postgresql_config_14`, `postgresql_config_14_1c`, `postgresql_config_15`, `postgresql_config_15_1c`, `postgresql_config_16`, `postgresql_config_16_1c`, `postgresql_config_17`, `postgresql_config_17_1c`.

Configuration of a PostgreSQL server for the host. ||
|#