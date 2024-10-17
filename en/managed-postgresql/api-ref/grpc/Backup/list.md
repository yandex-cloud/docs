---
editable: false
sourcePath: en/_api-ref-grpc/mdb/postgresql/v1/api-ref/grpc/Backup/list.md
---

# Managed Service for PostgreSQL API, gRPC: BackupService.List {#List}

Retrieves the list of Backup resources available for the specified folder.

## gRPC request

**rpc List ([ListBackupsRequest](#yandex.cloud.mdb.postgresql.v1.ListBackupsRequest)) returns ([ListBackupsResponse](#yandex.cloud.mdb.postgresql.v1.ListBackupsResponse))**

## ListBackupsRequest {#yandex.cloud.mdb.postgresql.v1.ListBackupsRequest}

```json
{
  "folderId": "string",
  "pageSize": "int64",
  "pageToken": "string"
}
```

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to list backups in.
To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| pageSize | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`, the service returns a [ListBackupsResponse.nextPageToken](#yandex.cloud.mdb.postgresql.v1.ListBackupsResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token.  To get the next page of results, Set `pageToken` to the [ListBackupsResponse.nextPageToken](#yandex.cloud.mdb.postgresql.v1.ListBackupsResponse)
returned by the previous list request. ||
|#

## ListBackupsResponse {#yandex.cloud.mdb.postgresql.v1.ListBackupsResponse}

```json
{
  "backups": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "google.protobuf.Timestamp",
      "sourceClusterId": "string",
      "startedAt": "google.protobuf.Timestamp",
      "size": "int64",
      "type": "BackupCreationType",
      "method": "BackupMethod",
      "journalSize": "int64",
      "status": "BackupStatus"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| backups[] | **[Backup](#yandex.cloud.mdb.postgresql.v1.Backup)**

List of PostgreSQL Backup resources. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListBackupsRequest.pageSize](#yandex.cloud.mdb.postgresql.v1.ListBackupsRequest), use the `nextPageToken` as the value
for the [ListBackupsRequest.pageToken](#yandex.cloud.mdb.postgresql.v1.ListBackupsRequest) parameter in the next list request. Each subsequent
list request will have its own `nextPageToken` to continue paging through the results. ||
|#

## Backup {#yandex.cloud.mdb.postgresql.v1.Backup}

A PostgreSQL Backup resource. For more information, see
the [Developer's Guide](/docs/managed-postgresql/concepts/backup).

#|
||Field | Description ||
|| id | **string**

Required. ID of the backup. ||
|| folderId | **string**

ID of the folder that the backup belongs to. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format
(i.e. when the backup operation was completed). ||
|| sourceClusterId | **string**

ID of the PostgreSQL cluster that the backup was created for. ||
|| startedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

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
|| journalSize | **int64**

Size of the journal associated with backup, in bytes ||
|| status | enum **BackupStatus**

Status of backup

- `BACKUP_STATUS_UNSPECIFIED`
- `DONE`: Backup is done
- `CREATING`: Backup is creating ||
|#