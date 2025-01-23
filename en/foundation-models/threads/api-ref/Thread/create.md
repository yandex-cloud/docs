---
editable: false
sourcePath: en/_api-ref/ai/assistants/v1/threads/api-ref/Thread/create.md
---

# Threads, REST: Thread.Create

Create a new thread.

## HTTP request

```
POST https://rest-assistant.{{ api-host }}/assistants/v1/threads
```

## Body parameters {#yandex.cloud.ai.assistants.v1.threads.CreateThreadRequest}

```json
{
  "folderId": "string",
  "messages": [
    {
      "author": {
        "id": "string",
        "role": "string"
      },
      "labels": "object",
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
  "defaultMessageAuthorId": "string",
  "expirationConfig": {
    "expirationPolicy": "string",
    "ttlDays": "string"
  },
  "labels": "object",
  "tools": [
    {
      // Includes only one of the fields `searchIndex`, `function`
      "searchIndex": {
        "searchIndexIds": [
          "string"
        ],
        "maxNumResults": "string"
      },
      "function": {
        "name": "string",
        "description": "string",
        "parameters": "object"
      }
      // end of the list of possible fields
    }
  ]
}
```

Request message for creating a new thread.

#|
||Field | Description ||
|| folderId | **string**

Required field.  ||
|| messages[] | **[MessageData](#yandex.cloud.ai.assistants.v1.threads.MessageData)**

List of messages to initialize the thread. ||
|| name | **string**

Name of the thread. ||
|| description | **string**

Description of the thread. ||
|| defaultMessageAuthorId | **string**

Default user ID that will be used as the author for thread messages if no other author is specified. ||
|| expirationConfig | **[ExpirationConfig](#yandex.cloud.ai.common.ExpirationConfig)**

Expiration configuration for the thread. ||
|| labels | **object** (map<**string**, **string**>)

Set of key-value pairs to label the thread. ||
|| tools[] | **[Tool](#yandex.cloud.ai.assistants.v1.Tool)**

List of tools that are available for assistants to use in this thread. ||
|#

## MessageData {#yandex.cloud.ai.assistants.v1.threads.MessageData}

Represents the data required to create or initialize a message in a thread.
This message is used, for example, to initialize a thread with some messages upon its creation.

#|
||Field | Description ||
|| author | **[Author](#yandex.cloud.ai.assistants.v1.threads.Author)**

Author of the message, containing details about the message's creator. ||
|| labels | **object** (map<**string**, **string**>)

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
|| expirationPolicy | **enum** (ExpirationPolicy)

- `EXPIRATION_POLICY_UNSPECIFIED`
- `STATIC`
- `SINCE_LAST_ACTIVE` ||
|| ttlDays | **string** (int64) ||
|#

## Tool {#yandex.cloud.ai.assistants.v1.Tool}

Represents a general tool that can be one of several types.

#|
||Field | Description ||
|| searchIndex | **[SearchIndexTool](#yandex.cloud.ai.assistants.v1.SearchIndexTool)**

SearchIndexTool tool that performs search across specified indexes.

Includes only one of the fields `searchIndex`, `function`. ||
|| function | **[FunctionTool](#yandex.cloud.ai.assistants.v1.FunctionTool)**

Function tool that can be invoked by the assistant.

Includes only one of the fields `searchIndex`, `function`. ||
|#

## SearchIndexTool {#yandex.cloud.ai.assistants.v1.SearchIndexTool}

Configures a tool that enables Retrieval-Augmented Generation (RAG) by allowing the assistant to search across a specified search index.

#|
||Field | Description ||
|| searchIndexIds[] | **string**

A list of search index IDs that this tool will query. Currently, only a single index ID is supported. ||
|| maxNumResults | **string** (int64)

The maximum number of results to return from the search.
Fewer results may be returned if necessary to fit within the prompt's token limit.
This ensures that the combined prompt and search results do not exceed the token constraints. ||
|#

## FunctionTool {#yandex.cloud.ai.assistants.v1.FunctionTool}

Represents a function tool that can be invoked by the assistant.

#|
||Field | Description ||
|| name | **string**

The name of the function. ||
|| description | **string**

A description of the function's purpose or behavior. ||
|| parameters | **object**

A JSON Schema that defines the expected parameters for the function.
The schema should describe the required fields, their types, and any constraints or default values. ||
|#

## Response {#yandex.cloud.ai.assistants.v1.threads.Thread}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "folderId": "string",
  "name": "string",
  "description": "string",
  "defaultMessageAuthorId": "string",
  "createdBy": "string",
  "createdAt": "string",
  "updatedBy": "string",
  "updatedAt": "string",
  "expirationConfig": {
    "expirationPolicy": "string",
    "ttlDays": "string"
  },
  "expiresAt": "string",
  "labels": "object",
  "tools": [
    {
      // Includes only one of the fields `searchIndex`, `function`
      "searchIndex": {
        "searchIndexIds": [
          "string"
        ],
        "maxNumResults": "string"
      },
      "function": {
        "name": "string",
        "description": "string",
        "parameters": "object"
      }
      // end of the list of possible fields
    }
  ]
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
|| createdAt | **string** (date-time)

Timestamp representing when the thread was created.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updatedBy | **string**

Identifier of the subject who last updated this thread. ||
|| updatedAt | **string** (date-time)

Timestamp representing the last time this thread was updated.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| expirationConfig | **[ExpirationConfig](#yandex.cloud.ai.common.ExpirationConfig2)**

Configuration for the expiration of the thread, defining when and how the thread will expire. ||
|| expiresAt | **string** (date-time)

Timestamp representing when the thread will expire.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| labels | **object** (map<**string**, **string**>)

Set of key-value pairs that can be used to organize and categorize the thread. ||
|| tools[] | **[Tool](#yandex.cloud.ai.assistants.v1.Tool2)**

List of tools that are available for assistants to use in this thread. ||
|#

## ExpirationConfig {#yandex.cloud.ai.common.ExpirationConfig2}

#|
||Field | Description ||
|| expirationPolicy | **enum** (ExpirationPolicy)

- `EXPIRATION_POLICY_UNSPECIFIED`
- `STATIC`
- `SINCE_LAST_ACTIVE` ||
|| ttlDays | **string** (int64) ||
|#

## Tool {#yandex.cloud.ai.assistants.v1.Tool2}

Represents a general tool that can be one of several types.

#|
||Field | Description ||
|| searchIndex | **[SearchIndexTool](#yandex.cloud.ai.assistants.v1.SearchIndexTool2)**

SearchIndexTool tool that performs search across specified indexes.

Includes only one of the fields `searchIndex`, `function`. ||
|| function | **[FunctionTool](#yandex.cloud.ai.assistants.v1.FunctionTool2)**

Function tool that can be invoked by the assistant.

Includes only one of the fields `searchIndex`, `function`. ||
|#

## SearchIndexTool {#yandex.cloud.ai.assistants.v1.SearchIndexTool2}

Configures a tool that enables Retrieval-Augmented Generation (RAG) by allowing the assistant to search across a specified search index.

#|
||Field | Description ||
|| searchIndexIds[] | **string**

A list of search index IDs that this tool will query. Currently, only a single index ID is supported. ||
|| maxNumResults | **string** (int64)

The maximum number of results to return from the search.
Fewer results may be returned if necessary to fit within the prompt's token limit.
This ensures that the combined prompt and search results do not exceed the token constraints. ||
|#

## FunctionTool {#yandex.cloud.ai.assistants.v1.FunctionTool2}

Represents a function tool that can be invoked by the assistant.

#|
||Field | Description ||
|| name | **string**

The name of the function. ||
|| description | **string**

A description of the function's purpose or behavior. ||
|| parameters | **object**

A JSON Schema that defines the expected parameters for the function.
The schema should describe the required fields, their types, and any constraints or default values. ||
|#