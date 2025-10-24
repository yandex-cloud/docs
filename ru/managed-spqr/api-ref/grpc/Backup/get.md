---
editable: false
sourcePath: en/_api-ref-grpc/mdb/spqr/v1/api-ref/grpc/Backup/get.md
---

# Managed Service for SPQR API, gRPC: BackupService.Get

Returns the specified SPQR backup.

To get the list of available SPQR backups, make a [List](/docs/managed-spqr/api-ref/grpc/Backup/list#List) request.

## gRPC request

**rpc Get ([GetBackupRequest](#yandex.cloud.mdb.spqr.v1.GetBackupRequest)) returns ([Backup](#yandex.cloud.mdb.spqr.v1.Backup))**

## GetBackupRequest {#yandex.cloud.mdb.spqr.v1.GetBackupRequest}

```json
{
  "backup_id": "string"
}
```

#|
||Field | Description ||
|| backup_id | **string**

Required field. ID of the backup to return information about.
To get the backup ID, use a [ClusterService.ListBackups](/docs/managed-spqr/api-ref/grpc/Cluster/listBackups#ListBackups) request. ||
|#

## Backup {#yandex.cloud.mdb.spqr.v1.Backup}

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
  "size": "int64",
  "type": "BackupType"
}
```

A SPQR Backup resource. For more information, see the
[Developer's Guide](/docs/managed-spqr/concepts).

#|
||Field | Description ||
|| id | **string**

ID of the backup. Required. ||
|| folder_id | **string**

ID of the folder that the backup belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format
(i.e. when the backup operation was completed). ||
|| source_cluster_id | **string**

ID of the SPQR cluster that the backup was created for. ||
|| started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the backup operation was started. ||
|| source_shard_names[] | **string**

Shard names used as a source for backup. ||
|| size | **int64**

Size of backup in bytes ||
|| type | enum **BackupType**

How this backup was created (manual/automatic/etc...)

- `BACKUP_TYPE_UNSPECIFIED`
- `AUTOMATED`: Backup created by automated daily schedule
- `MANUAL`: Backup created by user request ||
|#