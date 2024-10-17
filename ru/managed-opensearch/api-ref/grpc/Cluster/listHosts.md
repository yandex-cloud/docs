---
editable: false
sourcePath: en/_api-ref-grpc/mdb/opensearch/v1/api-ref/grpc/Cluster/listHosts.md
---

# Managed Service for OpenSearch API, gRPC: ClusterService.ListHosts {#ListHosts}

Retrieves a list of hosts for the specified cluster.

## gRPC request

**rpc ListHosts ([ListClusterHostsRequest](#yandex.cloud.mdb.opensearch.v1.ListClusterHostsRequest)) returns ([ListClusterHostsResponse](#yandex.cloud.mdb.opensearch.v1.ListClusterHostsResponse))**

## ListClusterHostsRequest {#yandex.cloud.mdb.opensearch.v1.ListClusterHostsRequest}

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

Required field. ID of the OpenSearch cluster.
To get the OpenSearch cluster ID use a [ClusterService.List](/docs/managed-opensearch/api-ref/grpc/Cluster/list#List) request. ||
|| pageSize | **int64**

The maximum number of results per page to return.

If the number of available results is larger than `pageSize`, the service returns
a [ListClusterHostsResponse.nextPageToken](#yandex.cloud.mdb.opensearch.v1.ListClusterHostsResponse) that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the [ListClusterHostsResponse.nextPageToken](#yandex.cloud.mdb.opensearch.v1.ListClusterHostsResponse)
returned by the previous list request. ||
|#

## ListClusterHostsResponse {#yandex.cloud.mdb.opensearch.v1.ListClusterHostsResponse}

```json
{
  "hosts": [
    {
      "name": "string",
      "clusterId": "string",
      "zoneId": "string",
      "resources": {
        "resourcePresetId": "string",
        "diskSize": "int64",
        "diskTypeId": "string"
      },
      "type": "Type",
      "health": "Health",
      "subnetId": "string",
      "assignPublicIp": "bool",
      "system": {
        "cpu": {
          "timestamp": "int64",
          "used": "double"
        },
        "memory": {
          "timestamp": "int64",
          "used": "int64",
          "total": "int64"
        },
        "disk": {
          "timestamp": "int64",
          "used": "int64",
          "total": "int64"
        }
      },
      "nodeGroup": "string",
      "roles": [
        "GroupRole"
      ]
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| hosts[] | **[Host](#yandex.cloud.mdb.opensearch.v1.Host)**

Requested list of hosts for the cluster. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests.

If the number of results is larger than [ListClusterHostsRequest.pageSize](#yandex.cloud.mdb.opensearch.v1.ListClusterHostsRequest), use the `nextPageToken`
as the value for the [ListClusterHostsRequest.pageToken](#yandex.cloud.mdb.opensearch.v1.ListClusterHostsRequest) query parameter in the next list request.

Each subsequent list request has its own `nextPageToken` to continue paging through the results. ||
|#

## Host {#yandex.cloud.mdb.opensearch.v1.Host}

An OpenSearch cluster host resource.

#|
||Field | Description ||
|| name | **string**

Required. Name of the OpenSearch host.

The host name is assigned by the platform at creation time and cannot be changed.

The name is unique across all MDB hosts that exist on the platform, as it defines the FQDN of the host. ||
|| clusterId | **string**

Required. ID of the OpenSearch cluster. The ID is assigned by the platform at creation time. ||
|| zoneId | **string**

ID of the availability zone the OpenSearch host belongs to. ||
|| resources | **[Resources](#yandex.cloud.mdb.opensearch.v1.Resources)**

Resources allocated to the OpenSearch host. ||
|| type | enum **Type**

Type of the host. If the field has default value, it is not returned in the response.

- `TYPE_UNSPECIFIED`: Type of the host is unspecified. Default value.
- `OPENSEARCH`: An OpenSearch type host.
- `DASHBOARDS`: A Dashboards type host. ||
|| health | enum **Health**

Aggregated health of the host. If the field has default value, it is not returned in the response.

- `UNKNOWN`: Health of the host is unknown. Default value.
- `ALIVE`: The host is performing all its functions normally.
- `DEAD`: The host is inoperable and cannot perform any of its essential functions.
- `DEGRADED`: The host is working below capacity or not fully functional. ||
|| subnetId | **string**

ID of the subnet that the host belongs to. ||
|| assignPublicIp | **bool**

Determines whether a public IP is assigned to the host. ||
|| system | **[SystemMetrics](#yandex.cloud.mdb.opensearch.v1.Host.SystemMetrics)**

Resources used by the host. ||
|| nodeGroup | **string**

Name of the host group that the host belongs to. ||
|| roles[] | enum **GroupRole**

Roles of the host.

- `GROUP_ROLE_UNSPECIFIED`
- `DATA`
- `MANAGER` ||
|#

## Resources {#yandex.cloud.mdb.opensearch.v1.Resources}

A list of computational resources allocated to a host.

#|
||Field | Description ||
|| resourcePresetId | **string**

ID of the preset for computational resources allocated to a host. ||
|| diskSize | **int64**

Volume of the storage used by the host, in bytes. ||
|| diskTypeId | **string**

Type of the storage used by the host: `network-hdd`, `network-ssd` or `local-ssd`. ||
|#

## SystemMetrics {#yandex.cloud.mdb.opensearch.v1.Host.SystemMetrics}

Resources used by the host.

#|
||Field | Description ||
|| cpu | **[CPUMetric](#yandex.cloud.mdb.opensearch.v1.Host.CPUMetric)**

CPU usage of the host. ||
|| memory | **[MemoryMetric](#yandex.cloud.mdb.opensearch.v1.Host.MemoryMetric)**

RAM usage of the host. ||
|| disk | **[DiskMetric](#yandex.cloud.mdb.opensearch.v1.Host.DiskMetric)**

Disk usage of the host. ||
|#

## CPUMetric {#yandex.cloud.mdb.opensearch.v1.Host.CPUMetric}

CPU usage of the host.

#|
||Field | Description ||
|| timestamp | **int64**

Time of the record. ||
|| used | **double**

Percentage of the CPU used. ||
|#

## MemoryMetric {#yandex.cloud.mdb.opensearch.v1.Host.MemoryMetric}

RAM usage of the host.

#|
||Field | Description ||
|| timestamp | **int64**

Time of the record. ||
|| used | **int64**

The amount of RAM used, in bytes. ||
|| total | **int64**

Total amount of RAM allocated to the host. ||
|#

## DiskMetric {#yandex.cloud.mdb.opensearch.v1.Host.DiskMetric}

Disk usage of the host.

#|
||Field | Description ||
|| timestamp | **int64**

Time of the record. ||
|| used | **int64**

The amount of disk space used, in bytes. ||
|| total | **int64**

Total amount of disk space allocated to the host. ||
|#