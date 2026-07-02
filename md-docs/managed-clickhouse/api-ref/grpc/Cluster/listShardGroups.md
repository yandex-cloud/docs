[Документация Yandex Cloud](../../../../index.md) > [Yandex Managed Service for ClickHouse®](../../../index.md) > Справочник API > [gRPC (англ.)](../index.md) > [Cluster](index.md) > ListShardGroups

# Managed Service for ClickHouse API, gRPC: ClusterService.ListShardGroups

Retrieves a list of shard groups that belong to specified cluster.

## gRPC request

**rpc ListShardGroups ([ListClusterShardGroupsRequest](#yandex.cloud.mdb.clickhouse.v1.ListClusterShardGroupsRequest)) returns ([ListClusterShardGroupsResponse](#yandex.cloud.mdb.clickhouse.v1.ListClusterShardGroupsResponse))**

## ListClusterShardGroupsRequest {#yandex.cloud.mdb.clickhouse.v1.ListClusterShardGroupsRequest}

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

Required field. ID of the cluster that the shard group belongs to.
To get the cluster ID, make a [ClusterService.List](list.md#List) request.

The maximum string length in characters is 50. ||
|| page_size | **int64**

The maximum number of results per page to return.
If the number of available results is larger than `page_size`, the service returns a [ListClusterShardGroupsResponse.next_page_token](#yandex.cloud.mdb.clickhouse.v1.ListClusterShardGroupsResponse) that can be used to get the next page of results in subsequent list requests.

Acceptable values are 0 to 1000, inclusive. ||
|| page_token | **string**

Page token.
To get the next page of results, set `page_token` to the [ListClusterShardGroupsResponse.next_page_token](#yandex.cloud.mdb.clickhouse.v1.ListClusterShardGroupsResponse) returned by the previous list request.

The maximum string length in characters is 100. ||
|#

## ListClusterShardGroupsResponse {#yandex.cloud.mdb.clickhouse.v1.ListClusterShardGroupsResponse}

```json
{
  "shard_groups": [
    {
      "name": "string",
      "cluster_id": "string",
      "description": "string",
      "shard_names": [
        "string"
      ],
      "external_shards": [
        {
          "name": "string",
          "weight": "google.protobuf.Int64Value",
          "replicas": [
            {
              "host": "string",
              "port": "google.protobuf.Int64Value",
              "secure": "google.protobuf.BoolValue",
              "user": "string",
              "password": "string",
              "priority": "google.protobuf.Int64Value"
            }
          ]
        }
      ]
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| shard_groups[] | **[ShardGroup](#yandex.cloud.mdb.clickhouse.v1.ShardGroup)**

List of ClickHouse cluster's shard groups. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests.
If the number of results is larger than [ListClusterShardGroupsRequest.page_size](#yandex.cloud.mdb.clickhouse.v1.ListClusterShardGroupsRequest), use the `next_page_token` as the value for the [ListClusterShardGroupsRequest.page_token](#yandex.cloud.mdb.clickhouse.v1.ListClusterShardGroupsRequest) parameter in the next list request.
Each subsequent list request will have its own `next_page_token` to continue paging through the results. ||
|#

## ShardGroup {#yandex.cloud.mdb.clickhouse.v1.ShardGroup}

#|
||Field | Description ||
|| name | **string**

Name of the shard group. ||
|| cluster_id | **string**

ID of the ClickHouse cluster that the shard group belongs to. ||
|| description | **string**

Description of the shard group. 0-256 characters long. ||
|| shard_names[] | **string**

List of shard names contained in the shard group. ||
|| external_shards[] | **[ExternalShard](#yandex.cloud.mdb.clickhouse.v1.ExternalShard)**

List of external shards contained in the shard group. ||
|#

## ExternalShard {#yandex.cloud.mdb.clickhouse.v1.ExternalShard}

#|
||Field | Description ||
|| name | **string**

Name of the external shard. ||
|| weight | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Relative weight of the external shard considered when writing data to the cluster.

For details, see [ClickHouse documentation](https://clickhouse.com/docs/en/operations/table_engines/distributed/). ||
|| replicas[] | **[Replica](#yandex.cloud.mdb.clickhouse.v1.ExternalShard.Replica)**

List of replicas contained in the external shard. ||
|#

## Replica {#yandex.cloud.mdb.clickhouse.v1.ExternalShard.Replica}

#|
||Field | Description ||
|| host | **string**

Name (FQDN) or IP address of the external replica host. ||
|| port | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Port to connect to the external replica. If not specified, the default ClickHouse port is used. ||
|| secure | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Whether to use a secure (SSL/TLS) connection when connecting to the external replica. ||
|| user | **string**

Name of the user to authenticate with on the external replica. ||
|| password | **string**

Password of the user to authenticate with on the external replica. ||
|| priority | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Priority of the external replica for load balancing.
The replica with the lowest priority value is preferred when establishing a connection. ||
|#