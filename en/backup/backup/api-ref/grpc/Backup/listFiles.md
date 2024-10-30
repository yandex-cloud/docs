---
editable: false
sourcePath: en/_api-ref-grpc/backup/v1/backup/api-ref/grpc/Backup/listFiles.md
---

# Cloud Backup API, gRPC: BackupService.ListFiles {#ListFiles}

ListFiles of the backup.

## gRPC request

**rpc ListFiles ([ListFilesRequest](#yandex.cloud.backup.v1.ListFilesRequest)) returns ([ListFilesResponse](#yandex.cloud.backup.v1.ListFilesResponse))**

## ListFilesRequest {#yandex.cloud.backup.v1.ListFilesRequest}

```json
{
  "folderId": "string",
  "backupId": "string",
  "sourceId": "string"
}
```

#|
||Field | Description ||
|| folderId | **string**

Required field. Folder ID. ||
|| backupId | **string**

Required field. Backup ID. ||
|| sourceId | **string**

Empty source will list disks of the backup. ||
|#

## ListFilesResponse {#yandex.cloud.backup.v1.ListFilesResponse}

```json
{
  "files": [
    {
      "id": "string",
      "parentId": "google.protobuf.StringValue",
      "type": "Type",
      "fullPath": "string",
      "name": "string",
      "size": "int64",
      "actions": {
        "restoreToDisk": "bool",
        "goToLocation": "bool"
      },
      "modifiedAt": "google.protobuf.Timestamp"
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
|| parentId | **[google.protobuf.StringValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/string-value)**

Might be empty if this is root directory. ||
|| type | enum **Type**

Required field. Type of the item.

- `TYPE_UNSPECIFIED`
- `TYPE_DIR`
- `TYPE_FILE` ||
|| fullPath | **string**

Required field. Absolute path of the item. ||
|| name | **string**

Required field. Name of the directory / file. ||
|| size | **int64**

Size in bytes of the item. ||
|| actions | **[Actions](#yandex.cloud.backup.v1.BackupFile.Actions)**

Required field. Actions that might be done on the object. ||
|| modifiedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Required field.  ||
|#

## Actions {#yandex.cloud.backup.v1.BackupFile.Actions}

#|
||Field | Description ||
|| restoreToDisk | **bool**

Allows to send request to restore item to disk ||
|| goToLocation | **bool**

Allows to move to location by id. ||
|#