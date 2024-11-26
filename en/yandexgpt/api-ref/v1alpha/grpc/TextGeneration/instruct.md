---
editable: false
sourcePath: en/_api-ref-grpc/ai/llm/v1alpha/api-ref/v1alpha/grpc/TextGeneration/instruct.md
---

# YandexGPT API, gRPC: TextGenerationService.Instruct

RPC method for instructing the model to generate text.

## gRPC request

**rpc Instruct ([InstructRequest](#yandex.cloud.ai.llm.v1alpha.InstructRequest)) returns (stream [InstructResponse](#yandex.cloud.ai.llm.v1alpha.InstructResponse))**

## InstructRequest {#yandex.cloud.ai.llm.v1alpha.InstructRequest}

```json
{
  "model": "string",
  "generation_options": {
    "partial_results": "bool",
    "temperature": "google.protobuf.DoubleValue",
    "max_tokens": "google.protobuf.Int64Value"
  },
  // Includes only one of the fields `instruction_text`, `instruction_uri`
  "instruction_text": "string",
  "instruction_uri": "string",
  // end of the list of possible fields
  // Includes only one of the fields `request_text`
  "request_text": "string"
  // end of the list of possible fields
}
```

Request for instructing the model to generate text.

#|
||Field | Description ||
|| model | **string**

The name or identifier of the model to be used for text generation.
Possible value for now: `general`. ||
|| generation_options | **[GenerationOptions](#yandex.cloud.ai.llm.v1alpha.GenerationOptions)**

Configuration options for text generation. ||
|| instruction_text | **string**

The text-based instruction for text generation.

Includes only one of the fields `instruction_text`, `instruction_uri`.

Text precondition or context of the request.
For example, if the instruction is "You are the youngest Nobel laureate",
the request text might be "Tell us about your daily routine". ||
|| instruction_uri | **string**

A URI containing instructions for text generation.

Includes only one of the fields `instruction_text`, `instruction_uri`.

Text precondition or context of the request.
For example, if the instruction is "You are the youngest Nobel laureate",
the request text might be "Tell us about your daily routine". ||
|| request_text | **string**

The text-based request for text generation.

Includes only one of the fields `request_text`.

Request for text generation. ||
|#

## GenerationOptions {#yandex.cloud.ai.llm.v1alpha.GenerationOptions}

Defines the options for text generation.

#|
||Field | Description ||
|| partial_results | **bool**

Enables streaming of partially generated text. ||
|| temperature | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

Affects creativity and randomness of responses. Should be a double number between 0 (inclusive) and 1 (inclusive).
Lower values produce more straightforward responses, while higher values lead to increased creativity and randomness. ||
|| max_tokens | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**

Sets the maximum limit on the total number of tokens used for both the input prompt and the generated response.
Must be greater than zero and not exceed 7400 tokens. ||
|#

## InstructResponse {#yandex.cloud.ai.llm.v1alpha.InstructResponse}

```json
{
  "alternatives": [
    {
      "text": "string",
      "score": "double",
      "num_tokens": "int64"
    }
  ],
  "num_prompt_tokens": "int64"
}
```

Response containing generated text alternatives and token count.

#|
||Field | Description ||
|| alternatives[] | **[Alternative](#yandex.cloud.ai.llm.v1alpha.Alternative)**

A list of alternative text responses. ||
|| num_prompt_tokens | **int64**

The number of tokens used in the prompt, including both the [instruction_text](#yandex.cloud.ai.llm.v1alpha.InstructRequest) and [request_text](#yandex.cloud.ai.llm.v1alpha.InstructRequest). ||
|#

## Alternative {#yandex.cloud.ai.llm.v1alpha.Alternative}

Represents an alternative generated response, including its score and token count.

#|
||Field | Description ||
|| text | **string**

The generated text response. ||
|| score | **double**

The score or confidence of the generated text. ||
|| num_tokens | **int64**

The number of tokens in the generated response. ||
|#