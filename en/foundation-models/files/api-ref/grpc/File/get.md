---
editable: false
sourcePath: en/_api-ref-grpc/ai/files/v1/files/api-ref/grpc/File/get.md
---

# Files API, gRPC: FileService.Get

Retrieve details of a specific file by its ID.

## gRPC request

**rpc Get ([GetFileRequest](#yandex.cloud.ai.files.v1.GetFileRequest)) returns ([File](#yandex.cloud.ai.files.v1.File))**

## GetFileRequest {#yandex.cloud.ai.files.v1.GetFileRequest}

```json
{
  "file_id": "string"
}
```

Request message for retrieving a file by ID.

#|
||Field | Description ||
|| file_id | **string**

Required field. ID of the file to retrieve. ||
|#

## File {#yandex.cloud.ai.files.v1.File}

```json
{
  "id": "string",
  "folder_id": "string",
  "name": "string",
  "description": "string",
  "mime_type": "string",
  "created_by": "string",
  "created_at": "google.protobuf.Timestamp",
  "updated_by": "string",
  "updated_at": "google.protobuf.Timestamp",
  "expiration_config": {
    "expiration_policy": "ExpirationPolicy",
    "ttl_days": "int64"
  },
  "expires_at": "google.protobuf.Timestamp",
  "labels": "map<string, string>"
}
```

#|
||Field | Description ||
|| id | **string**

Unique identifier of the file. ||
|| folder_id | **string**

ID of the folder that the file belongs to. ||
|| name | **string**

Name of the file. ||
|| description | **string**

Description of the file. ||
|| mime_type | **string**

MIME type of the file, indicating the file's format (e.g., "application/pdf") ||
|| created_by | **string**

Identifier of the subject who created this file. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp representing when the file was created. ||
|| updated_by | **string**

Identifier of the subject who last updated this file. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp representing the last time this file was updated. ||
|| expiration_config | **[ExpirationConfig](#yandex.cloud.ai.common.ExpirationConfig)**

Configuration for the expiration of the file, defining when and how the file will expire. ||
|| expires_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp representing when the file will expire. ||
|| labels | **object** (map<**string**, **string**>)

Set of key-value pairs that can be used to organize and categorize the file. ||
|#

## ExpirationConfig {#yandex.cloud.ai.common.ExpirationConfig}

#|
||Field | Description ||
|| expiration_policy | enum **ExpirationPolicy**

- `EXPIRATION_POLICY_UNSPECIFIED`
- `STATIC`
- `SINCE_LAST_ACTIVE` ||
|| ttl_days | **int64** ||
|#