---
editable: false
apiPlayground:
  - url: https://llm.{{ api-host }}/foundationModels/v1/completionAsync
    method: post
    path: null
    query: null
    body:
      type: object
      properties:
        modelUri:
          description: |-
            **string**
            The [ID of the model](/docs/foundation-models/concepts/yandexgpt/models) to be used for completion generation.
          type: string
        completionOptions:
          description: |-
            **[CompletionOptions](#yandex.cloud.ai.foundation_models.v1.CompletionOptions)**
            Configuration options for completion generation.
          $ref: '#/definitions/CompletionOptions'
        messages:
          description: |-
            **[Message](#yandex.cloud.ai.foundation_models.v1.Message)**
            A list of messages representing the context for the completion model.
          type: array
          items:
            $ref: '#/definitions/Message'
        tools:
          description: |-
            **[Tool](#yandex.cloud.ai.foundation_models.v1.Tool)**
            List of tools that are available for the model to invoke during the completion generation.
            Note: This parameter is not yet supported and will be ignored if provided.
          type: array
          items:
            $ref: '#/definitions/Tool'
        jsonObject:
          description: |-
            **boolean**
            When set to true, the model will respond with a valid JSON object.
            Be sure to explicitly ask the model for JSON.
            Otherwise, it may generate excessive whitespace and run indefinitely until it reaches the token limit.
            Includes only one of the fields `jsonObject`, `jsonSchema`.
            Specifies the format of the model's response.
          type: boolean
        jsonSchema:
          description: |-
            **[JsonSchema](#yandex.cloud.ai.foundation_models.v1.JsonSchema)**
            Enforces a specific JSON structure for the model's response based on a provided schema.
            Includes only one of the fields `jsonObject`, `jsonSchema`.
            Specifies the format of the model's response.
          $ref: '#/definitions/JsonSchema'
        parallelToolCalls:
          description: |-
            **boolean**
            Controls whether the model can generate multiple tool calls in a single response. Defaults to true.
          type: boolean
        toolChoice:
          description: |-
            **[ToolChoice](#yandex.cloud.ai.foundation_models.v1.ToolChoice)**
            Specifies how the model should select which tool (or tools) to use when generating a response.
          $ref: '#/definitions/ToolChoice'
      additionalProperties: false
      oneOf:
        - required:
            - jsonObject
        - required:
            - jsonSchema
    definitions:
      ReasoningOptions:
        type: object
        properties:
          mode:
            description: |-
              **enum** (ReasoningMode)
              Specifies the reasoning mode to be used.
              - `REASONING_MODE_UNSPECIFIED`: Unspecified reasoning mode.
              - `DISABLED`: Disables reasoning. The model will generate a response without performing any internal reasoning.
              - `ENABLED_HIDDEN`: Enables reasoning in a hidden manner without exposing the reasoning steps to the user.
            type: string
            enum:
              - REASONING_MODE_UNSPECIFIED
              - DISABLED
              - ENABLED_HIDDEN
      CompletionOptions:
        type: object
        properties:
          stream:
            description: |-
              **boolean**
              Enables streaming of partially generated text.
            type: boolean
          temperature:
            description: |-
              **number** (double)
              Affects creativity and randomness of responses. Should be a double number between 0 (inclusive) and 1 (inclusive).
              Lower values produce more straightforward responses while higher values lead to increased creativity and randomness.
              Default temperature: 0.3
            type: number
            format: double
          maxTokens:
            description: |-
              **string** (int64)
              The limit on the number of tokens used for single completion generation.
              Must be greater than zero. This maximum allowed parameter value may depend on the model being used.
            type: string
            format: int64
          reasoningOptions:
            description: |-
              **[ReasoningOptions](#yandex.cloud.ai.foundation_models.v1.ReasoningOptions)**
              Configures reasoning capabilities for the model, allowing it to perform internal reasoning before responding.
            $ref: '#/definitions/ReasoningOptions'
      FunctionCall:
        type: object
        properties:
          name:
            description: |-
              **string**
              The name of the function being called.
            type: string
          arguments:
            description: |-
              **object**
              The structured arguments passed to the function.
              These arguments must adhere to the JSON Schema defined in the corresponding function's parameters.
            type: object
      ToolCall:
        type: object
        properties:
          functionCall:
            description: |-
              **[FunctionCall](#yandex.cloud.ai.foundation_models.v1.FunctionCall)**
              Represents a call to a function.
              Includes only one of the fields `functionCall`.
            $ref: '#/definitions/FunctionCall'
        oneOf:
          - required:
              - functionCall
      ToolCallList:
        type: object
        properties:
          toolCalls:
            description: |-
              **[ToolCall](#yandex.cloud.ai.foundation_models.v1.ToolCall)**
              A list of tool calls to be executed.
            type: array
            items:
              $ref: '#/definitions/ToolCall'
      FunctionResult:
        type: object
        properties:
          name:
            description: |-
              **string**
              The name of the function that was executed.
            type: string
          content:
            description: |-
              **string**
              The result of the function call, represented as a string.
              This field can be used to store the output of the function.
              Includes only one of the fields `content`.
            type: string
        oneOf:
          - required:
              - content
      ToolResult:
        type: object
        properties:
          functionResult:
            description: |-
              **[FunctionResult](#yandex.cloud.ai.foundation_models.v1.FunctionResult)**
              Represents the result of a function call.
              Includes only one of the fields `functionResult`.
            $ref: '#/definitions/FunctionResult'
        oneOf:
          - required:
              - functionResult
      ToolResultList:
        type: object
        properties:
          toolResults:
            description: |-
              **[ToolResult](#yandex.cloud.ai.foundation_models.v1.ToolResult)**
              A list of tool results.
            type: array
            items:
              $ref: '#/definitions/ToolResult'
      Message:
        type: object
        properties:
          role:
            description: |-
              **string**
              The ID of the message sender. Supported roles:
              * `system`: Special role used to define the behavior of the completion model.
              * `assistant`: A role used by the model to generate responses.
              * `user`: A role used by the user to describe requests to the model.
            type: string
          text:
            description: |-
              **string**
              Textual content of the message.
              Includes only one of the fields `text`, `toolCallList`, `toolResultList`.
              Message content.
            type: string
          toolCallList:
            description: |-
              **[ToolCallList](#yandex.cloud.ai.foundation_models.v1.ToolCallList)**
              List of tool calls made by the model as part of the response generation.
              Includes only one of the fields `text`, `toolCallList`, `toolResultList`.
              Message content.
            $ref: '#/definitions/ToolCallList'
          toolResultList:
            description: |-
              **[ToolResultList](#yandex.cloud.ai.foundation_models.v1.ToolResultList)**
              List of tool results returned from external tools that were invoked by the model.
              Includes only one of the fields `text`, `toolCallList`, `toolResultList`.
              Message content.
            $ref: '#/definitions/ToolResultList'
        oneOf:
          - required:
              - text
          - required:
              - toolCallList
          - required:
              - toolResultList
      FunctionTool:
        type: object
        properties:
          name:
            description: |-
              **string**
              The name of the function.
            type: string
          description:
            description: |-
              **string**
              A description of the function's purpose or behavior.
            type: string
          parameters:
            description: |-
              **object**
              A JSON Schema that defines the expected parameters for the function.
              The schema should describe the required fields, their types, and any constraints or default values.
            type: object
          strict:
            description: |-
              **boolean**
              Enforces strict adherence to the function schema, ensuring only defined parameters are used.
            type: boolean
      Tool:
        type: object
        properties:
          function:
            description: |-
              **[FunctionTool](#yandex.cloud.ai.foundation_models.v1.FunctionTool)**
              Represents a function that can be called.
              Includes only one of the fields `function`.
            $ref: '#/definitions/FunctionTool'
        oneOf:
          - required:
              - function
      JsonSchema:
        type: object
        properties:
          schema:
            description: |-
              **object**
              The JSON Schema that the model's output must conform to.
            type: object
      ToolChoice:
        type: object
        properties:
          mode:
            description: |-
              **enum** (ToolChoiceMode)
              Specifies the overall tool-calling mode.
              Includes only one of the fields `mode`, `functionName`.
              - `TOOL_CHOICE_MODE_UNSPECIFIED`: The server will choose the default behavior, which is AUTO.
              - `NONE`: The model will not call any tool and will generate a standard text response.
              - `AUTO`: The model can choose between generating a text response or calling one or more tools.
              This is the default behavior.
              - `REQUIRED`: The model is required to call one or more tools.
            type: string
            enum:
              - TOOL_CHOICE_MODE_UNSPECIFIED
              - NONE
              - AUTO
              - REQUIRED
          functionName:
            description: |-
              **string**
              Forces the model to call a specific function.
              The provided string must match the name of a function in the API request.
              Includes only one of the fields `mode`, `functionName`.
            type: string
        oneOf:
          - required:
              - mode
          - required:
              - functionName
sourcePath: en/_api-ref/ai/foundation_models/v1/text_generation/text-generation/api-ref/TextGenerationAsync/completion.md
---

# Foundation Models Text Generation API, REST: TextGenerationAsync.Completion

A method for generating text completions in [asynchronous mode](/docs/foundation-models/concepts/#working-mode).

## HTTP request

```
POST https://llm.{{ api-host }}/foundationModels/v1/completionAsync
```

## Body parameters {#yandex.cloud.ai.foundation_models.v1.CompletionRequest}

```json
{
  "modelUri": "string",
  "completionOptions": {
    "stream": "boolean",
    "temperature": "number",
    "maxTokens": "string",
    "reasoningOptions": {
      "mode": "string"
    }
  },
  "messages": [
    {
      "role": "string",
      // Includes only one of the fields `text`, `toolCallList`, `toolResultList`
      "text": "string",
      "toolCallList": {
        "toolCalls": [
          {
            // Includes only one of the fields `functionCall`
            "functionCall": {
              "name": "string",
              "arguments": "object"
            }
            // end of the list of possible fields
          }
        ]
      },
      "toolResultList": {
        "toolResults": [
          {
            // Includes only one of the fields `functionResult`
            "functionResult": {
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
        "parameters": "object",
        "strict": "boolean"
      }
      // end of the list of possible fields
    }
  ],
  // Includes only one of the fields `jsonObject`, `jsonSchema`
  "jsonObject": "boolean",
  "jsonSchema": {
    "schema": "object"
  },
  // end of the list of possible fields
  "parallelToolCalls": "boolean",
  "toolChoice": {
    // Includes only one of the fields `mode`, `functionName`
    "mode": "string",
    "functionName": "string"
    // end of the list of possible fields
  }
}
```

Request for the service to generate text completion.

#|
||Field | Description ||
|| modelUri | **string**

The [ID of the model](/docs/foundation-models/concepts/yandexgpt/models) to be used for completion generation. ||
|| completionOptions | **[CompletionOptions](#yandex.cloud.ai.foundation_models.v1.CompletionOptions)**

Configuration options for completion generation. ||
|| messages[] | **[Message](#yandex.cloud.ai.foundation_models.v1.Message)**

A list of messages representing the context for the completion model. ||
|| tools[] | **[Tool](#yandex.cloud.ai.foundation_models.v1.Tool)**

List of tools that are available for the model to invoke during the completion generation.
Note: This parameter is not yet supported and will be ignored if provided. ||
|| jsonObject | **boolean**

When set to true, the model will respond with a valid JSON object.
Be sure to explicitly ask the model for JSON.
Otherwise, it may generate excessive whitespace and run indefinitely until it reaches the token limit.

Includes only one of the fields `jsonObject`, `jsonSchema`.

Specifies the format of the model's response. ||
|| jsonSchema | **[JsonSchema](#yandex.cloud.ai.foundation_models.v1.JsonSchema)**

Enforces a specific JSON structure for the model's response based on a provided schema.

Includes only one of the fields `jsonObject`, `jsonSchema`.

Specifies the format of the model's response. ||
|| parallelToolCalls | **boolean**

Controls whether the model can generate multiple tool calls in a single response. Defaults to true. ||
|| toolChoice | **[ToolChoice](#yandex.cloud.ai.foundation_models.v1.ToolChoice)**

Specifies how the model should select which tool (or tools) to use when generating a response. ||
|#

## CompletionOptions {#yandex.cloud.ai.foundation_models.v1.CompletionOptions}

Defines the options for completion generation.

#|
||Field | Description ||
|| stream | **boolean**

Enables streaming of partially generated text. ||
|| temperature | **number** (double)

Affects creativity and randomness of responses. Should be a double number between 0 (inclusive) and 1 (inclusive).
Lower values produce more straightforward responses while higher values lead to increased creativity and randomness.
Default temperature: 0.3 ||
|| maxTokens | **string** (int64)

The limit on the number of tokens used for single completion generation.
Must be greater than zero. This maximum allowed parameter value may depend on the model being used. ||
|| reasoningOptions | **[ReasoningOptions](#yandex.cloud.ai.foundation_models.v1.ReasoningOptions)**

Configures reasoning capabilities for the model, allowing it to perform internal reasoning before responding. ||
|#

## ReasoningOptions {#yandex.cloud.ai.foundation_models.v1.ReasoningOptions}

Represents reasoning options that enable the model's ability to perform internal reasoning before generating a response.

#|
||Field | Description ||
|| mode | **enum** (ReasoningMode)

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
* `system`: Special role used to define the behavior of the completion model.
* `assistant`: A role used by the model to generate responses.
* `user`: A role used by the user to describe requests to the model. ||
|| text | **string**

Textual content of the message.

Includes only one of the fields `text`, `toolCallList`, `toolResultList`.

Message content. ||
|| toolCallList | **[ToolCallList](#yandex.cloud.ai.foundation_models.v1.ToolCallList)**

List of tool calls made by the model as part of the response generation.

Includes only one of the fields `text`, `toolCallList`, `toolResultList`.

Message content. ||
|| toolResultList | **[ToolResultList](#yandex.cloud.ai.foundation_models.v1.ToolResultList)**

List of tool results returned from external tools that were invoked by the model.

Includes only one of the fields `text`, `toolCallList`, `toolResultList`.

Message content. ||
|#

## ToolCallList {#yandex.cloud.ai.foundation_models.v1.ToolCallList}

Represents a list of tool calls.

#|
||Field | Description ||
|| toolCalls[] | **[ToolCall](#yandex.cloud.ai.foundation_models.v1.ToolCall)**

A list of tool calls to be executed. ||
|#

## ToolCall {#yandex.cloud.ai.foundation_models.v1.ToolCall}

Represents a call to a tool.

#|
||Field | Description ||
|| functionCall | **[FunctionCall](#yandex.cloud.ai.foundation_models.v1.FunctionCall)**

Represents a call to a function.

Includes only one of the fields `functionCall`. ||
|#

## FunctionCall {#yandex.cloud.ai.foundation_models.v1.FunctionCall}

Represents the invocation of a function with specific arguments.

#|
||Field | Description ||
|| name | **string**

The name of the function being called. ||
|| arguments | **object**

The structured arguments passed to the function.
These arguments must adhere to the JSON Schema defined in the corresponding function's parameters. ||
|#

## ToolResultList {#yandex.cloud.ai.foundation_models.v1.ToolResultList}

Represents a list of tool results.

#|
||Field | Description ||
|| toolResults[] | **[ToolResult](#yandex.cloud.ai.foundation_models.v1.ToolResult)**

A list of tool results. ||
|#

## ToolResult {#yandex.cloud.ai.foundation_models.v1.ToolResult}

Represents the result of a tool call.

#|
||Field | Description ||
|| functionResult | **[FunctionResult](#yandex.cloud.ai.foundation_models.v1.FunctionResult)**

Represents the result of a function call.

Includes only one of the fields `functionResult`. ||
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
|| parameters | **object**

A JSON Schema that defines the expected parameters for the function.
The schema should describe the required fields, their types, and any constraints or default values. ||
|| strict | **boolean**

Enforces strict adherence to the function schema, ensuring only defined parameters are used. ||
|#

## JsonSchema {#yandex.cloud.ai.foundation_models.v1.JsonSchema}

Represents the expected structure of the model's response using a JSON Schema.

#|
||Field | Description ||
|| schema | **object**

The JSON Schema that the model's output must conform to. ||
|#

## ToolChoice {#yandex.cloud.ai.foundation_models.v1.ToolChoice}

Specifies how the model should select which tool (or tools) to use when generating a response.

#|
||Field | Description ||
|| mode | **enum** (ToolChoiceMode)

Specifies the overall tool-calling mode.

Includes only one of the fields `mode`, `functionName`.

- `TOOL_CHOICE_MODE_UNSPECIFIED`: The server will choose the default behavior, which is AUTO.
- `NONE`: The model will not call any tool and will generate a standard text response.
- `AUTO`: The model can choose between generating a text response or calling one or more tools.
This is the default behavior.
- `REQUIRED`: The model is required to call one or more tools. ||
|| functionName | **string**

Forces the model to call a specific function.
The provided string must match the name of a function in the API request.

Includes only one of the fields `mode`, `functionName`. ||
|#

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": "object",
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
    "alternatives": [
      {
        "message": {
          "role": "string",
          // Includes only one of the fields `text`, `toolCallList`, `toolResultList`
          "text": "string",
          "toolCallList": {
            "toolCalls": [
              {
                // Includes only one of the fields `functionCall`
                "functionCall": {
                  "name": "string",
                  "arguments": "object"
                }
                // end of the list of possible fields
              }
            ]
          },
          "toolResultList": {
            "toolResults": [
              {
                // Includes only one of the fields `functionResult`
                "functionResult": {
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
        "status": "string"
      }
    ],
    "usage": {
      "inputTextTokens": "string",
      "completionTokens": "string",
      "totalTokens": "string",
      "completionTokensDetails": {
        "reasoningTokens": "string"
      }
    },
    "modelVersion": "string"
  }
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **object**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[CompletionResponse](#yandex.cloud.ai.foundation_models.v1.CompletionResponse)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
|#

## CompletionResponse {#yandex.cloud.ai.foundation_models.v1.CompletionResponse}

Response containing generated text completions.

#|
||Field | Description ||
|| alternatives[] | **[Alternative](#yandex.cloud.ai.foundation_models.v1.Alternative)**

A list of generated completion alternatives. ||
|| usage | **[ContentUsage](#yandex.cloud.ai.foundation_models.v1.ContentUsage)**

A set of statistics describing the number of content tokens used by the completion model. ||
|| modelVersion | **string**

The model version changes with each new releases. ||
|#

## Alternative {#yandex.cloud.ai.foundation_models.v1.Alternative}

Represents a generated completion alternative, including its content and generation status.

#|
||Field | Description ||
|| message | **[Message](#yandex.cloud.ai.foundation_models.v1.Message2)**

A message with the content of the alternative. ||
|| status | **enum** (AlternativeStatus)

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
* `system`: Special role used to define the behavior of the completion model.
* `assistant`: A role used by the model to generate responses.
* `user`: A role used by the user to describe requests to the model. ||
|| text | **string**

Textual content of the message.

Includes only one of the fields `text`, `toolCallList`, `toolResultList`.

Message content. ||
|| toolCallList | **[ToolCallList](#yandex.cloud.ai.foundation_models.v1.ToolCallList2)**

List of tool calls made by the model as part of the response generation.

Includes only one of the fields `text`, `toolCallList`, `toolResultList`.

Message content. ||
|| toolResultList | **[ToolResultList](#yandex.cloud.ai.foundation_models.v1.ToolResultList2)**

List of tool results returned from external tools that were invoked by the model.

Includes only one of the fields `text`, `toolCallList`, `toolResultList`.

Message content. ||
|#

## ToolCallList {#yandex.cloud.ai.foundation_models.v1.ToolCallList2}

Represents a list of tool calls.

#|
||Field | Description ||
|| toolCalls[] | **[ToolCall](#yandex.cloud.ai.foundation_models.v1.ToolCall2)**

A list of tool calls to be executed. ||
|#

## ToolCall {#yandex.cloud.ai.foundation_models.v1.ToolCall2}

Represents a call to a tool.

#|
||Field | Description ||
|| functionCall | **[FunctionCall](#yandex.cloud.ai.foundation_models.v1.FunctionCall2)**

Represents a call to a function.

Includes only one of the fields `functionCall`. ||
|#

## FunctionCall {#yandex.cloud.ai.foundation_models.v1.FunctionCall2}

Represents the invocation of a function with specific arguments.

#|
||Field | Description ||
|| name | **string**

The name of the function being called. ||
|| arguments | **object**

The structured arguments passed to the function.
These arguments must adhere to the JSON Schema defined in the corresponding function's parameters. ||
|#

## ToolResultList {#yandex.cloud.ai.foundation_models.v1.ToolResultList2}

Represents a list of tool results.

#|
||Field | Description ||
|| toolResults[] | **[ToolResult](#yandex.cloud.ai.foundation_models.v1.ToolResult2)**

A list of tool results. ||
|#

## ToolResult {#yandex.cloud.ai.foundation_models.v1.ToolResult2}

Represents the result of a tool call.

#|
||Field | Description ||
|| functionResult | **[FunctionResult](#yandex.cloud.ai.foundation_models.v1.FunctionResult2)**

Represents the result of a function call.

Includes only one of the fields `functionResult`. ||
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
|| inputTextTokens | **string** (int64)

The number of tokens in the textual part of the model input. ||
|| completionTokens | **string** (int64)

The number of tokens in the generated completion. ||
|| totalTokens | **string** (int64)

The total number of tokens, including all input tokens and all generated tokens. ||
|| completionTokensDetails | **[CompletionTokensDetails](#yandex.cloud.ai.foundation_models.v1.ContentUsage.CompletionTokensDetails)**

Provides additional information about how the completion tokens were utilized. ||
|#

## CompletionTokensDetails {#yandex.cloud.ai.foundation_models.v1.ContentUsage.CompletionTokensDetails}

Provides additional information about how the completion tokens were utilized.

#|
||Field | Description ||
|| reasoningTokens | **string** (int64)

The number of tokens used specifically for internal reasoning performed by the model. ||
|#