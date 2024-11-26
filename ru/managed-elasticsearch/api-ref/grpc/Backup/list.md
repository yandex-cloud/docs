---
editable: false
sourcePath: en/_api-ref-grpc/mdb/elasticsearch/v1/api-ref/grpc/Backup/list.md
---

# Managed Service for Elasticsearch API, gRPC: BackupService.List

Returns the list of available backups for the specified Elasticsearch cluster.

## gRPC request

**rpc List ([ListBackupsRequest](#yandex.cloud.mdb.elasticsearch.v1.ListBackupsRequest)) returns ([ListBackupsResponse](#yandex.cloud.mdb.elasticsearch.v1.ListBackupsResponse))**

## ListBackupsRequest {#yandex.cloud.mdb.elasticsearch.v1.ListBackupsRequest}

```json
{
  "folder_id": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. Required. ID of the folder to list backups in. ||
|| page_size | **int64**

The maximum number of results per page that should be returned. If the number of available
results is larger than `page_size`, the service returns a `next_page_token` that can be used
to get the next page of results in subsequent ListBackups requests.
Acceptable values are 0 to 1000, inclusive. Default value: 100. ||
|| page_token | **string**

Page token. Set `page_token` to the `next_page_token` returned by a previous ListBackups
request to get the next page of results. ||
|#

## ListBackupsResponse {#yandex.cloud.mdb.elasticsearch.v1.ListBackupsResponse}

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
      "elasticsearch_version": "string",
      "size_bytes": "int64",
      "indices_total": "int64"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| backups[] | **[Backup](#yandex.cloud.mdb.elasticsearch.v1.Backup)**

Requested list of backups. ||
|| next_page_token | **string**

This token allows you to get the next page of results for ListBackups requests,
if the number of results is larger than `page_size` specified in the request.
To get the next page, specify the value of `next_page_token` as a value for
the `page_token` parameter in the next ListBackups request. Subsequent ListBackups
requests will have their own `next_page_token` to continue paging through the results. ||
|#

## Backup {#yandex.cloud.mdb.elasticsearch.v1.Backup}

#|
||Field | Description ||
|| id | **string**

Required. ID of the backup. ||
|| folder_id | **string**

ID of the folder that the backup belongs to. ||
|| source_cluster_id | **string**

ID of the associated Elasticsearch cluster. ||
|| started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the backup operation was started. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the backup was created (i.e. when the backup operation completed). ||
|| indices[] | **string**

Indices names. (max 100) ||
|| elasticsearch_version | **string**

Elasticsearch version used to create the snapshot ||
|| size_bytes | **int64**

Total size of all indices in backup. in bytes ||
|| indices_total | **int64**

Total count of indices in backup ||
|#