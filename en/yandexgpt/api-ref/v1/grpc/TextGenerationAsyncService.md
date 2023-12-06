---
editable: false
sourcePath: en/_api-ref-grpc/foundation-models/api-ref/v1/grpc/TextGenerationAsyncService.md
---

# Foundation Models API, gRPC: TextGenerationAsyncService

Service for asynchronous text generation.

| Call | Description |
| --- | --- |
| [Completion](#Completion) | RPC method for generating text completions in asynchronous mode. |

## Calls TextGenerationAsyncService {#calls}

## Completion {#Completion}

RPC method for generating text completions in asynchronous mode.

**rpc Completion ([CompletionRequest](#CompletionRequest)) returns ([operation.Operation](#Operation))**

	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[CompletionResponse](#CompletionResponse)<br>

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
role | **string**<br>Identifier of the message sender. Supported roles: <ul><li>`system` - special role used to define the behaviour of the completion model </li><li>`assistant` - a role used by the model to generate responses </li><li>`user` - a role used by the user to describe requests to the model</li></ul> 
Content | **oneof:** `text`<br>Message content.
&nbsp;&nbsp;text | **string**<br>Textual content of the message. 


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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CompletionResponse](#CompletionResponse)>**<br>if operation finished successfully. 


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


