---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-kafka/v1/clusters/{clusterId}/hosts
    method: get
    path:
      type: object
      properties:
        clusterId:
          description: |-
            **string**
            Required field. ID of the Apache Kafka® cluster.
            To get the Apache Kafka® cluster ID, make a [ClusterService.List](/docs/managed-kafka/api-ref/Cluster/list#List) request.
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
            If the number of available results is larger than `pageSize`, the service returns a [ListClusterHostsResponse.nextPageToken](/docs/managed-kafka/api-ref/Cluster/listHosts#yandex.cloud.mdb.kafka.v1.ListClusterHostsResponse) that can be used to get the next page of results in subsequent list requests.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token.
            To get the next page of results, set `pageToken` to the [ListClusterHostsResponse.nextPageToken](/docs/managed-kafka/api-ref/Cluster/listHosts#yandex.cloud.mdb.kafka.v1.ListClusterHostsResponse) returned by the previous list request.
          type: string
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/mdb/kafka/v1/api-ref/Cluster/listHosts.md
---

# Managed Service for Apache Kafka® API, REST: Cluster.ListHosts

Retrieves a list of hosts for the specified Apache Kafka® cluster.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-kafka/v1/clusters/{clusterId}/hosts
```

## Path parameters

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the Apache Kafka® cluster.

To get the Apache Kafka® cluster ID, make a [ClusterService.List](/docs/managed-kafka/api-ref/Cluster/list#List) request. ||
|#

## Query parameters {#yandex.cloud.mdb.kafka.v1.ListClusterHostsRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return.

If the number of available results is larger than `pageSize`, the service returns a [ListClusterHostsResponse.nextPageToken](#yandex.cloud.mdb.kafka.v1.ListClusterHostsResponse) that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token.

To get the next page of results, set `pageToken` to the [ListClusterHostsResponse.nextPageToken](#yandex.cloud.mdb.kafka.v1.ListClusterHostsResponse) returned by the previous list request. ||
|#

## Response {#yandex.cloud.mdb.kafka.v1.ListClusterHostsResponse}

**HTTP Code: 200 - OK**

```json
{
  "hosts": [
    {
      "name": "string",
      "clusterId": "string",
      "zoneId": "string",
      "role": "string",
      "resources": {
        "resourcePresetId": "string",
        "diskSize": "string",
        "diskTypeId": "string"
      },
      "health": "string",
      "subnetId": "string",
      "assignPublicIp": "boolean"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| hosts[] | **[Host](#yandex.cloud.mdb.kafka.v1.Host)**

List of hosts. ||
|| nextPageToken | **string**

Token that allows you to get the next page of results for list requests.

If the number of results is larger than [ListClusterHostsRequest.pageSize](#yandex.cloud.mdb.kafka.v1.ListClusterHostsRequest), use the `nextPageToken` as the value for the [ListClusterHostsRequest.pageToken](#yandex.cloud.mdb.kafka.v1.ListClusterHostsRequest) query parameter in the next list request.
Each subsequent list request will have its own `nextPageToken` to continue paging through the results. ||
|#

## Host {#yandex.cloud.mdb.kafka.v1.Host}

Cluster host metadata.

#|
||Field | Description ||
|| name | **string**

Name of the host. ||
|| clusterId | **string**

ID of the Apache Kafka® cluster. ||
|| zoneId | **string**

ID of the availability zone where the host resides. ||
|| role | **enum** (Role)

Host role. If the field has default value, it is not returned in the response.

- `ROLE_UNSPECIFIED`: Role of the host is unspecified. Default value.
- `KAFKA`: The host is a Kafka broker.
- `ZOOKEEPER`: The host is a ZooKeeper server.
- `KRAFT`: The host is a Kafka KRaft controller broker. ||
|| resources | **[Resources](#yandex.cloud.mdb.kafka.v1.Resources)**

Computational resources allocated to the host. ||
|| health | **enum** (Health)

Aggregated host health data. If the field has default value, it is not returned in the response.

- `UNKNOWN`: Health of the host is unknown. Default value.
- `ALIVE`: The host is performing all its functions normally.
- `DEAD`: The host is inoperable and cannot perform any of its essential functions.
- `DEGRADED`: The host is degraded and can perform only some of its essential functions. ||
|| subnetId | **string**

ID of the subnet the host resides in. ||
|| assignPublicIp | **boolean**

The flag that defines whether a public IP address is assigned to the node.

If the value is `true`, then this node is available on the Internet via it's public IP address. ||
|#

## Resources {#yandex.cloud.mdb.kafka.v1.Resources}

#|
||Field | Description ||
|| resourcePresetId | **string**

ID of the preset for computational resources available to a host (CPU, memory, etc.).
All available presets are listed in the [documentation](/docs/managed-kafka/concepts/instance-types). ||
|| diskSize | **string** (int64)

Volume of the storage available to a host, in bytes. Must be greater than 2 * partition segment size in bytes * partitions count, so each partition can have one active segment file and one closed segment file that can be deleted. ||
|| diskTypeId | **string**

Type of the storage environment for the host. ||
|#