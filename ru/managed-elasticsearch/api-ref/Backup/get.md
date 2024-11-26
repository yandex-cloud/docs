---
editable: false
sourcePath: en/_api-ref/mdb/elasticsearch/v1/api-ref/Backup/get.md
---

# Managed Service for Elasticsearch API, REST: Backup.Get

Returns the specified backup of Elasticsearch cluster.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-elasticsearch/v1/backups/{backupId}
```

## Path parameters

#|
||Field | Description ||
|| backupId | **string**

Required field. Required. ID of the backup to return. ||
|#

## Response {#yandex.cloud.mdb.elasticsearch.v1.Backup}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "folderId": "string",
  "sourceClusterId": "string",
  "startedAt": "string",
  "createdAt": "string",
  "indices": [
    "string"
  ],
  "elasticsearchVersion": "string",
  "sizeBytes": "string",
  "indicesTotal": "string"
}
```

#|
||Field | Description ||
|| id | **string**

Required. ID of the backup. ||
|| folderId | **string**

ID of the folder that the backup belongs to. ||
|| sourceClusterId | **string**

ID of the associated Elasticsearch cluster. ||
|| startedAt | **string** (date-time)

The time when the backup operation was started.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdAt | **string** (date-time)

The time when the backup was created (i.e. when the backup operation completed).

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| indices[] | **string**

Indices names. (max 100) ||
|| elasticsearchVersion | **string**

Elasticsearch version used to create the snapshot ||
|| sizeBytes | **string** (int64)

Total size of all indices in backup. in bytes ||
|| indicesTotal | **string** (int64)

Total count of indices in backup ||
|#