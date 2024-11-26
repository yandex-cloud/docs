---
editable: false
sourcePath: en/_api-ref-grpc/mdb/greenplum/v1/api-ref/grpc/Cluster/listMasterHosts.md
---

# Managed Service for Greenplum® API, gRPC: ClusterService.ListMasterHosts

Retrieves a list of master hosts for the specified cluster.

## gRPC request

**rpc ListMasterHosts ([ListClusterHostsRequest](#yandex.cloud.mdb.greenplum.v1.ListClusterHostsRequest)) returns ([ListClusterHostsResponse](#yandex.cloud.mdb.greenplum.v1.ListClusterHostsResponse))**

## ListClusterHostsRequest {#yandex.cloud.mdb.greenplum.v1.ListClusterHostsRequest}

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

Required field. ID of the Greenplum® cluster.

To get the Greenplum® cluster ID use a [ClusterService.List](/docs/managed-greenplum/api-ref/grpc/Cluster/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return.

If the number of available results is larger than `page_size`, the service returns a [ListClusterHostsResponse.next_page_token](#yandex.cloud.mdb.greenplum.v1.ListClusterHostsResponse) that can be used to get the next page of results in subsequent list requests. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the [ListClusterHostsResponse.next_page_token](#yandex.cloud.mdb.greenplum.v1.ListClusterHostsResponse) returned by the previous list request. ||
|#

## ListClusterHostsResponse {#yandex.cloud.mdb.greenplum.v1.ListClusterHostsResponse}

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
      "subnet_id": "string",
      "assign_public_ip": "bool"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| hosts[] | **[Host](#yandex.cloud.mdb.greenplum.v1.Host)**

Requested list of hosts for the cluster. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests.

If the number of results is larger than [ListClusterHostsRequest.page_size](#yandex.cloud.mdb.greenplum.v1.ListClusterHostsRequest), use the `next_page_token` as the value for the [ListClusterHostsRequest.page_token](#yandex.cloud.mdb.greenplum.v1.ListClusterHostsRequest) query parameter in the next list request.

Each subsequent list request has its own `next_page_token` to continue paging through the results. ||
|#

## Host {#yandex.cloud.mdb.greenplum.v1.Host}

A Greenplum® cluster host resource.

#|
||Field | Description ||
|| name | **string**

Required field. Name of the Greenplum® host.

The host name is assigned by the platform at creation time and cannot be changed.

The name is unique across all MDB hosts that exist on the platform, as it defines the FQDN of the host. ||
|| cluster_id | **string**

ID of the Greenplum® cluster. The ID is assigned by the platform at creation time. ||
|| zone_id | **string**

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
|| subnet_id | **string**

ID of the subnet that the host belongs to. ||
|| assign_public_ip | **bool**

Determines whether a public IP is assigned to the host. ||
|#

## Resources {#yandex.cloud.mdb.greenplum.v1.Resources}

#|
||Field | Description ||
|| resource_preset_id | **string**

ID of the preset for computational resources allocated to a host.

Available presets are listed in the [documentation](/docs/managed-greenplum/concepts/instance-types). ||
|| disk_size | **int64**

Volume of the storage used by the host, in bytes. ||
|| disk_type_id | **string**

Type of the storage used by the host: `network-hdd`, `network-ssd` or `local-ssd`. ||
|#