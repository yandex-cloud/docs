---
editable: false
sourcePath: en/_api-ref-grpc/mdb/elasticsearch/v1/api-ref/grpc/Backup/get.md
---

# Managed Service for Elasticsearch API, gRPC: BackupService.Get

Returns the specified backup of Elasticsearch cluster.

## gRPC request

**rpc Get ([GetBackupRequest](#yandex.cloud.mdb.elasticsearch.v1.GetBackupRequest)) returns ([Backup](#yandex.cloud.mdb.elasticsearch.v1.Backup))**

## GetBackupRequest {#yandex.cloud.mdb.elasticsearch.v1.GetBackupRequest}

```json
{
  "backup_id": "string"
}
```

#|
||Field | Description ||
|| backup_id | **string**

Required field. Required. ID of the backup to return. ||
|#

## Backup {#yandex.cloud.mdb.elasticsearch.v1.Backup}

```json
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
```

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