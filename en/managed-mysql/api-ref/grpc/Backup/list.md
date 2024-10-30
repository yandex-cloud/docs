---
editable: false
sourcePath: en/_api-ref-grpc/mdb/mysql/v1/api-ref/grpc/Backup/list.md
---

# Managed Service for MySQL API, gRPC: BackupService.List {#List}

Retrieves the list of backups in a folder.

To list backups for an existing cluster, make a [ClusterService.ListBackups](/docs/managed-mysql/api-ref/grpc/Cluster/listBackups#ListBackups) request.

## gRPC request

**rpc List ([ListBackupsRequest](#yandex.cloud.mdb.mysql.v1.ListBackupsRequest)) returns ([ListBackupsResponse](#yandex.cloud.mdb.mysql.v1.ListBackupsResponse))**

## ListBackupsRequest {#yandex.cloud.mdb.mysql.v1.ListBackupsRequest}

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

To get this ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| pageSize | **int64**

The maximum number of results per page to return.

If the number of available results is larger than `pageSize`, the API returns a [ListBackupsResponse.nextPageToken](#yandex.cloud.mdb.mysql.v1.ListBackupsResponse) that can be used to get the next page of results in the subsequent [BackupService.List](#List) requests. ||
|| pageToken | **string**

Page token that can be used to iterate through multiple pages of results.

To get the next page of results, set `pageToken` to the [ListBackupsResponse.nextPageToken](#yandex.cloud.mdb.mysql.v1.ListBackupsResponse) returned by the previous [BackupService.List](#List) request. ||
|#

## ListBackupsResponse {#yandex.cloud.mdb.mysql.v1.ListBackupsResponse}

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
      "status": "BackupStatus"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| backups[] | **[Backup](#yandex.cloud.mdb.mysql.v1.Backup)**

List of backups. ||
|| nextPageToken | **string**

The token that can be used to get the next page of results.

If the number of results is larger than [ListBackupsRequest.pageSize](#yandex.cloud.mdb.mysql.v1.ListBackupsRequest), use the `nextPageToken` as the value for the [ListBackupsRequest.pageToken](#yandex.cloud.mdb.mysql.v1.ListBackupsRequest) in the subsequent [BackupService.List](#List) request to iterate through multiple pages of results.

Each of the subsequent [BackupService.List](#List) requests should use the `nextPageToken` value returned by the previous request to continue paging through the results. ||
|#

## Backup {#yandex.cloud.mdb.mysql.v1.Backup}

An object that represents MySQL backup.

See [the documentation](/docs/managed-mysql/concepts/backup) for details.

#|
||Field | Description ||
|| id | **string**

Required field. ID of the backup. ||
|| folderId | **string**

ID of the folder that the backup belongs to. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp (the time when the backup operation was completed). ||
|| sourceClusterId | **string**

ID of the cluster that the backup was created for. ||
|| startedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

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
|#