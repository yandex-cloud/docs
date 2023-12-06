---
editable: false
sourcePath: en/_api-ref-grpc/yandexgpt/api-ref/v1alpha/grpc/llm_service.md
---

# YandexGPT API, gRPC: TextGenerationService

Service for text generation and conversation.

| Call | Description |
| --- | --- |
| [Instruct](#Instruct) | RPC method for instructing the model to generate text. |
| [Chat](#Chat) | RPC method for engaging in a chat conversation with the model. |

## Calls TextGenerationService {#calls}

## Instruct {#Instruct}

RPC method for instructing the model to generate text.

**rpc Instruct ([InstructRequest](#InstructRequest)) returns (stream [InstructResponse](#InstructResponse))**

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


## Chat {#Chat}

RPC method for engaging in a chat conversation with the model.

**rpc Chat ([ChatRequest](#ChatRequest)) returns (stream [ChatResponse](#ChatResponse))**

### ChatRequest {#ChatRequest}

Field | Description
--- | ---
model | **string**<br>The name or identifier of the model to be used for the chat. Possible value for now: `general`. The maximum string length in characters is 50.
generation_options | **[GenerationOptions](#GenerationOptions1)**<br>Configuration options for text generation. 
Instruction | **oneof:** `instruction_text`<br>Text precondition or context of the request. For example, the instruction may be "You are a helpful assistant".
&nbsp;&nbsp;instruction_text | **string**<br>The text-based instruction for the conversation. 
messages[] | **[Message](#Message)**<br>A list of messages in the conversation. 


### GenerationOptions {#GenerationOptions1}

Field | Description
--- | ---
partial_results | **bool**<br>Enables streaming of partially generated text. 
temperature | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**<br>Affects creativity and randomness of responses. Should be a double number between 0 (inclusive) and 1 (inclusive). Lower values produce more straightforward responses, while higher values lead to increased creativity and randomness. 
max_tokens | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets the maximum limit on the total number of tokens used for both the input prompt and the generated response. Must be greater than zero and not exceed 7400 tokens. 


### Message {#Message}

Field | Description
--- | ---
role | **string**<br>Identifies the sender of the message. 
text | **string**<br>The text content of the message. 


### ChatResponse {#ChatResponse}

Field | Description
--- | ---
message | **[Message](#Message1)**<br>The assistant's message in the chat conversation. 
num_tokens | **int64**<br>Total number of tokens used in both the chat request and chat response. 


