---
editable: false
sourcePath: en/_api-ref/mdb/clickhouse/v1/api-ref/Backup/get.md
---

# Managed Service for ClickHouse API, REST: Backup.Get

Returns the specified ClickHouse Backup resource.

To get the list of available ClickHouse Backup resources, make a [List](/docs/managed-clickhouse/api-ref/Backup/list#List) request.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-clickhouse/v1/backups/{backupId}
```

## Path parameters

#|
||Field | Description ||
|| backupId | **string**

Required field. ID of the backup to return information about.
To get the backup ID, use a [ClusterService.ListBackups](/docs/managed-clickhouse/api-ref/Cluster/listBackups#ListBackups) request. ||
|#

## Response {#yandex.cloud.mdb.clickhouse.v1.Backup}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "sourceClusterId": "string",
  "sourceShardNames": [
    "string"
  ],
  "startedAt": "string",
  "size": "string",
  "type": "string"
}
```

A ClickHouse Backup resource. See the [Developer's Guide](/docs/managed-clickhouse/concepts)
for more information.

#|
||Field | Description ||
|| id | **string**

ID of the backup. ||
|| folderId | **string**

ID of the folder that the backup belongs to. ||
|| createdAt | **string** (date-time)

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format
(i.e. when the backup operation was completed).

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| sourceClusterId | **string**

ID of the ClickHouse cluster that the backup was created for. ||
|| sourceShardNames[] | **string**

Names of the shards included in the backup. ||
|| startedAt | **string** (date-time)

Time when the backup operation was started.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| size | **string** (int64)

Size of backup in bytes. ||
|| type | **enum** (BackupType)

How this backup was created (manual/automatic/etc...).

- `BACKUP_TYPE_UNSPECIFIED`
- `AUTOMATED`: Backup created by automated daily schedule.
- `MANUAL`: Backup created by user request. ||
|#