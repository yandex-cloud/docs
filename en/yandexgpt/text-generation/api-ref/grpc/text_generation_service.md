---
editable: false
sourcePath: en/_api-ref-grpc/foundation-models/text-generation/text-generation/api-ref/grpc/text_generation_service.md
---

# Foundation Models Text Generation API, gRPC: TextGenerationService

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
completion_options | **CompletionOptions**<br>Configuration options for completion generation. 
messages[] | **Message**<br>A list of messages representing the context for the completion model. 


### CompletionResponse {#CompletionResponse}

Field | Description
--- | ---
alternatives[] | **Alternative**<br>A list of generated completion alternatives. 
usage | **ContentUsage**<br>A set of statistics describing the number of content tokens used by the completion model. 
model_version | **string**<br>Model version (changes with model releases). 


