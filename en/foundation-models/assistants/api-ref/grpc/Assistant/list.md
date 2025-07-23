---
editable: false
sourcePath: en/_api-ref-grpc/ai/assistants/v1/assistants/api-ref/grpc/Assistant/list.md
---

# AI Assistants API, gRPC: AssistantService.List

List assistants in a specific folder.

## gRPC request

**rpc List ([ListAssistantsRequest](#yandex.cloud.ai.assistants.v1.ListAssistantsRequest)) returns ([ListAssistantsResponse](#yandex.cloud.ai.assistants.v1.ListAssistantsResponse))**

## ListAssistantsRequest {#yandex.cloud.ai.assistants.v1.ListAssistantsRequest}

```json
{
  "folder_id": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

Request message for listing assistants in a specific folder.

#|
||Field | Description ||
|| folder_id | **string**

Required field. Folder ID from which to list assistants. ||
|| page_size | **int64**

Maximum number of assistants to return per page. ||
|| page_token | **string**

Token to retrieve the next page of results. ||
|#

## ListAssistantsResponse {#yandex.cloud.ai.assistants.v1.ListAssistantsResponse}

```json
{
  "assistants": [
    {
      "id": "string",
      "folder_id": "string",
      "name": "string",
      "description": "string",
      "created_by": "string",
      "created_at": "google.protobuf.Timestamp",
      "updated_by": "string",
      "updated_at": "google.protobuf.Timestamp",
      "expiration_config": {
        "expiration_policy": "ExpirationPolicy",
        "ttl_days": "int64"
      },
      "expires_at": "google.protobuf.Timestamp",
      "labels": "map<string, string>",
      "model_uri": "string",
      "instruction": "string",
      "prompt_truncation_options": {
        "max_prompt_tokens": "google.protobuf.Int64Value",
        // Includes only one of the fields `auto_strategy`, `last_messages_strategy`
        "auto_strategy": "AutoStrategy",
        "last_messages_strategy": {
          "num_messages": "int64"
        }
        // end of the list of possible fields
      },
      "completion_options": {
        "max_tokens": "google.protobuf.Int64Value",
        "temperature": "google.protobuf.DoubleValue"
      },
      "tools": [
        {
          // Includes only one of the fields `search_index`, `function`
          "search_index": {
            "search_index_ids": [
              "string"
            ],
            "max_num_results": "google.protobuf.Int64Value",
            "rephraser_options": {
              "rephraser_uri": "string"
            },
            "call_strategy": {
              // Includes only one of the fields `always_call`, `auto_call`
              "always_call": "AlwaysCall",
              "auto_call": {
                "name": "string",
                "instruction": "string"
              }
              // end of the list of possible fields
            }
          },
          "function": {
            "name": "string",
            "description": "string",
            "parameters": "google.protobuf.Struct"
          }
          // end of the list of possible fields
        }
      ],
      "response_format": {
        // Includes only one of the fields `json_object`, `json_schema`
        "json_object": "bool",
        "json_schema": {
          "schema": "google.protobuf.Struct"
        }
        // end of the list of possible fields
      }
    }
  ],
  "next_page_token": "string"
}
```

Response message for the list operation.

#|
||Field | Description ||
|| assistants[] | **[Assistant](#yandex.cloud.ai.assistants.v1.Assistant)**

List of assistants in the specified folder. ||
|| next_page_token | **string**

Token to retrieve the next page of results. ||
|#

## Assistant {#yandex.cloud.ai.assistants.v1.Assistant}

Assistant represents an AI assistant configuration with various settings and metadata.

#|
||Field | Description ||
|| id | **string**

Unique identifier of the assistant. ||
|| folder_id | **string**

ID of the folder that the assistant belongs to. ||
|| name | **string**

Name of the assistant. ||
|| description | **string**

Description of the assistant. ||
|| created_by | **string**

Identifier of the subject who created this assistant. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp representing when the assistant was created. ||
|| updated_by | **string**

Identifier of the subject who last updated this assistant. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp representing the last time this assistant was updated. ||
|| expiration_config | **[ExpirationConfig](#yandex.cloud.ai.common.ExpirationConfig)**

Configuration for the expiration of the assistant, defining when and how the assistant will expire. ||
|| expires_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp representing when the assistant will expire. ||
|| labels | **object** (map<**string**, **string**>)

Set of key-value pairs that can be used to organize and categorize the assistant. ||
|| model_uri | **string**

The [ID of the model](/docs/foundation-models/concepts/yandexgpt/models) to be used for completion generation. ||
|| instruction | **string**

Instructions or guidelines that the assistant should follow when generating responses or performing tasks.
These instructions can help guide the assistant's behavior and responses. ||
|| prompt_truncation_options | **[PromptTruncationOptions](#yandex.cloud.ai.assistants.v1.PromptTruncationOptions)**

Configuration options for truncating the prompt when the token count exceeds a specified limit. ||
|| completion_options | **[CompletionOptions](#yandex.cloud.ai.assistants.v1.CompletionOptions)**

Configuration options for completion generation. ||
|| tools[] | **[Tool](#yandex.cloud.ai.assistants.v1.Tool)**

List of tools that the assistant can use to perform additional tasks.
One example is the SearchIndexTool, which is used for Retrieval-Augmented Generation (RAG). ||
|| response_format | **[ResponseFormat](#yandex.cloud.ai.assistants.v1.ResponseFormat)**

Specifies the format of the model's response. ||
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

## PromptTruncationOptions {#yandex.cloud.ai.assistants.v1.PromptTruncationOptions}

Defines the options for truncating thread messages within a prompt.

#|
||Field | Description ||
|| max_prompt_tokens | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of tokens allowed in the prompt.
If the prompt exceeds this limit, the thread messages will be truncated.
Default max_prompt_tokens: 7000 ||
|| auto_strategy | **[AutoStrategy](#yandex.cloud.ai.assistants.v1.PromptTruncationOptions.AutoStrategy)**

Includes only one of the fields `auto_strategy`, `last_messages_strategy`.

Specifies the truncation strategy to use when the prompt exceeds the token limit. ||
|| last_messages_strategy | **[LastMessagesStrategy](#yandex.cloud.ai.assistants.v1.PromptTruncationOptions.LastMessagesStrategy)**

Retains only the last `num_messages` messages in the thread.
If these messages exceed `max_prompt_tokens`, older messages will be further truncated to fit the limit.

Includes only one of the fields `auto_strategy`, `last_messages_strategy`.

Specifies the truncation strategy to use when the prompt exceeds the token limit. ||
|#

## AutoStrategy {#yandex.cloud.ai.assistants.v1.PromptTruncationOptions.AutoStrategy}

Auto truncation strategy.

#|
||Field | Description ||
|| Empty | > ||
|#

## LastMessagesStrategy {#yandex.cloud.ai.assistants.v1.PromptTruncationOptions.LastMessagesStrategy}

Truncates the prompt by retaining only the last `num_messages` messages in the thread.

#|
||Field | Description ||
|| num_messages | **int64**

The number of most recent messages to retain in the prompt.
If these messages exceed `max_prompt_tokens`, older messages will be further truncated to fit the limit. ||
|#

## CompletionOptions {#yandex.cloud.ai.assistants.v1.CompletionOptions}

Defines the options for completion generation.

#|
||Field | Description ||
|| max_tokens | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

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
|| search_index | **[SearchIndexTool](#yandex.cloud.ai.assistants.v1.SearchIndexTool)**

SearchIndexTool tool that performs search across specified indexes.

Includes only one of the fields `search_index`, `function`. ||
|| function | **[FunctionTool](#yandex.cloud.ai.assistants.v1.FunctionTool)**

Function tool that can be invoked by the assistant.

Includes only one of the fields `search_index`, `function`. ||
|#

## SearchIndexTool {#yandex.cloud.ai.assistants.v1.SearchIndexTool}

Configures a tool that enables Retrieval-Augmented Generation (RAG) by allowing the assistant to search across a specified search index.

#|
||Field | Description ||
|| search_index_ids[] | **string**

A list of search index IDs that this tool will query. Currently, only a single index ID is supported. ||
|| max_num_results | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of results to return from the search.
Fewer results may be returned if necessary to fit within the prompt's token limit.
This ensures that the combined prompt and search results do not exceed the token constraints. ||
|| rephraser_options | **[RephraserOptions](#yandex.cloud.ai.assistants.v1.RephraserOptions)**

Options for rephrasing user queries.
Used to rewrite the last user message for search,
incorporating context from the previous conversation. ||
|| call_strategy | **[CallStrategy](#yandex.cloud.ai.assistants.v1.CallStrategy)**

Defines the strategy for triggering search.
Controls whether search results are always included or returned only when
the model explicitly calls the tool. ||
|#

## RephraserOptions {#yandex.cloud.ai.assistants.v1.RephraserOptions}

Options for configuring the rephrasing the last user message for search using context from previous conversation.

#|
||Field | Description ||
|| rephraser_uri | **string**

Required field. The ID of the model used to rephrase the last user message for search. ||
|#

## CallStrategy {#yandex.cloud.ai.assistants.v1.CallStrategy}

Defines when the assistant uses the search tool.

#|
||Field | Description ||
|| always_call | **[AlwaysCall](#yandex.cloud.ai.assistants.v1.CallStrategy.AlwaysCall)**

Includes only one of the fields `always_call`, `auto_call`.

One of `always_call` or `auto_call`.
always_call is used if no strategy is explicitly set ||
|| auto_call | **[AutoCall](#yandex.cloud.ai.assistants.v1.CallStrategy.AutoCall)**

Includes only one of the fields `always_call`, `auto_call`.

One of `always_call` or `auto_call`.
always_call is used if no strategy is explicitly set ||
|#

## AlwaysCall {#yandex.cloud.ai.assistants.v1.CallStrategy.AlwaysCall}

Always includes retrieved search results in the prompt.

#|
||Field | Description ||
|| Empty | > ||
|#

## AutoCall {#yandex.cloud.ai.assistants.v1.CallStrategy.AutoCall}

Exposes the tool as a callable function.
The model decides when to trigger search based on the instruction.

#|
||Field | Description ||
|| name | **string**

The name of the tool as exposed to the model. ||
|| instruction | **string**

Required field. Required instruction that helps the model decide when to call the tool. ||
|#

## FunctionTool {#yandex.cloud.ai.assistants.v1.FunctionTool}

Represents a function tool that can be invoked by the assistant.

#|
||Field | Description ||
|| name | **string**

The name of the function. ||
|| description | **string**

A description of the function's purpose or behavior. ||
|| parameters | **[google.protobuf.Struct](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/struct)**

A JSON Schema that defines the expected parameters for the function.
The schema should describe the required fields, their types, and any constraints or default values. ||
|#

## ResponseFormat {#yandex.cloud.ai.assistants.v1.ResponseFormat}

Specifies the format of the model's response.

#|
||Field | Description ||
|| json_object | **bool**

When set to true, the model will respond with a valid JSON object.
Be sure to explicitly ask the model for JSON.
Otherwise, it may generate excessive whitespace and run indefinitely until it reaches the token limit.

Includes only one of the fields `json_object`, `json_schema`. ||
|| json_schema | **[JsonSchema](#yandex.cloud.ai.assistants.v1.JsonSchema)**

Enforces a specific JSON structure for the model's response based on a provided schema.

Includes only one of the fields `json_object`, `json_schema`. ||
|#

## JsonSchema {#yandex.cloud.ai.assistants.v1.JsonSchema}

Represents the expected structure of the model's response using a JSON Schema.

#|
||Field | Description ||
|| schema | **[google.protobuf.Struct](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/struct)**

The JSON Schema that the model's output must conform to. ||
|#