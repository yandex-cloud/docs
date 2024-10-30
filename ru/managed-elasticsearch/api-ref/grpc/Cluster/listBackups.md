---
editable: false
sourcePath: en/_api-ref-grpc/mdb/elasticsearch/v1/api-ref/grpc/Cluster/listBackups.md
---

# Managed Service for Elasticsearch API, gRPC: ClusterService.ListBackups {#ListBackups}

Returns the list of available backups for the specified Elasticsearch cluster.

## gRPC request

**rpc ListBackups ([ListClusterBackupsRequest](#yandex.cloud.mdb.elasticsearch.v1.ListClusterBackupsRequest)) returns ([ListClusterBackupsResponse](#yandex.cloud.mdb.elasticsearch.v1.ListClusterBackupsResponse))**

## ListClusterBackupsRequest {#yandex.cloud.mdb.elasticsearch.v1.ListClusterBackupsRequest}

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

Required field. Required. ID of the Elasticsearch cluster. ||
|| pageSize | **int64**

The maximum number of results per page that should be returned. If the number of available
results is larger than `page_size`, the service returns a `next_page_token` that can be used
to get the next page of results in subsequent ListClusterBackups requests.
Acceptable values are 0 to 1000, inclusive. Default value: 100. ||
|| pageToken | **string**

Page token. Set `page_token` to the `next_page_token` returned by a previous ListClusterBackups
request to get the next page of results. ||
|#

## ListClusterBackupsResponse {#yandex.cloud.mdb.elasticsearch.v1.ListClusterBackupsResponse}

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
      "elasticsearchVersion": "string",
      "sizeBytes": "int64",
      "indicesTotal": "int64"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| backups[] | **[Backup](#yandex.cloud.mdb.elasticsearch.v1.Backup)**

Requested list of backups. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for ListClusterBackups requests,
if the number of results is larger than `page_size` specified in the request.
To get the next page, specify the value of `next_page_token` as a value for
the `page_token` parameter in the next ListClusterBackups request. Subsequent ListClusterBackups
requests will have their own `next_page_token` to continue paging through the results. ||
|#

## Backup {#yandex.cloud.mdb.elasticsearch.v1.Backup}

#|
||Field | Description ||
|| id | **string**

Required. ID of the backup. ||
|| folderId | **string**

ID of the folder that the backup belongs to. ||
|| sourceClusterId | **string**

ID of the associated Elasticsearch cluster. ||
|| startedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the backup operation was started. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the backup was created (i.e. when the backup operation completed). ||
|| indices[] | **string**

Indices names. (max 100) ||
|| elasticsearchVersion | **string**

Elasticsearch version used to create the snapshot ||
|| sizeBytes | **int64**

Total size of all indices in backup. in bytes ||
|| indicesTotal | **int64**

Total count of indices in backup ||
|#