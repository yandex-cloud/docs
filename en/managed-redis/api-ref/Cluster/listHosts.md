---
editable: false
sourcePath: en/_api-ref/mdb/redis/v1/api-ref/Cluster/listHosts.md
---

# Managed Service for Redis API, REST: Cluster.ListHosts

Retrieves a list of hosts for the specified cluster.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-redis/v1/clusters/{clusterId}/hosts
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the Redis cluster.
To get the Redis cluster ID use a [ClusterService.List](/docs/managed-redis/api-ref/Cluster/list#List) request. ||
|#

## Query parameters {#yandex.cloud.mdb.redis.v1.ListClusterHostsRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`, the service returns a [ListClusterHostsResponse.nextPageToken](#yandex.cloud.mdb.redis.v1.ListClusterHostsResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token.  To get the next page of results, set `pageToken` to the [ListClusterHostsResponse.nextPageToken](#yandex.cloud.mdb.redis.v1.ListClusterHostsResponse)
returned by the previous list request. ||
|#

## Response {#yandex.cloud.mdb.redis.v1.ListClusterHostsResponse}

**HTTP Code: 200 - OK**

```json
{
  "hosts": [
    {
      "name": "string",
      "clusterId": "string",
      "zoneId": "string",
      "subnetId": "string",
      "resources": {
        "resourcePresetId": "string",
        "diskSize": "string",
        "diskTypeId": "string"
      },
      "role": "string",
      "health": "string",
      "services": [
        {
          "type": "string",
          "health": "string"
        }
      ],
      "shardName": "string",
      "replicaPriority": "string",
      "assignPublicIp": "boolean"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| hosts[] | **[Host](#yandex.cloud.mdb.redis.v1.Host)**

List of hosts for the cluster. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListClusterHostsRequest.pageSize](#yandex.cloud.mdb.redis.v1.ListClusterHostsRequest), use the `nextPageToken` as the value
for the [ListClusterHostsRequest.pageToken](#yandex.cloud.mdb.redis.v1.ListClusterHostsRequest) query parameter in the next list request.
Each subsequent list request will have its own `nextPageToken` to continue paging through the results. ||
|#

## Host {#yandex.cloud.mdb.redis.v1.Host}

#|
||Field | Description ||
|| name | **string**

Name of the Redis host. The host name is assigned by MDB at creation time, and cannot be changed.
1-63 characters long.

The name is unique across all MDB hosts that exist on the platform, as it defines the FQDN of the host. ||
|| clusterId | **string**

ID of the Redis cluster. The ID is assigned by MDB at creation time. ||
|| zoneId | **string**

ID of the availability zone where the Redis host resides. ||
|| subnetId | **string**

ID of the subnet that the host belongs to. ||
|| resources | **[Resources](#yandex.cloud.mdb.redis.v1.Resources)**

Resources allocated to the Redis host. ||
|| role | **enum** (Role)

Role of the host in the cluster. If the field has default value, it is not returned in the response.

- `ROLE_UNKNOWN`: Role of the host in the cluster is unknown. Default value.
- `MASTER`: Host is the master Redis server in the cluster.
- `REPLICA`: Host is a replica (standby) Redis server in the cluster. ||
|| health | **enum** (Health)

Aggregated health of the host. If the field has default value, it is not returned in the response.

- `HEALTH_UNKNOWN`: Health of the host is unknown. Default value.
- `ALIVE`: The host is performing all its functions normally.
- `DEAD`: The host is inoperable, and cannot perform any of its essential functions.
- `DEGRADED`: The host is degraded, and can perform only some of its essential functions. ||
|| services[] | **[Service](#yandex.cloud.mdb.redis.v1.Service)**

Services provided by the host. ||
|| shardName | **string** ||
|| replicaPriority | **string** (int64)

A replica with a low priority number is considered better for promotion.
A replica with priority of 0 will never be selected by Redis Sentinel for promotion.
Works only for non-sharded clusters. Default value is 100. ||
|| assignPublicIp | **boolean**

Flag showing public IP assignment status to this host. ||
|#

## Resources {#yandex.cloud.mdb.redis.v1.Resources}

#|
||Field | Description ||
|| resourcePresetId | **string**

ID of the preset for computational resources available to a host (CPU, memory etc.).
All available presets are listed in the [documentation](/docs/managed-redis/concepts/instance-types). ||
|| diskSize | **string** (int64)

Volume of the storage available to a host, in bytes. ||
|| diskTypeId | **string**

Type of the storage environment for the host.
Possible values:
* network-ssd - network SSD drive,
* local-ssd - local SSD storage. ||
|#

## Service {#yandex.cloud.mdb.redis.v1.Service}

#|
||Field | Description ||
|| type | **enum** (Type)

Type of the service provided by the host. If the field has default value, it is not returned in the response.

- `TYPE_UNSPECIFIED`: Service type of the host is unspecified. Default value.
- `REDIS`: The host is a Redis server.
- `ARBITER`: The host provides a Sentinel-only service (a quorum node).
- `REDIS_CLUSTER`: The host is a Redis Cluster node. ||
|| health | **enum** (Health)

Aggregated health of the service. If the field has default value, it is not returned in the response.

- `HEALTH_UNKNOWN`: Health of the server is unknown. Default value.
- `ALIVE`: The server is working normally.
- `DEAD`: The server is dead or unresponsive. ||
|#