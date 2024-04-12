---
editable: false
sourcePath: en/_api-ref-grpc/foundation-models/text-generation/text-generation/api-ref/grpc/TokenizerService.md
---

# Foundation Models Text Generation API, gRPC: TokenizerService

Service for tokenizing input content.

| Call | Description |
| --- | --- |
| [Tokenize](#Tokenize) | RPC method for tokenizing text. |
| [TokenizeCompletion](#TokenizeCompletion) | RPC method for tokenizing content of CompletionRequest |

## Calls TokenizerService {#calls}

## Tokenize {#Tokenize}

RPC method for tokenizing text.

**rpc Tokenize ([TokenizeRequest](#TokenizeRequest)) returns ([TokenizeResponse](#TokenizeResponse))**

### TokenizeRequest {#TokenizeRequest}

Field | Description
--- | ---
model_uri | **string**<br>The identifier of the model to be used for tokenization. 
text | **string**<br>Text to be tokenized. 


### TokenizeResponse {#TokenizeResponse}

Field | Description
--- | ---
tokens[] | **Token**<br>A list of tokens obtained from tokenization. 
model_version | **string**<br>Model version (changes with model releases). 


## TokenizeCompletion {#TokenizeCompletion}

RPC method for tokenizing content of CompletionRequest

**rpc TokenizeCompletion ([CompletionRequest](#CompletionRequest)) returns ([TokenizeResponse](#TokenizeResponse))**

### CompletionRequest {#CompletionRequest}

Field | Description
--- | ---
model_uri | **string**<br>The [ID of the model](/docs/foundation-models/concepts/yandexgpt/models) to be used for completion generation. 
completion_options | **CompletionOptions**<br>Configuration options for completion generation. 
messages[] | **Message**<br>A list of messages representing the context for the completion model. 


### TokenizeResponse {#TokenizeResponse1}

Field | Description
--- | ---
tokens[] | **Token**<br>A list of tokens obtained from tokenization. 
model_version | **string**<br>Model version (changes with model releases). 


