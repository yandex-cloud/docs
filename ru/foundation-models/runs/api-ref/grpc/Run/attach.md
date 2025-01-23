---
editable: false
sourcePath: en/_api-ref-grpc/ai/assistants/v1/runs/api-ref/grpc/Run/attach.md
---

# Runs, gRPC: RunService.Attach

Bi-directional streaming method to interact with a specific run.
Like `Listen`, `Attach` streams events from the run, but also allows clients to send events back.
For example, it can be used to submit function call results when the run is waiting for user input.

## gRPC request

**rpc Attach (stream [AttachRunRequest](#yandex.cloud.ai.assistants.v1.runs.AttachRunRequest)) returns (stream [StreamEvent](#yandex.cloud.ai.assistants.v1.runs.StreamEvent))**

## AttachRunRequest {#yandex.cloud.ai.assistants.v1.runs.AttachRunRequest}

```json
{
  "run_id": "string",
  "events_start_idx": "google.protobuf.Int64Value",
  // Includes only one of the fields `tool_result_list`
  "tool_result_list": {
    "tool_results": [
      {
        // Includes only one of the fields `function_result`
        "function_result": {
          "name": "string",
          // Includes only one of the fields `content`
          "content": "string"
          // end of the list of possible fields
        }
        // end of the list of possible fields
      }
    ]
  }
  // end of the list of possible fields
}
```

#|
||Field | Description ||
|| run_id | **string**

Required field. ID of the run to listen to. ||
|| events_start_idx | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Starting index for events. If provided, listening will start from this event. ||
|| tool_result_list | **[ToolResultList](#yandex.cloud.ai.assistants.v1.ToolResultList)**

A list of tool results to submit to the run, such as the output of a function call.

Includes only one of the fields `tool_result_list`.

Event to submit to the run. ||
|#

## ToolResultList {#yandex.cloud.ai.assistants.v1.ToolResultList}

Represents a list of tool results.

#|
||Field | Description ||
|| tool_results[] | **[ToolResult](#yandex.cloud.ai.assistants.v1.ToolResult)**

A list of tool results. ||
|#

## ToolResult {#yandex.cloud.ai.assistants.v1.ToolResult}

Represents the result of a tool call.

#|
||Field | Description ||
|| function_result | **[FunctionResult](#yandex.cloud.ai.assistants.v1.FunctionResult)**

Represents the result of a function call.

Includes only one of the fields `function_result`. ||
|#

## FunctionResult {#yandex.cloud.ai.assistants.v1.FunctionResult}

Represents the result of a function call.

#|
||Field | Description ||
|| name | **string**

The name of the function that was executed. ||
|| content | **string**

The result of the function call, represented as a string.
This field can be used to store the output of the function.

Includes only one of the fields `content`. ||
|#

## StreamEvent {#yandex.cloud.ai.assistants.v1.runs.StreamEvent}

```json
{
  "event_type": "EventType",
  "stream_cursor": {
    "current_event_idx": "int64",
    "num_user_events_received": "int64"
  },
  // Includes only one of the fields `error`, `partial_message`, `completed_message`, `tool_call_list`
  "error": {
    "code": "int64",
    "message": "string"
  },
  "partial_message": {
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
  "completed_message": {
    "id": "string",
    "thread_id": "string",
    "created_by": "string",
    "created_at": "google.protobuf.Timestamp",
    "author": {
      "id": "string",
      "role": "string"
    },
    "labels": "map<string, string>",
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
  },
  "tool_call_list": {
    "tool_calls": [
      {
        // Includes only one of the fields `function_call`
        "function_call": {
          "name": "string",
          "arguments": "google.protobuf.Struct"
        }
        // end of the list of possible fields
      }
    ]
  }
  // end of the list of possible fields
}
```

Represents an event in the stream of a run.

#|
||Field | Description ||
|| event_type | enum **EventType**

The type of event.

- `EVENT_TYPE_UNSPECIFIED`: Unspecified event type.
- `PARTIAL_MESSAGE`: Partial message is available.
- `ERROR`: Run has failed due to an error.
- `DONE`: The run has completed.
- `TOOL_CALLS`: The run is waiting for tool calls to be executed and their results to be submitted. ||
|| stream_cursor | **[StreamCursor](#yandex.cloud.ai.assistants.v1.runs.StreamCursor)**

The current position in the stream. ||
|| error | **[Error](#yandex.cloud.ai.common.Error)**

Error information if the run has failed.

Includes only one of the fields `error`, `partial_message`, `completed_message`, `tool_call_list`.

Event data, which can be one of several types. ||
|| partial_message | **[MessageContent](#yandex.cloud.ai.assistants.v1.threads.MessageContent)**

Partially generated message.

Includes only one of the fields `error`, `partial_message`, `completed_message`, `tool_call_list`.

Event data, which can be one of several types. ||
|| completed_message | **[Message](#yandex.cloud.ai.assistants.v1.threads.Message)**

Final message generated by an assistant if a run has completed successfully.

Includes only one of the fields `error`, `partial_message`, `completed_message`, `tool_call_list`.

Event data, which can be one of several types. ||
|| tool_call_list | **[ToolCallList](#yandex.cloud.ai.assistants.v1.ToolCallList)**

A list of tool calls requested by the assistant.

Includes only one of the fields `error`, `partial_message`, `completed_message`, `tool_call_list`.

Event data, which can be one of several types. ||
|#

## StreamCursor {#yandex.cloud.ai.assistants.v1.runs.StreamCursor}

Represents the cursor position in a stream of events.

#|
||Field | Description ||
|| current_event_idx | **int64**

Index of the current event in the stream. ||
|| num_user_events_received | **int64**

The number of user events received so far. ||
|#

## Error {#yandex.cloud.ai.common.Error}

#|
||Field | Description ||
|| code | **int64** ||
|| message | **string** ||
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
|| labels | **object** (map<**string**, **string**>)

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

## ToolCallList {#yandex.cloud.ai.assistants.v1.ToolCallList}

Represents a list of tool calls.

#|
||Field | Description ||
|| tool_calls[] | **[ToolCall](#yandex.cloud.ai.assistants.v1.ToolCall)**

A list of tool calls to be executed. ||
|#

## ToolCall {#yandex.cloud.ai.assistants.v1.ToolCall}

Represents a call to a tool.

#|
||Field | Description ||
|| function_call | **[FunctionCall](#yandex.cloud.ai.assistants.v1.FunctionCall)**

Represents a call to a function.

Includes only one of the fields `function_call`. ||
|#

## FunctionCall {#yandex.cloud.ai.assistants.v1.FunctionCall}

Represents the invocation of a function with specific arguments.

#|
||Field | Description ||
|| name | **string**

The name of the function being called. ||
|| arguments | **[google.protobuf.Struct](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/struct)**

The structured arguments passed to the function.
These arguments must adhere to the JSON Schema defined in the corresponding function's parameters. ||
|#