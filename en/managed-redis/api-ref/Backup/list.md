---
editable: false
sourcePath: en/_api-ref/mdb/redis/v1/api-ref/Backup/list.md
---

# Managed Service for Redis API, REST: Backup.List

Retrieves the list of Redis backups available for the specified folder.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-redis/v1/backups
```

## Query parameters {#yandex.cloud.mdb.redis.v1.ListBackupsRequest}

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to list backups in.
To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/Folder/list#List) request. ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`, the service returns a [ListBackupsResponse.nextPageToken](#yandex.cloud.mdb.redis.v1.ListBackupsResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the [ListBackupsResponse.nextPageToken](#yandex.cloud.mdb.redis.v1.ListBackupsResponse)
returned by the previous list request. ||
|#

## Response {#yandex.cloud.mdb.redis.v1.ListBackupsResponse}

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
      "sourceShardNames": [
        "string"
      ],
      "type": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| backups[] | **[Backup](#yandex.cloud.mdb.redis.v1.Backup)**

Requested list of backups. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListBackupsRequest.pageSize](#yandex.cloud.mdb.redis.v1.ListBackupsRequest), use the `nextPageToken` as the value
for the [ListBackupsRequest.pageToken](#yandex.cloud.mdb.redis.v1.ListBackupsRequest) parameter in the next list request. Each subsequent
list request will have its own `nextPageToken` to continue paging through the results. ||
|#

## Backup {#yandex.cloud.mdb.redis.v1.Backup}

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
|| type | **enum** (BackupType)

How this backup was created (manual/automatic/etc...)

- `BACKUP_TYPE_UNSPECIFIED`
- `AUTOMATED`: Backup created by automated daily schedule
- `MANUAL`: Backup created by user request ||
|#