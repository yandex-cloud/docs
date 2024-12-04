---
editable: false
sourcePath: en/_api-ref-grpc/ai/assistants/v1/threads/api-ref/grpc/Thread/create.md
---

# Threads, gRPC: ThreadService.Create

Create a new thread.

## gRPC request

**rpc Create ([CreateThreadRequest](#yandex.cloud.ai.assistants.v1.threads.CreateThreadRequest)) returns ([Thread](#yandex.cloud.ai.assistants.v1.threads.Thread))**

## CreateThreadRequest {#yandex.cloud.ai.assistants.v1.threads.CreateThreadRequest}

```json
{
  "folder_id": "string",
  "messages": [
    {
      "author": {
        "id": "string",
        "role": "string"
      },
      "labels": "string",
      "content": {
        "content": [
          {
            // Includes only one of the fields `text`
            "text": {
              "content": "string"
            }
            // end of the list of possible fields
          }
        ]
      }
    }
  ],
  "name": "string",
  "description": "string",
  "default_message_author_id": "string",
  "expiration_config": {
    "expiration_policy": "ExpirationPolicy",
    "ttl_days": "int64"
  },
  "labels": "string"
}
```

Request message for creating a new thread.

#|
||Field | Description ||
|| folder_id | **string**

Required field.  ||
|| messages[] | **[MessageData](#yandex.cloud.ai.assistants.v1.threads.MessageData)**

List of messages to initialize the thread. ||
|| name | **string**

Name of the thread. ||
|| description | **string**

Description of the thread. ||
|| default_message_author_id | **string**

Default user ID that will be used as the author for thread messages if no other author is specified. ||
|| expiration_config | **[ExpirationConfig](#yandex.cloud.ai.common.ExpirationConfig)**

Expiration configuration for the thread. ||
|| labels | **string**

Set of key-value pairs to label the thread. ||
|#

## MessageData {#yandex.cloud.ai.assistants.v1.threads.MessageData}

Represents the data required to create or initialize a message in a thread.
This message is used, for example, to initialize a thread with some messages upon its creation.

#|
||Field | Description ||
|| author | **[Author](#yandex.cloud.ai.assistants.v1.threads.Author)**

Author of the message, containing details about the message's creator. ||
|| labels | **string**

Set of key-value pairs that can be used to organize and categorize the message. ||
|| content | **[MessageContent](#yandex.cloud.ai.assistants.v1.threads.MessageContent)**

Content of the message. ||
|#

## Author {#yandex.cloud.ai.assistants.v1.threads.Author}

Author of the message, containing details about the message's creator.

#|
||Field | Description ||
|| id | **string**

Unique identifier of the author. This could be either the user's ID or the assistant's ID, depending on the role. ||
|| role | **string**

Role of the author, indicating whether the message was created by a "user" or an "assistant". ||
|#

## MessageContent {#yandex.cloud.ai.assistants.v1.threads.MessageContent}

Represents the content of a message, which can consist of multiple parts.

#|
||Field | Description ||
|| content[] | **[ContentPart](#yandex.cloud.ai.assistants.v1.threads.ContentPart)**

A list of content parts that make up the message. ||
|#

## ContentPart {#yandex.cloud.ai.assistants.v1.threads.ContentPart}

ContentPart represents an individual part of the message content, which can be of various types.

#|
||Field | Description ||
|| text | **[Text](#yandex.cloud.ai.assistants.v1.threads.Text)**

Text content of the message part.

Includes only one of the fields `text`.

Specifies the type of content that the part contains. ||
|#

## Text {#yandex.cloud.ai.assistants.v1.threads.Text}

Text represents a textual content part of a message.

#|
||Field | Description ||
|| content | **string**

Text content of the message. ||
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

## Thread {#yandex.cloud.ai.assistants.v1.threads.Thread}

```json
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
```

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
|| expiration_config | **[ExpirationConfig](#yandex.cloud.ai.common.ExpirationConfig2)**

Configuration for the expiration of the thread, defining when and how the thread will expire. ||
|| expires_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp representing when the thread will expire. ||
|| labels | **string**

Set of key-value pairs that can be used to organize and categorize the thread. ||
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