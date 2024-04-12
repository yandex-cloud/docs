---
editable: false
sourcePath: en/_api-ref-grpc/foundation-models/text-generation/text-generation/api-ref/grpc/text_generation_service.md
---

# Foundation Models Text Generation API, gRPC: TextGenerationService

Service for text generation.

| Call | Description |
| --- | --- |
| [Completion](#Completion) | A method for generating text completions in [synchronous mode](/docs/foundation-models/concepts/#working-mode). |

## Calls TextGenerationService {#calls}

## Completion {#Completion}

A method for generating text completions in [synchronous mode](/docs/foundation-models/concepts/#working-mode).

**rpc Completion ([CompletionRequest](#CompletionRequest)) returns (stream [CompletionResponse](#CompletionResponse))**

### CompletionRequest {#CompletionRequest}

Field | Description
--- | ---
model_uri | **string**<br>The [ID of the model](/docs/foundation-models/concepts/yandexgpt/models) to be used for completion generation. 
completion_options | **CompletionOptions**<br>Configuration options for completion generation. 
messages[] | **Message**<br>A list of messages representing the context for the completion model. 


### CompletionResponse {#CompletionResponse}

Field | Description
--- | ---
alternatives[] | **Alternative**<br>A list of generated completion alternatives. 
usage | **ContentUsage**<br>A set of statistics describing the number of content tokens used by the completion model. 
model_version | **string**<br>The model version changes with each new releases. 


