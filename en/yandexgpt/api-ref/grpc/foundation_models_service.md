---
editable: false
sourcePath: en/_api-ref-grpc/yandexgpt/api-ref/grpc/foundation_models_service.md
---

# Foundation Models API, gRPC: TextGenerationService

Service for text generation.

| Call | Description |
| --- | --- |
| [Completion](#Completion) | RPC method for generating text completions. |

## Calls TextGenerationService {#calls}

## Completion {#Completion}

RPC method for generating text completions.

**rpc Completion ([CompletionRequest](#CompletionRequest)) returns (stream [CompletionResponse](#CompletionResponse))**

### CompletionRequest {#CompletionRequest}

Field | Description
--- | ---
model_uri | **string**<br>The identifier of the model to be used for completion generation. 
completion_options | **[CompletionOptions](#CompletionOptions)**<br>Configuration options for completion generation. 
messages[] | **[Message](#Message)**<br>A list of messages representing the context for the completion model. 


### CompletionOptions {#CompletionOptions}

Field | Description
--- | ---
stream | **bool**<br>Enables streaming of partially generated text. 
temperature | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**<br>Affects creativity and randomness of responses. Should be a double number between 0 (inclusive) and 1 (inclusive). Lower values produce more straightforward responses, while higher values lead to increased creativity and randomness. Default temperature: 0.6 
max_tokens | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The limit on the number of tokens used for single completion generation. Must be greater than zero. The maximum allowed parameter value may depend on the model used. 


### Message {#Message}

Field | Description
--- | ---
role | **string**<br>Identifier of the message sender. Supported roles: TBD. 
Content | **oneof:** `text`<br>Message content.
&nbsp;&nbsp;text | **string**<br>Textual content of the message. 


### CompletionResponse {#CompletionResponse}

Field | Description
--- | ---
alternatives[] | **[Alternative](#Alternative)**<br>A list of generated completion alternatives. 
usage | **[ContentUsage](#ContentUsage)**<br>A set of statistics describing the number of content tokens used by the completion model. 
model_version | **string**<br>Model version (changes with model releases). 


### Alternative {#Alternative}

Field | Description
--- | ---
message | **[Message](#Message1)**<br>A message containing the content of the alternative. 
status | enum **AlternativeStatus**<br>The generation status of the alternative <ul><li>`ALTERNATIVE_STATUS_UNSPECIFIED`: Unspecified generation status.</li><li>`ALTERNATIVE_STATUS_PARTIAL`: Partially generated alternative.</li><li>`ALTERNATIVE_STATUS_TRUNCATED_FINAL`: Incomplete final alternative resulting from reaching the maximum allowed number of tokens.</li><li>`ALTERNATIVE_STATUS_FINAL`: Final alternative generated without running into any limits.</li></ul>


### ContentUsage {#ContentUsage}

Field | Description
--- | ---
input_text_tokens | **int64**<br>The number of tokens in the text parts of the model input. 
completion_tokens | **int64**<br>The total number of tokens in the generated completions. 
total_tokens | **int64**<br>The total number of tokens, including all input tokens and all generated tokens. 


