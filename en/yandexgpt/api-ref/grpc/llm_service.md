---
editable: false
sourcePath: en/_api-ref-grpc/yandexgpt/api-ref/grpc/llm_service.md
---

# YandexGPT API, gRPC: TextGenerationService



| Call | Description |
| --- | --- |
| [Instruct](#Instruct) |  |
| [Chat](#Chat) |  |

## Calls TextGenerationService {#calls}

## Instruct {#Instruct}



**rpc Instruct ([InstructRequest](#InstructRequest)) returns (stream [InstructResponse](#InstructResponse))**

### InstructRequest {#InstructRequest}

Field | Description
--- | ---
model | **string**<br>Possible value for now: `general`. The maximum string length in characters is 50.
generation_options | **[GenerationOptions](#GenerationOptions)**<br>Generation options 
Instruction | **oneof:** `instruction_text` or `instruction_uri`<br>Text precondition or context of the request. For example, the instruction is "You are the youngest Nobel laureate", the request text is "Tell us about your daily routine".
&nbsp;&nbsp;instruction_text | **string**<br>Text of the instruction. The total length of `instruction_text`, `request_text`, and [max_tokens] should be equal or less than 7400 tokens. 
&nbsp;&nbsp;instruction_uri | **string**<br>Text precondition or context of the request. For example, the instruction is "You are the youngest Nobel laureate", the request text is "Tell us about your daily routine". 
Request | **oneof:** `request_text`<br>Request
&nbsp;&nbsp;request_text | **string**<br>Text of the instruction. The total length of `instruction_text`, `request_text`, and [max_tokens] should be equal or less than 7400 tokens. 


### GenerationOptions {#GenerationOptions}

Field | Description
--- | ---
partial_results | **bool**<br>Enables streaming of the partially generated text. 
temperature | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**<br>Affects creativity and randomness of the responses. It is a double number between 0 and infinity. A low temperature causes the responses to be straightforward, a high temperature causes high-level creativity and randomness. 
max_tokens | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets response limit in tokens. The total length of [instruction_text], [request_text], and `max_tokens` should be equal or less than 7400 tokens. 


### InstructResponse {#InstructResponse}

Field | Description
--- | ---
alternatives[] | **[Alternative](#Alternative)**<br>Generated alternatives 
num_prompt_tokens | **int64**<br>Number of tokens for instruction text and request text 


### Alternative {#Alternative}

Field | Description
--- | ---
text | **string**<br>Text of the response. 
score | **double**<br>Text log likelihood. 
num_tokens | **int64**<br>Number of tokens in the response. 


## Chat {#Chat}



**rpc Chat ([ChatRequest](#ChatRequest)) returns (stream [ChatResponse](#ChatResponse))**

### ChatRequest {#ChatRequest}

Field | Description
--- | ---
model | **string**<br>Possible value for now: `general`. The maximum string length in characters is 50.
generation_options | **[GenerationOptions](#GenerationOptions1)**<br>Generation options 
Instruction | **oneof:** `instruction_text`<br>Text precondition or context of the request. For example, the instruction may be "You are a helpful assistant".
&nbsp;&nbsp;instruction_text | **string**<br>Text of the instruction. 
messages[] | **[Message](#Message)**<br>Message history. 


### GenerationOptions {#GenerationOptions1}

Field | Description
--- | ---
partial_results | **bool**<br>Enables streaming of the partially generated text. 
temperature | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**<br>Affects creativity and randomness of the responses. It is a double number between 0 and infinity. A low temperature causes the responses to be straightforward, a high temperature causes high-level creativity and randomness. 
max_tokens | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets response limit in tokens. The total length of [instruction_text], [request_text], and `max_tokens` should be equal or less than 7400 tokens. 


### Message {#Message}

Field | Description
--- | ---
role | **string**<br>Identifies who sent message. For message from the LLM model, the mandatory value is "assistant". 
text | **string**<br>Text of the message. 


### ChatResponse {#ChatResponse}

Field | Description
--- | ---
message | **[Message](#Message1)**<br>Assistant's message. 
num_tokens | **int64**<br>Total number of tokens for chat request and chat response. 


