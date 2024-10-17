---
editable: false
sourcePath: en/_api-ref/mdb/elasticsearch/v1/api-ref/Cluster/listHosts.md
---

# Managed Service for Elasticsearch API, REST: Cluster.ListHosts {#ListHosts}

Retrieves a list of hosts for the specified Elasticsearch cluster.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-elasticsearch/v1/clusters/{clusterId}/hosts
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the Elasticsearch cluster.

To get the Elasticsearch cluster ID, make a [ClusterService.List](/docs/managed-elasticsearch/api-ref/Cluster/list#List) request. ||
|#

## Query parameters {#yandex.cloud.mdb.elasticsearch.v1.ListClusterHostsRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return.

If the number of available results is larger than `page_size`, the service returns a [ListClusterHostsResponse.nextPageToken](#yandex.cloud.mdb.elasticsearch.v1.ListClusterHostsResponse) that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token.

To get the next page of results, set `page_token` to the [ListClusterHostsResponse.nextPageToken](#yandex.cloud.mdb.elasticsearch.v1.ListClusterHostsResponse) returned by the previous list request. ||
|#

## Response {#yandex.cloud.mdb.elasticsearch.v1.ListClusterHostsResponse}

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
      "assignPublicIp": "boolean"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| hosts[] | **[Host](#yandex.cloud.mdb.elasticsearch.v1.Host)**

List of hosts. ||
|| nextPageToken | **string**

Token that allows you to get the next page of results for list requests.

If the number of results is larger than [ListClusterHostsRequest.pageSize](#yandex.cloud.mdb.elasticsearch.v1.ListClusterHostsRequest), use the `next_page_token` as the value for the [ListClusterHostsRequest.pageToken](#yandex.cloud.mdb.elasticsearch.v1.ListClusterHostsRequest) query parameter in the next list request.
Each subsequent list request will have its own `next_page_token` to continue paging through the results. ||
|#

## Host {#yandex.cloud.mdb.elasticsearch.v1.Host}

Cluster host metadata.

#|
||Field | Description ||
|| name | **string**

Name of the host. ||
|| clusterId | **string**

ID of the Elasticsearch cluster. ||
|| zoneId | **string**

ID of the availability zone where the host resides. ||
|| type | **enum** (Type)

Host type.

- `TYPE_UNSPECIFIED`: Host type is unspecified. Default value.
- `DATA_NODE`: The host is an Elasticsearch data node.
- `MASTER_NODE`: The host is an Elasticsearch master node. ||
|| resources | **[Resources](#yandex.cloud.mdb.elasticsearch.v1.Resources)** ||
|| health | **enum** (Health)

Aggregated host health data. If the field has default value, it is not returned in the response.

- `UNKNOWN`: Health of the host is unknown.
- `ALIVE`: The host is performing all its functions normally.
- `DEAD`: The host is inoperable and cannot perform any of its essential functions.
- `DEGRADED`: The host is degraded and can perform only some of its essential functions. ||
|| services[] | **[Service](#yandex.cloud.mdb.elasticsearch.v1.Service)**

Services provided by the host. ||
|| subnetId | **string**

ID of the subnet the host resides in. ||
|| assignPublicIp | **boolean**

The flag that defines whether a public IP address is assigned to the host.

If the value is `true`, then this host is available on the Internet via it's public IP address. ||
|#

## Resources {#yandex.cloud.mdb.elasticsearch.v1.Resources}

Computational resources.

#|
||Field | Description ||
|| resourcePresetId | **string**

ID of the preset for computational resources available to a host (CPU, memory etc.).
All available presets are listed in the [documentation](/docs/managed-elasticsearch/concepts/instance-types). ||
|| diskSize | **string** (int64)

Volume of the storage available to a host, in bytes. ||
|| diskTypeId | **string**

Type of the storage environment for the host.
All available types are listed in the [documentation](/docs/managed-elasticsearch/concepts/storage). ||
|#

## Service {#yandex.cloud.mdb.elasticsearch.v1.Service}

Cluster service metadata.

#|
||Field | Description ||
|| type | **enum** (Type)

Type of the service provided by the host.

- `TYPE_UNSPECIFIED`
- `ELASTICSEARCH`: The Elasticsearch service. ||
|| health | **enum** (Health)

Service health data. If the field has default value, it is not returned in the response.

- `UNKNOWN`: Health of the service is unknown.
- `ALIVE`: The service is working normally.
- `DEAD`: The service is dead or unresponsive. ||
|#