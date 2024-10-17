---
editable: false
sourcePath: en/_api-ref-grpc/mdb/opensearch/v1/api-ref/grpc/Backup/get.md
---

# Managed Service for OpenSearch API, gRPC: BackupService.Get {#Get}

Returns the specified backup of an OpenSearch cluster.

## gRPC request

**rpc Get ([GetBackupRequest](#yandex.cloud.mdb.opensearch.v1.GetBackupRequest)) returns ([Backup](#yandex.cloud.mdb.opensearch.v1.Backup))**

## GetBackupRequest {#yandex.cloud.mdb.opensearch.v1.GetBackupRequest}

```json
{
  "backupId": "string"
}
```

#|
||Field | Description ||
|| backupId | **string**

Required field. ID of the backup to return. ||
|#

## Backup {#yandex.cloud.mdb.opensearch.v1.Backup}

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
  "opensearchVersion": "string",
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