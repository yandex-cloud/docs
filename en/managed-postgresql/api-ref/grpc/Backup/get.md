---
editable: false
sourcePath: en/_api-ref-grpc/mdb/postgresql/v1/api-ref/grpc/Backup/get.md
---

# Managed Service for PostgreSQL API, gRPC: BackupService.Get

Returns the specified PostgreSQL Backup resource.

To get the list of available PostgreSQL Backup resources, make a [List](/docs/managed-postgresql/api-ref/grpc/Backup/list#List) request.

## gRPC request

**rpc Get ([GetBackupRequest](#yandex.cloud.mdb.postgresql.v1.GetBackupRequest)) returns ([Backup](#yandex.cloud.mdb.postgresql.v1.Backup))**

## GetBackupRequest {#yandex.cloud.mdb.postgresql.v1.GetBackupRequest}

```json
{
  "backup_id": "string"
}
```

#|
||Field | Description ||
|| backup_id | **string**

Required field. ID of the backup to return information about.
To get the backup ID, use a [ClusterService.ListBackups](/docs/managed-postgresql/api-ref/grpc/Cluster/listBackups#ListBackups) request. ||
|#

## Backup {#yandex.cloud.mdb.postgresql.v1.Backup}

```json
{
  "id": "string",
  "folder_id": "string",
  "created_at": "google.protobuf.Timestamp",
  "source_cluster_id": "string",
  "started_at": "google.protobuf.Timestamp",
  "size": "int64",
  "type": "BackupCreationType",
  "method": "BackupMethod",
  "journal_size": "int64",
  "status": "BackupStatus"
}
```

A PostgreSQL Backup resource. For more information, see
the [Developer's Guide](/docs/managed-postgresql/concepts/backup).

#|
||Field | Description ||
|| id | **string**

Required. ID of the backup. ||
|| folder_id | **string**

ID of the folder that the backup belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format
(i.e. when the backup operation was completed). ||
|| source_cluster_id | **string**

ID of the PostgreSQL cluster that the backup was created for. ||
|| started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the backup operation was started. ||
|| size | **int64**

Size of backup, in bytes ||
|| type | enum **BackupCreationType**

How this backup was created (manual/automatic/etc...)

- `BACKUP_CREATION_TYPE_UNSPECIFIED`
- `AUTOMATED`: Backup created by automated daily schedule
- `MANUAL`: Backup created by user request ||
|| method | enum **BackupMethod**

Method of backup creation

- `BACKUP_METHOD_UNSPECIFIED`
- `BASE`: Base backup
- `INCREMENTAL`: Delta (incremental) PostgreSQL backup ||
|| journal_size | **int64**

Size of the journal associated with backup, in bytes ||
|| status | enum **BackupStatus**

Status of backup

- `BACKUP_STATUS_UNSPECIFIED`
- `DONE`: Backup is done
- `CREATING`: Backup is creating ||
|#