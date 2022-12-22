---
editable: false
---

# Identity and Access Management API, gRPC: ApiKeyService

A set of methods for managing API keys.

| Call | Description |
| --- | --- |
| [List](#List) | Retrieves the list of API keys for the specified service account. |
| [Get](#Get) | Returns the specified API key. |
| [Create](#Create) | Creates an API key for the specified service account. |
| [Update](#Update) | Updates the specified API key. |
| [Delete](#Delete) | Deletes the specified API key. |
| [ListOperations](#ListOperations) | Retrieves the list of operations for the specified API key. |

## Calls ApiKeyService {#calls}

## List {#List}

Retrieves the list of API keys for the specified service account.

**rpc List ([ListApiKeysRequest](#ListApiKeysRequest)) returns ([ListApiKeysResponse](#ListApiKeysResponse))**

### ListApiKeysRequest {#ListApiKeysRequest}

Field | Description
--- | ---
service_account_id | **string**<br>ID of the service account to list API keys for. To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/service_account_service#List) request. If not specified, it defaults to the subject that made the request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListApiKeysResponse.next_page_token](#ListApiKeysResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListApiKeysResponse.next_page_token](#ListApiKeysResponse) returned by a previous list request. The maximum string length in characters is 2000.


### ListApiKeysResponse {#ListApiKeysResponse}

Field | Description
--- | ---
api_keys[] | **[ApiKey](#ApiKey)**<br>List of API keys. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListApiKeysRequest.page_size](#ListApiKeysRequest), use the `next_page_token` as the value for the [ListApiKeysRequest.page_token](#ListApiKeysRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### ApiKey {#ApiKey}

Field | Description
--- | ---
id | **string**<br>ID of the API Key. 
service_account_id | **string**<br>ID of the service account that the API key belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
description | **string**<br>Description of the API key. 0-256 characters long. 


## Get {#Get}

Returns the specified API key. <br>To get the list of available API keys, make a [List](#List) request.

**rpc Get ([GetApiKeyRequest](#GetApiKeyRequest)) returns ([ApiKey](#ApiKey1))**

### GetApiKeyRequest {#GetApiKeyRequest}

Field | Description
--- | ---
api_key_id | **string**<br>Required. ID of the API key to return. To get the API key ID, use a [ApiKeyService.List](#List) request. The maximum string length in characters is 50.


### ApiKey {#ApiKey1}

Field | Description
--- | ---
id | **string**<br>ID of the API Key. 
service_account_id | **string**<br>ID of the service account that the API key belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
description | **string**<br>Description of the API key. 0-256 characters long. 


## Create {#Create}

Creates an API key for the specified service account.

**rpc Create ([CreateApiKeyRequest](#CreateApiKeyRequest)) returns ([CreateApiKeyResponse](#CreateApiKeyResponse))**

### CreateApiKeyRequest {#CreateApiKeyRequest}

Field | Description
--- | ---
service_account_id | **string**<br>ID of the service account to create an API key for. To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/service_account_service#List) request. If not specified, it defaults to the subject that made the request. The maximum string length in characters is 50.
description | **string**<br>Description of the API key. The maximum string length in characters is 256.


### CreateApiKeyResponse {#CreateApiKeyResponse}

Field | Description
--- | ---
api_key | **[ApiKey](#ApiKey2)**<br>ApiKey resource. 
secret | **string**<br>Secret part of the API key. This secret key you may use in the requests for authentication. 


### ApiKey {#ApiKey2}

Field | Description
--- | ---
id | **string**<br>ID of the API Key. 
service_account_id | **string**<br>ID of the service account that the API key belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
description | **string**<br>Description of the API key. 0-256 characters long. 


## Update {#Update}

Updates the specified API key.

**rpc Update ([UpdateApiKeyRequest](#UpdateApiKeyRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateApiKeyMetadata](#UpdateApiKeyMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[ApiKey](#ApiKey3)<br>

### UpdateApiKeyRequest {#UpdateApiKeyRequest}

Field | Description
--- | ---
api_key_id | **string**<br>Required. ID of the ApiKey resource to update. To get the API key ID, use a [ApiKeyService.List](#List) request. The maximum string length in characters is 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the ApiKey resource are going to be updated. 
description | **string**<br>Description of the API key. The maximum string length in characters is 256.


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateApiKeyMetadata](#UpdateApiKeyMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[ApiKey](#ApiKey3)>**<br>if operation finished successfully. 


### UpdateApiKeyMetadata {#UpdateApiKeyMetadata}

Field | Description
--- | ---
api_key_id | **string**<br>ID of the ApiKey resource that is being updated. 


### ApiKey {#ApiKey3}

Field | Description
--- | ---
id | **string**<br>ID of the API Key. 
service_account_id | **string**<br>ID of the service account that the API key belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
description | **string**<br>Description of the API key. 0-256 characters long. 


## Delete {#Delete}

Deletes the specified API key.

**rpc Delete ([DeleteApiKeyRequest](#DeleteApiKeyRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteApiKeyMetadata](#DeleteApiKeyMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteApiKeyRequest {#DeleteApiKeyRequest}

Field | Description
--- | ---
api_key_id | **string**<br>Required. ID of the API key to delete. To get the API key ID, use a [ApiKeyService.List](#List) request. The maximum string length in characters is 50.


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteApiKeyMetadata](#DeleteApiKeyMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteApiKeyMetadata {#DeleteApiKeyMetadata}

Field | Description
--- | ---
api_key_id | **string**<br>ID of the API key that is being deleted. 


## ListOperations {#ListOperations}

Retrieves the list of operations for the specified API key.

**rpc ListOperations ([ListApiKeyOperationsRequest](#ListApiKeyOperationsRequest)) returns ([ListApiKeyOperationsResponse](#ListApiKeyOperationsResponse))**

### ListApiKeyOperationsRequest {#ListApiKeyOperationsRequest}

Field | Description
--- | ---
api_key_id | **string**<br>Required. ID of the key to list operations for. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListApiKeyOperationsResponse.next_page_token](#ListApiKeyOperationsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListApiKeyOperationsResponse.next_page_token](#ListApiKeyOperationsResponse) returned by a previous list request. The maximum string length in characters is 2000.


### ListApiKeyOperationsResponse {#ListApiKeyOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation2)**<br>List of operations for the specified API key. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListApiKeyOperationsRequest.page_size](#ListApiKeyOperationsRequest), use the `next_page_token` as the value for the [ListApiKeyOperationsRequest.page_token](#ListApiKeyOperationsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Operation {#Operation2}

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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**<br>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty). If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any. 


