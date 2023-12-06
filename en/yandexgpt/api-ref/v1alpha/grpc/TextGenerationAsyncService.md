---
editable: false
sourcePath: en/_api-ref-grpc/yandexgpt/api-ref/v1alpha/grpc/TextGenerationAsyncService.md
---

# YandexGPT API, gRPC: TextGenerationAsyncService

Service for asynchronous text generation.

| Call | Description |
| --- | --- |
| [Instruct](#Instruct) | RPC method for instructing the model to generate text. |

## Calls TextGenerationAsyncService {#calls}

## Instruct {#Instruct}

RPC method for instructing the model to generate text.

**rpc Instruct ([InstructRequest](#InstructRequest)) returns ([operation.Operation](#Operation))**

	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[InstructResponse](#InstructResponse)<br>

### InstructRequest {#InstructRequest}

Field | Description
--- | ---
model | **string**<br>The name or identifier of the model to be used for text generation. Possible value for now: `general`. The maximum string length in characters is 50.
generation_options | **[GenerationOptions](#GenerationOptions)**<br>Configuration options for text generation. 
Instruction | **oneof:** `instruction_text` or `instruction_uri`<br>Text precondition or context of the request. For example, if the instruction is "You are the youngest Nobel laureate", the request text might be "Tell us about your daily routine".
&nbsp;&nbsp;instruction_text | **string**<br>The text-based instruction for text generation. 
&nbsp;&nbsp;instruction_uri | **string**<br>A URI containing instructions for text generation. 
Request | **oneof:** `request_text`<br>Request for text generation.
&nbsp;&nbsp;request_text | **string**<br>The text-based request for text generation. 


### GenerationOptions {#GenerationOptions}

Field | Description
--- | ---
partial_results | **bool**<br>Enables streaming of partially generated text. 
temperature | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**<br>Affects creativity and randomness of responses. Should be a double number between 0 (inclusive) and 1 (inclusive). Lower values produce more straightforward responses, while higher values lead to increased creativity and randomness. 
max_tokens | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the maximum limit on the total number of tokens used for both the input prompt and the generated response. Must be greater than zero and not exceed 7400 tokens. 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[InstructResponse](#InstructResponse)>**<br>if operation finished successfully. 


### InstructResponse {#InstructResponse}

Field | Description
--- | ---
alternatives[] | **[Alternative](#Alternative)**<br>A list of alternative text responses. 
num_prompt_tokens | **int64**<br>The number of tokens used in the prompt, including both the [instruction_text] and [request_text]. 


### Alternative {#Alternative}

Field | Description
--- | ---
text | **string**<br>The generated text response. 
score | **double**<br>The score or confidence of the generated text. 
num_tokens | **int64**<br>The number of tokens in the generated response. 


