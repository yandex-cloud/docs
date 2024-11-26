---
editable: false
sourcePath: en/_api-ref/mdb/mysql/v1/api-ref/Backup/get.md
---

# Managed Service for MySQL API, REST: Backup.Get

Retrieves information about the specified backup.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-mysql/v1/backups/{backupId}
```

## Path parameters

#|
||Field | Description ||
|| backupId | **string**

Required field. ID of the backup to return information about.

To get this ID, make a [BackupService.List](/docs/managed-mysql/api-ref/Backup/list#List) request (lists all backups in a folder) or a [ClusterService.ListBackups](/docs/managed-mysql/api-ref/Cluster/listBackups#ListBackups) request (lists all backups for an existing cluster). ||
|#

## Response {#yandex.cloud.mdb.mysql.v1.Backup}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "sourceClusterId": "string",
  "startedAt": "string",
  "size": "string",
  "type": "string",
  "status": "string"
}
```

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
|#