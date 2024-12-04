---
editable: false
sourcePath: en/_api-ref-grpc/ai/files/v1/files/api-ref/grpc/File/create.md
---

# Files API, gRPC: FileService.Create

Create a new file.

## gRPC request

**rpc Create ([CreateFileRequest](#yandex.cloud.ai.files.v1.CreateFileRequest)) returns ([File](#yandex.cloud.ai.files.v1.File))**

## CreateFileRequest {#yandex.cloud.ai.files.v1.CreateFileRequest}

```json
{
  "folder_id": "string",
  "name": "string",
  "description": "string",
  "mime_type": "string",
  "content": "bytes",
  "labels": "string",
  "expiration_config": {
    "expiration_policy": "ExpirationPolicy",
    "ttl_days": "int64"
  }
}
```

Request message for creating a new file.

#|
||Field | Description ||
|| folder_id | **string**

Required field.  ||
|| name | **string**

Name of the file. ||
|| description | **string**

Description of the file. ||
|| mime_type | **string**

MIME type of the file, indicating the file's format (e.g., "application/pdf").
If not specified, will be deduced automatically based on the file content. ||
|| content | **bytes**

Required field. Binary content of the file. ||
|| labels | **string**

Set of key-value pairs to label the file. ||
|| expiration_config | **[ExpirationConfig](#yandex.cloud.ai.common.ExpirationConfig)**

Expiration configuration for the file. ||
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
  "labels": "string"
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
|| expiration_config | **[ExpirationConfig](#yandex.cloud.ai.common.ExpirationConfig2)**

Configuration for the expiration of the file, defining when and how the file will expire. ||
|| expires_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp representing when the file will expire. ||
|| labels | **string**

Set of key-value pairs that can be used to organize and categorize the file. ||
|#

## ExpirationConfig {#yandex.cloud.ai.common.ExpirationConfig2}

#|
||Field | Description ||
|| expiration_policy | enum **ExpirationPolicy**

- `EXPIRATION_POLICY_UNSPECIFIED`
- `STATIC`
- `SINCE_LAST_ACTIVE` ||
|| ttl_days | **int64** ||
|#