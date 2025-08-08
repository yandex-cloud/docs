---
editable: false
apiPlayground:
  - url: https://backup.{{ api-host }}/backup/v1/backups/{backupId}/files
    method: get
    path:
      type: object
      properties:
        backupId:
          description: |-
            **string**
            Required field. Backup ID.
          type: string
      required:
        - backupId
      additionalProperties: false
    query:
      type: object
      properties:
        folderId:
          description: |-
            **string**
            Required field. Folder ID.
          type: string
        sourceId:
          description: |-
            **string**
            Empty source will list disks of the backup.
          type: string
      required:
        - folderId
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/backup/v1/backup/api-ref/Backup/listFiles.md
---

# Cloud Backup API, REST: Backup.ListFiles

ListFiles of the backup.

## HTTP request

```
GET https://backup.{{ api-host }}/backup/v1/backups/{backupId}/files
```

## Path parameters

#|
||Field | Description ||
|| backupId | **string**

Required field. Backup ID. ||
|#

## Query parameters {#yandex.cloud.backup.v1.ListFilesRequest}

#|
||Field | Description ||
|| folderId | **string**

Required field. Folder ID. ||
|| sourceId | **string**

Empty source will list disks of the backup. ||
|#

## Response {#yandex.cloud.backup.v1.ListFilesResponse}

**HTTP Code: 200 - OK**

```json
{
  "files": [
    {
      "id": "string",
      "parentId": "string",
      "type": "string",
      "fullPath": "string",
      "name": "string",
      "size": "string",
      "actions": {
        "restoreToDisk": "boolean",
        "goToLocation": "boolean"
      },
      "modifiedAt": "string"
    }
  ]
}
```

#|
||Field | Description ||
|| files[] | **[BackupFile](#yandex.cloud.backup.v1.BackupFile)** ||
|#

## BackupFile {#yandex.cloud.backup.v1.BackupFile}

BackupFile represents a single unit of file or directory system inside the backup.

#|
||Field | Description ||
|| id | **string**

Required field. ID of the item. Should be used as source ID in case of listing. ||
|| parentId | **string**

Might be empty if this is root directory. ||
|| type | **enum** (Type)

Required field. Type of the item.

- `TYPE_UNSPECIFIED`
- `TYPE_DIR`
- `TYPE_FILE` ||
|| fullPath | **string**

Required field. Absolute path of the item. ||
|| name | **string**

Required field. Name of the directory / file. ||
|| size | **string** (int64)

Size in bytes of the item. ||
|| actions | **[Actions](#yandex.cloud.backup.v1.BackupFile.Actions)**

Required field. Actions that might be done on the object. ||
|| modifiedAt | **string** (date-time)

Required field. String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|#

## Actions {#yandex.cloud.backup.v1.BackupFile.Actions}

#|
||Field | Description ||
|| restoreToDisk | **boolean**

Allows to send request to restore item to disk ||
|| goToLocation | **boolean**

Allows to move to location by id. ||
|#