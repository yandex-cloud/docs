---
editable: false
sourcePath: en/_api-ref-grpc/foundation-models/text-generation/text-generation/api-ref/grpc/TextGenerationAsyncService.md
---

# Foundation Models Text Generation API, gRPC: TextGenerationAsyncService

Service for asynchronous text generation.

| Call | Description |
| --- | --- |
| [Completion](#Completion) | RPC method for generating text completions in asynchronous mode. |

## Calls TextGenerationAsyncService {#calls}

## Completion {#Completion}

RPC method for generating text completions in asynchronous mode.

**rpc Completion ([CompletionRequest](#CompletionRequest)) returns ([operation.Operation](#Operation))**

Response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[CompletionResponse](#CompletionResponse)<br>

### CompletionRequest {#CompletionRequest}

Field | Description
--- | ---
model_uri | **string**<br>The identifier of the model to be used for completion generation. 
completion_options | **CompletionOptions**<br>Configuration options for completion generation. 
messages[] | **Message**<br>A list of messages representing the context for the completion model. 


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
alternatives[] | **Alternative**<br>A list of generated completion alternatives. 
usage | **ContentUsage**<br>A set of statistics describing the number of content tokens used by the completion model. 
model_version | **string**<br>Model version (changes with model releases). 


