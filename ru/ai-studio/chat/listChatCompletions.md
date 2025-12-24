---
editable: false
sourcePath: en/_openapi/openai-compatible/chat/listChatCompletions.md
---

# REST: List Chat Completions

[CURRENTLY NOT SUPPORTED]

## HTTP request

```
GET https://ai.api.cloud.yandex.net/v1/chat/completions
```

## Query parameters

#|
||Field | Description ||
|| model | **string**

The model used to generate the Chat Completions. ||
|| metadata | **unknown**

A list of metadata keys to filter the Chat Completions by. Example:

`metadata[key1]=value1&metadata[key2]=value2` ||
|| after | **string**

Identifier for the last chat completion from the previous pagination request. ||
|| limit | **integer**

Number of Chat Completions to retrieve. ||
|| order | **enum**

Sort order for Chat Completions by timestamp. Use `asc` for ascending order or `desc` for descending order. Defaults to `asc`.

- `asc`
- `desc` ||
|#

## Response {#200}

**HTTP Code: 200**

A list of Chat Completions

**Response schema: application/json**

```json
{
  "object": "string",
  "data": [
    {
      "id": "string",
      "choices": [
        {
          "finish_reason": "string",
          "index": "integer",
          "message": {
            "content": "unknown",
            "refusal": "unknown",
            "tool_calls": [
              {
                "<anyOf>": [
                  {
                    "id": "string",
                    "type": "string",
                    "function": {
                      "name": "string",
                      "arguments": "string"
                    }
                  },
                  {
                    "id": "string",
                    "type": "string",
                    "custom": {
                      "name": "string",
                      "input": "string"
                    }
                  }
                ]
              }
            ],
            "annotations": [
              {
                "type": "string",
                "url_citation": {
                  "end_index": "integer",
                  "start_index": "integer",
                  "url": "string",
                  "title": "string"
                }
              }
            ],
            "role": "string",
            "function_call": "unknown",
            "audio": "unknown"
          },
          "logprobs": "unknown"
        }
      ],
      "created": "integer",
      "model": "string",
      "service_tier": "unknown",
      "system_fingerprint": "string",
      "object": "string",
      "usage": {
        "completion_tokens": "integer",
        "prompt_tokens": "integer",
        "total_tokens": "integer",
        "completion_tokens_details": {
          "accepted_prediction_tokens": "integer",
          "audio_tokens": "integer",
          "reasoning_tokens": "integer",
          "rejected_prediction_tokens": "integer"
        },
        "prompt_tokens_details": {
          "audio_tokens": "integer",
          "cached_tokens": "integer"
        }
      }
    }
  ],
  "first_id": "string",
  "last_id": "string",
  "has_more": "boolean"
}
```

An object representing a list of Chat Completions.

#|
||Field | Description ||
|| object | **enum**

Required field. The type of this object. It is always set to "list".

