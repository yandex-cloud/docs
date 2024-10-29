---
editable: false
sourcePath: en/_api-ref/ai/llm/v1alpha/api-ref/v1alpha/TextGeneration/instruct.md
---

# YandexGPT API, REST: TextGeneration.Instruct {#Instruct}

RPC method for instructing the model to generate text.

## HTTP request

```
POST https://llm.{{ api-host }}/llm/v1alpha/instruct
```

## Body parameters {#yandex.cloud.ai.llm.v1alpha.InstructRequest}

```json
{
  "model": "string",
  "generationOptions": {
    "partialResults": "boolean",
    "temperature": "number",
    "maxTokens": "string"
  },
  // Includes only one of the fields `instructionText`, `instructionUri`
  "instructionText": "string",
  "instructionUri": "string",
  // end of the list of possible fields
  // Includes only one of the fields `requestText`
  "requestText": "string"
  // end of the list of possible fields
}
```

Request for instructing the model to generate text.

#|
||Field | Description ||
|| model | **string**

The name or identifier of the model to be used for text generation.
Possible value for now: `general`. ||
|| generationOptions | **[GenerationOptions](#yandex.cloud.ai.llm.v1alpha.GenerationOptions)**

Configuration options for text generation. ||
|| instructionText | **string**

The text-based instruction for text generation.

Includes only one of the fields `instructionText`, `instructionUri`.

Text precondition or context of the request.
For example, if the instruction is "You are the youngest Nobel laureate",
the request text might be "Tell us about your daily routine". ||
|| instructionUri | **string**

A URI containing instructions for text generation.

Includes only one of the fields `instructionText`, `instructionUri`.

Text precondition or context of the request.
For example, if the instruction is "You are the youngest Nobel laureate",
the request text might be "Tell us about your daily routine". ||
|| requestText | **string**

The text-based request for text generation.

Includes only one of the fields `requestText`.

Request for text generation. ||
|#

## GenerationOptions {#yandex.cloud.ai.llm.v1alpha.GenerationOptions}

Defines the options for text generation.

#|
||Field | Description ||
|| partialResults | **boolean**

Enables streaming of partially generated text. ||
|| temperature | **number** (double)

Affects creativity and randomness of responses. Should be a double number between 0 (inclusive) and 1 (inclusive).
Lower values produce more straightforward responses, while higher values lead to increased creativity and randomness. ||
|| maxTokens | **string** (int64)

Sets the maximum limit on the total number of tokens used for both the input prompt and the generated response.
Must be greater than zero and not exceed 7400 tokens. ||
|#

## Response {#yandex.cloud.ai.llm.v1alpha.InstructResponse}

**HTTP Code: 200 - OK**

```json
{
  "alternatives": [
    {
      "text": "string",
      "score": "string",
      "numTokens": "string"
    }
  ],
  "numPromptTokens": "string"
}
```

Response containing generated text alternatives and token count.

#|
||Field | Description ||
|| alternatives[] | **[Alternative](#yandex.cloud.ai.llm.v1alpha.Alternative)**

A list of alternative text responses. ||
|| numPromptTokens | **string** (int64)

The number of tokens used in the prompt, including both the [instructionText](#yandex.cloud.ai.llm.v1alpha.InstructRequest) and [requestText](#yandex.cloud.ai.llm.v1alpha.InstructRequest). ||
|#

## Alternative {#yandex.cloud.ai.llm.v1alpha.Alternative}

Represents an alternative generated response, including its score and token count.

#|
||Field | Description ||
|| text | **string**

The generated text response. ||
|| score | **string**

The score or confidence of the generated text. ||
|| numTokens | **string** (int64)

The number of tokens in the generated response. ||
|#