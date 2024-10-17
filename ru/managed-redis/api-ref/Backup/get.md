---
editable: false
sourcePath: en/_api-ref/mdb/redis/v1/api-ref/Backup/get.md
---

# Managed Service for Redis API, REST: Backup.Get {#Get}

Returns the specified Redis backup.

To get the list of available Redis backups, make a [List](/docs/managed-redis/api-ref/Backup/list#List) request.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-redis/v1/backups/{backupId}
```

## Path parameters

#|
||Field | Description ||
|| backupId | **string**

Required field. ID of the Redis backup to return.
To get the backup ID, use a [ClusterService.ListBackups](/docs/managed-redis/api-ref/Cluster/listBackups#ListBackups) request. ||
|#

## Response {#yandex.cloud.mdb.redis.v1.Backup}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "sourceClusterId": "string",
  "startedAt": "string",
  "sourceShardNames": [
    "string"
  ]
}
```

Description of a Redis backup. For more information, see
the Managed Service for Redis [documentation](/docs/managed-redis/concepts/backup).

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

ID of the Redis cluster that the backup was created for. ||
|| startedAt | **string** (date-time)

Start timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format
(i.e. when the backup operation was started).

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| sourceShardNames[] | **string**

Shard names used as a source for backup. ||
|#