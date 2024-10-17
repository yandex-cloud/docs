---
editable: false
sourcePath: en/_api-ref-grpc/mdb/greenplum/v1/api-ref/grpc/Cluster/listMasterHosts.md
---

# Managed Service for Greenplum® API, gRPC: ClusterService.ListMasterHosts {#ListMasterHosts}

Retrieves a list of master hosts for the specified cluster.

## gRPC request

**rpc ListMasterHosts ([ListClusterHostsRequest](#yandex.cloud.mdb.greenplum.v1.ListClusterHostsRequest)) returns ([ListClusterHostsResponse](#yandex.cloud.mdb.greenplum.v1.ListClusterHostsResponse))**

## ListClusterHostsRequest {#yandex.cloud.mdb.greenplum.v1.ListClusterHostsRequest}

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

Required field. ID of the Greenplum® cluster.

To get the Greenplum® cluster ID use a [ClusterService.List](/docs/managed-greenplum/api-ref/grpc/Cluster/list#List) request. ||
|| pageSize | **int64**

The maximum number of results per page to return.

If the number of available results is larger than `pageSize`, the service returns a [ListClusterHostsResponse.nextPageToken](#yandex.cloud.mdb.greenplum.v1.ListClusterHostsResponse) that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the [ListClusterHostsResponse.nextPageToken](#yandex.cloud.mdb.greenplum.v1.ListClusterHostsResponse) returned by the previous list request. ||
|#

## ListClusterHostsResponse {#yandex.cloud.mdb.greenplum.v1.ListClusterHostsResponse}

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
      "subnetId": "string",
      "assignPublicIp": "bool"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| hosts[] | **[Host](#yandex.cloud.mdb.greenplum.v1.Host)**

Requested list of hosts for the cluster. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests.

If the number of results is larger than [ListClusterHostsRequest.pageSize](#yandex.cloud.mdb.greenplum.v1.ListClusterHostsRequest), use the `nextPageToken` as the value for the [ListClusterHostsRequest.pageToken](#yandex.cloud.mdb.greenplum.v1.ListClusterHostsRequest) query parameter in the next list request.

Each subsequent list request has its own `nextPageToken` to continue paging through the results. ||
|#

## Host {#yandex.cloud.mdb.greenplum.v1.Host}

A Greenplum® cluster host resource.

#|
||Field | Description ||
|| name | **string**

Required field. Name of the Greenplum® host.

The host name is assigned by the platform at creation time and cannot be changed.

The name is unique across all MDB hosts that exist on the platform, as it defines the FQDN of the host. ||
|| clusterId | **string**

ID of the Greenplum® cluster. The ID is assigned by the platform at creation time. ||
|| zoneId | **string**

ID of the availability zone the Greenplum® host belongs to. ||
|| type | enum **Type**

Type of the host. If the field has default value, it is not returned in the response.

- `TYPE_UNSPECIFIED`: Host type is not specified. Default value.
- `MASTER`: A Greenplum® master host.
- `REPLICA`: A Greenplum® master replica host.
- `SEGMENT`: A Greenplum® segment host. ||
|| resources | **[Resources](#yandex.cloud.mdb.greenplum.v1.Resources)**

Resources allocated to the Greenplum® host. ||
|| health | enum **Health**

Aggregated health of the host. If the field has default value, it is not returned in the response.

- `UNKNOWN`: Health of the host is unknown. Default value.
- `ALIVE`: The host is performing all its functions normally.
- `DEAD`: The host is inoperable and cannot perform any of its essential functions.
- `DEGRADED`: The host is working below capacity or not fully functional.
- `UNBALANCED`: One or more segments are not in the preferred role. ||
|| subnetId | **string**

ID of the subnet that the host belongs to. ||
|| assignPublicIp | **bool**

Determines whether a public IP is assigned to the host. ||
|#

## Resources {#yandex.cloud.mdb.greenplum.v1.Resources}

#|
||Field | Description ||
|| resourcePresetId | **string**

ID of the preset for computational resources allocated to a host.

Available presets are listed in the [documentation](/docs/managed-greenplum/concepts/instance-types). ||
|| diskSize | **int64**

Volume of the storage used by the host, in bytes. ||
|| diskTypeId | **string**

Type of the storage used by the host: `network-hdd`, `network-ssd` or `local-ssd`. ||
|#