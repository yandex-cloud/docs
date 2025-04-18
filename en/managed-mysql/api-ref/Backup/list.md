---
editable: false
sourcePath: en/_api-ref/mdb/mysql/v1/api-ref/Backup/list.md
---

# Managed Service for MySQL API, REST: Backup.List

Retrieves the list of backups in a folder.

To list backups for an existing cluster, make a [ClusterService.ListBackups](/docs/managed-mysql/api-ref/Cluster/listBackups#ListBackups) request.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-mysql/v1/backups
```

## Query parameters {#yandex.cloud.mdb.mysql.v1.ListBackupsRequest}

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to list backups in.

To get this ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return.

If the number of available results is larger than `pageSize`, the API returns a [ListBackupsResponse.nextPageToken](#yandex.cloud.mdb.mysql.v1.ListBackupsResponse) that can be used to get the next page of results in the subsequent [BackupService.List](#List) requests. ||
|| pageToken | **string**

Page token that can be used to iterate through multiple pages of results.

To get the next page of results, set `pageToken` to the [ListBackupsResponse.nextPageToken](#yandex.cloud.mdb.mysql.v1.ListBackupsResponse) returned by the previous [BackupService.List](#List) request. ||
|#

## Response {#yandex.cloud.mdb.mysql.v1.ListBackupsResponse}

**HTTP Code: 200 - OK**

```json
{
  "backups": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "string",
      "sourceClusterId": "string",
      "startedAt": "string",
      "size": "string",
      "type": "string",
      "status": "string",
      "journalSize": "string"
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
|| createdAt | **string** (date-time)

Creation timestamp (the time when the backup operation was completed).

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| sourceClusterId | **string**

ID of the cluster that the backup was created for. ||
|| startedAt | **string** (date-time)

Start timestamp (the time when the backup operation was started).

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| size | **string** (int64)

Size of backup, in bytes ||
|| type | **enum** (BackupCreationType)

How this backup was created (manual/automatic/etc...)

- `BACKUP_CREATION_TYPE_UNSPECIFIED`
- `AUTOMATED`: Backup created by automated daily schedule
- `MANUAL`: Backup created by user request ||
|| status | **enum** (BackupStatus)

Status of backup

- `BACKUP_STATUS_UNSPECIFIED`
- `DONE`: Backup is done
- `CREATING`: Backup is creating ||
|| journalSize | **string** (int64)

Size of the journal associated with backup, in bytes. ||
|#