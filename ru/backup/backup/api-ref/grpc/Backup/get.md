---
editable: false
sourcePath: en/_api-ref-grpc/backup/v1/backup/api-ref/grpc/Backup/get.md
---

# Cloud Backup API, gRPC: BackupService.Get

Get backup by its id.

## gRPC request

**rpc Get ([GetBackupRequest](#yandex.cloud.backup.v1.GetBackupRequest)) returns ([Backup](#yandex.cloud.backup.v1.Backup))**

## GetBackupRequest {#yandex.cloud.backup.v1.GetBackupRequest}

```json
{
  "backup_id": "string",
  "folder_id": "string"
}
```

#|
||Field | Description ||
|| backup_id | **string**

Required field. Backup ID. ||
|| folder_id | **string**

Required field. Folder ID. ||
|#

## Backup {#yandex.cloud.backup.v1.Backup}

```json
{
  "id": "string",
  "vault_id": "string",
  "archive_id": "string",
  "created_at": "google.protobuf.Timestamp",
  "last_seen_at": "google.protobuf.Timestamp",
  "size": "int64",
  "deduplicated_size": "int64",
  "backed_up_data_size": "int64",
  "original_data_size": "int64",
  "attributes": {
    "stream_name": "string",
    "uri": "string"
  },
  "compute_instance_id": "string",
  "disks": [
    {
      "device_model": "string",
      "name": "string",
      "size": "int64",
      "volumes": [
        {
          "free_space": "int64",
          "is_bootable": "bool",
          "is_system": "bool",
          "name": "string",
          "size": "int64",
          "mount_strid": "string"
        }
      ]
    }
  ],
  "type": "Type",
  "deleted": "bool",
  "policy_id": "string",
  "resource_id": "string"
}
```

#|
||Field | Description ||
|| id | **string**

ID of the backup. ||
|| vault_id | **string**

ID of the backup vault. ||
|| archive_id | **string**

ID of the backup archive. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| last_seen_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| size | **int64**

Backup size. ||
|| deduplicated_size | **int64**

Deduplicated backup size. ||
|| backed_up_data_size | **int64**

Backed up data size. ||
|| original_data_size | **int64**

Original data size. ||
|| attributes | **[BackupAttributes](#yandex.cloud.backup.v1.Backup.BackupAttributes)** ||
|| compute_instance_id | **string**

Compute Cloud instance ID. ||
|| disks[] | **[Disk](#yandex.cloud.backup.v1.Disk)** ||
|| type | enum **Type**

- `TYPE_UNSPECIFIED`
- `FULL`
- `INCREMENTAL` ||
|| deleted | **bool**

If this field is true, it means that the backup was deleted. ||
|| policy_id | **string**

[Policy](/docs/backup/concepts/policy) ID. ||
|| resource_id | **string**

Resource ID. It identifies Compute Cloud instance in backup service. ||
|#

## BackupAttributes {#yandex.cloud.backup.v1.Backup.BackupAttributes}

Backup attributes.

#|
||Field | Description ||
|| stream_name | **string**

Backup stream name. ||
|| uri | **string**

URI of the backup archive. ||
|#

## Disk {#yandex.cloud.backup.v1.Disk}

#|
||Field | Description ||
|| device_model | **string**

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
|| free_space | **int64**

Free space in the volume. ||
|| is_bootable | **bool**

If this field is true, it means that the volume is bootable. ||
|| is_system | **bool**

If this field is true, it means that the volume is a system volume. ||
|| name | **string**

Volume name. ||
|| size | **int64**

Volume size. ||
|| mount_strid | **string**

Mount string ID. ||
|#