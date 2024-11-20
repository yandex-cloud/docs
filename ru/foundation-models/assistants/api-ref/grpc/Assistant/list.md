---
editable: false
sourcePath: en/_api-ref-grpc/ai/assistants/v1/assistants/api-ref/grpc/Assistant/list.md
---

# AI Assistants API, gRPC: AssistantService.List {#List}

List assistants in a specific folder.

## gRPC request

**rpc List ([ListAssistantsRequest](#yandex.cloud.ai.assistants.v1.ListAssistantsRequest)) returns ([ListAssistantsResponse](#yandex.cloud.ai.assistants.v1.ListAssistantsResponse))**

## ListAssistantsRequest {#yandex.cloud.ai.assistants.v1.ListAssistantsRequest}

```json
{
  "folderId": "string",
  "pageSize": "int64",
  "pageToken": "string"
}
```

Request message for listing assistants in a specific folder.

#|
||Field | Description ||
|| folderId | **string**

Required field. Folder ID from which to list assistants. ||
|| pageSize | **int64**

Maximum number of assistants to return per page. ||
|| pageToken | **string**

Token to retrieve the next page of results. ||
|#

## ListAssistantsResponse {#yandex.cloud.ai.assistants.v1.ListAssistantsResponse}

```json
{
  "assistants": [
    {
      "id": "string",
      "folderId": "string",
      "name": "string",
      "description": "string",
      "createdBy": "string",
      "createdAt": "google.protobuf.Timestamp",
      "updatedBy": "string",
      "updatedAt": "google.protobuf.Timestamp",
      "expirationConfig": {
        "expirationPolicy": "ExpirationPolicy",
        "ttlDays": "int64"
      },
      "expiresAt": "google.protobuf.Timestamp",
      "labels": "string",
      "modelUri": "string",
      "instruction": "string",
      "promptTruncationOptions": {
        "maxPromptTokens": "google.protobuf.Int64Value"
      },
      "completionOptions": {
        "maxTokens": "google.protobuf.Int64Value",
        "temperature": "google.protobuf.DoubleValue"
      },
      "tools": [
        {
          // Includes only one of the fields `searchIndex`
          "searchIndex": {
            "searchIndexIds": [
              "string"
            ],
            "maxNumResults": "google.protobuf.Int64Value"
          }
          // end of the list of possible fields
        }
      ]
    }
  ],
  "nextPageToken": "string"
}
```

Response message for the list operation.

#|
||Field | Description ||
|| assistants[] | **[Assistant](#yandex.cloud.ai.assistants.v1.Assistant)**

List of assistants in the specified folder. ||
|| nextPageToken | **string**

Token to retrieve the next page of results. ||
|#

## Assistant {#yandex.cloud.ai.assistants.v1.Assistant}

Assistant represents an AI assistant configuration with various settings and metadata.

#|
||Field | Description ||
|| id | **string**

Unique identifier of the assistant. ||
|| folderId | **string**

ID of the folder that the assistant belongs to. ||
|| name | **string**

Name of the assistant. ||
|| description | **string**

Description of the assistant. ||
|| createdBy | **string**

Identifier of the subject who created this assistant. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp representing when the assistant was created. ||
|| updatedBy | **string**

Identifier of the subject who last updated this assistant. ||
|| updatedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp representing the last time this assistant was updated. ||
|| expirationConfig | **[ExpirationConfig](#yandex.cloud.ai.common.ExpirationConfig)**

Configuration for the expiration of the assistant, defining when and how the assistant will expire. ||
|| expiresAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp representing when the assistant will expire. ||
|| labels | **string**

Set of key-value pairs that can be used to organize and categorize the assistant. ||
|| modelUri | **string**

The [ID of the model](/docs/foundation-models/concepts/yandexgpt/models) to be used for completion generation. ||
|| instruction | **string**

Instructions or guidelines that the assistant should follow when generating responses or performing tasks.
These instructions can help guide the assistant's behavior and responses. ||
|| promptTruncationOptions | **[PromptTruncationOptions](#yandex.cloud.ai.assistants.v1.PromptTruncationOptions)**

Configuration options for truncating the prompt when the token count exceeds a specified limit. ||
|| completionOptions | **[CompletionOptions](#yandex.cloud.ai.assistants.v1.CompletionOptions)**

Configuration options for completion generation. ||
|| tools[] | **[Tool](#yandex.cloud.ai.assistants.v1.Tool)**

List of tools that the assistant can use to perform additional tasks.
One example is the SearchIndexTool, which is used for Retrieval-Augmented Generation (RAG). ||
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

## PromptTruncationOptions {#yandex.cloud.ai.assistants.v1.PromptTruncationOptions}

Defines the options for truncating thread messages within a prompt.

#|
||Field | Description ||
|| maxPromptTokens | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of tokens allowed in the prompt.
If the prompt exceeds this limit, the thread messages will be truncated.
Default max_prompt_tokens: 7000 ||
|#

## CompletionOptions {#yandex.cloud.ai.assistants.v1.CompletionOptions}

Defines the options for completion generation.

#|
||Field | Description ||
|| maxTokens | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The limit on the number of tokens used for single completion generation.
Must be greater than zero. This maximum allowed parameter value may depend on the model being used. ||
|| temperature | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

Affects creativity and randomness of responses. Should be a double number between 0 (inclusive) and 1 (inclusive).
Lower values produce more straightforward responses while higher values lead to increased creativity and randomness.
Default temperature: 0.3 ||
|#

## Tool {#yandex.cloud.ai.assistants.v1.Tool}

Represents a general tool that can be one of several types.

#|
||Field | Description ||
|| searchIndex | **[SearchIndexTool](#yandex.cloud.ai.assistants.v1.SearchIndexTool)**

SearchIndexTool tool that performs search across specified indexes.

Includes only one of the fields `searchIndex`. ||
|#

## SearchIndexTool {#yandex.cloud.ai.assistants.v1.SearchIndexTool}

Configures a tool that enables Retrieval-Augmented Generation (RAG) by allowing the assistant to search across a specified search index.

#|
||Field | Description ||
|| searchIndexIds[] | **string**

A list of search index IDs that this tool will query. Currently, only a single index ID is supported. ||
|| maxNumResults | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of results to return from the search.
Fewer results may be returned if necessary to fit within the prompt's token limit.
This ensures that the combined prompt and search results do not exceed the token constraints. ||
|#