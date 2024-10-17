---
editable: false
sourcePath: en/_api-ref-grpc/mdb/clickhouse/v1/api-ref/grpc/Cluster/listHosts.md
---

# Managed Service for ClickHouse API, gRPC: ClusterService.ListHosts {#ListHosts}

Retrieves a list of hosts for the specified cluster.

## gRPC request

**rpc ListHosts ([ListClusterHostsRequest](#yandex.cloud.mdb.clickhouse.v1.ListClusterHostsRequest)) returns ([ListClusterHostsResponse](#yandex.cloud.mdb.clickhouse.v1.ListClusterHostsResponse))**

## ListClusterHostsRequest {#yandex.cloud.mdb.clickhouse.v1.ListClusterHostsRequest}

```json
{
  "clusterId": "string",
  "pageSize": "int64",
  "pageToken": "string"
}
```

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the ClickHouse cluster.
To get the ClickHouse cluster ID use a [ClusterService.List](/docs/managed-clickhouse/api-ref/grpc/Cluster/list#List) request. ||
|| pageSize | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`, the service returns a [ListClusterHostsResponse.nextPageToken](#yandex.cloud.mdb.clickhouse.v1.ListClusterHostsResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token.  To get the next page of results, set `pageToken` to the [ListClusterHostsResponse.nextPageToken](#yandex.cloud.mdb.clickhouse.v1.ListClusterHostsResponse)
returned by the previous list request. ||
|#

## ListClusterHostsResponse {#yandex.cloud.mdb.clickhouse.v1.ListClusterHostsResponse}

```json
{
  "hosts": [
    {
      "name": "string",
      "clusterId": "string",
      "zoneId": "string",
      "type": "Type",
      "resources": {
        "resourcePresetId": "string",
        "diskSize": "int64",
        "diskTypeId": "string"
      },
      "health": "Health",
      "services": [
        {
          "type": "Type",
          "health": "Health"
        }
      ],
      "subnetId": "string",
      "assignPublicIp": "bool",
      "shardName": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| hosts[] | **[Host](#yandex.cloud.mdb.clickhouse.v1.Host)**

Requested list of hosts for the cluster. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListClusterHostsRequest.pageSize](#yandex.cloud.mdb.clickhouse.v1.ListClusterHostsRequest), use the `nextPageToken` as the value
for the [ListClusterHostsRequest.pageToken](#yandex.cloud.mdb.clickhouse.v1.ListClusterHostsRequest) query parameter in the next list request.
Each subsequent list request will have its own `nextPageToken` to continue paging through the results. ||
|#

## Host {#yandex.cloud.mdb.clickhouse.v1.Host}

#|
||Field | Description ||
|| name | **string**

Name of the ClickHouse host. The host name is assigned by MDB at creation time, and cannot be changed.
1-63 characters long.

The name is unique across all MDB hosts that exist on the platform, as it defines the FQDN of the host. ||
|| clusterId | **string**

ID of the ClickHouse host. The ID is assigned by MDB at creation time. ||
|| zoneId | **string**

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
|| subnetId | **string**

ID of the subnet that the host belongs to. ||
|| assignPublicIp | **bool**

Flag showing public IP assignment status to this host. ||
|| shardName | **string** ||
|#

## Resources {#yandex.cloud.mdb.clickhouse.v1.Resources}

#|
||Field | Description ||
|| resourcePresetId | **string**

ID of the preset for computational resources available to a host (CPU, memory etc.).
All available presets are listed in the [documentation](/docs/managed-clickhouse/concepts/instance-types) ||
|| diskSize | **int64**

Volume of the storage available to a host, in bytes. ||
|| diskTypeId | **string**

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