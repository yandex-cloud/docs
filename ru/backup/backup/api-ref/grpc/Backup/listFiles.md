---
editable: false
sourcePath: en/_api-ref-grpc/backup/v1/backup/api-ref/grpc/Backup/listFiles.md
---

# Cloud Backup API, gRPC: BackupService.ListFiles

ListFiles of the backup.

## gRPC request

**rpc ListFiles ([ListFilesRequest](#yandex.cloud.backup.v1.ListFilesRequest)) returns ([ListFilesResponse](#yandex.cloud.backup.v1.ListFilesResponse))**

## ListFilesRequest {#yandex.cloud.backup.v1.ListFilesRequest}

```json
{
  "folder_id": "string",
  "backup_id": "string",
  "source_id": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. Folder ID. ||
|| backup_id | **string**

Required field. Backup ID. ||
|| source_id | **string**

Empty source will list disks of the backup. ||
|#

## ListFilesResponse {#yandex.cloud.backup.v1.ListFilesResponse}

```json
{
  "files": [
    {
      "id": "string",
      "parent_id": "google.protobuf.StringValue",
      "type": "Type",
      "full_path": "string",
      "name": "string",
      "size": "int64",
      "actions": {
        "restore_to_disk": "bool",
        "go_to_location": "bool"
      },
      "modified_at": "google.protobuf.Timestamp"
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
|| parent_id | **[google.protobuf.StringValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/string-value)**

Might be empty if this is root directory. ||
|| type | enum **Type**

Required field. Type of the item.

- `TYPE_UNSPECIFIED`
- `TYPE_DIR`
- `TYPE_FILE` ||
|| full_path | **string**

Required field. Absolute path of the item. ||
|| name | **string**

Required field. Name of the directory / file. ||
|| size | **int64**

Size in bytes of the item. ||
|| actions | **[Actions](#yandex.cloud.backup.v1.BackupFile.Actions)**

Required field. Actions that might be done on the object. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Required field.  ||
|#

## Actions {#yandex.cloud.backup.v1.BackupFile.Actions}

#|
||Field | Description ||
|| restore_to_disk | **bool**

Allows to send request to restore item to disk ||
|| go_to_location | **bool**

Allows to move to location by id. ||
|#