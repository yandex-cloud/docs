---
editable: false
sourcePath: en/_api-ref-grpc/yandexgpt/api-ref/grpc/TokenizerService.md
---

# YandexGPT API, gRPC: TokenizerService

Service for tokenizing input text.

| Call | Description |
| --- | --- |
| [Tokenize](#Tokenize) | RPC method for tokenizing input text. |

## Calls TokenizerService {#calls}

## Tokenize {#Tokenize}

RPC method for tokenizing input text.

**rpc Tokenize ([TokenizeRequest](#TokenizeRequest)) returns ([TokenizeResponse](#TokenizeResponse))**

### TokenizeRequest {#TokenizeRequest}

Field | Description
--- | ---
model | **string**<br>The name or identifier of the model to be used for tokenization. Possible values for now: `general`, `general:embedding`. The maximum string length in characters is 50.
text | **string**<br>The input text to tokenize. 


### TokenizeResponse {#TokenizeResponse}

Field | Description
--- | ---
tokens[] | **[Token](#Token)**<br>A list of tokens obtained from tokenization. 


### Token {#Token}

Field | Description
--- | ---
id | **int64**<br>An internal token identifier. 
text | **string**<br>The textual representation of the token. 
special | **bool**<br>Indicates whether the token is special or not. Special tokens define the model's behavior and are not visible to users. 


