---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-mysql/v1/clusters/{clusterId}/hosts
    method: get
    path:
      type: object
      properties:
        clusterId:
          description: |-
            **string**
            Required field. ID of the cluster to list hosts for.
            To get this ID, make a [ClusterService.List](/docs/managed-mysql/api-ref/Cluster/list#List) request.
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
            The maximum number of results per page to return.
            If the number of available results is larger than `pageSize`, the API returns a [ListClusterHostsResponse.nextPageToken](/docs/managed-mysql/api-ref/Cluster/listHosts#yandex.cloud.mdb.mysql.v1.ListClusterHostsResponse) that can be used to get the next page of results in the subsequent [ClusterService.ListHosts](#ListHosts) requests.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token that can be used to iterate through multiple pages of results.
            To get the next page of results, set `pageToken` to the [ListClusterHostsResponse.nextPageToken](/docs/managed-mysql/api-ref/Cluster/listHosts#yandex.cloud.mdb.mysql.v1.ListClusterHostsResponse) returned by the previous [ClusterService.ListHosts](#ListHosts) request.
          type: string
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/mdb/mysql/v1/api-ref/Cluster/listHosts.md
---

# Managed Service for MySQL API, REST: Cluster.ListHosts

Retrieves a list of hosts for a cluster.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-mysql/v1/clusters/{clusterId}/hosts
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the cluster to list hosts for.

To get this ID, make a [ClusterService.List](/docs/managed-mysql/api-ref/Cluster/list#List) request. ||
|#

## Query parameters {#yandex.cloud.mdb.mysql.v1.ListClusterHostsRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return.

If the number of available results is larger than `pageSize`, the API returns a [ListClusterHostsResponse.nextPageToken](#yandex.cloud.mdb.mysql.v1.ListClusterHostsResponse) that can be used to get the next page of results in the subsequent [ClusterService.ListHosts](#ListHosts) requests. ||
|| pageToken | **string**

Page token that can be used to iterate through multiple pages of results.

To get the next page of results, set `pageToken` to the [ListClusterHostsResponse.nextPageToken](#yandex.cloud.mdb.mysql.v1.ListClusterHostsResponse) returned by the previous [ClusterService.ListHosts](#ListHosts) request. ||
|#

## Response {#yandex.cloud.mdb.mysql.v1.ListClusterHostsResponse}

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
      "replicationSource": "string",
      "backupPriority": "string",
      "priority": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| hosts[] | **[Host](#yandex.cloud.mdb.mysql.v1.Host)**

List of hosts in the cluster. ||
|| nextPageToken | **string**

The token that can be used to get the next page of results.

If the number of results is larger than [ListClusterHostsRequest.pageSize](#yandex.cloud.mdb.mysql.v1.ListClusterHostsRequest), use the `nextPageToken` as the value for the [ListClusterHostsRequest.pageToken](#yandex.cloud.mdb.mysql.v1.ListClusterHostsRequest) in the subsequent [ClusterService.ListHosts](#ListHosts) request to iterate through multiple pages of results.

Each of the subsequent [ClusterService.ListHosts](#ListHosts) requests should use the `nextPageToken` value returned by the previous request to continue paging through the results. ||
|#

## Host {#yandex.cloud.mdb.mysql.v1.Host}

#|
||Field | Description ||
|| name | **string**

Name of the host.

This name is assigned by the platform at the time of creation.
The name is unique across all MDB hosts that exist on the platform, as it defines the FQDN of the host. ||
|| clusterId | **string**

ID of the cluster the host belongs to. ||
|| zoneId | **string**

ID of the availability zone where the host resides. ||
|| resources | **[Resources](#yandex.cloud.mdb.mysql.v1.Resources)**

Resources allocated to the host. ||
|| role | **enum** (Role)

Role of the host in the cluster. If the field has default value, it is not returned in the response.

- `ROLE_UNKNOWN`: Role of the host is unknown. Default value.
- `MASTER`: Host is the master.
- `REPLICA`: Host is a replica. ||
|| health | **enum** (Health)

Aggregated health of the host. If the field has default value, it is not returned in the response.

- `HEALTH_UNKNOWN`: Health of the host is unknown. Default value.
- `ALIVE`: Host is performing all its functions normally.
- `DEAD`: Host is inoperable, and cannot perform any of its essential functions.
- `DEGRADED`: Host is degraded, and can perform only some of its essential functions.
- `READONLY`: Host is alive, but in read-only mode. ||
|| services[] | **[Service](#yandex.cloud.mdb.mysql.v1.Service)**

List of services provided by the host. ||
|| subnetId | **string**

ID of the subnet that the host belongs to. ||
|| assignPublicIp | **boolean**

Flag that shows if public IP address is assigned to the host so that the host can be accessed from the internet. ||
|| replicationSource | **string**

Name of the host to be used as the replication source for cascading replication. ||
|| backupPriority | **string** (int64)

Host backup priority. ||
|| priority | **string** (int64)

Host master promotion priority. ||
|#

## Resources {#yandex.cloud.mdb.mysql.v1.Resources}

Cluster resource preset.

#|
||Field | Description ||
|| resourcePresetId | **string**

ID of the resource preset that defines available computational resources (vCPU, RAM, etc.) for a cluster host.

All available presets are listed in [the documentation](/docs/managed-mysql/concepts/instance-types). ||
|| diskSize | **string** (int64)

Volume of the storage (for each cluster host, in bytes). ||
|| diskTypeId | **string**

Type of the storage.

Possible values:
* `network-hdd` - standard network storage
* `network-ssd` - fast network storage
* `network-ssd-nonreplicated` - fast network nonreplicated storage
* `local-ssd` - fast local storage.

See [the documentation](/docs/managed-mysql/concepts/storage) for details. ||
|#

## Service {#yandex.cloud.mdb.mysql.v1.Service}

#|
||Field | Description ||
|| type | **enum** (Type)

Type of the service provided by the host. If the field has default value, it is not returned in the response.

- `TYPE_UNSPECIFIED`: Service type of the host is unspecified. Default value.
- `MYSQL`: The host is a MySQL server. ||
|| health | **enum** (Health)

Aggregated health of the service. If the field has default value, it is not returned in the response.

- `HEALTH_UNKNOWN`: Health of the service is unknown. Default value.
- `ALIVE`: The service is working normally.
- `DEAD`: The service is dead or unresponsive.
- `READONLY`: The service is in read-only mode. ||
|#