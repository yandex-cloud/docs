---
editable: false
sourcePath: en/_api-ref-grpc/ai/files/v1/files/api-ref/grpc/File/get.md
---

# Files API, gRPC: FileService.Get {#Get}

Retrieve details of a specific file by its ID.

## gRPC request

**rpc Get ([GetFileRequest](#yandex.cloud.ai.files.v1.GetFileRequest)) returns ([File](#yandex.cloud.ai.files.v1.File))**

## GetFileRequest {#yandex.cloud.ai.files.v1.GetFileRequest}

```json
{
  "fileId": "string"
}
```

Request message for retrieving a file by ID.

#|
||Field | Description ||
|| fileId | **string**

Required field. ID of the file to retrieve. ||
|#

## File {#yandex.cloud.ai.files.v1.File}

```json
{
  "id": "string",
  "folderId": "string",
  "name": "string",
  "description": "string",
  "mimeType": "string",
  "createdBy": "string",
  "createdAt": "google.protobuf.Timestamp",
  "updatedBy": "string",
  "updatedAt": "google.protobuf.Timestamp",
  "expirationConfig": {
    "expirationPolicy": "ExpirationPolicy",
    "ttlDays": "int64"
  },
  "expiresAt": "google.protobuf.Timestamp",
  "labels": "string"
}
```

#|
||Field | Description ||
|| id | **string**

Unique identifier of the file. ||
|| folderId | **string**

ID of the folder that the file belongs to. ||
|| name | **string**

Name of the file. ||
|| description | **string**

Description of the file. ||
|| mimeType | **string**

MIME type of the file, indicating the file's format (e.g., "application/pdf") ||
|| createdBy | **string**

Identifier of the subject who created this file. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp representing when the file was created. ||
|| updatedBy | **string**

Identifier of the subject who last updated this file. ||
|| updatedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp representing the last time this file was updated. ||
|| expirationConfig | **[ExpirationConfig](#yandex.cloud.ai.common.ExpirationConfig)**

Configuration for the expiration of the file, defining when and how the file will expire. ||
|| expiresAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp representing when the file will expire. ||
|| labels | **string**

Set of key-value pairs that can be used to organize and categorize the file. ||
|#

## ExpirationConfig {#yandex.cloud.ai.common.ExpirationConfig}

#|
||Field | Description ||
|| expirationPolicy | enum **ExpirationPolicy**

- `EXPIRATION_POLICY_UNSPECIFIED`
- `STATIC`
- `SINCE_LAST_ACTIVE` ||
|| ttlDays | **int64** ||
|#