---
editable: false
sourcePath: en/_api-ref-grpc/ai/files/v1/files/api-ref/grpc/File/list.md
---

# Files API, gRPC: FileService.List

List files in a specific folder.

## gRPC request

**rpc List ([ListFilesRequest](#yandex.cloud.ai.files.v1.ListFilesRequest)) returns ([ListFilesResponse](#yandex.cloud.ai.files.v1.ListFilesResponse))**

## ListFilesRequest {#yandex.cloud.ai.files.v1.ListFilesRequest}

```json
{
  "folder_id": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

Request message for listing files in a specific folder.

#|
||Field | Description ||
|| folder_id | **string**

Required field. Folder ID from which to list files. ||
|| page_size | **int64**

Maximum number of files to return per page. ||
|| page_token | **string**

Token to retrieve the next page of results. ||
|#

## ListFilesResponse {#yandex.cloud.ai.files.v1.ListFilesResponse}

```json
{
  "files": [
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
  ],
  "next_page_token": "string"
}
```

Response message for the list operation.

#|
||Field | Description ||
|| files[] | **[File](#yandex.cloud.ai.files.v1.File)**

List of files in the specified folder. ||
|| next_page_token | **string**

Token to retrieve the next page of results. ||
|#

## File {#yandex.cloud.ai.files.v1.File}

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