- `list` ||
|| data[] | **[CreateChatCompletionResponse](#CreateChatCompletionResponse)**

Required field. Represents a chat completion response returned by model, based on the provided input. ||
|| first_id | **string**

Required field. The identifier of the first chat completion in the data array. ||
|| last_id | **string**

Required field. The identifier of the last chat completion in the data array. ||
|| has_more | **boolean**

Required field. Indicates whether there are more Chat Completions available. ||
|#

## CreateChatCompletionResponse {#CreateChatCompletionResponse}

Represents a chat completion response returned by model, based on the provided input.

#|
||Field | Description ||
|| id | **string**

Required field. A unique identifier for the chat completion. ||
|| choices[] | **[ChoicesItem](#ChoicesItem)**

Required field.  ||
|| created | **integer**

Required field. The Unix timestamp (in seconds) of when the chat completion was created. ||
|| model | **string**

Required field. The model used for the chat completion. ||
|| service_tier | **unknown**

[CURRENTLY NOT SUPPORTED] ||
|| system_fingerprint | **string**

This fingerprint represents the backend configuration that the model runs with.

Can be used in conjunction with the `seed` request parameter to understand when backend changes have been made that might impact determinism. ||
|| object | **enum**

Required field. The object type, which is always `chat.completion`.

- `chat.completion` ||
|| usage | **[CompletionUsage](#CompletionUsage)**

Required field. Usage statistics for the completion request. ||
|#

## ChoicesItem {#ChoicesItem}

#|
||Field | Description ||
|| finish_reason | **enum**

Required field. The reason the model stopped generating tokens. This will be `stop` if the model hit a natural stop point or a provided stop sequence,
`length` if the maximum number of tokens specified in the request was reached,
`content_filter` if content was omitted due to a flag from our content filters,
`tool_calls` if the model called a tool, or `function_call` (deprecated) if the model called a function.

- `stop`
- `length`
- `tool_calls`
- `content_filter`
- `function_call` ||
|| index | **integer**

Required field. The index of the choice in the list of choices. ||
|| message | **[ChatCompletionResponseMessage](#ChatCompletionResponseMessage)**

Required field. A chat completion message generated by the model. ||
|| logprobs | Any of **[Logprobs0](#Logprobs0)** \| **null** ||
|#

## ChatCompletionResponseMessage {#ChatCompletionResponseMessage}

A chat completion message generated by the model.

#|
||Field | Description ||
|| content | Any of **string** \| **null** ||
|| refusal | Any of **string** \| **null** ||
|| tool_calls[] | **unknown** ||
|| annotations[] | **[AnnotationsItem](#AnnotationsItem)**

Required field. A URL citation when using web search. ||
|| role | **enum**

Required field. The role of the author of this message.

- `assistant` ||
|| function_call | **unknown**

**DEPRECATED** - This field is deprecated and will be removed in a future version. Use `tool_choice` instead.

Controls which (if any) function is called by the model.

`none` means the model will not call a function and instead generates a
message. ||
|| audio | Any of **[Audio0](#Audio0)** \| **null** ||
|#

## AnnotationsItem {#AnnotationsItem}

A URL citation when using web search.

#|
||Field | Description ||
|| type | **enum**

Required field. The type of the URL citation. Always `url_citation`.

- `url_citation` ||
|| url_citation | **[UrlCitation](#UrlCitation)**

Required field. A URL citation when using web search. ||
|#

## UrlCitation {#UrlCitation}

A URL citation when using web search.

#|
||Field | Description ||
|| end_index | **integer**

Required field. The index of the last character of the URL citation in the message. ||
|| start_index | **integer**

Required field. The index of the first character of the URL citation in the message. ||
|| url | **string**

Required field. The URL of the web resource. ||
|| title | **string**

Required field. The title of the web resource. ||
|#

## Audio0 {#Audio0}

If the audio output modality is requested, this object contains data about the audio response from the model.'


#|
||Field | Description ||
|| id | **string**

Required field. Unique identifier for this audio response. ||
|| expires_at | **integer**

Required field. The Unix timestamp (in seconds) for when this audio response will
no longer be accessible on the server for use in multi-turn
conversations. ||
|| data | **string**

Required field. Base64 encoded audio bytes generated by the model, in the format
specified in the request. ||
|| transcript | **string**

Required field. Transcript of the audio generated by the model. ||
|#

## Logprobs0 {#Logprobs0}

Log probability information for the choice.

#|
||Field | Description ||
|| content | Any of **[ChatCompletionTokenLogprob](#ChatCompletionTokenLogprob)** \| **null** ||
|| refusal | Any of **[ChatCompletionTokenLogprob](#ChatCompletionTokenLogprob)** \| **null** ||
|#

## ChatCompletionTokenLogprob {#ChatCompletionTokenLogprob}

#|
||Field | Description ||
|| token | **string**

Required field. The token. ||
|| logprob | **number**

Required field. The log probability of this token, if it is within the top 20 most likely tokens. Otherwise, the value `-9999.0` is used to signify that the token is very unlikely. ||
|| bytes | Any of **integer** \| **null** ||
|| top_logprobs[] | **[TopLogprobsItem](#TopLogprobsItem)**

Required field.  ||
|#

## TopLogprobsItem {#TopLogprobsItem}

#|
||Field | Description ||
|| token | **string**

Required field. The token. ||
|| logprob | **number**

Required field. The log probability of this token, if it is within the top 20 most likely tokens. Otherwise, the value `-9999.0` is used to signify that the token is very unlikely. ||
|| bytes | Any of **integer** \| **null** ||
|#

## CompletionUsage {#CompletionUsage}

Usage statistics for the completion request.

#|
||Field | Description ||
|| completion_tokens | **integer**

Required field. Number of tokens in the generated completion. ||
|| prompt_tokens | **integer**

Required field. Number of tokens in the prompt. ||
|| total_tokens | **integer**

Required field. Total number of tokens used in the request (prompt + completion). ||
|| completion_tokens_details | **[CompletionTokensDetails](#CompletionTokensDetails)**

Breakdown of tokens used in a completion. ||
|| prompt_tokens_details | **[PromptTokensDetails](#PromptTokensDetails)**

Breakdown of tokens used in the prompt. ||
|#

## CompletionTokensDetails {#CompletionTokensDetails}

Breakdown of tokens used in a completion.

#|
||Field | Description ||
|| accepted_prediction_tokens | **integer**

When using Predicted Outputs, the number of tokens in the
prediction that appeared in the completion. ||
|| audio_tokens | **integer**

Audio input tokens generated by the model. ||
|| reasoning_tokens | **integer**

Tokens generated by the model for reasoning. ||
|| rejected_prediction_tokens | **integer**

When using Predicted Outputs, the number of tokens in the
prediction that did not appear in the completion. However, like
reasoning tokens, these tokens are still counted in the total
completion tokens for purposes of billing, output, and context window
limits. ||
|#

## PromptTokensDetails {#PromptTokensDetails}

Breakdown of tokens used in the prompt.

#|
||Field | Description ||
|| audio_tokens | **integer**

Audio input tokens present in the prompt. ||
|| cached_tokens | **integer**

Cached tokens present in the prompt. ||
|#