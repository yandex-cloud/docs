---
editable: false
sourcePath: en/_api-ref-grpc/ai/files/v1/files/api-ref/grpc/File/list.md
---

# Files API, gRPC: FileService.List {#List}

List files in a specific folder.

## gRPC request

**rpc List ([ListFilesRequest](#yandex.cloud.ai.files.v1.ListFilesRequest)) returns ([ListFilesResponse](#yandex.cloud.ai.files.v1.ListFilesResponse))**

## ListFilesRequest {#yandex.cloud.ai.files.v1.ListFilesRequest}

```json
{
  "folderId": "string",
  "pageSize": "int64",
  "pageToken": "string"
}
```

Request message for listing files in a specific folder.

#|
||Field | Description ||
|| folderId | **string**

Required field. Folder ID from which to list files. ||
|| pageSize | **int64**

Maximum number of files to return per page. ||
|| pageToken | **string**

Token to retrieve the next page of results. ||
|#

## ListFilesResponse {#yandex.cloud.ai.files.v1.ListFilesResponse}

```json
{
  "files": [
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
  ],
  "nextPageToken": "string"
}
```

Response message for the list operation.

#|
||Field | Description ||
|| files[] | **[File](#yandex.cloud.ai.files.v1.File)**

List of files in the specified folder. ||
|| nextPageToken | **string**

Token to retrieve the next page of results. ||
|#

## File {#yandex.cloud.ai.files.v1.File}

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