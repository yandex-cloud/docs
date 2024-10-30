---
editable: false
sourcePath: en/_api-ref-grpc/mdb/elasticsearch/v1/api-ref/grpc/Cluster/addHosts.md
---

# Managed Service for Elasticsearch API, gRPC: ClusterService.AddHosts {#AddHosts}

Adds new hosts to the specified Elasticsearch cluster.

## gRPC request

**rpc AddHosts ([AddClusterHostsRequest](#yandex.cloud.mdb.elasticsearch.v1.AddClusterHostsRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## AddClusterHostsRequest {#yandex.cloud.mdb.elasticsearch.v1.AddClusterHostsRequest}

```json
{
  "clusterId": "string",
  "hostSpecs": [
    {
      "zoneId": "string",
      "subnetId": "string",
      "assignPublicIp": "bool",
      "type": "Type",
      "shardName": "string"
    }
  ]
}
```

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the Elasticsearch cluster.

To get the Elasticsearch cluster ID, make a [ClusterService.List](/docs/managed-elasticsearch/api-ref/grpc/Cluster/list#List) request. ||
|| hostSpecs[] | **[HostSpec](#yandex.cloud.mdb.elasticsearch.v1.HostSpec)**

One or more configurations of hosts to be added to the Elasticsearch cluster. ||
|#

## HostSpec {#yandex.cloud.mdb.elasticsearch.v1.HostSpec}

#|
||Field | Description ||
|| zoneId | **string**

ID of the availability zone where the host resides. ||
|| subnetId | **string**

ID of the subnet the host resides in. ||
|| assignPublicIp | **bool**

The flag that defines whether a public IP address is assigned to the host.

If the value is `true`, then this host is available on the Internet via it's public IP address. ||
|| type | enum **Type**

Required field. Host type.

- `TYPE_UNSPECIFIED`: Host type is unspecified. Default value.
- `DATA_NODE`: The host is an Elasticsearch data node.
- `MASTER_NODE`: The host is an Elasticsearch master node. ||
|| shardName | **string**

The shard name to create on the host. ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "google.protobuf.Timestamp",
  "createdBy": "string",
  "modifiedAt": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "clusterId": "string",
    "hostNames": [
      "string"
    ]
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": "google.protobuf.Empty"
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[AddClusterHostsMetadata](#yandex.cloud.mdb.elasticsearch.v1.AddClusterHostsMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## AddClusterHostsMetadata {#yandex.cloud.mdb.elasticsearch.v1.AddClusterHostsMetadata}

#|
||Field | Description ||
|| clusterId | **string**

ID of the Elasticsearch cluster. ||
|| hostNames[] | **string**

Names of the host that are being added. ||
|#