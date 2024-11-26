---
editable: false
sourcePath: en/_api-ref-grpc/ai/assistants/v1/runs/api-ref/grpc/Run/list.md
---

# Runs, gRPC: RunService.List

List runs in a specific folder.

## gRPC request

**rpc List ([ListRunsRequest](#yandex.cloud.ai.assistants.v1.runs.ListRunsRequest)) returns ([ListRunsResponse](#yandex.cloud.ai.assistants.v1.runs.ListRunsResponse))**

## ListRunsRequest {#yandex.cloud.ai.assistants.v1.runs.ListRunsRequest}

```json
{
  "folder_id": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

Request message for listing runs.

#|
||Field | Description ||
|| folder_id | **string**

Required field. Folder ID from which to list runs. ||
|| page_size | **int64**

Maximum number of threads to return per page. ||
|| page_token | **string**

Token to retrieve the next page of results. ||
|#

## ListRunsResponse {#yandex.cloud.ai.assistants.v1.runs.ListRunsResponse}

```json
{
  "runs": [
    {
      "id": "string",
      "assistant_id": "string",
      "thread_id": "string",
      "created_by": "string",
      "created_at": "google.protobuf.Timestamp",
      "labels": "string",
      "state": {
        "status": "RunStatus",
        // Includes only one of the fields `error`, `completed_message`
        "error": {
          "code": "int64",
          "message": "string"
        },
        "completed_message": {
          "id": "string",
          "thread_id": "string",
          "created_by": "string",
          "created_at": "google.protobuf.Timestamp",
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
          },
          "status": "MessageStatus"
        }
        // end of the list of possible fields
      },
      "usage": {
        "prompt_tokens": "int64",
        "completion_tokens": "int64",
        "total_tokens": "int64"
      },
      "custom_prompt_truncation_options": {
        "max_prompt_tokens": "google.protobuf.Int64Value"
      },
      "custom_completion_options": {
        "max_tokens": "google.protobuf.Int64Value",
        "temperature": "google.protobuf.DoubleValue"
      }
    }
  ],
  "next_page_token": "string"
}
```

Response message for the list operation.

#|
||Field | Description ||
|| runs[] | **[Run](#yandex.cloud.ai.assistants.v1.runs.Run)**

List of runs in the specified folder. ||
|| next_page_token | **string**

Token to retrieve the next page of results. ||
|#

## Run {#yandex.cloud.ai.assistants.v1.runs.Run}

Represents a run of an assistant over a specific thread of messages.

#|
||Field | Description ||
|| id | **string**

Unique identifier of the run. ||
|| assistant_id | **string**

Identifier for the assistant that is being run. ||
|| thread_id | **string**

Identifier for the thread of messages that this run is associated with. ||
|| created_by | **string**

Identifier of the subject who created this run. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp representing when the run was created. ||
|| labels | **string**

Set of key-value pairs that can be used to organize and categorize the run. ||
|| state | **[RunState](#yandex.cloud.ai.assistants.v1.runs.RunState)**

Current state of the run, including its status and any associated data. ||
|| usage | **[ContentUsage](#yandex.cloud.ai.assistants.v1.runs.ContentUsage)**

Information about the content usage during the run, such as the number of [tokens](/docs/foundation-models/concepts/yandexgpt/tokens) used by the completion model. ||
|| custom_prompt_truncation_options | **[PromptTruncationOptions](#yandex.cloud.ai.assistants.v1.PromptTruncationOptions)**

Configuration options for truncating the prompt when the token count exceeds a specified limit.
If specified, these options will override the assistant's prompt truncation settings for this run. ||
|| custom_completion_options | **[CompletionOptions](#yandex.cloud.ai.assistants.v1.CompletionOptions)**

Configuration options for completion generation.
If specified, these options will override the assistant's completion settings for this run. ||
|#

## RunState {#yandex.cloud.ai.assistants.v1.runs.RunState}

Represents the current state of a run.

#|
||Field | Description ||
|| status | enum **RunStatus**

Current status of a run.

- `RUN_STATUS_UNSPECIFIED`: Default unspecified status.
- `PENDING`: Run has been created but has not started yet.
- `IN_PROGRESS`: Run is currently in progress.
- `FAILED`: Run has failed due to an error.
- `COMPLETED`: Run has completed successfully. ||
|| error | **[Error](#yandex.cloud.ai.common.Error)**

Error information if a run has failed.

Includes only one of the fields `error`, `completed_message`.

Oneof field to capture additional data depending on the state of a run. ||
|| completed_message | **[Message](#yandex.cloud.ai.assistants.v1.threads.Message)**

Final message generated by an assistant if a run has completed successfully.

Includes only one of the fields `error`, `completed_message`.

Oneof field to capture additional data depending on the state of a run. ||
|#

## Error {#yandex.cloud.ai.common.Error}

#|
||Field | Description ||
|| code | **int64** ||
|| message | **string** ||
|#

## Message {#yandex.cloud.ai.assistants.v1.threads.Message}

#|
||Field | Description ||
|| id | **string**

Unique identifier of the message. ||
|| thread_id | **string**

ID of the thread that this message belongs to. ||
|| created_by | **string**

Identifier of the subject who created this message. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp representing when the message was created. ||
|| author | **[Author](#yandex.cloud.ai.assistants.v1.threads.Author)**

Author of the message, containing details about the message's creator. ||
|| labels | **string**

Set of key-value pairs that can be used to organize and categorize the message. ||
|| content | **[MessageContent](#yandex.cloud.ai.assistants.v1.threads.MessageContent)**

Content of the message. ||
|| status | enum **MessageStatus**

Status of the message.

- `MESSAGE_STATUS_UNSPECIFIED`: Unspecified message status.
- `COMPLETED`: Message was successfully created by a user or generated by an assistant.
- `TRUNCATED`: Message generation was truncated due to reaching the maximum allowed number of tokens.
- `FILTERED_CONTENT`: Message generation was stopped because potentially sensitive content was detected either in the prompt or in the generated response. ||
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

## ContentUsage {#yandex.cloud.ai.assistants.v1.runs.ContentUsage}

Represents the content usage during a run, such as the number of [tokens](/docs/foundation-models/concepts/yandexgpt/tokens) used by the completion model.

#|
||Field | Description ||
|| prompt_tokens | **int64**

The number of tokens used in the prompt. ||
|| completion_tokens | **int64**

The number of tokens used in the completion response. ||
|| total_tokens | **int64**

The total number of tokens used (prompt + completion). ||
|#

## PromptTruncationOptions {#yandex.cloud.ai.assistants.v1.PromptTruncationOptions}

Defines the options for truncating thread messages within a prompt.

#|
||Field | Description ||
|| max_prompt_tokens | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The maximum number of tokens allowed in the prompt.
If the prompt exceeds this limit, the thread messages will be truncated.
Default max_prompt_tokens: 7000 ||
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