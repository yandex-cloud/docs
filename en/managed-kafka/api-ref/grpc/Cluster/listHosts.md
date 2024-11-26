---
editable: false
sourcePath: en/_api-ref-grpc/mdb/kafka/v1/api-ref/grpc/Cluster/listHosts.md
---

# Managed Service for Apache Kafka® API, gRPC: ClusterService.ListHosts

Retrieves a list of hosts for the specified Apache Kafka® cluster.

## gRPC request

**rpc ListHosts ([ListClusterHostsRequest](#yandex.cloud.mdb.kafka.v1.ListClusterHostsRequest)) returns ([ListClusterHostsResponse](#yandex.cloud.mdb.kafka.v1.ListClusterHostsResponse))**

## ListClusterHostsRequest {#yandex.cloud.mdb.kafka.v1.ListClusterHostsRequest}

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

Required field. ID of the Apache Kafka® cluster.

To get the Apache Kafka® cluster ID, make a [ClusterService.List](/docs/managed-kafka/api-ref/grpc/Cluster/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return.

If the number of available results is larger than `page_size`, the service returns a [ListClusterHostsResponse.next_page_token](#yandex.cloud.mdb.kafka.v1.ListClusterHostsResponse) that can be used to get the next page of results in subsequent list requests. ||
|| page_token | **string**

Page token.

To get the next page of results, set `page_token` to the [ListClusterHostsResponse.next_page_token](#yandex.cloud.mdb.kafka.v1.ListClusterHostsResponse) returned by the previous list request. ||
|#

## ListClusterHostsResponse {#yandex.cloud.mdb.kafka.v1.ListClusterHostsResponse}

```json
{
  "hosts": [
    {
      "name": "string",
      "cluster_id": "string",
      "zone_id": "string",
      "role": "Role",
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
|| hosts[] | **[Host](#yandex.cloud.mdb.kafka.v1.Host)**

List of hosts. ||
|| next_page_token | **string**

Token that allows you to get the next page of results for list requests.

If the number of results is larger than [ListClusterHostsRequest.page_size](#yandex.cloud.mdb.kafka.v1.ListClusterHostsRequest), use the `next_page_token` as the value for the [ListClusterHostsRequest.page_token](#yandex.cloud.mdb.kafka.v1.ListClusterHostsRequest) query parameter in the next list request.
Each subsequent list request will have its own `next_page_token` to continue paging through the results. ||
|#

## Host {#yandex.cloud.mdb.kafka.v1.Host}

Cluster host metadata.

#|
||Field | Description ||
|| name | **string**

Name of the host. ||
|| cluster_id | **string**

ID of the Apache Kafka® cluster. ||
|| zone_id | **string**

ID of the availability zone where the host resides. ||
|| role | enum **Role**

Host role. If the field has default value, it is not returned in the response.

- `ROLE_UNSPECIFIED`: Role of the host is unspecified. Default value.
- `KAFKA`: The host is a Kafka broker.
- `ZOOKEEPER`: The host is a ZooKeeper server. ||
|| resources | **[Resources](#yandex.cloud.mdb.kafka.v1.Resources)**

Computational resources allocated to the host. ||
|| health | enum **Health**

Aggregated host health data. If the field has default value, it is not returned in the response.

- `UNKNOWN`: Health of the host is unknown. Default value.
- `ALIVE`: The host is performing all its functions normally.
- `DEAD`: The host is inoperable and cannot perform any of its essential functions.
- `DEGRADED`: The host is degraded and can perform only some of its essential functions. ||
|| subnet_id | **string**

ID of the subnet the host resides in. ||
|| assign_public_ip | **bool**

The flag that defines whether a public IP address is assigned to the node.

If the value is `true`, then this node is available on the Internet via it's public IP address. ||
|#

## Resources {#yandex.cloud.mdb.kafka.v1.Resources}

#|
||Field | Description ||
|| resource_preset_id | **string**

ID of the preset for computational resources available to a host (CPU, memory, etc.).
All available presets are listed in the [documentation](/docs/managed-kafka/concepts/instance-types). ||
|| disk_size | **int64**

Volume of the storage available to a host, in bytes. Must be greater than 2 * partition segment size in bytes * partitions count, so each partition can have one active segment file and one closed segment file that can be deleted. ||
|| disk_type_id | **string**

Type of the storage environment for the host. ||
|#