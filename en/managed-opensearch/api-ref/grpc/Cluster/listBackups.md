---
editable: false
sourcePath: en/_api-ref-grpc/mdb/opensearch/v1/api-ref/grpc/Cluster/listBackups.md
---

# Managed Service for OpenSearch API, gRPC: ClusterService.ListBackups

Returns a list of available backups for the specified OpenSearch cluster.

## gRPC request

**rpc ListBackups ([ListClusterBackupsRequest](#yandex.cloud.mdb.opensearch.v1.ListClusterBackupsRequest)) returns ([ListClusterBackupsResponse](#yandex.cloud.mdb.opensearch.v1.ListClusterBackupsResponse))**

## ListClusterBackupsRequest {#yandex.cloud.mdb.opensearch.v1.ListClusterBackupsRequest}

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

Required field. ID of the OpenSearch cluster.

To get the ID, use a [ClusterService.List](/docs/managed-opensearch/api-ref/grpc/Cluster/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListClusterBackupsResponse.next_page_token](#yandex.cloud.mdb.opensearch.v1.ListClusterBackupsResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the [ListClusterBackupsResponse.next_page_token](#yandex.cloud.mdb.opensearch.v1.ListClusterBackupsResponse)
returned by the previous list request. ||
|#

## ListClusterBackupsResponse {#yandex.cloud.mdb.opensearch.v1.ListClusterBackupsResponse}

```json
{
  "backups": [
    {
      "id": "string",
      "folder_id": "string",
      "source_cluster_id": "string",
      "started_at": "google.protobuf.Timestamp",
      "created_at": "google.protobuf.Timestamp",
      "indices": [
        "string"
      ],
      "opensearch_version": "string",
      "size_bytes": "int64",
      "indices_total": "int64"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| backups[] | **[Backup](#yandex.cloud.mdb.opensearch.v1.Backup)**

List of the OpenSearch cluster backups. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests.

If the number of results is larger than [ListClustersRequest.page_size](/docs/managed-opensearch/api-ref/grpc/Cluster/list#yandex.cloud.mdb.opensearch.v1.ListClustersRequest), use the `next_page_token` as the value
for the [ListClustersRequest.page_token](/docs/managed-opensearch/api-ref/grpc/Cluster/list#yandex.cloud.mdb.opensearch.v1.ListClustersRequest) parameter in the next list request.

Each subsequent list request has its own `next_page_token` to continue paging through the results. ||
|#

## Backup {#yandex.cloud.mdb.opensearch.v1.Backup}

#|
||Field | Description ||
|| id | **string**

Required. ID of the backup. ||
|| folder_id | **string**

ID of the folder that the backup belongs to. ||
|| source_cluster_id | **string**

ID of the OpenSearch cluster that the backup was created for. ||
|| started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the backup operation was started. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the backup operation was completed. ||
|| indices[] | **string**

Names of indices in the backup. ||
|| opensearch_version | **string**

OpenSearch version used to create the backup. ||
|| size_bytes | **int64**

Size of the backup in bytes. ||
|| indices_total | **int64**

The number of indices in the backup. ||
|#