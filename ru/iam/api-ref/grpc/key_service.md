---
editable: false
sourcePath: en/_api-ref-grpc/iam/api-ref/grpc/key_service.md
---

# Identity and Access Management API, gRPC: KeyService

A set of methods for managing Key resources.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified Key resource. |
| [List](#List) | Retrieves the list of Key resources for the specified service account. |
| [Create](#Create) | Creates a key pair for the specified service account. |
| [Update](#Update) | Updates the specified key pair. |
| [Delete](#Delete) | Deletes the specified key pair. |
| [ListOperations](#ListOperations) | Lists operations for the specified key. |

## Calls KeyService {#calls}

## Get {#Get}

Returns the specified Key resource. <br>To get the list of available Key resources, make a [List](#List) request.

**rpc Get ([GetKeyRequest](#GetKeyRequest)) returns ([Key](#Key))**

### GetKeyRequest {#GetKeyRequest}

Field | Description
--- | ---
key_id | **string**<br>Required. ID of the Key resource to return. To get the ID use a [KeyService.List](#List) request. The maximum string length in characters is 50.
format | enum **KeyFormat**<br>Output format of the key. <ul><li>`PEM_FILE`: Privacy-Enhanced Mail (PEM) format. Default value.</li></ul>


### Key {#Key}

Field | Description
--- | ---
id | **string**<br>ID of the Key resource. 
subject | **oneof:** `user_account_id` or `service_account_id`<br>
&nbsp;&nbsp;user_account_id | **string**<br>ID of the user account that the Key resource belongs to. 
&nbsp;&nbsp;service_account_id | **string**<br>ID of the service account that the Key resource belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
description | **string**<br>Description of the Key resource. 0-256 characters long. 
key_algorithm | enum **Algorithm**<br>An algorithm used to generate a key pair of the Key resource. <ul><li>`RSA_2048`: RSA with a 2048-bit key size. Default value.</li><li>`RSA_4096`: RSA with a 4096-bit key size.</li></ul>
public_key | **string**<br>A public key of the Key resource. 


## List {#List}

Retrieves the list of Key resources for the specified service account.

**rpc List ([ListKeysRequest](#ListKeysRequest)) returns ([ListKeysResponse](#ListKeysResponse))**

### ListKeysRequest {#ListKeysRequest}

Field | Description
--- | ---
format | enum **KeyFormat**<br>Output format of the key. <ul><li>`PEM_FILE`: Privacy-Enhanced Mail (PEM) format. Default value.</li></ul>
service_account_id | **string**<br>ID of the service account to list key pairs for. To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/service_account_service#List) request. If not specified, it defaults to the subject that made the request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListKeysResponse.next_page_token](#ListKeysResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListKeysResponse.next_page_token](#ListKeysResponse) returned by a previous list request. The maximum string length in characters is 2000.


### ListKeysResponse {#ListKeysResponse}

Field | Description
--- | ---
keys[] | **[Key](#Key1)**<br>List of Key resources. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListKeysRequest.page_size](#ListKeysRequest), use the `next_page_token` as the value for the [ListKeysRequest.page_token](#ListKeysRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Key {#Key1}

Field | Description
--- | ---
id | **string**<br>ID of the Key resource. 
subject | **oneof:** `user_account_id` or `service_account_id`<br>
&nbsp;&nbsp;user_account_id | **string**<br>ID of the user account that the Key resource belongs to. 
&nbsp;&nbsp;service_account_id | **string**<br>ID of the service account that the Key resource belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
description | **string**<br>Description of the Key resource. 0-256 characters long. 
key_algorithm | enum **Algorithm**<br>An algorithm used to generate a key pair of the Key resource. <ul><li>`RSA_2048`: RSA with a 2048-bit key size. Default value.</li><li>`RSA_4096`: RSA with a 4096-bit key size.</li></ul>
public_key | **string**<br>A public key of the Key resource. 


## Create {#Create}

Creates a key pair for the specified service account.

**rpc Create ([CreateKeyRequest](#CreateKeyRequest)) returns ([CreateKeyResponse](#CreateKeyResponse))**

### CreateKeyRequest {#CreateKeyRequest}

Field | Description
--- | ---
service_account_id | **string**<br>ID of the service account to create a key pair for. To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/service_account_service#List) request. If not specified, it defaults to the subject that made the request. The maximum string length in characters is 50.
description | **string**<br>Description of the key pair. The maximum string length in characters is 256.
format | enum **KeyFormat**<br>Output format of the key. <ul><li>`PEM_FILE`: Privacy-Enhanced Mail (PEM) format. Default value.</li></ul>
key_algorithm | **[Key.Algorithm](#Key2)**<br>An algorithm used to generate a key pair of the Key resource. 


### CreateKeyResponse {#CreateKeyResponse}

Field | Description
--- | ---
key | **[Key](#Key2)**<br>Key resource. 
private_key | **string**<br>A private key of the Key resource. This key must be stored securely. 


### Key {#Key2}

Field | Description
--- | ---
id | **string**<br>ID of the Key resource. 
subject | **oneof:** `user_account_id` or `service_account_id`<br>
&nbsp;&nbsp;user_account_id | **string**<br>ID of the user account that the Key resource belongs to. 
&nbsp;&nbsp;service_account_id | **string**<br>ID of the service account that the Key resource belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
description | **string**<br>Description of the Key resource. 0-256 characters long. 
key_algorithm | enum **Algorithm**<br>An algorithm used to generate a key pair of the Key resource. <ul><li>`RSA_2048`: RSA with a 2048-bit key size. Default value.</li><li>`RSA_4096`: RSA with a 4096-bit key size.</li></ul>
public_key | **string**<br>A public key of the Key resource. 


## Update {#Update}

Updates the specified key pair.

**rpc Update ([UpdateKeyRequest](#UpdateKeyRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateKeyMetadata](#UpdateKeyMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Key](#Key3)<br>

### UpdateKeyRequest {#UpdateKeyRequest}

Field | Description
--- | ---
key_id | **string**<br>Required. ID of the Key resource to update. To get key pair ID, use a [KeyService.List](#List) request. The maximum string length in characters is 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the Key resource are going to be updated. 
description | **string**<br>Description of the key pair. The maximum string length in characters is 256.


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateKeyMetadata](#UpdateKeyMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Key](#Key3)>**<br>if operation finished successfully. 


### UpdateKeyMetadata {#UpdateKeyMetadata}

Field | Description
--- | ---
key_id | **string**<br>ID of the Key resource that is being updated. 


### Key {#Key3}

Field | Description
--- | ---
id | **string**<br>ID of the Key resource. 
subject | **oneof:** `user_account_id` or `service_account_id`<br>
&nbsp;&nbsp;user_account_id | **string**<br>ID of the user account that the Key resource belongs to. 
&nbsp;&nbsp;service_account_id | **string**<br>ID of the service account that the Key resource belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
description | **string**<br>Description of the Key resource. 0-256 characters long. 
key_algorithm | enum **Algorithm**<br>An algorithm used to generate a key pair of the Key resource. <ul><li>`RSA_2048`: RSA with a 2048-bit key size. Default value.</li><li>`RSA_4096`: RSA with a 4096-bit key size.</li></ul>
public_key | **string**<br>A public key of the Key resource. 


## Delete {#Delete}

Deletes the specified key pair.

**rpc Delete ([DeleteKeyRequest](#DeleteKeyRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteKeyMetadata](#DeleteKeyMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteKeyRequest {#DeleteKeyRequest}

Field | Description
--- | ---
key_id | **string**<br>Required. ID of the key to delete. To get key ID use a [KeyService.List](#List) request. The maximum string length in characters is 50.


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteKeyMetadata](#DeleteKeyMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteKeyMetadata {#DeleteKeyMetadata}

Field | Description
--- | ---
key_id | **string**<br>ID of the key that is being deleted. 


## ListOperations {#ListOperations}

Lists operations for the specified key.

**rpc ListOperations ([ListKeyOperationsRequest](#ListKeyOperationsRequest)) returns ([ListKeyOperationsResponse](#ListKeyOperationsResponse))**

### ListKeyOperationsRequest {#ListKeyOperationsRequest}

Field | Description
--- | ---
key_id | **string**<br>Required. ID of the key to list operations for. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListKeyOperationsResponse.next_page_token](#ListKeyOperationsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListKeyOperationsResponse.next_page_token](#ListKeyOperationsResponse) returned by a previous list request. The maximum string length in characters is 2000.


### ListKeyOperationsResponse {#ListKeyOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation2)**<br>List of operations for the specified key. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListKeyOperationsRequest.page_size](#ListKeyOperationsRequest), use the `next_page_token` as the value for the [ListKeyOperationsRequest.page_token](#ListKeyOperationsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


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


