---
editable: false
sourcePath: en/_api-ref-grpc/datasphere/api-ref/grpc/app_token_service.md
---


# AppTokenService

A set of methods for managing app tokens.

| Call | Description |
| --- | --- |
| [Validate](#Validate) | Validates app token. |

## Calls AppTokenService {#calls}

## Validate {#Validate}

Validates app token.

**rpc Validate ([AppTokenValidateRequest](#AppTokenValidateRequest)) returns ([google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty))**

### AppTokenValidateRequest {#AppTokenValidateRequest}

Field | Description
--- | ---
token | **string**<br>App token to validate. 


