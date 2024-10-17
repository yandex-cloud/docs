---
editable: false
sourcePath: en/_api-ref-grpc/mdb/opensearch/v1/api-ref/grpc/Cluster/listBackups.md
---

# Managed Service for OpenSearch API, gRPC: ClusterService.ListBackups {#ListBackups}

Returns a list of available backups for the specified OpenSearch cluster.

## gRPC request

**rpc ListBackups ([ListClusterBackupsRequest](#yandex.cloud.mdb.opensearch.v1.ListClusterBackupsRequest)) returns ([ListClusterBackupsResponse](#yandex.cloud.mdb.opensearch.v1.ListClusterBackupsResponse))**

## ListClusterBackupsRequest {#yandex.cloud.mdb.opensearch.v1.ListClusterBackupsRequest}

```json
{
  "clusterId": "string",
  "pageSize": "int64",
  "pageToken": "string"
}
```

#|
||Field | Description ||
|| clusterId | **string**

Required field. ID of the OpenSearch cluster.

To get the ID, use a [ClusterService.List](/docs/managed-opensearch/api-ref/grpc/Cluster/list#List) request. ||
|| pageSize | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListClusterBackupsResponse.nextPageToken](#yandex.cloud.mdb.opensearch.v1.ListClusterBackupsResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token. To get the next page of results, set `page_token` to the [ListClusterBackupsResponse.nextPageToken](#yandex.cloud.mdb.opensearch.v1.ListClusterBackupsResponse)
returned by the previous list request. ||
|#

## ListClusterBackupsResponse {#yandex.cloud.mdb.opensearch.v1.ListClusterBackupsResponse}

```json
{
  "backups": [
    {
      "id": "string",
      "folderId": "string",
      "sourceClusterId": "string",
      "startedAt": "google.protobuf.Timestamp",
      "createdAt": "google.protobuf.Timestamp",
      "indices": [
        "string"
      ],
      "opensearchVersion": "string",
      "sizeBytes": "int64",
      "indicesTotal": "int64"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| backups[] | **[Backup](#yandex.cloud.mdb.opensearch.v1.Backup)**

List of the OpenSearch cluster backups. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests.

If the number of results is larger than [ListClustersRequest.pageSize](/docs/managed-opensearch/api-ref/grpc/Cluster/list#yandex.cloud.mdb.opensearch.v1.ListClustersRequest), use the `nextPageToken` as the value
for the [ListClustersRequest.pageToken](/docs/managed-opensearch/api-ref/grpc/Cluster/list#yandex.cloud.mdb.opensearch.v1.ListClustersRequest) parameter in the next list request.

Each subsequent list request has its own `nextPageToken` to continue paging through the results. ||
|#

## Backup {#yandex.cloud.mdb.opensearch.v1.Backup}

#|
||Field | Description ||
|| id | **string**

Required. ID of the backup. ||
|| folderId | **string**

ID of the folder that the backup belongs to. ||
|| sourceClusterId | **string**

ID of the OpenSearch cluster that the backup was created for. ||
|| startedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the backup operation was started. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the backup operation was completed. ||
|| indices[] | **string**

Names of indices in the backup. ||
|| opensearchVersion | **string**

OpenSearch version used to create the backup. ||
|| sizeBytes | **int64**

Size of the backup in bytes. ||
|| indicesTotal | **int64**

The number of indices in the backup. ||
|#