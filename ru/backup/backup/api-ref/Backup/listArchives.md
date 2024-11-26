---
editable: false
sourcePath: en/_api-ref/backup/v1/backup/api-ref/Backup/listArchives.md
---

# Cloud Backup API, REST: Backup.ListArchives

List archives that holds backups for specified folder or
specified [Compute Cloud instance](/docs/backup/concepts/vm-connection#os).

## HTTP request

```
GET https://backup.{{ api-host }}/backup/v1/backups/{computeInstanceId}/archives
```

## Path parameters

#|
||Field | Description ||
|| computeInstanceId | **string**

Required field. List of archives of the specified Compute Cloud instance.

Includes only one of the fields `folderId`, `computeInstanceId`. ||
|#

## Query parameters {#yandex.cloud.backup.v1.ListArchivesRequest}

#|
||Field | Description ||
|| folderId | **string**

List of archives in specified folder.

Includes only one of the fields `folderId`, `computeInstanceId`. ||
|#

## Response {#yandex.cloud.backup.v1.ListArchivesResponse}

**HTTP Code: 200 - OK**

```json
{
  "archives": [
    {
      "id": "string",
      "name": "string",
      "vaultId": "string",
      "attributes": {
        "aaib": "string",
        "uri": "string"
      },
      "size": "string",
      "compressedDataSize": "string",
      "dataSize": "string",
      "originalDataSize": "string",
      "logicalSize": "string",
      "format": "string",
      "createdAt": "string",
      "updatedAt": "string",
      "lastBackupCreatedAt": "string",
      "lastSeenAt": "string",
      "protectedByPassword": "boolean",
      "encryptionAlgorithm": "string",
      "actions": [
        "string"
      ],
      "backupPlanId": "string",
      "backupPlanName": "string",
      "description": "string",
      "displayName": "string",
      "computeInstanceId": "string",
      "consistent": "boolean",
      "deleted": "boolean",
      "resourceId": "string"
    }
  ]
}
```

#|
||Field | Description ||
|| archives[] | **[Archive](#yandex.cloud.backup.v1.Archive)** ||
|#

## Archive {#yandex.cloud.backup.v1.Archive}

Archive is a container that holds backups of Compute Cloud instance.

#|
||Field | Description ||
|| id | **string**

ID of the backup. ||
|| name | **string**

Name of the backup. ||
|| vaultId | **string**

ID of the backup vault. ||
|| attributes | **[ArchiveAttributes](#yandex.cloud.backup.v1.Archive.ArchiveAttributes)**

Archive attributes. ||
|| size | **string** (int64)

Archive size. ||
|| compressedDataSize | **string** (int64)

Compressed data size. ||
|| dataSize | **string** (int64)

Data size. ||
|| originalDataSize | **string** (int64)

Original data size. ||
|| logicalSize | **string** (int64)

Logical size. ||
|| format | **enum** (Format)

- `FORMAT_UNSPECIFIED`
- `VERSION_11`: A legacy backup format used in older versions. It's not recommended to use.
- `VERSION_12`: A new format recommended in most cases for fast backup and recovery.
- `AUTO`: Automatic version selection. Will be used version 12 unless the protection
plan (policy) appends backups to the ones created by earlier product
versions. ||
|| createdAt | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updatedAt | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| lastBackupCreatedAt | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| lastSeenAt | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| protectedByPassword | **boolean**

If this field is true, it means that any of encryption algorithm
has been chosen. ||
|| encryptionAlgorithm | **enum** (EncryptionAlgorithm)

- `ENCRYPTION_ALGORITHM_UNSPECIFIED`
- `NONE`
- `AES128`
- `AES192`
- `AES256` ||
|| actions[] | **enum** (Action)

- `ACTION_UNSPECIFIED`
- `REFRESH`
- `DELETE_BY_AGENT` ||
|| backupPlanId | **string**

Backup plan ID. ||
|| backupPlanName | **string**

Backup plan name. ||
|| description | **string**

Backup plan description. ||
|| displayName | **string**

Display name, e.g. `INSTANCE_NAME - POLICY_NAME`. ||
|| computeInstanceId | **string**

Compute Cloud instance ID. ||
|| consistent | **boolean**

If this field is true, it means that the archive is consistent. ||
|| deleted | **boolean**

If this field is true, it means that the archive was deleted. ||
|| resourceId | **string**

Resource ID. ||
|#

## ArchiveAttributes {#yandex.cloud.backup.v1.Archive.ArchiveAttributes}

Archive attributes.

#|
||Field | Description ||
|| aaib | **string**

Archive attribute. Default value: `0`. ||
|| uri | **string**

URI of the backup archive. ||
|#