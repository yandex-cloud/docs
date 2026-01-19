---
editable: false
sourcePath: en/_api-ref-grpc/mdb/redis/v1/api-ref/grpc/Backup/get.md
---

# Managed Service for Redis API, gRPC: BackupService.Get

Returns the specified Redis backup.

To get the list of available Redis backups, make a [List](/docs/managed-redis/api-ref/grpc/Backup/list#List) request.

## gRPC request

**rpc Get ([GetBackupRequest](#yandex.cloud.mdb.redis.v1.GetBackupRequest)) returns ([Backup](#yandex.cloud.mdb.redis.v1.Backup))**

## GetBackupRequest {#yandex.cloud.mdb.redis.v1.GetBackupRequest}

```json
{
  "backup_id": "string"
}
```

#|
||Field | Description ||
|| backup_id | **string**

Required field. ID of the Redis backup to return.
To get the backup ID, use a [ClusterService.ListBackups](/docs/managed-redis/api-ref/grpc/Cluster/listBackups#ListBackups) request. ||
|#

## Backup {#yandex.cloud.mdb.redis.v1.Backup}

```json
{
  "id": "string",
  "folder_id": "string",
  "created_at": "google.protobuf.Timestamp",
  "source_cluster_id": "string",
  "started_at": "google.protobuf.Timestamp",
  "source_shard_names": [
    "string"
  ],
  "type": "BackupType"
}
```

Description of a Redis backup. For more information, see
the Managed Service for Redis [documentation](/docs/managed-redis/concepts/backup).

#|
||Field | Description ||
|| id | **string**

ID of the backup. ||
|| folder_id | **string**

ID of the folder that the backup belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format
(i.e. when the backup operation was completed). ||
|| source_cluster_id | **string**

ID of the Redis cluster that the backup was created for. ||
|| started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Start timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format
(i.e. when the backup operation was started). ||
|| source_shard_names[] | **string**

Shard names used as a source for backup. ||
|| type | enum **BackupType**

How this backup was created (manual/automatic/etc...)

- `BACKUP_TYPE_UNSPECIFIED`
- `AUTOMATED`: Backup created by automated daily schedule
- `MANUAL`: Backup created by user request ||
|#