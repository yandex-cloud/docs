---
editable: false
apiPlayground:
  - url: https://{{ api-host-mdb }}/managed-opensearch/v1/backups/{backupId}
    method: get
    path:
      type: object
      properties:
        backupId:
          description: |-
            **string**
            Required field. ID of the backup to return.
          type: string
      required:
        - backupId
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/mdb/opensearch/v1/api-ref/Backup/get.md
---

# Managed Service for OpenSearch API, REST: Backup.Get

Returns the specified backup of an OpenSearch cluster.

## HTTP request

```
GET https://{{ api-host-mdb }}/managed-opensearch/v1/backups/{backupId}
```

## Path parameters

#|
||Field | Description ||
|| backupId | **string**

Required field. ID of the backup to return. ||
|#

## Response {#yandex.cloud.mdb.opensearch.v1.Backup}

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
  "opensearchVersion": "string",
  "sizeBytes": "string",
  "indicesTotal": "string",
  "incrementalSizeBytes": "string",
  "totalSizeBytes": "string",
  "freeSpaceRequiredBytes": "string"
}
```

#|
||Field | Description ||
|| id | **string**

Required. ID of the backup. ||
|| folderId | **string**

ID of the folder that the backup belongs to. ||
|| sourceClusterId | **string**

ID of the OpenSearch cluster that the backup was created for. ||
|| startedAt | **string** (date-time)

Time when the backup operation was started.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdAt | **string** (date-time)

Time when the backup operation was completed.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| indices[] | **string**

Names of indices in the backup. ||
|| opensearchVersion | **string**

OpenSearch version used to create the backup. ||
|| sizeBytes | **string** (int64)

Size of the backup in bytes. ||
|| indicesTotal | **string** (int64)

The number of indices in the backup. ||
|| incrementalSizeBytes | **string** (int64)

Size of files which were copied as part of the incremental snapshot. ||
|| totalSizeBytes | **string** (int64)

Size of files that are referenced by the snapshot. ||
|| freeSpaceRequiredBytes | **string** (int64)

The space amount required to restore from this backup. ||
|#