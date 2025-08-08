---
editable: false
apiPlayground:
  - url: https://backup.{{ api-host }}/backup/v1/backups/{backupId}
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
      required:
        - folderId
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/backup/v1/backup/api-ref/Backup/get.md
---

# Cloud Backup API, REST: Backup.Get

Get backup by its id.

## HTTP request

```
GET https://backup.{{ api-host }}/backup/v1/backups/{backupId}
```

## Path parameters

#|
||Field | Description ||
|| backupId | **string**

Required field. Backup ID. ||
|#

## Query parameters {#yandex.cloud.backup.v1.GetBackupRequest}

#|
||Field | Description ||
|| folderId | **string**

Required field. Folder ID. ||
|#

## Response {#yandex.cloud.backup.v1.Backup}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "vaultId": "string",
  "archiveId": "string",
  "createdAt": "string",
  "lastSeenAt": "string",
  "size": "string",
  "deduplicatedSize": "string",
  "backedUpDataSize": "string",
  "originalDataSize": "string",
  "attributes": {
    "streamName": "string",
    "uri": "string"
  },
  "computeInstanceId": "string",
  "disks": [
    {
      "deviceModel": "string",
      "name": "string",
      "size": "string",
      "volumes": [
        {
          "freeSpace": "string",
          "isBootable": "boolean",
          "isSystem": "boolean",
          "name": "string",
          "size": "string",
          "mountStrid": "string"
        }
      ]
    }
  ],
  "type": "string",
  "deleted": "boolean",
  "policyId": "string",
  "resourceId": "string"
}
```

#|
||Field | Description ||
|| id | **string**

ID of the backup. ||
|| vaultId | **string**

ID of the backup vault. ||
|| archiveId | **string**

ID of the backup archive. ||
|| createdAt | **string** (date-time)

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
|| size | **string** (int64)

Backup size. ||
|| deduplicatedSize | **string** (int64)

Deduplicated backup size. ||
|| backedUpDataSize | **string** (int64)

Backed up data size. ||
|| originalDataSize | **string** (int64)

Original data size. ||
|| attributes | **[BackupAttributes](#yandex.cloud.backup.v1.Backup.BackupAttributes)** ||
|| computeInstanceId | **string**

Compute Cloud instance ID. ||
|| disks[] | **[Disk](#yandex.cloud.backup.v1.Disk)** ||
|| type | **enum** (Type)

- `TYPE_UNSPECIFIED`
- `FULL`
- `INCREMENTAL` ||
|| deleted | **boolean**

If this field is true, it means that the backup was deleted. ||
|| policyId | **string**

[Policy](/docs/backup/concepts/policy) ID. ||
|| resourceId | **string**

Resource ID. It identifies Compute Cloud instance in backup service. ||
|#

## BackupAttributes {#yandex.cloud.backup.v1.Backup.BackupAttributes}

Backup attributes.

#|
||Field | Description ||
|| streamName | **string**

Backup stream name. ||
|| uri | **string**

URI of the backup archive. ||
|#

## Disk {#yandex.cloud.backup.v1.Disk}

#|
||Field | Description ||
|| deviceModel | **string**

Device model. ||
|| name | **string**

Disk name. ||
|| size | **string** (int64)

Disk size. ||
|| volumes[] | **[Volume](#yandex.cloud.backup.v1.Volume)** ||
|#

## Volume {#yandex.cloud.backup.v1.Volume}

#|
||Field | Description ||
|| freeSpace | **string** (int64)

Free space in the volume. ||
|| isBootable | **boolean**

If this field is true, it means that the volume is bootable. ||
|| isSystem | **boolean**

If this field is true, it means that the volume is a system volume. ||
|| name | **string**

Volume name. ||
|| size | **string** (int64)

Volume size. ||
|| mountStrid | **string**

Mount string ID. ||
|#