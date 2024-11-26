---
editable: false
sourcePath: en/_api-ref-grpc/mdb/clickhouse/v1/api-ref/grpc/Cluster/listHosts.md
---

# Managed Service for ClickHouse API, gRPC: ClusterService.ListHosts

Retrieves a list of hosts for the specified cluster.

## gRPC request

**rpc ListHosts ([ListClusterHostsRequest](#yandex.cloud.mdb.clickhouse.v1.ListClusterHostsRequest)) returns ([ListClusterHostsResponse](#yandex.cloud.mdb.clickhouse.v1.ListClusterHostsResponse))**

## ListClusterHostsRequest {#yandex.cloud.mdb.clickhouse.v1.ListClusterHostsRequest}

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

Required field. ID of the ClickHouse cluster.
To get the ClickHouse cluster ID use a [ClusterService.List](/docs/managed-clickhouse/api-ref/grpc/Cluster/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListClusterHostsResponse.next_page_token](#yandex.cloud.mdb.clickhouse.v1.ListClusterHostsResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| page_token | **string**

Page token.  To get the next page of results, set `page_token` to the [ListClusterHostsResponse.next_page_token](#yandex.cloud.mdb.clickhouse.v1.ListClusterHostsResponse)
returned by the previous list request. ||
|#

## ListClusterHostsResponse {#yandex.cloud.mdb.clickhouse.v1.ListClusterHostsResponse}

```json
{
  "hosts": [
    {
      "name": "string",
      "cluster_id": "string",
      "zone_id": "string",
      "type": "Type",
      "resources": {
        "resource_preset_id": "string",
        "disk_size": "int64",
        "disk_type_id": "string"
      },
      "health": "Health",
      "services": [
        {
          "type": "Type",
          "health": "Health"
        }
      ],
      "subnet_id": "string",
      "assign_public_ip": "bool",
      "shard_name": "string"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| hosts[] | **[Host](#yandex.cloud.mdb.clickhouse.v1.Host)**

Requested list of hosts for the cluster. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListClusterHostsRequest.page_size](#yandex.cloud.mdb.clickhouse.v1.ListClusterHostsRequest), use the `next_page_token` as the value
for the [ListClusterHostsRequest.page_token](#yandex.cloud.mdb.clickhouse.v1.ListClusterHostsRequest) query parameter in the next list request.
Each subsequent list request will have its own `next_page_token` to continue paging through the results. ||
|#

## Host {#yandex.cloud.mdb.clickhouse.v1.Host}

#|
||Field | Description ||
|| name | **string**

Name of the ClickHouse host. The host name is assigned by MDB at creation time, and cannot be changed.
1-63 characters long.

The name is unique across all MDB hosts that exist on the platform, as it defines the FQDN of the host. ||
|| cluster_id | **string**

ID of the ClickHouse host. The ID is assigned by MDB at creation time. ||
|| zone_id | **string**

ID of the availability zone where the ClickHouse host resides. ||
|| type | enum **Type**

Type of the host. If the field has default value, it is not returned in the response.

- `TYPE_UNSPECIFIED`: Host type is unspecified. Default value.
- `CLICKHOUSE`: ClickHouse host.
- `ZOOKEEPER`: ZooKeeper host. ||
|| resources | **[Resources](#yandex.cloud.mdb.clickhouse.v1.Resources)**

Resources allocated to the ClickHouse host. ||
|| health | enum **Health**

Aggregated health of the host. If the field has default value, it is not returned in the response.

- `UNKNOWN`: Health of the host is unknown.
- `ALIVE`: The host is performing all its functions normally.
- `DEAD`: The host is inoperable, and cannot perform any of its essential functions.
- `DEGRADED`: The host is degraded, and can perform only some of its essential functions. ||
|| services[] | **[Service](#yandex.cloud.mdb.clickhouse.v1.Service)**

Services provided by the host. ||
|| subnet_id | **string**

ID of the subnet that the host belongs to. ||
|| assign_public_ip | **bool**

Flag showing public IP assignment status to this host. ||
|| shard_name | **string** ||
|#

## Resources {#yandex.cloud.mdb.clickhouse.v1.Resources}

#|
||Field | Description ||
|| resource_preset_id | **string**

ID of the preset for computational resources available to a host (CPU, memory etc.).
All available presets are listed in the [documentation](/docs/managed-clickhouse/concepts/instance-types) ||
|| disk_size | **int64**

Volume of the storage available to a host, in bytes. ||
|| disk_type_id | **string**

Type of the storage environment for the host.
Possible values:
* network-hdd - network HDD drive,
* network-ssd - network SSD drive,
* local-ssd - local SSD storage. ||
|#

## Service {#yandex.cloud.mdb.clickhouse.v1.Service}

#|
||Field | Description ||
|| type | enum **Type**

Type of the service provided by the host. If the field has default value, it is not returned in the response.

- `TYPE_UNSPECIFIED`: Service type of the host is unspecified. Default value.
- `CLICKHOUSE`: The host is a ClickHouse server.
- `ZOOKEEPER`: The host is a ZooKeeper server. ||
|| health | enum **Health**

Aggregated health of the service. If the field has default value, it is not returned in the response.

- `UNKNOWN`: Health of the server is unknown. Default value.
- `ALIVE`: The server is working normally.
- `DEAD`: The server is dead or unresponsive. ||
|#