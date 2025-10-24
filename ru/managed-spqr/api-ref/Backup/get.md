---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-spqr/v1/backups/{backupId}
    method: get
    path:
      type: object
      properties:
        backupId:
          description: |-
            **string**
            Required field. ID of the backup to return information about.
            To get the backup ID, use a [ClusterService.ListBackups](/docs/managed-spqr/api-ref/Cluster/listBackups#ListBackups) request.
          type: string
      required:
        - backupId
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/mdb/spqr/v1/api-ref/Backup/get.md
---

# Managed Service for SPQR API, REST: Backup.Get

Returns the specified SPQR backup.

To get the list of available SPQR backups, make a [List](/docs/managed-spqr/api-ref/Backup/list#List) request.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-spqr/v1/backups/{backupId}
```

## Path parameters

#|
||Field | Description ||
|| backupId | **string**

Required field. ID of the backup to return information about.
To get the backup ID, use a [ClusterService.ListBackups](/docs/managed-spqr/api-ref/Cluster/listBackups#ListBackups) request. ||
|#

## Response {#yandex.cloud.mdb.spqr.v1.Backup}

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
  ],
  "size": "string",
  "type": "string"
}
```

A SPQR Backup resource. For more information, see the
[Developer's Guide](/docs/managed-spqr/concepts).

#|
||Field | Description ||
|| id | **string**

ID of the backup. Required. ||
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

ID of the SPQR cluster that the backup was created for. ||
|| startedAt | **string** (date-time)

Time when the backup operation was started.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| sourceShardNames[] | **string**

Shard names used as a source for backup. ||
|| size | **string** (int64)

Size of backup in bytes ||
|| type | **enum** (BackupType)

How this backup was created (manual/automatic/etc...)

- `BACKUP_TYPE_UNSPECIFIED`
- `AUTOMATED`: Backup created by automated daily schedule
- `MANUAL`: Backup created by user request ||
|#