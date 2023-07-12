---
editable: false
sourcePath: en/_api-ref-grpc/yandexgpt/api-ref/grpc/llm_service.md
---

# YandexGPT API, gRPC: TextGenerationService



| Call | Description |
| --- | --- |
| [Instruct](#Instruct) |  |

## Calls TextGenerationService {#calls}

## Instruct {#Instruct}



**rpc Instruct ([InstructRequest](#InstructRequest)) returns (stream [InstructResponse](#InstructResponse))**

### InstructRequest {#InstructRequest}

Field | Description
--- | ---
model | **string**<br>Possible value for now: `general`. The maximum string length in characters is 50.
generation_options | **[GenerationOptions](#GenerationOptions)**<br>Generation options 
Instruction | **oneof:** `instruction_text`<br>Text precondition or context of the request. For example, the instruction is "You are the youngest Nobel laureate", the request text is "Tell us about your daily routine".
&nbsp;&nbsp;instruction_text | **string**<br>Text of the instruction. The total length of `instruction_text` and `request_text` should be equal or less to 2500 tokens. 
Request | **oneof:** `request_text`<br>Request
&nbsp;&nbsp;request_text | **string**<br>Text of the instruction. The total length of `instruction_text` and `request_text` should be equal or less to 2500 tokens. 


### GenerationOptions {#GenerationOptions}

Field | Description
--- | ---
partial_results | **bool**<br>Enables streaming of the partially generated text. 
temperature | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**<br>Affects creativity and randomness of the responses. It is a double number between 0 and infinity. A low temperature causes the responses to be straightforward, a high temperature causes high-level creativity and randomness. 
max_tokens | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Sets response limit in tokens. It is a int number between 1 and 2000. 


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


