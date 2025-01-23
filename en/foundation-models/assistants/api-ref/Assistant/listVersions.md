---
editable: false
sourcePath: en/_api-ref/ai/assistants/v1/assistants/api-ref/Assistant/listVersions.md
---

# AI Assistants API, REST: Assistant.ListVersions

Lists all versions of a specific assistant.

## HTTP request

```
GET https://rest-assistant.{{ api-host }}/assistants/v1/assistants:listVersions
```

## Query parameters {#yandex.cloud.ai.assistants.v1.ListAssistantVersionsRequest}

Request to list all versions of a specific assistant.

#|
||Field | Description ||
|| assistantId | **string**

Required field. ID of the assistant whose versions are to be listed. ||
|| pageSize | **string** (int64)

Maximum number of versions to return per page. ||
|| pageToken | **string**

Token to retrieve the next page of results. ||
|#

## Response {#yandex.cloud.ai.assistants.v1.ListAssistantVersionsResponse}

**HTTP Code: 200 - OK**

```json
{
  "versions": [
    {
      "id": "string",
      "updateMask": "string",
      "assistant": {
        "id": "string",
        "folderId": "string",
        "name": "string",
        "description": "string",
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
        "modelUri": "string",
        "instruction": "string",
        "promptTruncationOptions": {
          "maxPromptTokens": "string",
          // Includes only one of the fields `autoStrategy`, `lastMessagesStrategy`
          "autoStrategy": "object",
          "lastMessagesStrategy": {
            "numMessages": "string"
          }
          // end of the list of possible fields
        },
        "completionOptions": {
          "maxTokens": "string",
          "temperature": "number"
        },
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
    }
  ],
  "nextPageToken": "string"
}
```

Response message containing the list versions operation.

#|
||Field | Description ||
|| versions[] | **[AssistantVersion](#yandex.cloud.ai.assistants.v1.AssistantVersion)**

List of assistant versions. ||
|| nextPageToken | **string**

Token to retrieve the next page of results. ||
|#

## AssistantVersion {#yandex.cloud.ai.assistants.v1.AssistantVersion}

Represents a specific version of an assistant.

#|
||Field | Description ||
|| id | **string**

ID of the assistant version. ||
|| updateMask | **string** (field-mask)

A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
|| assistant | **[Assistant](#yandex.cloud.ai.assistants.v1.Assistant)**

Assistant configuration for this version. ||
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
|| createdAt | **string** (date-time)

Timestamp representing when the assistant was created.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updatedBy | **string**

Identifier of the subject who last updated this assistant. ||
|| updatedAt | **string** (date-time)

Timestamp representing the last time this assistant was updated.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| expirationConfig | **[ExpirationConfig](#yandex.cloud.ai.common.ExpirationConfig)**

Configuration for the expiration of the assistant, defining when and how the assistant will expire. ||
|| expiresAt | **string** (date-time)

Timestamp representing when the assistant will expire.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| labels | **object** (map<**string**, **string**>)

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
|| expirationPolicy | **enum** (ExpirationPolicy)

- `EXPIRATION_POLICY_UNSPECIFIED`
- `STATIC`
- `SINCE_LAST_ACTIVE` ||
|| ttlDays | **string** (int64) ||
|#

## PromptTruncationOptions {#yandex.cloud.ai.assistants.v1.PromptTruncationOptions}

Defines the options for truncating thread messages within a prompt.

#|
||Field | Description ||
|| maxPromptTokens | **string** (int64)

The maximum number of tokens allowed in the prompt.
If the prompt exceeds this limit, the thread messages will be truncated.
Default max_prompt_tokens: 7000 ||
|| autoStrategy | **object**

Includes only one of the fields `autoStrategy`, `lastMessagesStrategy`.

Specifies the truncation strategy to use when the prompt exceeds the token limit. ||
|| lastMessagesStrategy | **[LastMessagesStrategy](#yandex.cloud.ai.assistants.v1.PromptTruncationOptions.LastMessagesStrategy)**

Retains only the last `num_messages` messages in the thread.
If these messages exceed `max_prompt_tokens`, older messages will be further truncated to fit the limit.

Includes only one of the fields `autoStrategy`, `lastMessagesStrategy`.

Specifies the truncation strategy to use when the prompt exceeds the token limit. ||
|#

## LastMessagesStrategy {#yandex.cloud.ai.assistants.v1.PromptTruncationOptions.LastMessagesStrategy}

Truncates the prompt by retaining only the last `num_messages` messages in the thread.

#|
||Field | Description ||
|| numMessages | **string** (int64)

The number of most recent messages to retain in the prompt.
If these messages exceed `max_prompt_tokens`, older messages will be further truncated to fit the limit. ||
|#

## CompletionOptions {#yandex.cloud.ai.assistants.v1.CompletionOptions}

Defines the options for completion generation.

#|
||Field | Description ||
|| maxTokens | **string** (int64)

The limit on the number of tokens used for single completion generation.
Must be greater than zero. This maximum allowed parameter value may depend on the model being used. ||
|| temperature | **number** (double)

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