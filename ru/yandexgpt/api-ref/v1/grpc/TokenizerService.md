---
editable: false
sourcePath: en/_api-ref-grpc/foundation-models/api-ref/v1/grpc/TokenizerService.md
---

# Foundation Models API, gRPC: TokenizerService

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
tokens[] | **[Token](#Token)**<br>A list of tokens obtained from tokenization. 
model_version | **string**<br>Model version (changes with model releases). 


### Token {#Token}

Field | Description
--- | ---
id | **int64**<br>An internal token identifier. 
text | **string**<br>The textual representation of the token. 
special | **bool**<br>Indicates whether the token is special or not. Special tokens may define the model's behavior and are not visible to users. 


## TokenizeCompletion {#TokenizeCompletion}

RPC method for tokenizing content of CompletionRequest

**rpc TokenizeCompletion ([CompletionRequest](#CompletionRequest)) returns ([TokenizeResponse](#TokenizeResponse))**

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


### TokenizeResponse {#TokenizeResponse1}

Field | Description
--- | ---
tokens[] | **[Token](#Token1)**<br>A list of tokens obtained from tokenization. 
model_version | **string**<br>Model version (changes with model releases). 


### Token {#Token1}

Field | Description
--- | ---
id | **int64**<br>An internal token identifier. 
text | **string**<br>The textual representation of the token. 
special | **bool**<br>Indicates whether the token is special or not. Special tokens may define the model's behavior and are not visible to users. 


