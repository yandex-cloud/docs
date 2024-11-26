---
editable: false
sourcePath: en/_api-ref-grpc/ai/assistants/v1/threads/api-ref/grpc/Thread/list.md
---

# Threads, gRPC: ThreadService.List

List threads in a specific folder.

## gRPC request

**rpc List ([ListThreadsRequest](#yandex.cloud.ai.assistants.v1.threads.ListThreadsRequest)) returns ([ListThreadsResponse](#yandex.cloud.ai.assistants.v1.threads.ListThreadsResponse))**

## ListThreadsRequest {#yandex.cloud.ai.assistants.v1.threads.ListThreadsRequest}

```json
{
  "folder_id": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

Request message for listing threads in a specific folder.

#|
||Field | Description ||
|| folder_id | **string**

Required field. Folder ID from which to list threads. ||
|| page_size | **int64**

Maximum number of threads to return per page. ||
|| page_token | **string**

Token to retrieve the next page of results. ||
|#

## ListThreadsResponse {#yandex.cloud.ai.assistants.v1.threads.ListThreadsResponse}

```json
{
  "threads": [
    {
      "id": "string",
      "folder_id": "string",
      "name": "string",
      "description": "string",
      "default_message_author_id": "string",
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
  ],
  "next_page_token": "string"
}
```

Response message for the list operation.

#|
||Field | Description ||
|| threads[] | **[Thread](#yandex.cloud.ai.assistants.v1.threads.Thread)**

List of threads in the specified folder. ||
|| next_page_token | **string**

Token to retrieve the next page of results. ||
|#

## Thread {#yandex.cloud.ai.assistants.v1.threads.Thread}

#|
||Field | Description ||
|| id | **string**

Unique identifier of the thread. ||
|| folder_id | **string**

ID of the folder that the thread belongs to. ||
|| name | **string**

Name of the thread. ||
|| description | **string**

Description of the thread. ||
|| default_message_author_id | **string**

Default user ID that will be used as the author for thread messages if no other author is specified. ||
|| created_by | **string**

Identifier of the subject who created this thread. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp representing when the thread was created. ||
|| updated_by | **string**

Identifier of the subject who last updated this thread. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp representing the last time this thread was updated. ||
|| expiration_config | **[ExpirationConfig](#yandex.cloud.ai.common.ExpirationConfig)**

Configuration for the expiration of the thread, defining when and how the thread will expire. ||
|| expires_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp representing when the thread will expire. ||
|| labels | **string**

Set of key-value pairs that can be used to organize and categorize the thread. ||
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