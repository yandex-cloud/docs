---
editable: false
sourcePath: en/_api-ref-grpc/mdb/postgresql/v1/api-ref/grpc/Backup/list.md
---

# Managed Service for PostgreSQL API, gRPC: BackupService.List

Retrieves the list of Backup resources available for the specified folder.

## gRPC request

**rpc List ([ListBackupsRequest](#yandex.cloud.mdb.postgresql.v1.ListBackupsRequest)) returns ([ListBackupsResponse](#yandex.cloud.mdb.postgresql.v1.ListBackupsResponse))**

## ListBackupsRequest {#yandex.cloud.mdb.postgresql.v1.ListBackupsRequest}

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

Required field. ID of the folder to list backups in.
To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListBackupsResponse.next_page_token](#yandex.cloud.mdb.postgresql.v1.ListBackupsResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| page_token | **string**

Page token.  To get the next page of results, Set `page_token` to the [ListBackupsResponse.next_page_token](#yandex.cloud.mdb.postgresql.v1.ListBackupsResponse)
returned by the previous list request. ||
|#

## ListBackupsResponse {#yandex.cloud.mdb.postgresql.v1.ListBackupsResponse}

```json
{
  "backups": [
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
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| backups[] | **[Backup](#yandex.cloud.mdb.postgresql.v1.Backup)**

List of PostgreSQL Backup resources. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListBackupsRequest.page_size](#yandex.cloud.mdb.postgresql.v1.ListBackupsRequest), use the `next_page_token` as the value
for the [ListBackupsRequest.page_token](#yandex.cloud.mdb.postgresql.v1.ListBackupsRequest) parameter in the next list request. Each subsequent
list request will have its own `next_page_token` to continue paging through the results. ||
|#

## Backup {#yandex.cloud.mdb.postgresql.v1.Backup}

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