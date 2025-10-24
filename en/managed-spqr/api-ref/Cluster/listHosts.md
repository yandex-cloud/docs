---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-spqr/v1/clusters/{clusterId}/hosts
    method: get
    path:
      type: object
      properties:
        clusterId:
          description: |-
            **string**
            Required field. ID of the SPQR cluster.
            To get the SPQR cluster ID, use a [ClusterService.List](/docs/managed-spqr/api-ref/Cluster/list#List) request.
          type: string
      required:
        - clusterId
      additionalProperties: false
    query:
      type: object
      properties:
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of results per page to return. If the number of available
            results is larger than `pageSize`, the service returns a [ListClusterHostsResponse.nextPageToken](#yandex.cloud.mdb.spqr.v1.ListClusterHostsResponse)
            that can be used to get the next page of results in subsequent list requests.
            Acceptable values are 0 to 1000, inclusive. Default value: 100.
          default: '100'
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token. To get the next page of results, set `pageToken` to the
            [ListClusterHostsResponse.nextPageToken](#yandex.cloud.mdb.spqr.v1.ListClusterHostsResponse) returned by the previous list request.
          type: string
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/mdb/spqr/v1/api-ref/Cluster/listHosts.md
---

# Managed Service for SPQR API, REST: Cluster.ListHosts

Retrieves a list of hosts for the specified cluster.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-spqr/v1/clusters/{clusterId}/hosts
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the SPQR cluster.
To get the SPQR cluster ID, use a [ClusterService.List](/docs/managed-spqr/api-ref/Cluster/list#List) request. ||
|#

## Query parameters {#yandex.cloud.mdb.spqr.v1.ListClusterHostsRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`, the service returns a [ListClusterHostsResponse.nextPageToken](#yandex.cloud.mdb.spqr.v1.ListClusterHostsResponse)
that can be used to get the next page of results in subsequent list requests.
Acceptable values are 0 to 1000, inclusive. Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListClusterHostsResponse.nextPageToken](#yandex.cloud.mdb.spqr.v1.ListClusterHostsResponse) returned by the previous list request. ||
|#

## Response {#yandex.cloud.mdb.spqr.v1.ListClusterHostsResponse}

**HTTP Code: 200 - OK**

```json
{
  "hosts": [
    {
      "name": "string",
      "clusterId": "string",
      "zoneId": "string",
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
      "subnetId": "string",
      "assignPublicIp": "boolean",
      "type": "string",
      "walleLink": "string",
      "stateReason": "string",
      "system": {
        "cpu": {
          "timestamp": "string",
          "used": "string"
        },
        "memory": {
          "timestamp": "string",
          "used": "string",
          "total": "string"
        },
        "disk": {
          "timestamp": "string",
          "used": "string",
          "total": "string"
        }
      },
      "shardName": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| hosts[] | **[Host](#yandex.cloud.mdb.spqr.v1.Host)**

List of Host resources. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListClusterHostsRequest.pageSize](#yandex.cloud.mdb.spqr.v1.ListClusterHostsRequest), use the `nextPageToken` as the value
for the [ListClusterHostsRequest.pageToken](#yandex.cloud.mdb.spqr.v1.ListClusterHostsRequest) query parameter in the next list request.
Each subsequent list request will have its own `nextPageToken` to continue paging through the results. ||
|#

## Host {#yandex.cloud.mdb.spqr.v1.Host}

#|
||Field | Description ||
|| name | **string**

Name of the SPQR host. The host name is assigned by MDB at creation time, and cannot be changed.
1-63 characters long.

The name is unique across all MDB hosts that exist on the platform, as it defines the FQDN of the host. ||
|| clusterId | **string**

The ID of the SPQR cluster that the host belongs to. ||
|| zoneId | **string**

ID of the availability zone where the SPQR host resides. ||
|| resources | **[Resources](#yandex.cloud.mdb.spqr.v1.Resources)**

Resources allocated to the SPQR host. ||
|| role | **enum** (Role)

Role of the host in the cluster.

- `ROLE_UNKNOWN`: Role of the host in the cluster is unknown.
- `PRIMARY`: Host is the primary SPQR server in the cluster.
- `SECONDARY`: Host is a secondary SPQR server in the cluster.
- `MASTER`: Host is the master PostgreSQL server in the cluster.
- `REPLICA`: Host is a replica (standby) PostgreSQL server in the cluster. ||
|| health | **enum** (Health)

Status code of the aggregated health of the host.

- `HEALTH_UNKNOWN`: Health of the host is unknown.
- `ALIVE`: The host is performing all its functions normally.
- `DEAD`: The host is inoperable, and cannot perform any of its essential functions.
- `DEGRADED`: The host is degraded, and can perform only some of its essential functions. ||
|| services[] | **[Service](#yandex.cloud.mdb.spqr.v1.Service)**

Services provided by the host. ||
|| subnetId | **string**

ID of the subnet that the host belongs to. ||
|| assignPublicIp | **boolean**

Flag showing public IP assignment status to this host. ||
|| type | **enum** (Type)

Host type

- `TYPE_UNSPECIFIED`
- `ROUTER`: A SPQR Router host.
- `COORDINATOR`: A SPQR Coordinator host.
- `INFRA`: A SPQR Infra host (router+coordinator)
- `POSTGRESQL`: A PostgreSQL host.
- `EXTERNAL_POSTGRESQL`: An External PostgreSQL host.
- `MDB_POSTGRESQL`: A Managed PostgreSQL host ||
|| walleLink | **string**

link to wall-e (porto only) ||
|| stateReason | **string**

host state reason from cms (porto only) ||
|| system | **[SystemMetrics](#yandex.cloud.mdb.spqr.v1.Host.SystemMetrics)**

System metrics ||
|| shardName | **string**

Shard which this host belongs to. ||
|#

## Resources {#yandex.cloud.mdb.spqr.v1.Resources}

#|
||Field | Description ||
|| resourcePresetId | **string**

ID of the preset for computational resources available to a host (CPU, memory etc.).
All available presets are listed in the [documentation](/docs/managed-spqr/concepts/instance-types). ||
|| diskSize | **string** (int64)

Volume of the storage available to a host, in bytes. ||
|| diskTypeId | **string**

Type of the storage environment for the host.
Possible values:
* network-hdd - network HDD drive,
* network-ssd - network SSD drive,
* local-ssd - local SSD storage. ||
|#

## Service {#yandex.cloud.mdb.spqr.v1.Service}

#|
||Field | Description ||
|| type | **enum** (Type)

Type of the service provided by the host.

- `TYPE_UNSPECIFIED`
- `ROUTER`: The host is running a SPQR Router.
- `COORDINATOR`: The host is running a SPQR Coordinator.
- `INFRA`: The host is running a SPQR router and coordinator
- `POSTGRESQL`: The host is running a PostgreSQL.
- `EXTERNAL_POSTGRESQL`: The host is running a PostgreSQL.
- `MDB_POSTGRESQL`: The host is running a PostgreSQL ||
|| health | **enum** (Health)

Status code of server availability.

- `HEALTH_UNKNOWN`: Health of the server is unknown.
- `ALIVE`: The server is working normally.
- `DEAD`: The server is dead or unresponsive. ||
|#

## SystemMetrics {#yandex.cloud.mdb.spqr.v1.Host.SystemMetrics}

#|
||Field | Description ||
|| cpu | **[CPUMetric](#yandex.cloud.mdb.spqr.v1.Host.CPUMetric)** ||
|| memory | **[MemoryMetric](#yandex.cloud.mdb.spqr.v1.Host.MemoryMetric)** ||
|| disk | **[DiskMetric](#yandex.cloud.mdb.spqr.v1.Host.DiskMetric)** ||
|#

## CPUMetric {#yandex.cloud.mdb.spqr.v1.Host.CPUMetric}

#|
||Field | Description ||
|| timestamp | **string** (int64) ||
|| used | **string** ||
|#

## MemoryMetric {#yandex.cloud.mdb.spqr.v1.Host.MemoryMetric}

#|
||Field | Description ||
|| timestamp | **string** (int64) ||
|| used | **string** (int64) ||
|| total | **string** (int64) ||
|#

## DiskMetric {#yandex.cloud.mdb.spqr.v1.Host.DiskMetric}

#|
||Field | Description ||
|| timestamp | **string** (int64) ||
|| used | **string** (int64) ||
|| total | **string** (int64) ||
|#