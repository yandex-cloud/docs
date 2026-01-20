---
editable: false
sourcePath: en/_openapi/openai-compatible/responses/getResponse.md
---

# REST: Get a model response

Retrieves a model response with the given ID.

## HTTP request

```
GET https://ai.api.cloud.yandex.net/v1/responses/{response_id}
```

## Path parameters

#|
||Field | Description ||
|| response_id | **string**

Required field. The ID of the response to retrieve. ||
|#

## Query parameters

#|
||Field | Description ||
|| include[] | **enum**

NOT SUPPORTED BY ALL MODELS. Additional fields to include in the response. See the `include` parameter for Response creation above for more information.

[CURRENTLY NOT SUPPORTED]

- `file_search_call.results`
- `web_search_call.results`
- `web_search_call.action.sources`
- `message.input_image.image_url`
- `computer_call_output.output.image_url`
- `code_interpreter_call.outputs`
- `reasoning.encrypted_content`
- `message.output_text.logprobs` ||
|| stream | **boolean**

If set to true, the model response data will be streamed to the client as it is generated using [server-sent events](https://developer.mozilla.org/en-US/docs/Web/API/Server-sent_events/Using_server-sent_events#Event_stream_format). ||
|| starting_after | **integer**

The sequence number of the event after which to start streaming. ||
|| include_obfuscation | **boolean**

[CURRENTLY NOT SUPPORTED] ||
|#

## Response {#200}

**HTTP Code: 200**

OK

**Response schema: application/json**

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

>

#|
||Field | Description ||
|| previous_response_id | Any of **string** \| **null** ||
|| model | Any of **unknown** \| **enum** ||
|| reasoning | Any of **[Reasoning](#Reasoning)** \| **null** ||
|| background | Any of **boolean** \| **null** ||
|| max_output_tokens | Any of **integer** \| **null** ||
|| max_tool_calls | Any of **integer** \| **null** ||
|| text | **[ResponseTextParam](#ResponseTextParam)**

Configuration options for a text response from the model. Can be plain text or structured JSON data. 
 ||
|| tools[] | **unknown**

A tool that can be used to generate a response. 
 ||
|| tool_choice | Any of **enum** \| **[ToolChoiceAllowed](#ToolChoiceAllowed)** \| **[ToolChoiceTypes](#ToolChoiceTypes)** \| **[ToolChoiceFunction](#ToolChoiceFunction)** \| **[ToolChoiceMCP](#ToolChoiceMCP)** \| **[ToolChoiceCustom](#ToolChoiceCustom)** \| **[SpecificApplyPatchParam](#SpecificApplyPatchParam)** \| **[SpecificFunctionShellParam](#SpecificFunctionShellParam)** ||
|| prompt | Any of **[Prompt0](#Prompt0)** \| **null** ||
|| truncation | **unknown**

[CURRENTLY NOT SUPPORTED] ||
|#

>

#|
||Field | Description ||
|| id | **string**

Required field. Unique identifier for this Response. ||
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

Required field. Unix timestamp (in seconds) of when this Response was created. ||
|| error | Any of **[ResponseError0](#ResponseError0)** \| **null** ||
|| incomplete_details | Any of **[IncompleteDetails0](#IncompleteDetails0)** \| **null** ||
|| output[] | **unknown**

Required field.  ||
|| instructions | Any of **unknown** \| **null** ||
|| output_text | Any of **string** \| **null** ||
|| usage | **[ResponseUsage](#ResponseUsage)**

Required field. Represents token usage details including input tokens, output tokens,
a breakdown of output tokens, and the total tokens used. 
 ||
|| parallel_tool_calls | **boolean**

Required field. Whether to allow the model to run tool calls in parallel. ||
|| conversation | Any of **[Conversation-2](#Conversation-2)** \| **null** ||
|#

>

## Reasoning {#Reasoning}

[CURRENTLY NOT SUPPORTED]

#|
||Field | Description ||
|| effort '[CURRENTLY NOT SUPPORTED]' | Any of **enum** \| **null** ||
|| summary '[CURRENTLY NOT SUPPORTED]' | Any of **enum** \| **null** ||
|| generate_summary | Any of **enum** \| **null** ||
|#

## ResponseTextParam {#ResponseTextParam}

Configuration options for a text response from the model. Can be plain text or structured JSON data. 


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

A description of what the response format is for, used by the model to determine 
how to respond in the format."
 ||
|| name | **string**

Required field. The name of the response format. Must be a-z, A-Z, 0-9, or contain underscores and dashes, with a maximum length of 64. 
 ||
|| schema | **object**

Required field. The schema for the response format, described as a JSON Schema object.
Learn how to build JSON schemas [here](https://json-schema.org/). 
 ||
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

Required field. Constrains the tools available to the model to a pre-defined set.  `auto` allows the model to pick from among the allowed tools and generate a message. `required` requires the model to call one or more of the allowed tools. 


- `auto`
- `required` ||
|| tools[] | **object**

Required field. A tool definition that the model should be allowed to call. ||
|#

## ToolChoiceTypes {#ToolChoiceTypes}

Indicates that the model should use a built-in tool to generate a response.

#|
||Field | Description ||
|| type | **enum**

Required field. The type of hosted tool the model should to use.

- `file_search`
- `web_search`
- `mcp` ||
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

Required field. The label of the MCP server to use. 
 ||
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

## ResponseError0 {#ResponseError0}

An error object returned when the model fails to generate a Response.
'

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

Required field. A human-readable description of the error. ||
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