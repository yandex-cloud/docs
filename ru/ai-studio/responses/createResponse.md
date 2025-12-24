---
editable: false
sourcePath: en/_openapi/openai-compatible/responses/createResponse.md
---

# REST: Create a model response

Creates a model response. Provide  text or image inputs to generate text 
or JSON outputs. Have the model call your own custom code or use built-in
tools like [Web Search Tool](https://yandex.cloud/docs/ai-studio/concepts/agents/tools/websearch).
or [File Search Tool](https://yandex.cloud/docs/ai-studio/concepts/agents/tools/filesearch) to use your own data
as input for the model's response.


## HTTP request

```
POST https://ai.api.cloud.yandex.net/v1/responses
```

## Body parameters

**Request schema: application/json**

```json
{
  "<allOf>": [
    "unknown",
    {
      "previous_response_id": "unknown",
      "model": "unknown",
      "reasoning": "unknown",
      "background": "unknown",
      "max_output_tokens": "unknown",
      "max_tool_calls": "unknown",
      "text": {
        "format": "unknown",
        "verbosity": "unknown"
      },
      "tools": [
        {
          "<anyOf>": [
            {
              "type": "string",
              "name": "string",
              "description": "unknown",
              "parameters": "unknown",
              "strict": "unknown"
            },
            {
              "type": "string",
              "vector_store_ids": [
                "string"
              ],
              "max_num_results": "integer",
              "ranking_options": {
                "ranker": "string",
                "score_threshold": "number",
                "hybrid_search": {
                  "embedding_weight": "number",
                  "text_weight": "number"
                }
              },
              "filters": "unknown"
            },
            {
              "type": "string",
              "environment": "string",
              "display_width": "integer",
              "display_height": "integer"
            },
            {
              "type": "string",
              "filters": "unknown",
              "user_location": "unknown",
              "search_context_size": "string"
            },
            {
              "type": "string",
              "server_label": "string",
              "server_url": "string",
              "connector_id": "string",
              "authorization": "string",
              "server_description": "string",
              "headers": "unknown",
              "allowed_tools": "unknown",
              "require_approval": "unknown"
            },
            {
              "type": "string",
              "container": "unknown"
            },
            {
              "type": "string",
              "model": "unknown",
              "quality": "string",
              "size": "string",
              "output_format": "string",
              "output_compression": "integer",
              "moderation": "string",
              "background": "string",
              "input_fidelity": "unknown",
              "input_image_mask": {
                "image_url": "string",
                "file_id": "string"
              },
              "partial_images": "integer"
            },
            {
              "type": "string"
            },
            {
              "type": "string"
            },
            {
              "type": "string",
              "name": "string",
              "description": "string",
              "format": "unknown"
            },
            {
              "type": "string",
              "user_location": "unknown",
              "search_context_size": "string"
            },
            {
              "type": "string"
            }
          ]
        }
      ],
      "tool_choice": "unknown",
      "prompt": "unknown",
      "truncation": "unknown"
    },
    {
      "input": "unknown",
      "include": "unknown",
      "parallel_tool_calls": "unknown",
      "store": "unknown",
      "instructions": "unknown",
      "stream": "unknown",
      "stream_options": "unknown",
      "conversation": "unknown"
    }
  ]
}
```

#|
||Field | Description ||
|| previous_response_id | Any of **string** \| **null** ||
|| model | Any of **unknown** \| **enum** ||
|| reasoning | Any of **[Reasoning](#Reasoning)** \| **null** ||
|| background | Any of **boolean** \| **null** ||
|| max_output_tokens | Any of **integer** \| **null** ||
|| max_tool_calls | Any of **integer** \| **null** ||
|| text | **[ResponseTextParam](#ResponseTextParam)**

Configuration options for a text response from the model. Can be plain
text or structured JSON data. ||
|| tools[] | **unknown**

A tool that can be used to generate a response. ||
|| tool_choice | Any of **enum** \| **[ToolChoiceAllowed](#ToolChoiceAllowed)** \| **[ToolChoiceTypes](#ToolChoiceTypes)** \| **[ToolChoiceFunction](#ToolChoiceFunction)** \| **[ToolChoiceMCP](#ToolChoiceMCP)** \| **[ToolChoiceCustom](#ToolChoiceCustom)** \| **[SpecificApplyPatchParam](#SpecificApplyPatchParam)** \| **[SpecificFunctionShellParam](#SpecificFunctionShellParam)** ||
|| prompt | Any of **[Prompt0](#Prompt0)** \| **null** ||
|| truncation | **unknown**

[CURRENTLY NOT SUPPORTED] ||
|#

#|
||Field | Description ||
|| input | Any of **string** \| **unknown** ||
|| include | Any of **enum** \| **null** ||
|| parallel_tool_calls | Any of **boolean** \| **null** ||
|| store | Any of **boolean** \| **null** ||
|| instructions | Any of **string** \| **null** ||
|| stream | Any of **boolean** \| **null** ||
|| stream_options | Any of **[ResponseStreamOptions0](#ResponseStreamOptions0)** \| **null** ||
|| conversation | Any of **unknown** \| **null** ||
|#

## Reasoning {#Reasoning}

[CURRENTLY NOT SUPPORTED]

#|
||Field | Description ||
|| effort [CURRENTLY NOT SUPPORTED] | Any of **enum** \| **null** ||
|| summary [CURRENTLY NOT SUPPORTED] | Any of **enum** \| **null** ||
|| generate_summary | Any of **enum** \| **null** ||
|#

## ResponseTextParam {#ResponseTextParam}

Configuration options for a text response from the model. Can be plain
text or structured JSON data.

#|
||Field | Description ||
|| format | Any of **[ResponseFormatText](#ResponseFormatText)** \| **[TextResponseFormatJsonSchema](#TextResponseFormatJsonSchema)** \| **[ResponseFormatJsonObject](#ResponseFormatJsonObject)** ||
|| verbosity | Any of **enum** \| **null** ||
|#

## ResponseFormatText {#ResponseFormatText}

Default response format. Used to generate text responses.

#|
||Field | Description ||
|| type | **enum**

Required field. The type of response format being defined. Always `text`.

- `text` ||
|#

## TextResponseFormatJsonSchema {#TextResponseFormatJsonSchema}

JSON Schema response format. Used to generate structured JSON responses.'


#|
||Field | Description ||
|| type | **enum**

Required field. The type of response format being defined. Always `json_schema`.

- `json_schema` ||
|| description | **string**

A description of what the response format is for, used by the model to
determine how to respond in the format. ||
|| name | **string**

Required field. The name of the response format. Must be a-z, A-Z, 0-9, or contain
underscores and dashes, with a maximum length of 64. ||
|| schema | **object**

Required field. The schema for the response format, described as a JSON Schema object.
Learn how to build JSON schemas [here](https://json-schema.org/). ||
|| strict | Any of **boolean** \| **null** ||
|#

## ResponseFormatJsonObject {#ResponseFormatJsonObject}

JSON object response format. An older method of generating JSON responses.
Using `json_schema` is recommended for models that support it. Note that the
model will not generate JSON without a system or user message instructing it
to do so.

#|
||Field | Description ||
|| type | **enum**

Required field. The type of response format being defined. Always `json_object`.

- `json_object` ||
|#

## ToolChoiceAllowed {#ToolChoiceAllowed}

Constrains the tools available to the model to a pre-defined set.

#|
||Field | Description ||
|| type | **enum**

Required field. Allowed tool configuration type. Always `allowed_tools`.

- `allowed_tools` ||
|| mode | **enum**

Required field. Constrains the tools available to the model to a pre-defined set.

`auto` allows the model to pick from among the allowed tools and generate a
message.

`required` requires the model to call one or more of the allowed tools.

- `auto`
- `required` ||
|| tools[] | **object**

Required field. A tool definition that the model should be allowed to call. ||
|#

## ToolChoiceTypes {#ToolChoiceTypes}

Indicates that the model should use a built-in tool to generate a response.'


#|
||Field | Description ||
|| type | **enum**

Required field. The type of hosted tool the model should to use. Allowed values are:


- `file_search`
- `web_search_preview`
- `computer_use_preview`
- `web_search_preview_2025_03_11`
- `image_generation`
- `code_interpreter` ||
|#

## ToolChoiceFunction {#ToolChoiceFunction}

Use this option to force the model to call a specific function.

#|
||Field | Description ||
|| type | **enum**

Required field. For function calling, the type is always `function`.

- `function` ||
|| name | **string**

Required field. The name of the function to call. ||
|#

## ToolChoiceMCP {#ToolChoiceMCP}

Use this option to force the model to call a specific tool on a remote MCP server.

#|
||Field | Description ||
|| type | **enum**

Required field. For MCP tools, the type is always `mcp`.

- `mcp` ||
|| server_label | **string**

Required field. The label of the MCP server to use. ||
|| name | Any of **string** \| **null** ||
|#

## ToolChoiceCustom {#ToolChoiceCustom}

Use this option to force the model to call a specific custom tool.

#|
||Field | Description ||
|| type | **enum**

Required field. For custom tool calling, the type is always `custom`.

- `custom` ||
|| name | **string**

Required field. The name of the custom tool to call. ||
|#

## SpecificApplyPatchParam {#SpecificApplyPatchParam}

Forces the model to call the apply_patch tool when executing a tool call.

#|
||Field | Description ||
|| type | **enum**

Required field. The tool to call. Always `apply_patch`.

- `apply_patch` ||
|#

## SpecificFunctionShellParam {#SpecificFunctionShellParam}

Forces the model to call the shell tool when a tool call is required.

#|
||Field | Description ||
|| type | **enum**

Required field. The tool to call. Always `shell`.

- `shell` ||
|#

## Prompt0 {#Prompt0}

Reference to a prompt template and its variables.

#|
||Field | Description ||
|| id | **string**

Required field. The unique identifier of the prompt template to use. ||
|| version | Any of **string** \| **null** ||
|| variables | Any of **object** (map<**string**, **unknown**>) \| **null** ||
|#

## ResponseStreamOptions0 {#ResponseStreamOptions0}

Options for streaming responses. Only set this when you set `stream: true`.


#|
||Field | Description ||
|| include_obfuscation | **boolean**

[CURRENTLY NOT SUPPPORTED] ||
|#

## Response {#200}

**HTTP Code: 200**

OK

{% list tabs %}

- application/json

  ```json
  {
    "<allOf>": [
      {
        "metadata": "unknown",
        "top_logprobs": "unknown",
        "temperature": "unknown",
        "top_p": "unknown",
        "user": "string",
        "safety_identifier": "unknown",
        "prompt_cache_key": "unknown",
        "service_tier": "unknown",
        "prompt_cache_retention": "unknown"
      },
      {
        "previous_response_id": "unknown",
        "model": "unknown",
        "reasoning": "unknown",
        "background": "unknown",
        "max_output_tokens": "unknown",
        "max_tool_calls": "unknown",
        "text": {
          "format": "unknown",
          "verbosity": "unknown"
        },
        "tools": [
          {
            "<anyOf>": [
              {
                "type": "string",
                "name": "string",
                "description": "unknown",
                "parameters": "unknown",
                "strict": "unknown"
              },
              {
                "type": "string",
                "vector_store_ids": [
                  "string"
                ],
                "max_num_results": "integer",
                "ranking_options": {
                  "ranker": "string",
                  "score_threshold": "number",
                  "hybrid_search": {
                    "embedding_weight": "number",
                    "text_weight": "number"
                  }
                },
                "filters": "unknown"
              },
              {
                "type": "string",
                "environment": "string",
                "display_width": "integer",
                "display_height": "integer"
              },
              {
                "type": "string",
                "filters": "unknown",
                "user_location": "unknown",
                "search_context_size": "string"
              },
              {
                "type": "string",
                "server_label": "string",
                "server_url": "string",
                "connector_id": "string",
                "authorization": "string",
                "server_description": "string",
                "headers": "unknown",
                "allowed_tools": "unknown",
                "require_approval": "unknown"
              },
              {
                "type": "string",
                "container": "unknown"
              },
              {
                "type": "string",
                "model": "unknown",
                "quality": "string",
                "size": "string",
                "output_format": "string",
                "output_compression": "integer",
                "moderation": "string",
                "background": "string",
                "input_fidelity": "unknown",
                "input_image_mask": {
                  "image_url": "string",
                  "file_id": "string"
                },
                "partial_images": "integer"
              },
              {
                "type": "string"
              },
              {
                "type": "string"
              },
              {
                "type": "string",
                "name": "string",
                "description": "string",
                "format": "unknown"
              },
              {
                "type": "string",
                "user_location": "unknown",
                "search_context_size": "string"
              },
              {
                "type": "string"
              }
            ]
          }
        ],
        "tool_choice": "unknown",
        "prompt": "unknown",
        "truncation": "unknown"
      },
      {
        "id": "string",
        "object": "string",
        "status": "string",
        "created_at": "number",
        "error": "unknown",
        "incomplete_details": "unknown",
        "output": [
          {
            "<anyOf>": [
              {
                "id": "string",
                "type": "string",
                "role": "string",
                "content": [
                  {
                    "<anyOf>": [
                      {
                        "type": "string",
                        "text": "string",
                        "annotations": [
                          {
                            "<anyOf>": [
                              {
                                "type": "string",
                                "file_id": "string",
                                "index": "integer",
                                "filename": "string"
                              },
                              {
                                "type": "string",
                                "url": "string",
                                "start_index": "integer",
                                "end_index": "integer",
                                "title": "string"
                              },
                              {
                                "type": "string",
                                "container_id": "string",
                                "file_id": "string",
                                "start_index": "integer",
                                "end_index": "integer",
                                "filename": "string"
                              },
                              {
                                "type": "string",
                                "file_id": "string",
                                "index": "integer"
                              }
                            ]
                          }
                        ],
                        "logprobs": [
                          {
                            "token": "string",
                            "logprob": "number",
                            "bytes": [
                              "integer"
                            ],
                            "top_logprobs": [
                              {
                                "token": "string",
                                "logprob": "number",
                                "bytes": [
                                  "integer"
                                ]
                              }
                            ]
                          }
                        ]
                      },
                      {
                        "type": "string",
                        "refusal": "string"
                      }
                    ]
                  }
                ],
                "status": "string"
              },
              {
                "id": "string",
                "type": "string",
                "status": "string",
                "queries": [
                  "string"
                ],
                "results": "unknown"
              },
              {
                "id": "string",
                "type": "string",
                "call_id": "string",
                "name": "string",
                "arguments": "string",
                "status": "string"
              },
              {
                "id": "string",
                "type": "string",
                "status": "string",
                "action": {
                  "<anyOf>": [
                    {
                      "type": "string",
                      "query": "string",
                      "sources": [
                        {
                          "type": "string",
                          "url": "string"
                        }
                      ]
                    },
                    {
                      "type": "string",
                      "url": "string"
                    },
                    {
                      "type": "string",
                      "url": "string",
                      "pattern": "string"
                    }
                  ]
                }
              },
              {
                "type": "string",
                "id": "string",
                "call_id": "string",
                "action": "unknown",
                "pending_safety_checks": [
                  {
                    "id": "string",
                    "code": "unknown",
                    "message": "unknown"
                  }
                ],
                "status": "string"
              },
              {
                "type": "string",
                "id": "string",
                "encrypted_content": "unknown",
                "summary": [
                  {
                    "type": "string",
                    "text": "string"
                  }
                ],
                "content": [
                  {
                    "type": "string",
                    "text": "string"
                  }
                ],
                "status": "string"
              },
              {
                "type": "string",
                "id": "string",
                "encrypted_content": "string",
                "created_by": "string"
              },
              {
                "type": "string",
                "id": "string",
                "status": "string",
                "result": "unknown"
              },
              {
                "type": "string",
                "id": "string",
                "status": "string",
                "container_id": "string",
                "code": "unknown",
                "outputs": "unknown"
              },
              {
                "type": "string",
                "id": "string",
                "call_id": "string",
                "action": {
                  "type": "string",
                  "command": [
                    "string"
                  ],
                  "timeout_ms": "unknown",
                  "working_directory": "unknown",
                  "env": {
                    "string": "string"
                  },
                  "user": "unknown"
                },
                "status": "string"
              },
              {
                "type": "string",
                "id": "string",
                "call_id": "string",
                "action": {
                  "commands": [
                    "string"
                  ],
                  "timeout_ms": "unknown",
                  "max_output_length": "unknown"
                },
                "status": "string",
                "created_by": "string"
              },
              {
                "type": "string",
                "id": "string",
                "call_id": "string",
                "output": [
                  {
                    "stdout": "string",
                    "stderr": "string",
                    "outcome": "unknown",
                    "created_by": "string"
                  }
                ],
                "max_output_length": "unknown",
                "created_by": "string"
              },
              {
                "type": "string",
                "id": "string",
                "call_id": "string",
                "status": "string",
                "operation": "unknown",
                "created_by": "string"
              },
              {
                "type": "string",
                "id": "string",
                "call_id": "string",
                "status": "string",
                "output": "unknown",
                "created_by": "string"
              },
              {
                "type": "string",
                "id": "string",
                "server_label": "string",
                "name": "string",
                "arguments": "string",
                "output": "unknown",
                "error": "unknown",
                "status": "string",
                "approval_request_id": "unknown"
              },
              {
                "type": "string",
                "id": "string",
                "server_label": "string",
                "tools": [
                  {
                    "name": "string",
                    "description": "unknown",
                    "input_schema": {},
                    "annotations": "unknown"
                  }
                ],
                "error": "unknown"
              },
              {
                "type": "string",
                "id": "string",
                "server_label": "string",
                "name": "string",
                "arguments": "string"
              },
              {
                "type": "string",
                "id": "string",
                "call_id": "string",
                "name": "string",
                "input": "string"
              }
            ]
          }
        ],
        "instructions": "unknown",
        "output_text": "unknown",
        "usage": {
          "input_tokens": "integer",
          "input_tokens_details": {
            "cached_tokens": "integer"
          },
          "output_tokens": "integer",
          "output_tokens_details": {
            "reasoning_tokens": "integer"
          },
          "total_tokens": "integer"
        },
        "parallel_tool_calls": "boolean",
        "conversation": "unknown"
      }
    ]
  }
  ```
  
  All of:
  
  #|
  ||Field | Description ||
  || metadata | **unknown**
  
  [CURRENTLY NOT SUPPORTED] ||
  || top_logprobs | **unknown**
  
  NOT SUPPORTED BY ALL MODELS. An integer between 0 and 20 specifying the number of most likely tokens to return at each token position, each with an associated log probability. ||
  || temperature | **unknown**
  
  What sampling temperature to use, between 0 and 1. Higher values like 0.8 will make the output more random, while lower values like 0.3 will make it more focused and deterministic. We generally recommend altering this or top_p but not both. ||
  || top_p | **unknown**
  
  NOT SUPPORTED BY ALL MODELS. An alternative to sampling with temperature, called nucleus sampling, where the model considers the results of the tokens with top_p probability mass. So 0.1 means only the tokens comprising the top 10% probability mass are considered. ||
  || user | **string**
  
  This field is being replaced by `safety_identifier` and `prompt_cache_key`. Use `prompt_cache_key` instead to maintain caching optimizations.
  A stable identifier for your end-users.
  Used to boost cache hit rates by better bucketing similar requests and  to help Yandex Cloud AI Studio detect and prevent abuse. 
   ||
  || safety_identifier | **unknown**
  
  [CURRENTLY NOT SUPPORTED] ||
  || prompt_cache_key | **unknown**
  
  [CURRENTLY NOT SUPPORTED] ||
  || service_tier | **unknown**
  
  [CURRENTLY NOT SUPPORTED] ||
  || prompt_cache_retention | **unknown**
  
  [CURRENTLY NOT SUPPORTED] ||
  |#
   
  #|
  ||Field | Description ||
  || previous_response_id | Any of **string** \| **null** ||
  || model | Any of **unknown** \| **enum** ||
  || reasoning | Any of **[Reasoning](#Reasoning2)** \| **null** ||
  || background | Any of **boolean** \| **null** ||
  || max_output_tokens | Any of **integer** \| **null** ||
  || max_tool_calls | Any of **integer** \| **null** ||
  || text | **[ResponseTextParam](#ResponseTextParam2)**
  
  Configuration options for a text response from the model. Can be plain
  text or structured JSON data.   ||
  || tools[] | **unknown**
  
  A tool that can be used to generate a response.   ||
  || tool_choice | Any of **enum** \| **[ToolChoiceAllowed](#ToolChoiceAllowed2)** \| **[ToolChoiceTypes](#ToolChoiceTypes2)** \| **[ToolChoiceFunction](#ToolChoiceFunction2)** \| **[ToolChoiceMCP](#ToolChoiceMCP2)** \| **[ToolChoiceCustom](#ToolChoiceCustom2)** \| **[SpecificApplyPatchParam](#SpecificApplyPatchParam2)** \| **[SpecificFunctionShellParam](#SpecificFunctionShellParam2)** ||
  || prompt | Any of **[Prompt0](#Prompt02)** \| **null** ||
  || truncation | **unknown**
  
  [CURRENTLY NOT SUPPORTED] ||
  |#
  
  #|
  ||Field | Description ||
  || id | **string**
  
  Required field. Unique identifier for this Response.   ||
  || object | **enum**
  
  Required field. The object type of this resource - always set to `response`.  
  
  - `response` ||
  || status | **enum**
  
  The status of the response generation. One of `completed`, `failed`,
  `in_progress`, `cancelled`, `queued`, or `incomplete`.  
  
  - `completed`
  - `failed`
  - `in_progress`
  - `cancelled`
  - `queued`
  - `incomplete` ||
  || created_at | **number**
  
  Required field. Unix timestamp (in seconds) of when this Response was created.   ||
  || error | Any of **[ResponseError0](#ResponseError0)** \| **null** ||
  || incomplete_details | Any of **[IncompleteDetails0](#IncompleteDetails0)** \| **null** ||
  || output[] | **unknown**
  
  Required field.  ||
  || instructions | Any of **unknown** \| **null** ||
  || output_text | Any of **string** \| **null** ||
  || usage | **[ResponseUsage](#ResponseUsage)**
  
  Required field. Represents token usage details including input tokens, output tokens,
  a breakdown of output tokens, and the total tokens used.   ||
  || parallel_tool_calls | **boolean**
  
  Required field. Whether to allow the model to run tool calls in parallel.   ||
  || conversation | Any of **[Conversation-2](#Conversation-2)** \| **null** ||
  |#
  
  
  ## Reasoning {#Reasoning2}
  
  [CURRENTLY NOT SUPPORTED]
  
  #|
  ||Field | Description ||
  || effort [CURRENTLY NOT SUPPORTED] | Any of **enum** \| **null** ||
  || summary [CURRENTLY NOT SUPPORTED] | Any of **enum** \| **null** ||
  || generate_summary | Any of **enum** \| **null** ||
  |#
  
  ## ResponseTextParam {#ResponseTextParam2}
  
  Configuration options for a text response from the model. Can be plain
  text or structured JSON data.  
  
  #|
  ||Field | Description ||
  || format | Any of **[ResponseFormatText](#ResponseFormatText2)** \| **[TextResponseFormatJsonSchema](#TextResponseFormatJsonSchema2)** \| **[ResponseFormatJsonObject](#ResponseFormatJsonObject2)** ||
  || verbosity | Any of **enum** \| **null** ||
  |#
  
  ## ResponseFormatText {#ResponseFormatText2}
  
  Default response format. Used to generate text responses.  
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of response format being defined. Always `text`.
  
  - `text` ||
  |#
  
  ## TextResponseFormatJsonSchema {#TextResponseFormatJsonSchema2}
  
  JSON Schema response format. Used to generate structured JSON responses.'
  
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of response format being defined. Always `json_schema`.
  
  - `json_schema` ||
  || description | **string**
  
  A description of what the response format is for, used by the model to
  determine how to respond in the format.   ||
  || name | **string**
  
  Required field. The name of the response format. Must be a-z, A-Z, 0-9, or contain
  underscores and dashes, with a maximum length of 64.   ||
  || schema | **object**
  
  Required field. The schema for the response format, described as a JSON Schema object.
  Learn how to build JSON schemas [here](https://json-schema.org/).   ||
  || strict | Any of **boolean** \| **null** ||
  |#
  
  ## ResponseFormatJsonObject {#ResponseFormatJsonObject2}
  
  JSON object response format. An older method of generating JSON responses.
  Using `json_schema` is recommended for models that support it. Note that the
  model will not generate JSON without a system or user message instructing it
  to do so.  
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of response format being defined. Always `json_object`.
  
  - `json_object` ||
  |#
  
  ## ToolChoiceAllowed {#ToolChoiceAllowed2}
  
  Constrains the tools available to the model to a pre-defined set.  
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. Allowed tool configuration type. Always `allowed_tools`.
  
  - `allowed_tools` ||
  || mode | **enum**
  
  Required field. Constrains the tools available to the model to a pre-defined set.
  
  `auto` allows the model to pick from among the allowed tools and generate a
  message.
  
  `required` requires the model to call one or more of the allowed tools.  
  
  - `auto`
  - `required` ||
  || tools[] | **object**
  
  Required field. A tool definition that the model should be allowed to call.   ||
  |#
  
  ## ToolChoiceTypes {#ToolChoiceTypes2}
  
  Indicates that the model should use a built-in tool to generate a response.'
  
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of hosted tool the model should to use. Allowed values are:
  
  
  - `file_search`
  - `web_search_preview`
  - `computer_use_preview`
  - `web_search_preview_2025_03_11`
  - `image_generation`
  - `code_interpreter` ||
  |#
  
  ## ToolChoiceFunction {#ToolChoiceFunction2}
  
  Use this option to force the model to call a specific function.  
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. For function calling, the type is always `function`.
  
  - `function` ||
  || name | **string**
  
  Required field. The name of the function to call. ||
  |#
  
  ## ToolChoiceMCP {#ToolChoiceMCP2}
  
  Use this option to force the model to call a specific tool on a remote MCP server.  
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. For MCP tools, the type is always `mcp`.
  
  - `mcp` ||
  || server_label | **string**
  
  Required field. The label of the MCP server to use.   ||
  || name | Any of **string** \| **null** ||
  |#
  
  ## ToolChoiceCustom {#ToolChoiceCustom2}
  
  Use this option to force the model to call a specific custom tool.  
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. For custom tool calling, the type is always `custom`.
  
  - `custom` ||
  || name | **string**
  
  Required field. The name of the custom tool to call. ||
  |#
  
  ## SpecificApplyPatchParam {#SpecificApplyPatchParam2}
  
  Forces the model to call the apply_patch tool when executing a tool call.
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The tool to call. Always `apply_patch`.
  
  - `apply_patch` ||
  |#
  
  ## SpecificFunctionShellParam {#SpecificFunctionShellParam2}
  
  Forces the model to call the shell tool when a tool call is required.
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The tool to call. Always `shell`.
  
  - `shell` ||
  |#
  
  ## Prompt0 {#Prompt02}
  
  Reference to a prompt template and its variables.
  
  #|
  ||Field | Description ||
  || id | **string**
  
  Required field. The unique identifier of the prompt template to use. ||
  || version | Any of **string** \| **null** ||
  || variables | Any of **object** (map<**string**, **unknown**>) \| **null** ||
  |#
  
  ## ResponseError0 {#ResponseError0}
  
  An error object returned when the model fails to generate a Response.  
  
  #|
  ||Field | Description ||
  || code | **enum**
  
  Required field. The error code for the response.  
  
  - `server_error`
  - `rate_limit_exceeded`
  - `invalid_prompt`
  - `vector_store_timeout`
  - `invalid_image`
  - `invalid_image_format`
  - `invalid_base64_image`
  - `invalid_image_url`
  - `image_too_large`
  - `image_too_small`
  - `image_parse_error`
  - `image_content_policy_violation`
  - `invalid_image_mode`
  - `image_file_too_large`
  - `unsupported_image_media_type`
  - `empty_image_file`
  - `failed_to_download_image`
  - `image_file_not_found` ||
  || message | **string**
  
  Required field. A human-readable description of the error.   ||
  |#
  
  ## IncompleteDetails0 {#IncompleteDetails0}
  
  Details about why the response is incomplete.  
  
  #|
  ||Field | Description ||
  || reason | **enum**
  
  The reason why the response is incomplete.
  
  - `max_output_tokens`
  - `content_filter` ||
  |#
  
  ## ResponseUsage {#ResponseUsage}
  
  Represents token usage details including input tokens, output tokens,
  a breakdown of output tokens, and the total tokens used.  
  
  #|
  ||Field | Description ||
  || input_tokens | **integer**
  
  Required field. The number of input tokens. ||
  || input_tokens_details | **[InputTokensDetails](#InputTokensDetails)**
  
  Required field. A detailed breakdown of the input tokens. ||
  || output_tokens | **integer**
  
  Required field. The number of output tokens. ||
  || output_tokens_details | **[OutputTokensDetails](#OutputTokensDetails)**
  
  Required field. A detailed breakdown of the output tokens. ||
  || total_tokens | **integer**
  
  Required field. The total number of tokens used. ||
  |#
  
  ## InputTokensDetails {#InputTokensDetails}
  
  A detailed breakdown of the input tokens.
  
  #|
  ||Field | Description ||
  || cached_tokens | **integer**
  
  Required field. The number of tokens that were retrieved from the cache. ||
  |#
  
  ## OutputTokensDetails {#OutputTokensDetails}
  
  A detailed breakdown of the output tokens.
  
  #|
  ||Field | Description ||
  || reasoning_tokens | **integer**
  
  Required field. The number of reasoning tokens. ||
  |#
  
  ## Conversation-2 {#Conversation-2}
  
  The conversation that this response belongs to. Input items and output items from this response are automatically added to this conversation.
  
  #|
  ||Field | Description ||
  || id | **string**
  
  Required field. The unique ID of the conversation. ||
  |#

- text/event-stream

  Any of:
  
  Emitted when there is a partial audio response.
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the event. Always `response.audio.delta`.  
  
  - `response.audio.delta` ||
  || sequence_number | **integer**
  
  Required field. A sequence number for this chunk of the stream response.   ||
  || delta | **string**
  
  Required field. A chunk of Base64 encoded response audio bytes.   ||
  |#
  

  Emitted when the audio response is complete.
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the event. Always `response.audio.done`.  
  
  - `response.audio.done` ||
  || sequence_number | **integer**
  
  Required field. The sequence number of the delta.   ||
  |#
  

  Emitted when there is a partial transcript of audio.
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the event. Always `response.audio.transcript.delta`.  
  
  - `response.audio.transcript.delta` ||
  || delta | **string**
  
  Required field. The partial transcript of the audio response.   ||
  || sequence_number | **integer**
  
  Required field. The sequence number of this event. ||
  |#
  

  Emitted when the full audio transcript is completed.
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the event. Always `response.audio.transcript.done`.  
  
  - `response.audio.transcript.done` ||
  || sequence_number | **integer**
  
  Required field. The sequence number of this event. ||
  |#
  

  Emitted when a partial code snippet is streamed by the code interpreter.
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the event. Always `response.code_interpreter_call_code.delta`.
  
  - `response.code_interpreter_call_code.delta` ||
  || output_index | **integer**
  
  Required field. The index of the output item in the response for which the code is being streamed. ||
  || item_id | **string**
  
  Required field. The unique identifier of the code interpreter tool call item. ||
  || delta | **string**
  
  Required field. The partial code snippet being streamed by the code interpreter. ||
  || sequence_number | **integer**
  
  Required field. The sequence number of this event, used to order streaming events. ||
  |#
  

  Emitted when the code snippet is finalized by the code interpreter.
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the event. Always `response.code_interpreter_call_code.done`.
  
  - `response.code_interpreter_call_code.done` ||
  || output_index | **integer**
  
  Required field. The index of the output item in the response for which the code is finalized. ||
  || item_id | **string**
  
  Required field. The unique identifier of the code interpreter tool call item. ||
  || code | **string**
  
  Required field. The final code snippet output by the code interpreter. ||
  || sequence_number | **integer**
  
  Required field. The sequence number of this event, used to order streaming events. ||
  |#
  

  Emitted when the code interpreter call is completed.
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the event. Always `response.code_interpreter_call.completed`.
  
  - `response.code_interpreter_call.completed` ||
  || output_index | **integer**
  
  Required field. The index of the output item in the response for which the code interpreter call is completed. ||
  || item_id | **string**
  
  Required field. The unique identifier of the code interpreter tool call item. ||
  || sequence_number | **integer**
  
  Required field. The sequence number of this event, used to order streaming events. ||
  |#
  

  Emitted when a code interpreter call is in progress.
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the event. Always `response.code_interpreter_call.in_progress`.
  
  - `response.code_interpreter_call.in_progress` ||
  || output_index | **integer**
  
  Required field. The index of the output item in the response for which the code interpreter call is in progress. ||
  || item_id | **string**
  
  Required field. The unique identifier of the code interpreter tool call item. ||
  || sequence_number | **integer**
  
  Required field. The sequence number of this event, used to order streaming events. ||
  |#
  

  Emitted when the code interpreter is actively interpreting the code snippet.
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the event. Always `response.code_interpreter_call.interpreting`.
  
  - `response.code_interpreter_call.interpreting` ||
  || output_index | **integer**
  
  Required field. The index of the output item in the response for which the code interpreter is interpreting code. ||
  || item_id | **string**
  
  Required field. The unique identifier of the code interpreter tool call item. ||
  || sequence_number | **integer**
  
  Required field. The sequence number of this event, used to order streaming events. ||
  |#
  

  Emitted when the model response is complete.
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the event. Always `response.completed`.  
  
  - `response.completed` ||
  || response | All of **[ModelResponseProperties](#ModelResponseProperties)** & **[ResponseProperties](#ResponseProperties)** & **[Response2](#Response2)** ||
  || sequence_number | **integer**
  
  Required field. The sequence number for this event. ||
  |#
  

  Emitted when a new content part is added.
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the event. Always `response.content_part.added`.  
  
  - `response.content_part.added` ||
  || item_id | **string**
  
  Required field. The ID of the output item that the content part was added to.   ||
  || output_index | **integer**
  
  Required field. The index of the output item that the content part was added to.   ||
  || content_index | **integer**
  
  Required field. The index of the content part that was added.   ||
  || part | Any of **[OutputTextContent](#OutputTextContent)** \| **[RefusalContent](#RefusalContent)** \| **[ReasoningTextContent](#ReasoningTextContent)** ||
  || sequence_number | **integer**
  
  Required field. The sequence number of this event. ||
  |#
  

  Emitted when a content part is done.
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the event. Always `response.content_part.done`.  
  
  - `response.content_part.done` ||
  || item_id | **string**
  
  Required field. The ID of the output item that the content part was added to.   ||
  || output_index | **integer**
  
  Required field. The index of the output item that the content part was added to.   ||
  || content_index | **integer**
  
  Required field. The index of the content part that is done.   ||
  || sequence_number | **integer**
  
  Required field. The sequence number of this event. ||
  || part | Any of **[OutputTextContent](#OutputTextContent)** \| **[RefusalContent](#RefusalContent)** \| **[ReasoningTextContent](#ReasoningTextContent)** ||
  |#
  

  An event that is emitted when a response is created.  
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the event. Always `response.created`.  
  
  - `response.created` ||
  || response | All of **[ModelResponseProperties](#ModelResponseProperties)** & **[ResponseProperties](#ResponseProperties)** & **[Response2](#Response2)** ||
  || sequence_number | **integer**
  
  Required field. The sequence number for this event. ||
  |#
  

  Emitted when an error occurs.
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the event. Always `error`.  
  
  - `error` ||
  || code | Any of **string** \| **null** ||
  || message | **string**
  
  Required field. The error message.   ||
  || param | Any of **string** \| **null** ||
  || sequence_number | **integer**
  
  Required field. The sequence number of this event. ||
  |#
  

  Emitted when a file search call is completed (results found).
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the event. Always `response.file_search_call.completed`.  
  
  - `response.file_search_call.completed` ||
  || output_index | **integer**
  
  Required field. The index of the output item that the file search call is initiated.   ||
  || item_id | **string**
  
  Required field. The ID of the output item that the file search call is initiated.   ||
  || sequence_number | **integer**
  
  Required field. The sequence number of this event. ||
  |#
  

  Emitted when a file search call is initiated.
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the event. Always `response.file_search_call.in_progress`.  
  
  - `response.file_search_call.in_progress` ||
  || output_index | **integer**
  
  Required field. The index of the output item that the file search call is initiated.   ||
  || item_id | **string**
  
  Required field. The ID of the output item that the file search call is initiated.   ||
  || sequence_number | **integer**
  
  Required field. The sequence number of this event. ||
  |#
  

  Emitted when a file search is currently searching.
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the event. Always `response.file_search_call.searching`.  
  
  - `response.file_search_call.searching` ||
  || output_index | **integer**
  
  Required field. The index of the output item that the file search call is searching.   ||
  || item_id | **string**
  
  Required field. The ID of the output item that the file search call is initiated.   ||
  || sequence_number | **integer**
  
  Required field. The sequence number of this event. ||
  |#
  

  Emitted when there is a partial function-call arguments delta.
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the event. Always `response.function_call_arguments.delta`.  
  
  - `response.function_call_arguments.delta` ||
  || item_id | **string**
  
  Required field. The ID of the output item that the function-call arguments delta is added to.   ||
  || output_index | **integer**
  
  Required field. The index of the output item that the function-call arguments delta is added to.   ||
  || sequence_number | **integer**
  
  Required field. The sequence number of this event. ||
  || delta | **string**
  
  Required field. The function-call arguments delta that is added.   ||
  |#
  

  Emitted when function-call arguments are finalized.
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. 
  
  - `response.function_call_arguments.done` ||
  || item_id | **string**
  
  Required field. The ID of the item. ||
  || name | **string**
  
  Required field. The name of the function that was called. ||
  || output_index | **integer**
  
  Required field. The index of the output item. ||
  || sequence_number | **integer**
  
  Required field. The sequence number of this event. ||
  || arguments | **string**
  
  Required field. The function-call arguments. ||
  |#
  

  Emitted when the response is in progress.
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the event. Always `response.in_progress`.  
  
  - `response.in_progress` ||
  || response | All of **[ModelResponseProperties](#ModelResponseProperties)** & **[ResponseProperties](#ResponseProperties)** & **[Response2](#Response2)** ||
  || sequence_number | **integer**
  
  Required field. The sequence number of this event. ||
  |#
  

  An event that is emitted when a response fails.  
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the event. Always `response.failed`.  
  
  - `response.failed` ||
  || sequence_number | **integer**
  
  Required field. The sequence number of this event. ||
  || response | All of **[ModelResponseProperties](#ModelResponseProperties)** & **[ResponseProperties](#ResponseProperties)** & **[Response2](#Response2)** ||
  |#
  

  An event that is emitted when a response finishes as incomplete.  
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the event. Always `response.incomplete`.  
  
  - `response.incomplete` ||
  || response | All of **[ModelResponseProperties](#ModelResponseProperties)** & **[ResponseProperties](#ResponseProperties)** & **[Response2](#Response2)** ||
  || sequence_number | **integer**
  
  Required field. The sequence number of this event. ||
  |#
  

  Emitted when a new output item is added.
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the event. Always `response.output_item.added`.  
  
  - `response.output_item.added` ||
  || output_index | **integer**
  
  Required field. The index of the output item that was added.   ||
  || sequence_number | **integer**
  
  Required field. The sequence number of this event.   ||
  || item | Any of **[OutputMessage](#OutputMessage)** \| **[FileSearchToolCall](#FileSearchToolCall)** \| **[FunctionToolCall](#FunctionToolCall)** \| **[WebSearchToolCall](#WebSearchToolCall)** \| **[ComputerToolCall](#ComputerToolCall)** \| **[ReasoningItem](#ReasoningItem)** \| **[CompactionBody](#CompactionBody)** \| **[ImageGenToolCall](#ImageGenToolCall)** \| **[CodeInterpreterToolCall](#CodeInterpreterToolCall)** \| **[LocalShellToolCall](#LocalShellToolCall)** \| **[FunctionShellCall](#FunctionShellCall)** \| **[FunctionShellCallOutput](#FunctionShellCallOutput)** \| **[ApplyPatchToolCall](#ApplyPatchToolCall)** \| **[ApplyPatchToolCallOutput](#ApplyPatchToolCallOutput)** \| **[MCPToolCall](#MCPToolCall)** \| **[MCPListTools](#MCPListTools)** \| **[MCPApprovalRequest](#MCPApprovalRequest)** \| **[CustomToolCall](#CustomToolCall)** ||
  |#
  

  Emitted when an output item is marked done.
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the event. Always `response.output_item.done`.  
  
  - `response.output_item.done` ||
  || output_index | **integer**
  
  Required field. The index of the output item that was marked done.   ||
  || sequence_number | **integer**
  
  Required field. The sequence number of this event.   ||
  || item | Any of **[OutputMessage](#OutputMessage)** \| **[FileSearchToolCall](#FileSearchToolCall)** \| **[FunctionToolCall](#FunctionToolCall)** \| **[WebSearchToolCall](#WebSearchToolCall)** \| **[ComputerToolCall](#ComputerToolCall)** \| **[ReasoningItem](#ReasoningItem)** \| **[CompactionBody](#CompactionBody)** \| **[ImageGenToolCall](#ImageGenToolCall)** \| **[CodeInterpreterToolCall](#CodeInterpreterToolCall)** \| **[LocalShellToolCall](#LocalShellToolCall)** \| **[FunctionShellCall](#FunctionShellCall)** \| **[FunctionShellCallOutput](#FunctionShellCallOutput)** \| **[ApplyPatchToolCall](#ApplyPatchToolCall)** \| **[ApplyPatchToolCallOutput](#ApplyPatchToolCallOutput)** \| **[MCPToolCall](#MCPToolCall)** \| **[MCPListTools](#MCPListTools)** \| **[MCPApprovalRequest](#MCPApprovalRequest)** \| **[CustomToolCall](#CustomToolCall)** ||
  |#
  

  Emitted when a new reasoning summary part is added.
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the event. Always `response.reasoning_summary_part.added`.  
  
  - `response.reasoning_summary_part.added` ||
  || item_id | **string**
  
  Required field. The ID of the item this summary part is associated with.   ||
  || output_index | **integer**
  
  Required field. The index of the output item this summary part is associated with.   ||
  || summary_index | **integer**
  
  Required field. The index of the summary part within the reasoning summary.   ||
  || sequence_number | **integer**
  
  Required field. The sequence number of this event.   ||
  || part | **[Part](#Part)**
  
  Required field. The summary part that was added.   ||
  |#
  

  Emitted when a reasoning summary part is completed.
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the event. Always `response.reasoning_summary_part.done`.  
  
  - `response.reasoning_summary_part.done` ||
  || item_id | **string**
  
  Required field. The ID of the item this summary part is associated with.   ||
  || output_index | **integer**
  
  Required field. The index of the output item this summary part is associated with.   ||
  || summary_index | **integer**
  
  Required field. The index of the summary part within the reasoning summary.   ||
  || sequence_number | **integer**
  
  Required field. The sequence number of this event.   ||
  || part | **[Part](#Part-1)**
  
  Required field. The completed summary part.   ||
  |#
  

  Emitted when a delta is added to a reasoning summary text.
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the event. Always `response.reasoning_summary_text.delta`.  
  
  - `response.reasoning_summary_text.delta` ||
  || item_id | **string**
  
  Required field. The ID of the item this summary text delta is associated with.   ||
  || output_index | **integer**
  
  Required field. The index of the output item this summary text delta is associated with.   ||
  || summary_index | **integer**
  
  Required field. The index of the summary part within the reasoning summary.   ||
  || delta | **string**
  
  Required field. The text delta that was added to the summary.   ||
  || sequence_number | **integer**
  
  Required field. The sequence number of this event.   ||
  |#
  

  Emitted when a reasoning summary text is completed.
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the event. Always `response.reasoning_summary_text.done`.  
  
  - `response.reasoning_summary_text.done` ||
  || item_id | **string**
  
  Required field. The ID of the item this summary text is associated with.   ||
  || output_index | **integer**
  
  Required field. The index of the output item this summary text is associated with.   ||
  || summary_index | **integer**
  
  Required field. The index of the summary part within the reasoning summary.   ||
  || text | **string**
  
  Required field. The full text of the completed reasoning summary.   ||
  || sequence_number | **integer**
  
  Required field. The sequence number of this event.   ||
  |#
  

  Emitted when a delta is added to a reasoning text.
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the event. Always `response.reasoning_text.delta`.  
  
  - `response.reasoning_text.delta` ||
  || item_id | **string**
  
  Required field. The ID of the item this reasoning text delta is associated with.   ||
  || output_index | **integer**
  
  Required field. The index of the output item this reasoning text delta is associated with.   ||
  || content_index | **integer**
  
  Required field. The index of the reasoning content part this delta is associated with.   ||
  || delta | **string**
  
  Required field. The text delta that was added to the reasoning content.   ||
  || sequence_number | **integer**
  
  Required field. The sequence number of this event.   ||
  |#
  

  Emitted when a reasoning text is completed.
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the event. Always `response.reasoning_text.done`.  
  
  - `response.reasoning_text.done` ||
  || item_id | **string**
  
  Required field. The ID of the item this reasoning text is associated with.   ||
  || output_index | **integer**
  
  Required field. The index of the output item this reasoning text is associated with.   ||
  || content_index | **integer**
  
  Required field. The index of the reasoning content part.   ||
  || text | **string**
  
  Required field. The full text of the completed reasoning content.   ||
  || sequence_number | **integer**
  
  Required field. The sequence number of this event.   ||
  |#
  

  Emitted when there is a partial refusal text.
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the event. Always `response.refusal.delta`.  
  
  - `response.refusal.delta` ||
  || item_id | **string**
  
  Required field. The ID of the output item that the refusal text is added to.   ||
  || output_index | **integer**
  
  Required field. The index of the output item that the refusal text is added to.   ||
  || content_index | **integer**
  
  Required field. The index of the content part that the refusal text is added to.   ||
  || delta | **string**
  
  Required field. The refusal text that is added.   ||
  || sequence_number | **integer**
  
  Required field. The sequence number of this event.   ||
  |#
  

  Emitted when refusal text is finalized.
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the event. Always `response.refusal.done`.  
  
  - `response.refusal.done` ||
  || item_id | **string**
  
  Required field. The ID of the output item that the refusal text is finalized.   ||
  || output_index | **integer**
  
  Required field. The index of the output item that the refusal text is finalized.   ||
  || content_index | **integer**
  
  Required field. The index of the content part that the refusal text is finalized.   ||
  || refusal | **string**
  
  Required field. The refusal text that is finalized.   ||
  || sequence_number | **integer**
  
  Required field. The sequence number of this event.   ||
  |#
  

  Emitted when there is an additional text delta.
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the event. Always `response.output_text.delta`.  
  
  - `response.output_text.delta` ||
  || item_id | **string**
  
  Required field. The ID of the output item that the text delta was added to.   ||
  || output_index | **integer**
  
  Required field. The index of the output item that the text delta was added to.   ||
  || content_index | **integer**
  
  Required field. The index of the content part that the text delta was added to.   ||
  || delta | **string**
  
  Required field. The text delta that was added.   ||
  || sequence_number | **integer**
  
  Required field. The sequence number for this event. ||
  || logprobs[] | **[ResponseLogProb](#ResponseLogProb)**
  
  Required field. A logprob is the logarithmic probability that the model assigns to producing 
  a particular token at a given position in the sequence. Less-negative (higher) 
  logprob values indicate greater model confidence in that token choice.
   ||
  |#
  

  Emitted when text content is finalized.
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the event. Always `response.output_text.done`.  
  
  - `response.output_text.done` ||
  || item_id | **string**
  
  Required field. The ID of the output item that the text content is finalized.   ||
  || output_index | **integer**
  
  Required field. The index of the output item that the text content is finalized.   ||
  || content_index | **integer**
  
  Required field. The index of the content part that the text content is finalized.   ||
  || text | **string**
  
  Required field. The text content that is finalized.   ||
  || sequence_number | **integer**
  
  Required field. The sequence number for this event. ||
  || logprobs[] | **[ResponseLogProb](#ResponseLogProb)**
  
  Required field. A logprob is the logarithmic probability that the model assigns to producing 
  a particular token at a given position in the sequence. Less-negative (higher) 
  logprob values indicate greater model confidence in that token choice.
   ||
  |#
  

  Emitted when a web search call is completed.
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the event. Always `response.web_search_call.completed`.  
  
  - `response.web_search_call.completed` ||
  || output_index | **integer**
  
  Required field. The index of the output item that the web search call is associated with.   ||
  || item_id | **string**
  
  Required field. Unique ID for the output item associated with the web search call.   ||
  || sequence_number | **integer**
  
  Required field. The sequence number of the web search call being processed. ||
  |#
  

  Emitted when a web search call is initiated.
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the event. Always `response.web_search_call.in_progress`.  
  
  - `response.web_search_call.in_progress` ||
  || output_index | **integer**
  
  Required field. The index of the output item that the web search call is associated with.   ||
  || item_id | **string**
  
  Required field. Unique ID for the output item associated with the web search call.   ||
  || sequence_number | **integer**
  
  Required field. The sequence number of the web search call being processed. ||
  |#
  

  Emitted when a web search call is executing.
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the event. Always `response.web_search_call.searching`.  
  
  - `response.web_search_call.searching` ||
  || output_index | **integer**
  
  Required field. The index of the output item that the web search call is associated with.   ||
  || item_id | **string**
  
  Required field. Unique ID for the output item associated with the web search call.   ||
  || sequence_number | **integer**
  
  Required field. The sequence number of the web search call being processed. ||
  |#
  

  Emitted when an image generation tool call has completed and the final image is available.  
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the event. Always 'response.image_generation_call.completed'.
  
  - `response.image_generation_call.completed` ||
  || output_index | **integer**
  
  Required field. The index of the output item in the response's output array. ||
  || sequence_number | **integer**
  
  Required field. The sequence number of this event. ||
  || item_id | **string**
  
  Required field. The unique identifier of the image generation item being processed. ||
  |#
  

  Emitted when an image generation tool call is actively generating an image (intermediate state).  
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the event. Always 'response.image_generation_call.generating'.
  
  - `response.image_generation_call.generating` ||
  || output_index | **integer**
  
  Required field. The index of the output item in the response's output array. ||
  || item_id | **string**
  
  Required field. The unique identifier of the image generation item being processed. ||
  || sequence_number | **integer**
  
  Required field. The sequence number of the image generation item being processed. ||
  |#
  

  Emitted when an image generation tool call is in progress.  
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the event. Always 'response.image_generation_call.in_progress'.
  
  - `response.image_generation_call.in_progress` ||
  || output_index | **integer**
  
  Required field. The index of the output item in the response's output array. ||
  || item_id | **string**
  
  Required field. The unique identifier of the image generation item being processed. ||
  || sequence_number | **integer**
  
  Required field. The sequence number of the image generation item being processed. ||
  |#
  

  Emitted when a partial image is available during image generation streaming.  
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the event. Always 'response.image_generation_call.partial_image'.
  
  - `response.image_generation_call.partial_image` ||
  || output_index | **integer**
  
  Required field. The index of the output item in the response's output array. ||
  || item_id | **string**
  
  Required field. The unique identifier of the image generation item being processed. ||
  || sequence_number | **integer**
  
  Required field. The sequence number of the image generation item being processed. ||
  || partial_image_index | **integer**
  
  Required field. 0-based index for the partial image (backend is 1-based, but this is 0-based for the user). ||
  || partial_image_b64 | **string**
  
  Required field. Base64-encoded partial image data, suitable for rendering as an image. ||
  |#
  

  Emitted when there is a delta (partial update) to the arguments of an MCP tool call.  
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the event. Always 'response.mcp_call_arguments.delta'.
  
  - `response.mcp_call_arguments.delta` ||
  || output_index | **integer**
  
  Required field. The index of the output item in the response's output array. ||
  || item_id | **string**
  
  Required field. The unique identifier of the MCP tool call item being processed. ||
  || delta | **string**
  
  Required field. A JSON string containing the partial update to the arguments for the MCP tool call.   ||
  || sequence_number | **integer**
  
  Required field. The sequence number of this event. ||
  |#
  

  Emitted when the arguments for an MCP tool call are finalized.  
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the event. Always 'response.mcp_call_arguments.done'.
  
  - `response.mcp_call_arguments.done` ||
  || output_index | **integer**
  
  Required field. The index of the output item in the response's output array. ||
  || item_id | **string**
  
  Required field. The unique identifier of the MCP tool call item being processed. ||
  || arguments | **string**
  
  Required field. A JSON string containing the finalized arguments for the MCP tool call.   ||
  || sequence_number | **integer**
  
  Required field. The sequence number of this event. ||
  |#
  

  Emitted when an MCP  tool call has completed successfully.  
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the event. Always 'response.mcp_call.completed'.
  
  - `response.mcp_call.completed` ||
  || item_id | **string**
  
  Required field. The ID of the MCP tool call item that completed. ||
  || output_index | **integer**
  
  Required field. The index of the output item that completed. ||
  || sequence_number | **integer**
  
  Required field. The sequence number of this event. ||
  |#
  

  Emitted when an MCP  tool call has failed.  
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the event. Always 'response.mcp_call.failed'.
  
  - `response.mcp_call.failed` ||
  || item_id | **string**
  
  Required field. The ID of the MCP tool call item that failed. ||
  || output_index | **integer**
  
  Required field. The index of the output item that failed. ||
  || sequence_number | **integer**
  
  Required field. The sequence number of this event. ||
  |#
  

  Emitted when an MCP  tool call is in progress.  
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the event. Always 'response.mcp_call.in_progress'.
  
  - `response.mcp_call.in_progress` ||
  || sequence_number | **integer**
  
  Required field. The sequence number of this event. ||
  || output_index | **integer**
  
  Required field. The index of the output item in the response's output array. ||
  || item_id | **string**
  
  Required field. The unique identifier of the MCP tool call item being processed. ||
  |#
  

  Emitted when the list of available MCP tools has been successfully retrieved.  
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the event. Always 'response.mcp_list_tools.completed'.
  
  - `response.mcp_list_tools.completed` ||
  || item_id | **string**
  
  Required field. The ID of the MCP tool call item that produced this output. ||
  || output_index | **integer**
  
  Required field. The index of the output item that was processed. ||
  || sequence_number | **integer**
  
  Required field. The sequence number of this event. ||
  |#
  

  Emitted when the attempt to list available MCP tools has failed.  
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the event. Always 'response.mcp_list_tools.failed'.
  
  - `response.mcp_list_tools.failed` ||
  || item_id | **string**
  
  Required field. The ID of the MCP tool call item that failed. ||
  || output_index | **integer**
  
  Required field. The index of the output item that failed. ||
  || sequence_number | **integer**
  
  Required field. The sequence number of this event. ||
  |#
  

  Emitted when the system is in the process of retrieving the list of available MCP tools.  
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the event. Always 'response.mcp_list_tools.in_progress'.
  
  - `response.mcp_list_tools.in_progress` ||
  || item_id | **string**
  
  Required field. The ID of the MCP tool call item that is being processed. ||
  || output_index | **integer**
  
  Required field. The index of the output item that is being processed. ||
  || sequence_number | **integer**
  
  Required field. The sequence number of this event. ||
  |#
  

  Emitted when an annotation is added to output text content.  
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the event. Always 'response.output_text.annotation.added'.
  
  - `response.output_text.annotation.added` ||
  || item_id | **string**
  
  Required field. The unique identifier of the item to which the annotation is being added. ||
  || output_index | **integer**
  
  Required field. The index of the output item in the response's output array. ||
  || content_index | **integer**
  
  Required field. The index of the content part within the output item. ||
  || annotation_index | **integer**
  
  Required field. The index of the annotation within the content part. ||
  || sequence_number | **integer**
  
  Required field. The sequence number of this event. ||
  || annotation | **[Annotation](#null)**
  
  Required field. The annotation object being added. (See annotation schema for details.) ||
  |#
  

  Emitted when a response is queued and waiting to be processed.  
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the event. Always 'response.queued'.
  
  - `response.queued` ||
  || response | All of **[ModelResponseProperties](#ModelResponseProperties)** & **[ResponseProperties](#ResponseProperties)** & **[Response2](#Response2)** ||
  || sequence_number | **integer**
  
  Required field. The sequence number for this event. ||
  |#
  

  Event representing a delta (partial update) to the input of a custom tool call.  
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The event type identifier.
  
  - `response.custom_tool_call_input.delta` ||
  || sequence_number | **integer**
  
  Required field. The sequence number of this event. ||
  || output_index | **integer**
  
  Required field. The index of the output this delta applies to. ||
  || item_id | **string**
  
  Required field. Unique identifier for the API item associated with this event. ||
  || delta | **string**
  
  Required field. The incremental input data (delta) for the custom tool call. ||
  |#
  

  Event indicating that input for a custom tool call is complete.  
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The event type identifier.
  
  - `response.custom_tool_call_input.done` ||
  || sequence_number | **integer**
  
  Required field. The sequence number of this event. ||
  || output_index | **integer**
  
  Required field. The index of the output this event applies to. ||
  || item_id | **string**
  
  Required field. Unique identifier for the API item associated with this event. ||
  || input | **string**
  
  Required field. The complete input data for the custom tool call. ||
  |#
  

  ## ModelResponseProperties {#ModelResponseProperties}
  
  #|
  ||Field | Description ||
  || metadata | **unknown**
  
  [CURRENTLY NOT SUPPORTED] ||
  || top_logprobs | **unknown**
  
  NOT SUPPORTED BY ALL MODELS. An integer between 0 and 20 specifying the number of most likely tokens to return at each token position, each with an associated log probability. ||
  || temperature | **unknown**
  
  What sampling temperature to use, between 0 and 1. Higher values like 0.8 will make the output more random, while lower values like 0.3 will make it more focused and deterministic. We generally recommend altering this or top_p but not both. ||
  || top_p | **unknown**
  
  NOT SUPPORTED BY ALL MODELS. An alternative to sampling with temperature, called nucleus sampling, where the model considers the results of the tokens with top_p probability mass. So 0.1 means only the tokens comprising the top 10% probability mass are considered. ||
  || user | **string**
  
  This field is being replaced by `safety_identifier` and `prompt_cache_key`. Use `prompt_cache_key` instead to maintain caching optimizations.
  A stable identifier for your end-users.
  Used to boost cache hit rates by better bucketing similar requests and  to help Yandex Cloud AI Studio detect and prevent abuse. 
   ||
  || safety_identifier | **unknown**
  
  [CURRENTLY NOT SUPPORTED] ||
  || prompt_cache_key | **unknown**
  
  [CURRENTLY NOT SUPPORTED] ||
  || service_tier | **unknown**
  
  [CURRENTLY NOT SUPPORTED] ||
  || prompt_cache_retention | **unknown**
  
  [CURRENTLY NOT SUPPORTED] ||
  |#
  
  ## ResponseProperties {#ResponseProperties}
  
  #|
  ||Field | Description ||
  || previous_response_id | Any of **string** \| **null** ||
  || model | Any of **unknown** \| **enum** ||
  || reasoning | Any of **[Reasoning](#Reasoning3)** \| **null** ||
  || background | Any of **boolean** \| **null** ||
  || max_output_tokens | Any of **integer** \| **null** ||
  || max_tool_calls | Any of **integer** \| **null** ||
  || text | **[ResponseTextParam](#ResponseTextParam3)**
  
  Configuration options for a text response from the model. Can be plain
  text or structured JSON data.   ||
  || tools[] | **unknown**
  
  A tool that can be used to generate a response.   ||
  || tool_choice | Any of **enum** \| **[ToolChoiceAllowed](#ToolChoiceAllowed3)** \| **[ToolChoiceTypes](#ToolChoiceTypes3)** \| **[ToolChoiceFunction](#ToolChoiceFunction3)** \| **[ToolChoiceMCP](#ToolChoiceMCP3)** \| **[ToolChoiceCustom](#ToolChoiceCustom3)** \| **[SpecificApplyPatchParam](#SpecificApplyPatchParam3)** \| **[SpecificFunctionShellParam](#SpecificFunctionShellParam3)** ||
  || prompt | Any of **[Prompt0](#Prompt03)** \| **null** ||
  || truncation | **unknown**
  
  [CURRENTLY NOT SUPPORTED] ||
  |#
  
  ## Reasoning {#Reasoning3}
  
  [CURRENTLY NOT SUPPORTED]
  
  #|
  ||Field | Description ||
  || effort [CURRENTLY NOT SUPPORTED] | Any of **enum** \| **null** ||
  || summary [CURRENTLY NOT SUPPORTED] | Any of **enum** \| **null** ||
  || generate_summary | Any of **enum** \| **null** ||
  |#
  
  ## ResponseTextParam {#ResponseTextParam3}
  
  Configuration options for a text response from the model. Can be plain
  text or structured JSON data.  
  
  #|
  ||Field | Description ||
  || format | Any of **[ResponseFormatText](#ResponseFormatText3)** \| **[TextResponseFormatJsonSchema](#TextResponseFormatJsonSchema3)** \| **[ResponseFormatJsonObject](#ResponseFormatJsonObject3)** ||
  || verbosity | Any of **enum** \| **null** ||
  |#
  
  ## ResponseFormatText {#ResponseFormatText3}
  
  Default response format. Used to generate text responses.  
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of response format being defined. Always `text`.
  
  - `text` ||
  |#
  
  ## TextResponseFormatJsonSchema {#TextResponseFormatJsonSchema3}
  
  JSON Schema response format. Used to generate structured JSON responses.'
  
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of response format being defined. Always `json_schema`.
  
  - `json_schema` ||
  || description | **string**
  
  A description of what the response format is for, used by the model to
  determine how to respond in the format.   ||
  || name | **string**
  
  Required field. The name of the response format. Must be a-z, A-Z, 0-9, or contain
  underscores and dashes, with a maximum length of 64.   ||
  || schema | **object**
  
  Required field. The schema for the response format, described as a JSON Schema object.
  Learn how to build JSON schemas [here](https://json-schema.org/).   ||
  || strict | Any of **boolean** \| **null** ||
  |#
  
  ## ResponseFormatJsonObject {#ResponseFormatJsonObject3}
  
  JSON object response format. An older method of generating JSON responses.
  Using `json_schema` is recommended for models that support it. Note that the
  model will not generate JSON without a system or user message instructing it
  to do so.  
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of response format being defined. Always `json_object`.
  
  - `json_object` ||
  |#
  
  ## ToolChoiceAllowed {#ToolChoiceAllowed3}
  
  Constrains the tools available to the model to a pre-defined set.  
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. Allowed tool configuration type. Always `allowed_tools`.
  
  - `allowed_tools` ||
  || mode | **enum**
  
  Required field. Constrains the tools available to the model to a pre-defined set.
  
  `auto` allows the model to pick from among the allowed tools and generate a
  message.
  
  `required` requires the model to call one or more of the allowed tools.  
  
  - `auto`
  - `required` ||
  || tools[] | **object**
  
  Required field. A tool definition that the model should be allowed to call.   ||
  |#
  
  ## ToolChoiceTypes {#ToolChoiceTypes3}
  
  Indicates that the model should use a built-in tool to generate a response.'
  
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of hosted tool the model should to use. Allowed values are:
  
  
  - `file_search`
  - `web_search_preview`
  - `computer_use_preview`
  - `web_search_preview_2025_03_11`
  - `image_generation`
  - `code_interpreter` ||
  |#
  
  ## ToolChoiceFunction {#ToolChoiceFunction3}
  
  Use this option to force the model to call a specific function.  
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. For function calling, the type is always `function`.
  
  - `function` ||
  || name | **string**
  
  Required field. The name of the function to call. ||
  |#
  
  ## ToolChoiceMCP {#ToolChoiceMCP3}
  
  Use this option to force the model to call a specific tool on a remote MCP server.  
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. For MCP tools, the type is always `mcp`.
  
  - `mcp` ||
  || server_label | **string**
  
  Required field. The label of the MCP server to use.   ||
  || name | Any of **string** \| **null** ||
  |#
  
  ## ToolChoiceCustom {#ToolChoiceCustom3}
  
  Use this option to force the model to call a specific custom tool.  
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. For custom tool calling, the type is always `custom`.
  
  - `custom` ||
  || name | **string**
  
  Required field. The name of the custom tool to call. ||
  |#
  
  ## SpecificApplyPatchParam {#SpecificApplyPatchParam3}
  
  Forces the model to call the apply_patch tool when executing a tool call.
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The tool to call. Always `apply_patch`.
  
  - `apply_patch` ||
  |#
  
  ## SpecificFunctionShellParam {#SpecificFunctionShellParam3}
  
  Forces the model to call the shell tool when a tool call is required.
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The tool to call. Always `shell`.
  
  - `shell` ||
  |#
  
  ## Prompt0 {#Prompt03}
  
  Reference to a prompt template and its variables.
  
  #|
  ||Field | Description ||
  || id | **string**
  
  Required field. The unique identifier of the prompt template to use. ||
  || version | Any of **string** \| **null** ||
  || variables | Any of **object** (map<**string**, **unknown**>) \| **null** ||
  |#
  
  ## Response2 {#Response2}
  
  #|
  ||Field | Description ||
  || id | **string**
  
  Required field. Unique identifier for this Response.   ||
  || object | **enum**
  
  Required field. The object type of this resource - always set to `response`.  
  
  - `response` ||
  || status | **enum**
  
  The status of the response generation. One of `completed`, `failed`,
  `in_progress`, `cancelled`, `queued`, or `incomplete`.  
  
  - `completed`
  - `failed`
  - `in_progress`
  - `cancelled`
  - `queued`
  - `incomplete` ||
  || created_at | **number**
  
  Required field. Unix timestamp (in seconds) of when this Response was created.   ||
  || error | Any of **[ResponseError0](#ResponseError02)** \| **null** ||
  || incomplete_details | Any of **[IncompleteDetails0](#IncompleteDetails02)** \| **null** ||
  || output[] | **unknown**
  
  Required field.  ||
  || instructions | Any of **unknown** \| **null** ||
  || output_text | Any of **string** \| **null** ||
  || usage | **[ResponseUsage](#ResponseUsage2)**
  
  Required field. Represents token usage details including input tokens, output tokens,
  a breakdown of output tokens, and the total tokens used.   ||
  || parallel_tool_calls | **boolean**
  
  Required field. Whether to allow the model to run tool calls in parallel.   ||
  || conversation | Any of **[Conversation-2](#Conversation-22)** \| **null** ||
  |#
  
  ## ResponseError0 {#ResponseError02}
  
  An error object returned when the model fails to generate a Response.  
  
  #|
  ||Field | Description ||
  || code | **enum**
  
  Required field. The error code for the response.  
  
  - `server_error`
  - `rate_limit_exceeded`
  - `invalid_prompt`
  - `vector_store_timeout`
  - `invalid_image`
  - `invalid_image_format`
  - `invalid_base64_image`
  - `invalid_image_url`
  - `image_too_large`
  - `image_too_small`
  - `image_parse_error`
  - `image_content_policy_violation`
  - `invalid_image_mode`
  - `image_file_too_large`
  - `unsupported_image_media_type`
  - `empty_image_file`
  - `failed_to_download_image`
  - `image_file_not_found` ||
  || message | **string**
  
  Required field. A human-readable description of the error.   ||
  |#
  
  ## IncompleteDetails0 {#IncompleteDetails02}
  
  Details about why the response is incomplete.  
  
  #|
  ||Field | Description ||
  || reason | **enum**
  
  The reason why the response is incomplete.
  
  - `max_output_tokens`
  - `content_filter` ||
  |#
  
  ## ResponseUsage {#ResponseUsage2}
  
  Represents token usage details including input tokens, output tokens,
  a breakdown of output tokens, and the total tokens used.  
  
  #|
  ||Field | Description ||
  || input_tokens | **integer**
  
  Required field. The number of input tokens. ||
  || input_tokens_details | **[InputTokensDetails](#InputTokensDetails2)**
  
  Required field. A detailed breakdown of the input tokens. ||
  || output_tokens | **integer**
  
  Required field. The number of output tokens. ||
  || output_tokens_details | **[OutputTokensDetails](#OutputTokensDetails2)**
  
  Required field. A detailed breakdown of the output tokens. ||
  || total_tokens | **integer**
  
  Required field. The total number of tokens used. ||
  |#
  
  ## InputTokensDetails {#InputTokensDetails2}
  
  A detailed breakdown of the input tokens.
  
  #|
  ||Field | Description ||
  || cached_tokens | **integer**
  
  Required field. The number of tokens that were retrieved from the cache. ||
  |#
  
  ## OutputTokensDetails {#OutputTokensDetails2}
  
  A detailed breakdown of the output tokens.
  
  #|
  ||Field | Description ||
  || reasoning_tokens | **integer**
  
  Required field. The number of reasoning tokens. ||
  |#
  
  ## Conversation-2 {#Conversation-22}
  
  The conversation that this response belongs to. Input items and output items from this response are automatically added to this conversation.
  
  #|
  ||Field | Description ||
  || id | **string**
  
  Required field. The unique ID of the conversation. ||
  |#
  
  ## OutputTextContent {#OutputTextContent}
  
  A text output from the model.
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the output text. Always `output_text`.
  
  - `output_text` ||
  || text | **string**
  
  Required field. The text output from the model. ||
  || annotations[] | **unknown**
  
  Required field.  ||
  || logprobs[] | **[LogProb](#LogProb)**
  
  Required field. The log probability of a token. ||
  |#
  
  ## LogProb {#LogProb}
  
  The log probability of a token.
  
  #|
  ||Field | Description ||
  || token | **string**
  
  Required field.  ||
  || logprob | **number**
  
  Required field.  ||
  || bytes[] | **integer**
  
  Required field.  ||
  || top_logprobs[] | **[TopLogProb](#TopLogProb)**
  
  Required field. The top log probability of a token. ||
  |#
  
  ## TopLogProb {#TopLogProb}
  
  The top log probability of a token.
  
  #|
  ||Field | Description ||
  || token | **string**
  
  Required field.  ||
  || logprob | **number**
  
  Required field.  ||
  || bytes[] | **integer**
  
  Required field.  ||
  |#
  
  ## RefusalContent {#RefusalContent}
  
  A refusal from the model.
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the refusal. Always `refusal`.
  
  - `refusal` ||
  || refusal | **string**
  
  Required field. The refusal explanation from the model. ||
  |#
  
  ## ReasoningTextContent {#ReasoningTextContent}
  
  Reasoning text from the model.
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the reasoning text. Always `reasoning_text`.
  
  - `reasoning_text` ||
  || text | **string**
  
  Required field. The reasoning text from the model. ||
  |#
  
  ## OutputMessage {#OutputMessage}
  
  An output message from the model.  
  
  #|
  ||Field | Description ||
  || id | **string**
  
  Required field. The unique ID of the output message.   ||
  || type | **enum**
  
  Required field. The type of the output message. Always `message`.  
  
  - `message` ||
  || role | **enum**
  
  Required field. The role of the output message. Always `assistant`.  
  
  - `assistant` ||
  || content[] | **unknown**
  
  Required field.  ||
  || status | **enum**
  
  Required field. The status of the message input. One of `in_progress`, `completed`, or
  `incomplete`. Populated when input items are returned via API.  
  
  - `in_progress`
  - `completed`
  - `incomplete` ||
  |#
  
  ## FileSearchToolCall {#FileSearchToolCall}
  
  The results of a file search tool call.
  
  #|
  ||Field | Description ||
  || id | **string**
  
  Required field. The unique ID of the file search tool call.   ||
  || type | **enum**
  
  Required field. The type of the file search tool call. Always `file_search_call`.  
  
  - `file_search_call` ||
  || status | **enum**
  
  Required field. The status of the file search tool call. One of `in_progress`,
  `searching`, `incomplete` or `failed`,  
  
  - `in_progress`
  - `searching`
  - `completed`
  - `incomplete`
  - `failed` ||
  || queries[] | **string**
  
  Required field.  ||
  || results | Any of **[0Item](#0Item)** \| **null** ||
  |#
  
  ## 0Item {#0Item}
  
  #|
  ||Field | Description ||
  || file_id | **string**
  
  The unique ID of the file.   ||
  || text | **string**
  
  The text that was retrieved from the file.   ||
  || filename | **string**
  
  The name of the file.   ||
  || attributes | Any of **object** (map<**string**, **string**>) \| **null** ||
  || score | **number** (float)
  
  The relevance score of the file - a value between 0 and 1.   ||
  |#
  
  ## FunctionToolCall {#FunctionToolCall}
  
  A tool call to run a function.
  
  #|
  ||Field | Description ||
  || id | **string**
  
  The unique ID of the function tool call.   ||
  || type | **enum**
  
  Required field. The type of the function tool call. Always `function_call`.  
  
  - `function_call` ||
  || call_id | **string**
  
  Required field. The unique ID of the function tool call generated by the model.   ||
  || name | **string**
  
  Required field. The name of the function to run.   ||
  || arguments | **string**
  
  Required field. A JSON string of the arguments to pass to the function.   ||
  || status | **enum**
  
  The status of the item. One of `in_progress`, `completed`, or
  `incomplete`. Populated when items are returned via API.  
  
  - `in_progress`
  - `completed`
  - `incomplete` ||
  |#
  
  ## WebSearchToolCall {#WebSearchToolCall}
  
  The results of a web search tool call.
  
  #|
  ||Field | Description ||
  || id | **string**
  
  Required field. The unique ID of the web search tool call.   ||
  || type | **enum**
  
  Required field. The type of the web search tool call. Always `web_search_call`.  
  
  - `web_search_call` ||
  || status | **enum**
  
  Required field. The status of the web search tool call.  
  
  - `in_progress`
  - `searching`
  - `completed`
  - `failed` ||
  || action | Any of **[WebSearchActionSearch](#WebSearchActionSearch)** \| **[WebSearchActionOpenPage](#WebSearchActionOpenPage)** \| **[WebSearchActionFind](#WebSearchActionFind)** ||
  |#
  
  ## WebSearchActionSearch {#WebSearchActionSearch}
  
  Action type "search" - Performs a web search query.  
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The action type.  
  
  - `search` ||
  || query | **string**
  
  Required field. The search query.   ||
  || sources[] | **[SourcesItem](#SourcesItem)**
  
  Required field. A source used in the search.   ||
  |#
  
  ## SourcesItem {#SourcesItem}
  
  A source used in the search.  
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of source. Always `url`.  
  
  - `url` ||
  || url | **string**
  
  Required field. The URL of the source.   ||
  |#
  
  ## WebSearchActionOpenPage {#WebSearchActionOpenPage}
  
  Action type "open_page" - Opens a specific URL from search results.  
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The action type.  
  
  - `open_page` ||
  || url | **string** (uri)
  
  Required field. The URL opened by the model.   ||
  |#
  
  ## WebSearchActionFind {#WebSearchActionFind}
  
  Action type "find": Searches for a pattern within a loaded page.  
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The action type.  
  
  - `find` ||
  || url | **string** (uri)
  
  Required field. The URL of the page searched for the pattern.   ||
  || pattern | **string**
  
  Required field. The pattern or text to search for within the page.   ||
  |#
  
  ## ComputerToolCall {#ComputerToolCall}
  
  CURRENTLY NOT SUPPORTED
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the computer call. Always `computer_call`.
  
  - `computer_call` ||
  || id | **string**
  
  Required field. The unique ID of the computer call. ||
  || call_id | **string**
  
  Required field. An identifier used when responding to the tool call with output.   ||
  || action | Any of **[ClickParam](#ClickParam)** \| **[DoubleClickAction](#DoubleClickAction)** \| **[Drag](#Drag)** \| **[KeyPressAction](#KeyPressAction)** \| **[Move](#Move)** \| **[Screenshot](#Screenshot)** \| **[Scroll](#Scroll)** \| **[Type](#Type)** \| **[Wait](#Wait)** ||
  || pending_safety_checks[] | **[ComputerCallSafetyCheckParam](#ComputerCallSafetyCheckParam)**
  
  Required field. A pending safety check for the computer call. ||
  || status | **enum**
  
  Required field. The status of the item. One of `in_progress`, `completed`, or
  `incomplete`. Populated when items are returned via API.  
  
  - `in_progress`
  - `completed`
  - `incomplete` ||
  |#
  
  ## ClickParam {#ClickParam}
  
  A click action.
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. Specifies the event type. For a click action, this property is always `click`.
  
  - `click` ||
  || button | **enum**
  
  Required field. 
  
  - `left`
  - `right`
  - `wheel`
  - `back`
  - `forward` ||
  || x | **integer**
  
  Required field. The x-coordinate where the click occurred. ||
  || y | **integer**
  
  Required field. The y-coordinate where the click occurred. ||
  |#
  
  ## DoubleClickAction {#DoubleClickAction}
  
  A double click action.
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. Specifies the event type. For a double click action, this property is always set to `double_click`.
  
  - `double_click` ||
  || x | **integer**
  
  Required field. The x-coordinate where the double click occurred. ||
  || y | **integer**
  
  Required field. The y-coordinate where the double click occurred. ||
  |#
  
  ## Drag {#Drag}
  
  A drag action.  
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. Specifies the event type. For a drag action, this property is 
  always set to `drag`.
  
  
  - `drag` ||
  || path[] | **[DragPoint](#DragPoint)**
  
  Required field. An x/y coordinate pair, e.g. `{ x: 100, y: 200 }`. ||
  |#
  
  ## DragPoint {#DragPoint}
  
  An x/y coordinate pair, e.g. `{ x: 100, y: 200 }`.
  
  #|
  ||Field | Description ||
  || x | **integer**
  
  Required field. The x-coordinate. ||
  || y | **integer**
  
  Required field. The y-coordinate. ||
  |#
  
  ## KeyPressAction {#KeyPressAction}
  
  A collection of keypresses the model would like to perform.
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. Specifies the event type. For a keypress action, this property is always set to `keypress`.
  
  - `keypress` ||
  || keys[] | **string**
  
  Required field. One of the keys the model is requesting to be pressed. ||
  |#
  
  ## Move {#Move}
  
  A mouse move action.  
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. Specifies the event type. For a move action, this property is 
  always set to `move`.
  
  
  - `move` ||
  || x | **integer**
  
  Required field. The x-coordinate to move to.   ||
  || y | **integer**
  
  Required field. The y-coordinate to move to.   ||
  |#
  
  ## Screenshot {#Screenshot}
  
  A screenshot action.  
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. Specifies the event type. For a screenshot action, this property is 
  always set to `screenshot`.
  
  
  - `screenshot` ||
  |#
  
  ## Scroll {#Scroll}
  
  A scroll action.  
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. Specifies the event type. For a scroll action, this property is 
  always set to `scroll`.
  
  
  - `scroll` ||
  || x | **integer**
  
  Required field. The x-coordinate where the scroll occurred.   ||
  || y | **integer**
  
  Required field. The y-coordinate where the scroll occurred.   ||
  || scroll_x | **integer**
  
  Required field. The horizontal scroll distance.   ||
  || scroll_y | **integer**
  
  Required field. The vertical scroll distance.   ||
  |#
  
  ## Type {#Type}
  
  An action to type in text.  
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. Specifies the event type. For a type action, this property is 
  always set to `type`.
  
  
  - `type` ||
  || text | **string**
  
  Required field. The text to type.   ||
  |#
  
  ## Wait {#Wait}
  
  A wait action.  
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. Specifies the event type. For a wait action, this property is 
  always set to `wait`.
  
  
  - `wait` ||
  |#
  
  ## ComputerCallSafetyCheckParam {#ComputerCallSafetyCheckParam}
  
  A pending safety check for the computer call.
  
  #|
  ||Field | Description ||
  || id | **string**
  
  Required field. The ID of the pending safety check. ||
  || code | Any of **string** \| **null** ||
  || message | Any of **string** \| **null** ||
  |#
  
  ## ReasoningItem {#ReasoningItem}
  
  A description of the chain of thought used by a reasoning model while generating a response. '
  
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the object. Always `reasoning`.  
  
  - `reasoning` ||
  || id | **string**
  
  Required field. The unique identifier of the reasoning content.   ||
  || encrypted_content | Any of **string** \| **null** ||
  || summary[] | **[Summary](#Summary)**
  
  Required field. A summary text from the model. ||
  || content[] | **[ReasoningTextContent](#ReasoningTextContent)**
  
  Required field. Reasoning text from the model. ||
  || status | **enum**
  
  The status of the item. One of `in_progress`, `completed`, or
  `incomplete`. Populated when items are returned via API.  
  
  - `in_progress`
  - `completed`
  - `incomplete` ||
  |#
  
  ## Summary {#Summary}
  
  A summary text from the model.
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the object. Always `summary_text`.
  
  - `summary_text` ||
  || text | **string**
  
  Required field. A summary of the reasoning output from the model so far. ||
  |#
  
  ## CompactionBody {#CompactionBody}
  
  CURRENTLY NOT SUPPORTED
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the item. Always `compaction`.
  
  - `compaction` ||
  || id | **string**
  
  Required field. The unique ID of the compaction item. ||
  || encrypted_content | **string**
  
  Required field.  ||
  || created_by | **string** ||
  |#
  
  ## ImageGenToolCall {#ImageGenToolCall}
  
  An image generation request made by the model.  
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the image generation call. Always `image_generation_call`.  
  
  - `image_generation_call` ||
  || id | **string**
  
  Required field. The unique ID of the image generation call.   ||
  || status | **enum**
  
  Required field. The status of the image generation call.  
  
  - `in_progress`
  - `completed`
  - `generating`
  - `failed` ||
  || result | Any of **string** \| **null** ||
  |#
  
  ## CodeInterpreterToolCall {#CodeInterpreterToolCall}
  
  A tool call to run code.  
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the code interpreter tool call. Always `code_interpreter_call`.  
  
  - `code_interpreter_call` ||
  || id | **string**
  
  Required field. The unique ID of the code interpreter tool call.   ||
  || status | **enum**
  
  Required field. The status of the code interpreter tool call. Valid values are `in_progress`, `completed`, `incomplete`, `interpreting`, and `failed`.  
  
  - `in_progress`
  - `completed`
  - `incomplete`
  - `interpreting`
  - `failed` ||
  || container_id | **string**
  
  Required field. The ID of the container used to run the code.   ||
  || code | Any of **string** \| **null** ||
  || outputs | Any of **unknown** \| **null** ||
  |#
  
  ## LocalShellToolCall {#LocalShellToolCall}
  
  A tool call to run a command on the local shell.  
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the local shell call. Always `local_shell_call`.  
  
  - `local_shell_call` ||
  || id | **string**
  
  Required field. The unique ID of the local shell call.   ||
  || call_id | **string**
  
  Required field. The unique ID of the local shell tool call generated by the model.   ||
  || action | **[LocalShellExecAction](#LocalShellExecAction)**
  
  Required field. Execute a shell command on the server. ||
  || status | **enum**
  
  Required field. The status of the local shell call.  
  
  - `in_progress`
  - `completed`
  - `incomplete` ||
  |#
  
  ## LocalShellExecAction {#LocalShellExecAction}
  
  Execute a shell command on the server.
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the local shell action. Always `exec`.
  
  - `exec` ||
  || command[] | **string**
  
  Required field.  ||
  || timeout_ms | Any of **integer** \| **null** ||
  || working_directory | Any of **string** \| **null** ||
  || env | **object** (map<**string**, **string**>)
  
  Required field.  ||
  || user | Any of **string** \| **null** ||
  |#
  
  ## FunctionShellCall {#FunctionShellCall}
  
  A tool call that executes one or more shell commands in a managed environment.
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the item. Always `shell_call`.
  
  - `shell_call` ||
  || id | **string**
  
  Required field. The unique ID of the shell tool call. Populated when this item is returned via API. ||
  || call_id | **string**
  
  Required field. The unique ID of the shell tool call generated by the model. ||
  || action | **[FunctionShellAction](#FunctionShellAction)**
  
  Required field. Execute a shell command. ||
  || status | **enum**
  
  Required field. 
  
  - `in_progress`
  - `completed`
  - `incomplete` ||
  || created_by | **string**
  
  The ID of the entity that created this tool call. ||
  |#
  
  ## FunctionShellAction {#FunctionShellAction}
  
  Execute a shell command.
  
  #|
  ||Field | Description ||
  || commands[] | **string**
  
  Required field. A list of commands to run. ||
  || timeout_ms | Any of **integer** \| **null** ||
  || max_output_length | Any of **integer** \| **null** ||
  |#
  
  ## FunctionShellCallOutput {#FunctionShellCallOutput}
  
  The output of a shell tool call.
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the shell call output. Always `shell_call_output`.
  
  - `shell_call_output` ||
  || id | **string**
  
  Required field. The unique ID of the shell call output. Populated when this item is returned via API. ||
  || call_id | **string**
  
  Required field. The unique ID of the shell tool call generated by the model. ||
  || output[] | **[FunctionShellCallOutputContent](#FunctionShellCallOutputContent)**
  
  Required field. The content of a shell call output. ||
  || max_output_length | Any of **integer** \| **null** ||
  || created_by | **string** ||
  |#
  
  ## FunctionShellCallOutputContent {#FunctionShellCallOutputContent}
  
  The content of a shell call output.
  
  #|
  ||Field | Description ||
  || stdout | **string**
  
  Required field.  ||
  || stderr | **string**
  
  Required field.  ||
  || outcome | Any of **[FunctionShellCallOutputTimeoutOutcome](#FunctionShellCallOutputTimeoutOutcome)** \| **[FunctionShellCallOutputExitOutcome](#FunctionShellCallOutputExitOutcome)** ||
  || created_by | **string** ||
  |#
  
  ## FunctionShellCallOutputTimeoutOutcome {#FunctionShellCallOutputTimeoutOutcome}
  
  Indicates that the shell call exceeded its configured time limit.
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The outcome type. Always `timeout`.
  
  - `timeout` ||
  |#
  
  ## FunctionShellCallOutputExitOutcome {#FunctionShellCallOutputExitOutcome}
  
  Indicates that the shell commands finished and returned an exit code.
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The outcome type. Always `exit`.
  
  - `exit` ||
  || exit_code | **integer**
  
  Required field. Exit code from the shell process. ||
  |#
  
  ## ApplyPatchToolCall {#ApplyPatchToolCall}
  
  A tool call that applies file diffs by creating, deleting, or updating files.
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the item. Always `apply_patch_call`.
  
  - `apply_patch_call` ||
  || id | **string**
  
  Required field. The unique ID of the apply patch tool call. Populated when this item is returned via API. ||
  || call_id | **string**
  
  Required field. The unique ID of the apply patch tool call generated by the model. ||
  || status | **enum**
  
  Required field. 
  
  - `in_progress`
  - `completed` ||
  || operation | Any of **[ApplyPatchCreateFileOperation](#ApplyPatchCreateFileOperation)** \| **[ApplyPatchDeleteFileOperation](#ApplyPatchDeleteFileOperation)** \| **[ApplyPatchUpdateFileOperation](#ApplyPatchUpdateFileOperation)** ||
  || created_by | **string**
  
  The ID of the entity that created this tool call. ||
  |#
  
  ## ApplyPatchCreateFileOperation {#ApplyPatchCreateFileOperation}
  
  Instruction describing how to create a file via the apply_patch tool.
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. Create a new file with the provided diff.
  
  - `create_file` ||
  || path | **string**
  
  Required field. Path of the file to create. ||
  || diff | **string**
  
  Required field. Diff to apply. ||
  |#
  
  ## ApplyPatchDeleteFileOperation {#ApplyPatchDeleteFileOperation}
  
  Instruction describing how to delete a file via the apply_patch tool.
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. Delete the specified file.
  
  - `delete_file` ||
  || path | **string**
  
  Required field. Path of the file to delete. ||
  |#
  
  ## ApplyPatchUpdateFileOperation {#ApplyPatchUpdateFileOperation}
  
  Instruction describing how to update a file via the apply_patch tool.
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. Update an existing file with the provided diff.
  
  - `update_file` ||
  || path | **string**
  
  Required field. Path of the file to update. ||
  || diff | **string**
  
  Required field. Diff to apply. ||
  |#
  
  ## ApplyPatchToolCallOutput {#ApplyPatchToolCallOutput}
  
  The output emitted by an apply patch tool call.
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the item. Always `apply_patch_call_output`.
  
  - `apply_patch_call_output` ||
  || id | **string**
  
  Required field. The unique ID of the apply patch tool call output. Populated when this item is returned via API. ||
  || call_id | **string**
  
  Required field. The unique ID of the apply patch tool call generated by the model. ||
  || status | **enum**
  
  Required field. 
  
  - `completed`
  - `failed` ||
  || output | Any of **string** \| **null** ||
  || created_by | **string**
  
  The ID of the entity that created this tool call output. ||
  |#
  
  ## MCPToolCall {#MCPToolCall}
  
  An invocation of a tool on an MCP server.  
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the item. Always `mcp_call`.  
  
  - `mcp_call` ||
  || id | **string**
  
  Required field. The unique ID of the tool call.   ||
  || server_label | **string**
  
  Required field. The label of the MCP server running the tool.   ||
  || name | **string**
  
  Required field. The name of the tool that was run.   ||
  || arguments | **string**
  
  Required field. A JSON string of the arguments passed to the tool.   ||
  || output | Any of **string** \| **null** ||
  || error | Any of **string** \| **null** ||
  || status | **enum**
  
  - `in_progress`
  - `completed`
  - `incomplete`
  - `calling`
  - `failed` ||
  || approval_request_id | Any of **string** \| **null** ||
  |#
  
  ## MCPListTools {#MCPListTools}
  
  A list of tools available on an MCP server.  
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the item. Always `mcp_list_tools`.  
  
  - `mcp_list_tools` ||
  || id | **string**
  
  Required field. The unique ID of the list.   ||
  || server_label | **string**
  
  Required field. The label of the MCP server.   ||
  || tools[] | **[MCPListToolsTool](#MCPListToolsTool)**
  
  Required field. A tool available on an MCP server.   ||
  || error | Any of **string** \| **null** ||
  |#
  
  ## MCPListToolsTool {#MCPListToolsTool}
  
  A tool available on an MCP server.  
  
  #|
  ||Field | Description ||
  || name | **string**
  
  Required field. The name of the tool.   ||
  || description | Any of **string** \| **null** ||
  || input_schema | **[InputSchema](#null)**
  
  Required field. The JSON schema describing the tool''s input.   ||
  || annotations | Any of **[Annotations0](#null)** \| **null** ||
  |#
  
  ## MCPApprovalRequest {#MCPApprovalRequest}
  
  A request for human approval of a tool invocation.  
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the item. Always `mcp_approval_request`.  
  
  - `mcp_approval_request` ||
  || id | **string**
  
  Required field. The unique ID of the approval request.   ||
  || server_label | **string**
  
  Required field. The label of the MCP server making the request.   ||
  || name | **string**
  
  Required field. The name of the tool to run.   ||
  || arguments | **string**
  
  Required field. A JSON string of arguments for the tool.   ||
  |#
  
  ## CustomToolCall {#CustomToolCall}
  
  A call to a custom tool created by the model.  
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the custom tool call. Always `custom_tool_call`.  
  
  - `custom_tool_call` ||
  || id | **string**
  
  The unique ID of the custom tool call in the Yandex Cloud AI Studio platform.   ||
  || call_id | **string**
  
  Required field. An identifier used to map this custom tool call to a tool call output.   ||
  || name | **string**
  
  Required field. The name of the custom tool being called.   ||
  || input | **string**
  
  Required field. The input for the custom tool call generated by the model.   ||
  |#
  
  ## Part {#Part}
  
  The summary part that was added.  
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the summary part. Always `summary_text`.
  
  - `summary_text` ||
  || text | **string**
  
  Required field. The text of the summary part. ||
  |#
  
  ## Part {#Part-1}
  
  The completed summary part.  
  
  #|
  ||Field | Description ||
  || type | **enum**
  
  Required field. The type of the summary part. Always `summary_text`.
  
  - `summary_text` ||
  || text | **string**
  
  Required field. The text of the summary part. ||
  |#
  
  ## ResponseLogProb {#ResponseLogProb}
  
  A logprob is the logarithmic probability that the model assigns to producing 
  a particular token at a given position in the sequence. Less-negative (higher) 
  logprob values indicate greater model confidence in that token choice.
  
  
  #|
  ||Field | Description ||
  || token | **string**
  
  Required field. A possible text token. ||
  || logprob | **number**
  
  Required field. The log probability of this token.   ||
  || top_logprobs[] | **[TopLogprobsItem](#TopLogprobsItem)** ||
  |#
  
  ## TopLogprobsItem {#TopLogprobsItem}
  
  #|
  ||Field | Description ||
  || token | **string**
  
  A possible text token. ||
  || logprob | **number**
  
  The log probability of this token. ||
  |#

{% endlist %}