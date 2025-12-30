---
editable: false
sourcePath: en/_openapi/openai-compatible/chat/createChatCompletion.md
---

# REST: Create chat completion

**Starting a new project?** We recommend trying [Responses](https://yandex.cloud/docs/ai-studio/concepts/agents/). Parameter support can differ depending on the model used to generate the response, particularly for newer reasoning models. Parameters that are only supported for reasoning models are noted below.

## HTTP request

```
POST https://ai.api.cloud.yandex.net/v1/chat/completions
```

## Body parameters

**Request schema: application/json**

```json
{
  "<allOf>": [
    "unknown",
    {
      "messages": [
        {
          "<anyOf>": [
            {
              "content": "unknown",
              "role": "string",
              "name": "string"
            },
            {
              "content": "unknown",
              "role": "string",
              "name": "string"
            },
            "object",
            {
              "role": "string",
              "content": "unknown",
              "tool_call_id": "string"
            },
            "object"
          ]
        }
      ],
      "model": "unknown",
      "modalities": "unknown",
      "verbosity": "unknown",
      "reasoning_effort": "unknown",
      "max_completion_tokens": "integer",
      "frequency_penalty": "number",
      "presence_penalty": "number",
      "web_search_options": {},
      "top_logprobs": "integer",
      "response_format": "unknown",
      "audio": {},
      "store": "boolean",
      "stream": "boolean",
      "stop": "unknown",
      "logit_bias": {
        "string": "integer"
      },
      "logprobs": "boolean",
      "max_tokens": "integer",
      "n": "integer",
      "prediction": "unknown",
      "seed": "integer",
      "stream_options": "unknown",
      "tools": [
        {
          "<anyOf>": [
            {
              "type": "string",
              "function": {
                "description": "string",
                "name": "string",
                "parameters": "object",
                "strict": "unknown"
              }
            },
            {
              "type": "string",
              "custom": {
                "name": "string",
                "description": "string",
                "format": "unknown"
              }
            }
          ]
        }
      ],
      "tool_choice": "unknown",
      "parallel_tool_calls": "boolean",
      "function_call": "unknown",
      "functions": [
        {}
      ]
    }
  ]
}
```

#|
||Field | Description ||
|| messages[] | **unknown**

Required field.  ||
|| model | Any of **string** \| **enum** ||
|| modalities | Any of **enum** \| **null** ||
|| verbosity | Any of **enum** \| **null** ||
|| reasoning_effort | Any of **enum** \| **null** ||
|| max_completion_tokens | **integer**

An upper bound for the number of tokens that can be generated for a completion, including visible output tokens and reasoning tokens. ||
|| frequency_penalty | **number**

NOT SUPPORTED BY ALL MODELS. 
Number between -2.0 and 2.0. Positive values penalize new tokens based on
their existing frequency in the text so far, decreasing the model''''s likelihood to repeat the same line verbatim.
 ||
|| presence_penalty | **number**

NOT SUPPORTED BY ALL MODELS.
Number between -2.0 and 2.0.
Positive values penalize new tokens based on whether they appear in the text so far, increasing the model''''s likelihood
to talk about new topics.
 ||
|| web_search_options | **[WebSearchOptions](#null)**

[CURRENTLY NOT SUPPORTED] ||
|| top_logprobs | **integer**

NOT SUPPORTED BY ALL MODELS. An integer between 0 and 20 specifying the number of most likely tokens to return at each token position, each with an associated log probability. `logprobs` must be set to `true` if this parameter is used. ||
|| response_format | Any of **[ResponseFormatText](#ResponseFormatText)** \| **[ResponseFormatJsonSchema](#ResponseFormatJsonSchema)** \| **[ResponseFormatJsonObject](#ResponseFormatJsonObject)** ||
|| audio | **[Audio](#null)**

[CURRENTLY NOT SUPPORTED] ||
|| store | **boolean**

[CURRENTLY NOT SUPPORTED] ||
|| stream | **boolean**

If set to true, the model response data will be streamed to the client as it is generated using [server-sent events](https://developer.mozilla.org/en-US/docs/Web/API/Server-sent_events/Using_server-sent_events#Event_stream_format). ||
|| stop | **unknown**

'[CURRENTLY NOT SUPPORTED]' 
 ||
|| logit_bias | **object** (map<**string**, **integer**>) ||
|| logprobs | **boolean**

NOT ALL MODELS SUPPORTED. Whether to return log probabilities of the output tokens or not. If true, returns the log probabilities of each output token returned in the `content` of `message`. ||
|| max_tokens | **integer**

The maximum number of [tokens](/tokenizer) that can be generated in the chat completion. This value can be used to control [costs](https://yandex.cloud/docs/ai-studio/pricing) for text generated via API. This value is now deprecated in favor of `max_completion_tokens`. ||
|| n | **integer**

NOT SUPPPORTED BY ALL MODELS. How many chat completion choices to generate for each input message. Note that you will be charged based on the number of generated tokens across all of the choices. Keep `n` as `1` to minimize costs. ||
|| prediction | Any of **[PredictionContent](#PredictionContent)** ||
|| seed | **integer**

[CURRENTLY NOT SUPPORTED] ||
|| stream_options | Any of **[ChatCompletionStreamOptions0](#ChatCompletionStreamOptions0)** \| **null** ||
|| tools[] | **unknown** ||
|| tool_choice | Any of **enum** \| **object** \| **object** \| **object** ||
|| parallel_tool_calls | **boolean**

NOT SUPPORTED BY ALL MODELS. To enable parallel function calling during tool use. ||
|| function_call | Any of **enum** \| **object** ||
|| functions[] | **object**

Placeholder schema for ChatCompletionFunctions. ||
|#


## ResponseFormatText {#ResponseFormatText}

Default response format. Used to generate text responses. 


#|
||Field | Description ||
|| type | **enum**

Required field. The type of response format being defined. Always `text`.

- `text` ||
|#

## ResponseFormatJsonSchema {#ResponseFormatJsonSchema}

JSON Schema response format. Used to generate structured JSON responses.''
'

#|
||Field | Description ||
|| type | **enum**

Required field. The type of response format being defined. Always `json_schema`.

- `json_schema` ||
|| json_schema | **[JsonSchema](#JsonSchema)**

Required field. Structured Outputs configuration options, including a JSON Schema. 
 ||
|#

## JsonSchema {#JsonSchema}

Structured Outputs configuration options, including a JSON Schema. 


#|
||Field | Description ||
|| description | **string**

A description of what the response format is for, used by the model to
determine how to respond in the format. 
 ||
|| name | **string**

Required field. The name of the response format. Must be a-z, A-Z, 0-9, or contain
underscores and dashes, with a maximum length of 64. 
 ||
|| schema | **object**

The schema for the response format, described as a JSON Schema object.
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

## PredictionContent {#PredictionContent}

Static predicted output content, such as the content of a text file that is
being regenerated. 


#|
||Field | Description ||
|| type | **enum**

Required field. The type of the predicted content you want to provide. This type is
currently always `content`. 


- `content` ||
|| content | Any of **string** \| **[ChatCompletionRequestMessageContentPartText](#ChatCompletionRequestMessageContentPartText)** ||
|#

## ChatCompletionRequestMessageContentPartText {#ChatCompletionRequestMessageContentPartText}

Text input

#|
||Field | Description ||
|| type | **enum**

Required field. The type of the content part.

- `text` ||
|| text | **string**

Required field. The text content. ||
|#

## ChatCompletionStreamOptions0 {#ChatCompletionStreamOptions0}

Options for streaming response. Only set this when you set `stream: true`.

#|
||Field | Description ||
|| include_usage | **boolean**

[CURRENTLY NOT SUPPORTED] ||
|| include_obfuscation | **boolean**

[CURRENTLY NOT SUPPORTED] ||
|#

## Response {#200}

**HTTP Code: 200**

OK

{% list tabs %}

- application/json

  ```json
  {
    "id": "string",
    "choices": [
      {
        "finish_reason": "string",
        "index": "integer",
        "message": {
          "content": "unknown",
          "refusal": "unknown",
          "tool_calls": "object",
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
  ```
  
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
  
  Can be used in conjunction with the `seed` request parameter to understand when backend changes have been made that might impact determinism. 
   ||
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
  
  Required field. The reason the model stopped generating tokens. This will be `stop` if the model hit a natural stop point or a provided stop sequence, `length` if the maximum number of tokens specified in the request was reached, `content_filter` if content was omitted due to a flag from our content filters, `tool_calls` if the model called a tool, or `function_call` (deprecated) if the model called a function.
  
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
  || tool_calls | **object**
  
  Placeholder schema for ChatCompletionMessageToolCalls. ||
  || annotations[] | **[AnnotationsItem](#AnnotationsItem)**
  
  Required field. A URL citation when using web search. ||
  || role | **enum**
  
  Required field. The role of the author of this message.
  
  - `assistant` ||
  || function_call | Any of **enum** \| **object** ||
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
  
  If the audio output modality is requested, this object contains data about the audio response from the model.''
  
  #|
  ||Field | Description ||
  || id | **string**
  
  Required field. Unique identifier for this audio response. ||
  || expires_at | **integer**
  
  Required field. The Unix timestamp (in seconds) for when this audio response will
  no longer be accessible on the server for use in multi-turn
  conversations.' ||
  || data | **string**
  
  Required field. Base64 encoded audio bytes generated by the model, in the format
  specified in the request.' ||
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
  prediction that appeared in the completion. 
   ||
  || audio_tokens | **integer**
  
  Audio input tokens generated by the model. ||
  || reasoning_tokens | **integer**
  
  Tokens generated by the model for reasoning. ||
  || rejected_prediction_tokens | **integer**
  
  When using Predicted Outputs, the number of tokens in the
  prediction that did not appear in the completion. However, like
  reasoning tokens, these tokens are still counted in the total
  completion tokens for purposes of billing, output, and context window
  limits. 
   ||
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

- text/event-stream

  Represents a streamed chunk of a chat completion response returned
  by the model, based on the provided input.'
  
  #|
  ||Field | Description ||
  || id | **string**
  
  Required field. A unique identifier for the chat completion. Each chunk has the same ID. ||
  || choices[] | **[ChoicesItem](#ChoicesItem-1)**
  
  Required field.  ||
  || created | **integer**
  
  Required field. The Unix timestamp (in seconds) of when the chat completion was created. Each chunk has the same timestamp. ||
  || model | **string**
  
  Required field. The model to generate the completion. ||
  || service_tier | **unknown**
  
  [CURRENTLY NOT SUPPORTED] ||
  || system_fingerprint | **string**
  
  This fingerprint represents the backend configuration that the model runs with. Can be used in conjunction with the `seed` request parameter to understand when backend changes have been made that might impact determinism. ||
  || object | **enum**
  
  Required field. The object type, which is always `chat.completion.chunk`.
  
  - `chat.completion.chunk` ||
  || usage | **[CompletionUsage](#CompletionUsage2)**
  
  Required field. Usage statistics for the completion request. ||
  |#
  
  ## ChoicesItem {#ChoicesItem-1}
  
  #|
  ||Field | Description ||
  || delta | **[ChatCompletionStreamResponseDelta](#ChatCompletionStreamResponseDelta)**
  
  Required field. A chat completion delta generated by streamed model responses. ||
  || logprobs | **[Logprobs](#Logprobs)**
  
  Required field. Log probability information for the choice. ||
  || finish_reason | **enum**
  
  Required field. The reason the model stopped generating tokens. This will be `stop` if the model hit a natural stop point or a provided stop sequence, `length` if the maximum number of tokens specified in the request was reached, `content_filter` if content was omitted due to a flag from our content filters, `tool_calls` if the model called a tool, or `function_call` (deprecated) if the model called a function.
  
  - `stop`
  - `length`
  - `tool_calls`
  - `content_filter`
  - `function_call` ||
  || index | **integer**
  
  Required field. The index of the choice in the list of choices. ||
  |#
  
  ## ChatCompletionStreamResponseDelta {#ChatCompletionStreamResponseDelta}
  
  A chat completion delta generated by streamed model responses.
  
  #|
  ||Field | Description ||
  || content | Any of **string** \| **null** ||
  || function_call | Any of **enum** \| **object** ||
  || tool_calls[] | **object**
  
  Placeholder schema for ChatCompletionMessageToolCallChunk. ||
  || role | **enum**
  
  The role of the author of this message.
  
  - `developer`
  - `system`
  - `user`
  - `assistant`
  - `tool` ||
  || refusal | Any of **string** \| **null** ||
  |#
  
  ## Logprobs {#Logprobs}
  
  Log probability information for the choice.
  
  #|
  ||Field | Description ||
  || content[] | **[ChatCompletionTokenLogprob](#ChatCompletionTokenLogprob2)**
  
  Required field.  ||
  || refusal[] | **[ChatCompletionTokenLogprob](#ChatCompletionTokenLogprob2)**
  
  Required field.  ||
  |#
  
  ## ChatCompletionTokenLogprob {#ChatCompletionTokenLogprob2}
  
  #|
  ||Field | Description ||
  || token | **string**
  
  Required field. The token. ||
  || logprob | **number**
  
  Required field. The log probability of this token, if it is within the top 20 most likely tokens. Otherwise, the value `-9999.0` is used to signify that the token is very unlikely. ||
  || bytes | Any of **integer** \| **null** ||
  || top_logprobs[] | **[TopLogprobsItem](#TopLogprobsItem2)**
  
  Required field.  ||
  |#
  
  ## TopLogprobsItem {#TopLogprobsItem2}
  
  #|
  ||Field | Description ||
  || token | **string**
  
  Required field. The token. ||
  || logprob | **number**
  
  Required field. The log probability of this token, if it is within the top 20 most likely tokens. Otherwise, the value `-9999.0` is used to signify that the token is very unlikely. ||
  || bytes | Any of **integer** \| **null** ||
  |#
  
  ## CompletionUsage {#CompletionUsage2}
  
  Usage statistics for the completion request.
  
  #|
  ||Field | Description ||
  || completion_tokens | **integer**
  
  Required field. Number of tokens in the generated completion. ||
  || prompt_tokens | **integer**
  
  Required field. Number of tokens in the prompt. ||
  || total_tokens | **integer**
  
  Required field. Total number of tokens used in the request (prompt + completion). ||
  || completion_tokens_details | **[CompletionTokensDetails](#CompletionTokensDetails2)**
  
  Breakdown of tokens used in a completion. ||
  || prompt_tokens_details | **[PromptTokensDetails](#PromptTokensDetails2)**
  
  Breakdown of tokens used in the prompt. ||
  |#
  
  ## CompletionTokensDetails {#CompletionTokensDetails2}
  
  Breakdown of tokens used in a completion.
  
  #|
  ||Field | Description ||
  || accepted_prediction_tokens | **integer**
  
  When using Predicted Outputs, the number of tokens in the
  prediction that appeared in the completion. 
   ||
  || audio_tokens | **integer**
  
  Audio input tokens generated by the model. ||
  || reasoning_tokens | **integer**
  
  Tokens generated by the model for reasoning. ||
  || rejected_prediction_tokens | **integer**
  
  When using Predicted Outputs, the number of tokens in the
  prediction that did not appear in the completion. However, like
  reasoning tokens, these tokens are still counted in the total
  completion tokens for purposes of billing, output, and context window
  limits. 
   ||
  |#
  
  ## PromptTokensDetails {#PromptTokensDetails2}
  
  Breakdown of tokens used in the prompt.
  
  #|
  ||Field | Description ||
  || audio_tokens | **integer**
  
  Audio input tokens present in the prompt. ||
  || cached_tokens | **integer**
  
  Cached tokens present in the prompt. ||
  |#

{% endlist %}