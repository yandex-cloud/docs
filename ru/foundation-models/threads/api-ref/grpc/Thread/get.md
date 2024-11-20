---
editable: false
sourcePath: en/_api-ref-grpc/ai/assistants/v1/threads/api-ref/grpc/Thread/get.md
---

# Threads, gRPC: ThreadService.Get {#Get}

Retrieve details of a specific thread by its ID.

## gRPC request

**rpc Get ([GetThreadRequest](#yandex.cloud.ai.assistants.v1.threads.GetThreadRequest)) returns ([Thread](#yandex.cloud.ai.assistants.v1.threads.Thread))**

## GetThreadRequest {#yandex.cloud.ai.assistants.v1.threads.GetThreadRequest}

```json
{
  "threadId": "string"
}
```

Request message for retrieving a thread by ID.

#|
||Field | Description ||
|| threadId | **string**

Required field. ID of the thread to retrieve. ||
|#

## Thread {#yandex.cloud.ai.assistants.v1.threads.Thread}

```json
{
  "id": "string",
  "folderId": "string",
  "name": "string",
  "description": "string",
  "defaultMessageAuthorId": "string",
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

Unique identifier of the thread. ||
|| folderId | **string**

ID of the folder that the thread belongs to. ||
|| name | **string**

Name of the thread. ||
|| description | **string**

Description of the thread. ||
|| defaultMessageAuthorId | **string**

Default user ID that will be used as the author for thread messages if no other author is specified. ||
|| createdBy | **string**

Identifier of the subject who created this thread. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp representing when the thread was created. ||
|| updatedBy | **string**

Identifier of the subject who last updated this thread. ||
|| updatedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp representing the last time this thread was updated. ||
|| expirationConfig | **[ExpirationConfig](#yandex.cloud.ai.common.ExpirationConfig)**

Configuration for the expiration of the thread, defining when and how the thread will expire. ||
|| expiresAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp representing when the thread will expire. ||
|| labels | **string**

Set of key-value pairs that can be used to organize and categorize the thread. ||
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