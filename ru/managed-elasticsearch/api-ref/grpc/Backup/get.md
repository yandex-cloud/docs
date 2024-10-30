---
editable: false
sourcePath: en/_api-ref-grpc/mdb/elasticsearch/v1/api-ref/grpc/Backup/get.md
---

# Managed Service for Elasticsearch API, gRPC: BackupService.Get {#Get}

Returns the specified backup of Elasticsearch cluster.

## gRPC request

**rpc Get ([GetBackupRequest](#yandex.cloud.mdb.elasticsearch.v1.GetBackupRequest)) returns ([Backup](#yandex.cloud.mdb.elasticsearch.v1.Backup))**

## GetBackupRequest {#yandex.cloud.mdb.elasticsearch.v1.GetBackupRequest}

```json
{
  "backupId": "string"
}
```

#|
||Field | Description ||
|| backupId | **string**

Required field. Required. ID of the backup to return. ||
|#

## Backup {#yandex.cloud.mdb.elasticsearch.v1.Backup}

```json
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
```

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