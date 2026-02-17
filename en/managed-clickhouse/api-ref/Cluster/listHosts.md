---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/{clusterId}/hosts
    method: get
    path:
      type: object
      properties:
        clusterId:
          description: |-
            **string**
            Required field. ID of the ClickHouse cluster.
            To get the ClickHouse cluster ID use a [ClusterService.List](/docs/managed-clickhouse/api-ref/Cluster/list#List) request.
            The maximum string length in characters is 50.
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
            results is larger than `pageSize`, the service returns a [ListClusterHostsResponse.nextPageToken](#yandex.cloud.mdb.clickhouse.v1.ListClusterHostsResponse)
            that can be used to get the next page of results in subsequent list requests.
            The maximum value is 1000.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token.  To get the next page of results, set `pageToken` to the [ListClusterHostsResponse.nextPageToken](#yandex.cloud.mdb.clickhouse.v1.ListClusterHostsResponse)
            returned by the previous list request.
            The maximum string length in characters is 100.
          type: string
      additionalProperties: false
    body: null
    definitions: null
---

# Managed Service for ClickHouse API, REST: Cluster.ListHosts

Retrieves a list of hosts for the specified cluster.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/{clusterId}/hosts
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the ClickHouse cluster.
To get the ClickHouse cluster ID use a [ClusterService.List](/docs/managed-clickhouse/api-ref/Cluster/list#List) request.

The maximum string length in characters is 50. ||
|#

## Query parameters {#yandex.cloud.mdb.clickhouse.v1.ListClusterHostsRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`, the service returns a [ListClusterHostsResponse.nextPageToken](#yandex.cloud.mdb.clickhouse.v1.ListClusterHostsResponse)
that can be used to get the next page of results in subsequent list requests.

The maximum value is 1000. ||
|| pageToken | **string**

Page token.  To get the next page of results, set `pageToken` to the [ListClusterHostsResponse.nextPageToken](#yandex.cloud.mdb.clickhouse.v1.ListClusterHostsResponse)
returned by the previous list request.

The maximum string length in characters is 100. ||
|#

## Response {#yandex.cloud.mdb.clickhouse.v1.ListClusterHostsResponse}

**HTTP Code: 200 - OK**

```json
{
  "hosts": [
    {
      "name": "string",
      "clusterId": "string",
      "zoneId": "string",
      "type": "string",
      "resources": {
        "resourcePresetId": "string",
        "diskSize": "string",
        "diskTypeId": "string"
      },
      "health": "string",
      "services": [
        {
          "type": "string",
          "health": "string"
        }
      ],
      "subnetId": "string",
      "assignPublicIp": "boolean",
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
|| type | **enum** (Type)

Type of the host. If the field has default value, it is not returned in the response.

- `CLICKHOUSE`: ClickHouse host.
- `ZOOKEEPER`: ZooKeeper host.
- `KEEPER`: ClickHouse Keeper host. ||
|| resources | **[Resources](#yandex.cloud.mdb.clickhouse.v1.Resources)**

Resources allocated to the ClickHouse host. ||
|| health | **enum** (Health)

Aggregated health of the host. If the field has default value, it is not returned in the response.

- `UNKNOWN`: Health of the host is unknown.
- `ALIVE`: The host is performing all its functions normally.
- `DEAD`: The host is inoperable, and cannot perform any of its essential functions.
- `DEGRADED`: The host is degraded, and can perform only some of its essential functions.
- `READONLY`: The host is read-only and cannot perform write requests.
- `RESTORING`: The host is restoring from backup or syncronzing from other replica. ||
|| services[] | **[Service](#yandex.cloud.mdb.clickhouse.v1.Service)**

Services provided by the host. ||
|| subnetId | **string**

ID of the subnet that the host belongs to. ||
|| assignPublicIp | **boolean**

Flag showing public IP assignment status to this host. ||
|| shardName | **string** ||
|#

## Resources {#yandex.cloud.mdb.clickhouse.v1.Resources}

#|
||Field | Description ||
|| resourcePresetId | **string**

ID of the preset for computational resources available to a host (CPU, memory etc.).
All available presets are listed in the [documentation](/docs/managed-clickhouse/concepts/instance-types) ||
|| diskSize | **string** (int64)

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
|| type | **enum** (Type)

Type of the service provided by the host. If the field has default value, it is not returned in the response.

- `CLICKHOUSE`: The host is a ClickHouse server.
- `ZOOKEEPER`: The host is a ZooKeeper server.
- `KEEPER`: The host is a ClickHouse Keeper server. ||
|| health | **enum** (Health)

Aggregated health of the service. If the field has default value, it is not returned in the response.

- `UNKNOWN`: Health of the server is unknown. Default value.
- `ALIVE`: The server is working normally.
- `DEAD`: The server is dead or unresponsive.
- `READONLY`: The service is read-only.
- `RESTORING`: The service is restoring from backup or syncronzing from other replica. ||
|#