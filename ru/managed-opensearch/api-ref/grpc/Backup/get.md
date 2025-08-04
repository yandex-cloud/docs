---
editable: false
sourcePath: en/_api-ref-grpc/mdb/opensearch/v1/api-ref/grpc/Backup/get.md
---

# Managed Service for OpenSearch API, gRPC: BackupService.Get

Returns the specified backup of an OpenSearch cluster.

## gRPC request

**rpc Get ([GetBackupRequest](#yandex.cloud.mdb.opensearch.v1.GetBackupRequest)) returns ([Backup](#yandex.cloud.mdb.opensearch.v1.Backup))**

## GetBackupRequest {#yandex.cloud.mdb.opensearch.v1.GetBackupRequest}

```json
{
  "backup_id": "string"
}
```

#|
||Field | Description ||
|| backup_id | **string**

Required field. ID of the backup to return. ||
|#

## Backup {#yandex.cloud.mdb.opensearch.v1.Backup}

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
  "opensearch_version": "string",
  "size_bytes": "int64",
  "indices_total": "int64",
  "incremental_size_bytes": "int64",
  "total_size_bytes": "int64",
  "free_space_required_bytes": "int64"
}
```

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
|| incremental_size_bytes | **int64**

Size of files which were copied as part of the incremental snapshot. ||
|| total_size_bytes | **int64**

Size of files that are referenced by the snapshot. ||
|| free_space_required_bytes | **int64**

The space amount required to restore from this backup. ||
|#