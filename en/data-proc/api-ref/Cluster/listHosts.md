---
editable: false
sourcePath: en/_api-ref/dataproc/v1/api-ref/Cluster/listHosts.md
---

# Data Proc API, REST: Cluster.ListHosts {#ListHosts}

Retrieves the list of hosts in the specified cluster.

## HTTP request

```
GET https://dataproc.{{ api-host }}/dataproc/v1/clusters/{clusterId}/hosts
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the cluster to list hosts for.

To get a cluster ID, make a [ClusterService.List](/docs/data-proc/api-ref/Cluster/list#List) request. ||
|#

## Query parameters {#yandex.cloud.dataproc.v1.ListClusterHostsRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`, the service returns a [ListClusterHostsResponse.nextPageToken](#yandex.cloud.dataproc.v1.ListClusterHostsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListClusterHostsResponse.nextPageToken](#yandex.cloud.dataproc.v1.ListClusterHostsResponse) returned by a previous list request. ||
|| filter | **string**

A filter expression that filters hosts listed in the response.

The expression must specify:
1. The field name. Currently you can use filtering only on [Cluster.name](/docs/data-proc/api-ref/Cluster/get#yandex.cloud.dataproc.v1.Cluster) field.
2. An `=` operator.
3. The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.
Example of a filter: `name=my-host` ||
|#

## Response {#yandex.cloud.dataproc.v1.ListClusterHostsResponse}

**HTTP Code: 200 - OK**

```json
{
  "hosts": [
    {
      "name": "string",
      "subclusterId": "string",
      "health": "string",
      "computeInstanceId": "string",
      "role": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| hosts[] | **[Host](#yandex.cloud.dataproc.v1.Host)**

Requested list of hosts. ||
|| nextPageToken | **string**

Token for getting the next page of the list. If the number of results is greater than
the specified [ListClusterHostsRequest.pageSize](#yandex.cloud.dataproc.v1.ListClusterHostsRequest), use `next_page_token` as the value
for the [ListClusterHostsRequest.pageToken](#yandex.cloud.dataproc.v1.ListClusterHostsRequest) parameter in the next list request.

Each subsequent page will have its own `next_page_token` to continue paging through the results. ||
|#

## Host {#yandex.cloud.dataproc.v1.Host}

A Data Proc host. For details about the concept, see [documentation](/docs/data-proc/concepts/).

#|
||Field | Description ||
|| name | **string**

Name of the Data Proc host. The host name is assigned by Data Proc at creation time
and cannot be changed. The name is generated to be unique across all Data Proc
hosts that exist on the platform, as it defines the FQDN of the host. ||
|| subclusterId | **string**

ID of the Data Proc subcluster that the host belongs to. ||
|| health | **enum** (Health)

Status code of the aggregated health of the host.

- `HEALTH_UNKNOWN`: Object is in unknown state (we have no data).
- `ALIVE`: Object is alive and well (for example, all hosts of the cluster are alive).
- `DEAD`: Object is inoperable (it cannot perform any of its essential functions).
- `DEGRADED`: Object is partially alive (it can perform some of its essential functions). ||
|| computeInstanceId | **string**

ID of the Compute virtual machine that is used as the Data Proc host. ||
|| role | **enum** (Role)

Role of the host in the cluster.

- `ROLE_UNSPECIFIED`
- `MASTERNODE`: The subcluster fulfills the master role.

  Master can run the following services, depending on the requested components:
* HDFS: Namenode, Secondary Namenode
* YARN: ResourceManager, Timeline Server
* HBase Master
* Hive: Server, Metastore, HCatalog
* Spark History Server
* Zeppelin
* ZooKeeper
- `DATANODE`: The subcluster is a DATANODE in a Data Proc cluster.

  DATANODE can run the following services, depending on the requested components:
* HDFS DataNode
* YARN NodeManager
* HBase RegionServer
* Spark libraries
- `COMPUTENODE`: The subcluster is a COMPUTENODE in a Data Proc cluster.

  COMPUTENODE can run the following services, depending on the requested components:
* YARN NodeManager
* Spark libraries ||
|#