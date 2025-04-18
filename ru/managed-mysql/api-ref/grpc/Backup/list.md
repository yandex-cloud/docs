---
editable: false
sourcePath: en/_api-ref-grpc/mdb/mysql/v1/api-ref/grpc/Backup/list.md
---

# Managed Service for MySQL API, gRPC: BackupService.List

Retrieves the list of backups in a folder.

To list backups for an existing cluster, make a [ClusterService.ListBackups](/docs/managed-mysql/api-ref/grpc/Cluster/listBackups#ListBackups) request.

## gRPC request

**rpc List ([ListBackupsRequest](#yandex.cloud.mdb.mysql.v1.ListBackupsRequest)) returns ([ListBackupsResponse](#yandex.cloud.mdb.mysql.v1.ListBackupsResponse))**

## ListBackupsRequest {#yandex.cloud.mdb.mysql.v1.ListBackupsRequest}

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

To get this ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| page_size | **int64**

The maximum number of results per page to return.

If the number of available results is larger than `page_size`, the API returns a [ListBackupsResponse.next_page_token](#yandex.cloud.mdb.mysql.v1.ListBackupsResponse) that can be used to get the next page of results in the subsequent [BackupService.List](#List) requests. ||
|| page_token | **string**

Page token that can be used to iterate through multiple pages of results.

To get the next page of results, set `page_token` to the [ListBackupsResponse.next_page_token](#yandex.cloud.mdb.mysql.v1.ListBackupsResponse) returned by the previous [BackupService.List](#List) request. ||
|#

## ListBackupsResponse {#yandex.cloud.mdb.mysql.v1.ListBackupsResponse}

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
      "status": "BackupStatus",
      "journal_size": "int64"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| backups[] | **[Backup](#yandex.cloud.mdb.mysql.v1.Backup)**

List of backups. ||
|| next_page_token | **string**

The token that can be used to get the next page of results.

If the number of results is larger than [ListBackupsRequest.page_size](#yandex.cloud.mdb.mysql.v1.ListBackupsRequest), use the `next_page_token` as the value for the [ListBackupsRequest.page_token](#yandex.cloud.mdb.mysql.v1.ListBackupsRequest) in the subsequent [BackupService.List](#List) request to iterate through multiple pages of results.

Each of the subsequent [BackupService.List](#List) requests should use the `next_page_token` value returned by the previous request to continue paging through the results. ||
|#

## Backup {#yandex.cloud.mdb.mysql.v1.Backup}

An object that represents MySQL backup.

See [the documentation](/docs/managed-mysql/concepts/backup) for details.

#|
||Field | Description ||
|| id | **string**

Required field. ID of the backup. ||
|| folder_id | **string**

ID of the folder that the backup belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp (the time when the backup operation was completed). ||
|| source_cluster_id | **string**

ID of the cluster that the backup was created for. ||
|| started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Start timestamp (the time when the backup operation was started). ||
|| size | **int64**

Size of backup, in bytes ||
|| type | enum **BackupCreationType**

How this backup was created (manual/automatic/etc...)

- `BACKUP_CREATION_TYPE_UNSPECIFIED`
- `AUTOMATED`: Backup created by automated daily schedule
- `MANUAL`: Backup created by user request ||
|| status | enum **BackupStatus**

Status of backup

- `BACKUP_STATUS_UNSPECIFIED`
- `DONE`: Backup is done
- `CREATING`: Backup is creating ||
|| journal_size | **int64**

Size of the journal associated with backup, in bytes. ||
|#