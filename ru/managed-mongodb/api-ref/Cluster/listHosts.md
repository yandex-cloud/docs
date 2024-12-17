---
editable: false
sourcePath: en/_api-ref/mdb/mongodb/v1/api-ref/Cluster/listHosts.md
---

# Managed Service for MongoDB API, REST: Cluster.ListHosts

Retrieves a list of hosts for the specified cluster.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-mongodb/v1/clusters/{clusterId}/hosts
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the MongoDB cluster.
To get the MongoDB cluster ID, use a [ClusterService.List](/docs/managed-mongodb/api-ref/Cluster/list#List) request. ||
|#

## Query parameters {#yandex.cloud.mdb.mongodb.v1.ListClusterHostsRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`, the service returns a [ListClusterHostsResponse.nextPageToken](#yandex.cloud.mdb.mongodb.v1.ListClusterHostsResponse)
that can be used to get the next page of results in subsequent list requests.
Acceptable values are 0 to 1000, inclusive. Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListClusterHostsResponse.nextPageToken](#yandex.cloud.mdb.mongodb.v1.ListClusterHostsResponse) returned by the previous list request. ||
|#

## Response {#yandex.cloud.mdb.mongodb.v1.ListClusterHostsResponse}

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
      "shardName": "string",
      "type": "string",
      "hostParameters": {
        "hidden": "boolean",
        "secondaryDelaySecs": "string",
        "priority": "string",
        "tags": "object"
      }
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| hosts[] | **[Host](#yandex.cloud.mdb.mongodb.v1.Host)**

List of Host resources. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListClusterHostsRequest.pageSize](#yandex.cloud.mdb.mongodb.v1.ListClusterHostsRequest), use the `nextPageToken` as the value
for the [ListClusterHostsRequest.pageToken](#yandex.cloud.mdb.mongodb.v1.ListClusterHostsRequest) query parameter in the next list request.
Each subsequent list request will have its own `nextPageToken` to continue paging through the results. ||
|#

## Host {#yandex.cloud.mdb.mongodb.v1.Host}

#|
||Field | Description ||
|| name | **string**

Name of the MongoDB host. The host name is assigned by MDB at creation time, and cannot be changed.
1-63 characters long.

The name is unique across all MDB hosts that exist on the platform, as it defines the FQDN of the host. ||
|| clusterId | **string**

ID of the MongoDB host. The ID is assigned by MDB at creation time. ||
|| zoneId | **string**

ID of the availability zone where the MongoDB host resides. ||
|| resources | **[Resources](#yandex.cloud.mdb.mongodb.v1.Resources)**

Resources allocated to the MongoDB host. ||
|| role | **enum** (Role)

Role of the host in the cluster. If the field has default value, it is not returned in the response.

- `ROLE_UNKNOWN`: Role of the host in the cluster is unknown. Default value.
- `PRIMARY`: Host is the primary MongoDB server in the cluster.
- `SECONDARY`: Host is a secondary MongoDB server in the cluster. ||
|| health | **enum** (Health)

Aggregated health of the host. If the field has default value, it is not returned in the response.

- `HEALTH_UNKNOWN`: Health of the host is unknown. Default value.
- `ALIVE`: The host is performing all its functions normally.
- `DEAD`: The host is inoperable, and cannot perform any of its essential functions.
- `DEGRADED`: The host is degraded, and can perform only some of its essential functions. ||
|| services[] | **[Service](#yandex.cloud.mdb.mongodb.v1.Service)**

Services provided by the host. ||
|| subnetId | **string**

ID of the subnet that the host belongs to. ||
|| assignPublicIp | **boolean**

Flag showing public IP assignment status to this host. ||
|| shardName | **string**

Shard which this host belongs to. ||
|| type | **enum** (Type)

Host type. If the field has default value, it is not returned in the response.

- `TYPE_UNSPECIFIED`: Type of the host is unspecified. Default value.
- `MONGOD`: A mongod host.
- `MONGOS`: A mongos host.
- `MONGOCFG`: A mongocfg host.
- `MONGOINFRA`: A mongoinfra (mongos+mongocfg) host. ||
|| hostParameters | **[HostParameters](#yandex.cloud.mdb.mongodb.v1.Host.HostParameters)**

Host parameters ||
|#

## Resources {#yandex.cloud.mdb.mongodb.v1.Resources}

#|
||Field | Description ||
|| resourcePresetId | **string**

ID of the preset for computational resources available to a host (CPU, memory etc.).
All available presets are listed in the [documentation](/docs/managed-mongodb/concepts/instance-types). ||
|| diskSize | **string** (int64)

Volume of the storage available to a host, in bytes. ||
|| diskTypeId | **string**

Type of the storage environment for the host.
Possible values:
* network-hdd - network HDD drive,
* network-ssd - network SSD drive,
* local-ssd - local SSD storage. ||
|#

## Service {#yandex.cloud.mdb.mongodb.v1.Service}

#|
||Field | Description ||
|| type | **enum** (Type)

Type of the service provided by the host. If the field has default value, it is not returned in the response.

- `TYPE_UNSPECIFIED`: Service type of the host is unspecified. Default value.
- `MONGOD`: The host is running a mongod daemon.
- `MONGOS`: The host is running a mongos daemon.
- `MONGOCFG`: The host is running a MongoDB config server. ||
|| health | **enum** (Health)

Aggregated health of the service. If the field has default value, it is not returned in the response.

- `HEALTH_UNKNOWN`: Health of the server is unknown.
- `ALIVE`: The server is working normally.
- `DEAD`: The server is dead or unresponsive. ||
|#

## HostParameters {#yandex.cloud.mdb.mongodb.v1.Host.HostParameters}

#|
||Field | Description ||
|| hidden | **boolean** ||
|| secondaryDelaySecs | **string** (int64) ||
|| priority | **string** ||
|| tags | **object** (map<**string**, **string**>) ||
|#