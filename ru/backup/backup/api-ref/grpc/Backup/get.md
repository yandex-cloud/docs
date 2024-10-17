---
editable: false
sourcePath: en/_api-ref-grpc/backup/v1/backup/api-ref/grpc/Backup/get.md
---

# Cloud Backup API, gRPC: BackupService.Get {#Get}

Get backup by its id.

## gRPC request

**rpc Get ([GetBackupRequest](#yandex.cloud.backup.v1.GetBackupRequest)) returns ([Backup](#yandex.cloud.backup.v1.Backup))**

## GetBackupRequest {#yandex.cloud.backup.v1.GetBackupRequest}

```json
{
  "backupId": "string",
  "folderId": "string"
}
```

#|
||Field | Description ||
|| backupId | **string**

Required field. Backup ID. ||
|| folderId | **string**

Required field. Folder ID. ||
|#

## Backup {#yandex.cloud.backup.v1.Backup}

```json
{
  "id": "string",
  "vaultId": "string",
  "archiveId": "string",
  "createdAt": "google.protobuf.Timestamp",
  "lastSeenAt": "google.protobuf.Timestamp",
  "size": "int64",
  "deduplicatedSize": "int64",
  "backedUpDataSize": "int64",
  "originalDataSize": "int64",
  "attributes": {
    "streamName": "string",
    "uri": "string"
  },
  "computeInstanceId": "string",
  "disks": [
    {
      "deviceModel": "string",
      "name": "string",
      "size": "int64",
      "volumes": [
        {
          "freeSpace": "int64",
          "isBootable": "bool",
          "isSystem": "bool",
          "name": "string",
          "size": "int64",
          "mountStrid": "string"
        }
      ]
    }
  ],
  "type": "Type",
  "deleted": "bool",
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
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| lastSeenAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| size | **int64**

Backup size. ||
|| deduplicatedSize | **int64**

Deduplicated backup size. ||
|| backedUpDataSize | **int64**

Backed up data size. ||
|| originalDataSize | **int64**

Original data size. ||
|| attributes | **[BackupAttributes](#yandex.cloud.backup.v1.Backup.BackupAttributes)** ||
|| computeInstanceId | **string**

Compute Cloud instance ID. ||
|| disks[] | **[Disk](#yandex.cloud.backup.v1.Disk)** ||
|| type | enum **Type**

- `TYPE_UNSPECIFIED`
- `FULL`
- `INCREMENTAL` ||
|| deleted | **bool**

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
|| size | **int64**

Disk size. ||
|| volumes[] | **[Volume](#yandex.cloud.backup.v1.Volume)** ||
|#

## Volume {#yandex.cloud.backup.v1.Volume}

#|
||Field | Description ||
|| freeSpace | **int64**

Free space in the volume. ||
|| isBootable | **bool**

If this field is true, it means that the volume is bootable. ||
|| isSystem | **bool**

If this field is true, it means that the volume is a system volume. ||
|| name | **string**

Volume name. ||
|| size | **int64**

Volume size. ||
|| mountStrid | **string**

Mount string ID. ||
|#