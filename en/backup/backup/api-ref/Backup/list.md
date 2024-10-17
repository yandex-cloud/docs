---
editable: false
sourcePath: en/_api-ref/backup/v1/backup/api-ref/Backup/list.md
---

# Cloud Backup API, REST: Backup.List {#List}

List backups using filters.

## HTTP request

```
GET https://backup.{{ api-host }}/backup/v1/backups
```

## Query parameters {#yandex.cloud.backup.v1.ListBackupsRequest}

#|
||Field | Description ||
|| computeInstanceId | **string**

List backups that belongs to specific Compute Cloud instance.

Includes only one of the fields `computeInstanceId`, `archive`, `folderId`, `instancePolicy`, `resourceId`, `policyId`. ||
|| archive | **[ArchiveParameters](#yandex.cloud.backup.v1.ListBackupsRequest.ArchiveParameters)**

List backups that belongs to specific archive of specific folder.

Includes only one of the fields `computeInstanceId`, `archive`, `folderId`, `instancePolicy`, `resourceId`, `policyId`. ||
|| folderId | **string**

List backups that belongs to specific folder.

Includes only one of the fields `computeInstanceId`, `archive`, `folderId`, `instancePolicy`, `resourceId`, `policyId`. ||
|| instancePolicy | **[InstancePolicy](#yandex.cloud.backup.v1.ListBackupsRequest.InstancePolicy)**

List backups that belongs to specific instance and policy at the same time.

Includes only one of the fields `computeInstanceId`, `archive`, `folderId`, `instancePolicy`, `resourceId`, `policyId`. ||
|| resourceId | **string**

List backups by specific resource ID.

Includes only one of the fields `computeInstanceId`, `archive`, `folderId`, `instancePolicy`, `resourceId`, `policyId`. ||
|| policyId | **string**

List backups by specific policy ID.

Includes only one of the fields `computeInstanceId`, `archive`, `folderId`, `instancePolicy`, `resourceId`, `policyId`. ||
|| orderBy | **string**

By which column the listing should be ordered and in which direction,
format is "createdAt desc". "createdAt desc" if omitted. ||
|| filter | **string**

Filter list by various parameters.
Supported parameters are:
* created_at

Supported logic operators:
* AND ||
|#

## ArchiveParameters {#yandex.cloud.backup.v1.ListBackupsRequest.ArchiveParameters}

#|
||Field | Description ||
|| archiveId | **string**

Required field. Archive ID. ||
|| folderId | **string**

Required field. Folder ID. ||
|#

## InstancePolicy {#yandex.cloud.backup.v1.ListBackupsRequest.InstancePolicy}

#|
||Field | Description ||
|| computeInstanceId | **string**

Compute Cloud instance ID. ||
|| policyId | **string**

Policy ID. ||
|#

## Response {#yandex.cloud.backup.v1.ListBackupsResponse}

**HTTP Code: 200 - OK**

```json
{
  "backups": [
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
  ]
}
```

#|
||Field | Description ||
|| backups[] | **[Backup](#yandex.cloud.backup.v1.Backup)** ||
|#

## Backup {#yandex.cloud.backup.v1.Backup}

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