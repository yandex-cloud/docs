---
editable: false
sourcePath: en/_api-ref-grpc/ai/foundation_models/v1/text_generation/text-generation/api-ref/grpc/TextGeneration/completion.md
---

# Foundation Models Text Generation API, gRPC: TextGenerationService.Completion

A method for generating text completions in [synchronous mode](/docs/foundation-models/concepts/#working-mode).

## gRPC request

**rpc Completion ([CompletionRequest](#yandex.cloud.ai.foundation_models.v1.CompletionRequest)) returns (stream [CompletionResponse](#yandex.cloud.ai.foundation_models.v1.CompletionResponse))**

## CompletionRequest {#yandex.cloud.ai.foundation_models.v1.CompletionRequest}

```json
{
  "model_uri": "string",
  "completion_options": {
    "stream": "bool",
    "temperature": "google.protobuf.DoubleValue",
    "max_tokens": "google.protobuf.Int64Value",
    "reasoning_options": {
      "mode": "ReasoningMode"
    }
  },
  "messages": [
    {
      "role": "string",
      // Includes only one of the fields `text`, `tool_call_list`, `tool_result_list`
      "text": "string",
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
      },
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
  ],
  "tools": [
    {
      // Includes only one of the fields `function`
      "function": {
        "name": "string",
        "description": "string",
        "parameters": "google.protobuf.Struct",
        "strict": "bool"
      }
      // end of the list of possible fields
    }
  ],
  // Includes only one of the fields `json_object`, `json_schema`
  "json_object": "bool",
  "json_schema": {
    "schema": "google.protobuf.Struct"
  },
  // end of the list of possible fields
  "parallel_tool_calls": "google.protobuf.BoolValue",
  "tool_choice": {
    // Includes only one of the fields `mode`, `function_name`
    "mode": "ToolChoiceMode",
    "function_name": "string"
    // end of the list of possible fields
  }
}
```

Request for the service to generate text completion.

#|
||Field | Description ||
|| model_uri | **string**

The [ID of the model](/docs/foundation-models/concepts/yandexgpt/models) to be used for completion generation. ||
|| completion_options | **[CompletionOptions](#yandex.cloud.ai.foundation_models.v1.CompletionOptions)**

Configuration options for completion generation. ||
|| messages[] | **[Message](#yandex.cloud.ai.foundation_models.v1.Message)**

A list of messages representing the context for the completion model. ||
|| tools[] | **[Tool](#yandex.cloud.ai.foundation_models.v1.Tool)**

List of tools that are available for the model to invoke during the completion generation.
Note: This parameter is not yet supported and will be ignored if provided. ||
|| json_object | **bool**

When set to true, the model will respond with a valid JSON object.
Be sure to explicitly ask the model for JSON.
Otherwise, it may generate excessive whitespace and run indefinitely until it reaches the token limit.

Includes only one of the fields `json_object`, `json_schema`.

Specifies the format of the model's response. ||
|| json_schema | **[JsonSchema](#yandex.cloud.ai.foundation_models.v1.JsonSchema)**

Enforces a specific JSON structure for the model's response based on a provided schema.

Includes only one of the fields `json_object`, `json_schema`.

Specifies the format of the model's response. ||
|| parallel_tool_calls | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**

Controls whether the model can generate multiple tool calls in a single response. Defaults to true. ||
|| tool_choice | **[ToolChoice](#yandex.cloud.ai.foundation_models.v1.ToolChoice)**

Specifies how the model should select which tool (or tools) to use when generating a response. ||
|#

## CompletionOptions {#yandex.cloud.ai.foundation_models.v1.CompletionOptions}

Defines the options for completion generation.

#|
||Field | Description ||
|| stream | **bool**

Enables streaming of partially generated text. ||
|| temperature | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

Affects creativity and randomness of responses. Should be a double number between 0 (inclusive) and 1 (inclusive).
Lower values produce more straightforward responses while higher values lead to increased creativity and randomness.
Default temperature: 0.3 ||
|| max_tokens | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

The limit on the number of tokens used for single completion generation.
Must be greater than zero. This maximum allowed parameter value may depend on the model being used. ||
|| reasoning_options | **[ReasoningOptions](#yandex.cloud.ai.foundation_models.v1.ReasoningOptions)**

Configures reasoning capabilities for the model, allowing it to perform internal reasoning before responding. ||
|#

## ReasoningOptions {#yandex.cloud.ai.foundation_models.v1.ReasoningOptions}

Represents reasoning options that enable the model's ability to perform internal reasoning before generating a response.

#|
||Field | Description ||
|| mode | enum **ReasoningMode**

Specifies the reasoning mode to be used.

- `REASONING_MODE_UNSPECIFIED`: Unspecified reasoning mode.
- `DISABLED`: Disables reasoning. The model will generate a response without performing any internal reasoning.
- `ENABLED_HIDDEN`: Enables reasoning in a hidden manner without exposing the reasoning steps to the user. ||
|#

## Message {#yandex.cloud.ai.foundation_models.v1.Message}

A message object representing a wrapper over the inputs and outputs of the completion model.

#|
||Field | Description ||
|| role | **string**

The ID of the message sender. Supported roles:
* `system`: Special role used to define the behaviour of the completion model.
* `assistant`: A role used by the model to generate responses.
* `user`: A role used by the user to describe requests to the model. ||
|| text | **string**

Textual content of the message.

Includes only one of the fields `text`, `tool_call_list`, `tool_result_list`.

Message content. ||
|| tool_call_list | **[ToolCallList](#yandex.cloud.ai.foundation_models.v1.ToolCallList)**

List of tool calls made by the model as part of the response generation.

Includes only one of the fields `text`, `tool_call_list`, `tool_result_list`.

Message content. ||
|| tool_result_list | **[ToolResultList](#yandex.cloud.ai.foundation_models.v1.ToolResultList)**

List of tool results returned from external tools that were invoked by the model.

Includes only one of the fields `text`, `tool_call_list`, `tool_result_list`.

Message content. ||
|#

## ToolCallList {#yandex.cloud.ai.foundation_models.v1.ToolCallList}

Represents a list of tool calls.

#|
||Field | Description ||
|| tool_calls[] | **[ToolCall](#yandex.cloud.ai.foundation_models.v1.ToolCall)**

A list of tool calls to be executed. ||
|#

## ToolCall {#yandex.cloud.ai.foundation_models.v1.ToolCall}

Represents a call to a tool.

#|
||Field | Description ||
|| function_call | **[FunctionCall](#yandex.cloud.ai.foundation_models.v1.FunctionCall)**

Represents a call to a function.

Includes only one of the fields `function_call`. ||
|#

## FunctionCall {#yandex.cloud.ai.foundation_models.v1.FunctionCall}

Represents the invocation of a function with specific arguments.

#|
||Field | Description ||
|| name | **string**

The name of the function being called. ||
|| arguments | **[google.protobuf.Struct](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/struct)**

The structured arguments passed to the function.
These arguments must adhere to the JSON Schema defined in the corresponding function's parameters. ||
|#

## ToolResultList {#yandex.cloud.ai.foundation_models.v1.ToolResultList}

Represents a list of tool results.

#|
||Field | Description ||
|| tool_results[] | **[ToolResult](#yandex.cloud.ai.foundation_models.v1.ToolResult)**

A list of tool results. ||
|#

## ToolResult {#yandex.cloud.ai.foundation_models.v1.ToolResult}

Represents the result of a tool call.

#|
||Field | Description ||
|| function_result | **[FunctionResult](#yandex.cloud.ai.foundation_models.v1.FunctionResult)**

Represents the result of a function call.

Includes only one of the fields `function_result`. ||
|#

## FunctionResult {#yandex.cloud.ai.foundation_models.v1.FunctionResult}

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

## Tool {#yandex.cloud.ai.foundation_models.v1.Tool}

Represents a tool that can be invoked during completion generation.

#|
||Field | Description ||
|| function | **[FunctionTool](#yandex.cloud.ai.foundation_models.v1.FunctionTool)**

Represents a function that can be called.

Includes only one of the fields `function`. ||
|#

## FunctionTool {#yandex.cloud.ai.foundation_models.v1.FunctionTool}

Represents a function tool that can be invoked during completion generation.

#|
||Field | Description ||
|| name | **string**

The name of the function. ||
|| description | **string**

A description of the function's purpose or behavior. ||
|| parameters | **[google.protobuf.Struct](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/struct)**

A JSON Schema that defines the expected parameters for the function.
The schema should describe the required fields, their types, and any constraints or default values. ||
|| strict | **bool**

Enforces strict adherence to the function schema, ensuring only defined parameters are used. ||
|#

## JsonSchema {#yandex.cloud.ai.foundation_models.v1.JsonSchema}

Represents the expected structure of the model's response using a JSON Schema.

#|
||Field | Description ||
|| schema | **[google.protobuf.Struct](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/struct)**

The JSON Schema that the model's output must conform to. ||
|#

## ToolChoice {#yandex.cloud.ai.foundation_models.v1.ToolChoice}

Specifies how the model should select which tool (or tools) to use when generating a response.

#|
||Field | Description ||
|| mode | enum **ToolChoiceMode**

Specifies the overall tool-calling mode.

Includes only one of the fields `mode`, `function_name`.

- `TOOL_CHOICE_MODE_UNSPECIFIED`: The server will choose the default behavior, which is AUTO.
- `NONE`: The model will not call any tool and will generate a standard text response.
- `AUTO`: The model can choose between generating a text response or calling one or more tools.
This is the default behavior.
- `REQUIRED`: The model is required to call one or more tools. ||
|| function_name | **string**

Forces the model to call a specific function.
The provided string must match the name of a function in the API request.

Includes only one of the fields `mode`, `function_name`. ||
|#

## CompletionResponse {#yandex.cloud.ai.foundation_models.v1.CompletionResponse}

```json
{
  "alternatives": [
    {
      "message": {
        "role": "string",
        // Includes only one of the fields `text`, `tool_call_list`, `tool_result_list`
        "text": "string",
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
        },
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
      },
      "status": "AlternativeStatus"
    }
  ],
  "usage": {
    "input_text_tokens": "int64",
    "completion_tokens": "int64",
    "total_tokens": "int64",
    "completion_tokens_details": {
      "reasoning_tokens": "int64"
    }
  },
  "model_version": "string"
}
```

Response containing generated text completions.

#|
||Field | Description ||
|| alternatives[] | **[Alternative](#yandex.cloud.ai.foundation_models.v1.Alternative)**

A list of generated completion alternatives. ||
|| usage | **[ContentUsage](#yandex.cloud.ai.foundation_models.v1.ContentUsage)**

A set of statistics describing the number of content tokens used by the completion model. ||
|| model_version | **string**

The model version changes with each new releases. ||
|#

## Alternative {#yandex.cloud.ai.foundation_models.v1.Alternative}

Represents a generated completion alternative, including its content and generation status.

#|
||Field | Description ||
|| message | **[Message](#yandex.cloud.ai.foundation_models.v1.Message2)**

A message with the content of the alternative. ||
|| status | enum **AlternativeStatus**

The generation status of the alternative.

- `ALTERNATIVE_STATUS_UNSPECIFIED`: Unspecified generation status.
- `ALTERNATIVE_STATUS_PARTIAL`: Partially generated alternative.
- `ALTERNATIVE_STATUS_TRUNCATED_FINAL`: Incomplete final alternative resulting from reaching the maximum allowed number of tokens.
- `ALTERNATIVE_STATUS_FINAL`: Final alternative generated without running into any limits.
- `ALTERNATIVE_STATUS_CONTENT_FILTER`: Generation was stopped due to the discovery of potentially sensitive content in the prompt or generated response.
To fix, modify the prompt and restart generation.
- `ALTERNATIVE_STATUS_TOOL_CALLS`: Tools were invoked during the completion generation. ||
|#

## Message {#yandex.cloud.ai.foundation_models.v1.Message2}

A message object representing a wrapper over the inputs and outputs of the completion model.

#|
||Field | Description ||
|| role | **string**

The ID of the message sender. Supported roles:
* `system`: Special role used to define the behaviour of the completion model.
* `assistant`: A role used by the model to generate responses.
* `user`: A role used by the user to describe requests to the model. ||
|| text | **string**

Textual content of the message.

Includes only one of the fields `text`, `tool_call_list`, `tool_result_list`.

Message content. ||
|| tool_call_list | **[ToolCallList](#yandex.cloud.ai.foundation_models.v1.ToolCallList2)**

List of tool calls made by the model as part of the response generation.

Includes only one of the fields `text`, `tool_call_list`, `tool_result_list`.

Message content. ||
|| tool_result_list | **[ToolResultList](#yandex.cloud.ai.foundation_models.v1.ToolResultList2)**

List of tool results returned from external tools that were invoked by the model.

Includes only one of the fields `text`, `tool_call_list`, `tool_result_list`.

Message content. ||
|#

## ToolCallList {#yandex.cloud.ai.foundation_models.v1.ToolCallList2}

Represents a list of tool calls.

#|
||Field | Description ||
|| tool_calls[] | **[ToolCall](#yandex.cloud.ai.foundation_models.v1.ToolCall2)**

A list of tool calls to be executed. ||
|#

## ToolCall {#yandex.cloud.ai.foundation_models.v1.ToolCall2}

Represents a call to a tool.

#|
||Field | Description ||
|| function_call | **[FunctionCall](#yandex.cloud.ai.foundation_models.v1.FunctionCall2)**

Represents a call to a function.

Includes only one of the fields `function_call`. ||
|#

## FunctionCall {#yandex.cloud.ai.foundation_models.v1.FunctionCall2}

Represents the invocation of a function with specific arguments.

#|
||Field | Description ||
|| name | **string**

The name of the function being called. ||
|| arguments | **[google.protobuf.Struct](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/struct)**

The structured arguments passed to the function.
These arguments must adhere to the JSON Schema defined in the corresponding function's parameters. ||
|#

## ToolResultList {#yandex.cloud.ai.foundation_models.v1.ToolResultList2}

Represents a list of tool results.

#|
||Field | Description ||
|| tool_results[] | **[ToolResult](#yandex.cloud.ai.foundation_models.v1.ToolResult2)**

A list of tool results. ||
|#

## ToolResult {#yandex.cloud.ai.foundation_models.v1.ToolResult2}

Represents the result of a tool call.

#|
||Field | Description ||
|| function_result | **[FunctionResult](#yandex.cloud.ai.foundation_models.v1.FunctionResult2)**

Represents the result of a function call.

Includes only one of the fields `function_result`. ||
|#

## FunctionResult {#yandex.cloud.ai.foundation_models.v1.FunctionResult2}

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

## ContentUsage {#yandex.cloud.ai.foundation_models.v1.ContentUsage}

An object representing the number of content [tokens](/docs/foundation-models/concepts/yandexgpt/tokens) used by the completion model.

#|
||Field | Description ||
|| input_text_tokens | **int64**

The number of tokens in the textual part of the model input. ||
|| completion_tokens | **int64**

The number of tokens in the generated completion. ||
|| total_tokens | **int64**

The total number of tokens, including all input tokens and all generated tokens. ||
|| completion_tokens_details | **[CompletionTokensDetails](#yandex.cloud.ai.foundation_models.v1.ContentUsage.CompletionTokensDetails)**

Provides additional information about how the completion tokens were utilized. ||
|#

## CompletionTokensDetails {#yandex.cloud.ai.foundation_models.v1.ContentUsage.CompletionTokensDetails}

Provides additional information about how the completion tokens were utilized.

#|
||Field | Description ||
|| reasoning_tokens | **int64**

The number of tokens used specifically for internal reasoning performed by the model. ||
|#