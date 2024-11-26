---
editable: false
sourcePath: en/_api-ref-grpc/backup/v1/backup/api-ref/grpc/Resource/listDirectory.md
---

# Cloud Backup API, gRPC: ResourceService.ListDirectory

ListDirectory returns all subdirectories found in requested directory identified
by the id.

## gRPC request

**rpc ListDirectory ([ListDirectoryRequest](#yandex.cloud.backup.v1.ListDirectoryRequest)) returns ([ListDirectoryResponse](#yandex.cloud.backup.v1.ListDirectoryResponse))**

## ListDirectoryRequest {#yandex.cloud.backup.v1.ListDirectoryRequest}

```json
{
  "folder_id": "string",
  "compute_instance_id": "string",
  "path": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. Folder ID. ||
|| compute_instance_id | **string**

Required field. Compute Cloud instance ID. ||
|| path | **string**

Path to list items in. ||
|#

## ListDirectoryResponse {#yandex.cloud.backup.v1.ListDirectoryResponse}

```json
{
  "items": [
    {
      "name": "string",
      "type": "Type",
      "file_type": "Type",
      "size": "int64"
    }
  ]
}
```

#|
||Field | Description ||
|| items[] | **[FilesystemItem](#yandex.cloud.backup.v1.ListDirectoryResponse.FilesystemItem)** ||
|#

## FilesystemItem {#yandex.cloud.backup.v1.ListDirectoryResponse.FilesystemItem}

#|
||Field | Description ||
|| name | **string**

Item name. ||
|| type | enum **Type**

Might be Volume, Directory of File.

- `TYPE_UNSPECIFIED`
- `VOLUME`
- `DIRECTORY`
- `FILE` ||
|| file_type | enum **Type**

Might be Directory or File.

- `TYPE_UNSPECIFIED`
- `VOLUME`
- `DIRECTORY`
- `FILE` ||
|| size | **int64** ||
|#