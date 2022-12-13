---
editable: false
---

# Identity and Access Management API, gRPC: AccessKeyService

A set of methods for managing access keys.

| Call | Description |
| --- | --- |
| [List](#List) | Retrieves the list of access keys for the specified service account. |
| [Get](#Get) | Returns the specified access key. |
| [Create](#Create) | Creates an access key for the specified service account. |
| [Update](#Update) | Updates the specified access key. |
| [Delete](#Delete) | Deletes the specified access key. |
| [ListOperations](#ListOperations) | Retrieves the list of operations for the specified access key. |

## Calls AccessKeyService {#calls}

## List {#List}

Retrieves the list of access keys for the specified service account.

**rpc List ([ListAccessKeysRequest](#ListAccessKeysRequest)) returns ([ListAccessKeysResponse](#ListAccessKeysResponse))**

### ListAccessKeysRequest {#ListAccessKeysRequest}

Field | Description
--- | ---
service_account_id | **string**<br>ID of the service account to list access keys for. To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/service_account_service#List) request. If not specified, it defaults to the subject that made the request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListAccessKeysResponse.next_page_token](#ListAccessKeysResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListAccessKeysResponse.next_page_token](#ListAccessKeysResponse) returned by a previous list request. The maximum string length in characters is 2000.


### ListAccessKeysResponse {#ListAccessKeysResponse}

Field | Description
--- | ---
access_keys[] | **[AccessKey](#AccessKey)**<br>List of access keys. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListAccessKeysRequest.page_size](#ListAccessKeysRequest), use the `next_page_token` as the value for the [ListAccessKeysRequest.page_token](#ListAccessKeysRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### AccessKey {#AccessKey}

Field | Description
--- | ---
id | **string**<br>ID of the AccessKey resource. It is used to manage secret credentials: an access key ID and a secret access key. 
service_account_id | **string**<br>ID of the service account that the access key belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
description | **string**<br>Description of the access key. 0-256 characters long. 
key_id | **string**<br>ID of the access key. The key is AWS compatible. 


## Get {#Get}

Returns the specified access key. <br>To get the list of available access keys, make a [List](#List) request.

**rpc Get ([GetAccessKeyRequest](#GetAccessKeyRequest)) returns ([AccessKey](#AccessKey1))**

### GetAccessKeyRequest {#GetAccessKeyRequest}

Field | Description
--- | ---
access_key_id | **string**<br>Required. ID of the AccessKey resource to return. To get the access key ID, use a [AccessKeyService.List](#List) request. The maximum string length in characters is 50.


### AccessKey {#AccessKey1}

Field | Description
--- | ---
id | **string**<br>ID of the AccessKey resource. It is used to manage secret credentials: an access key ID and a secret access key. 
service_account_id | **string**<br>ID of the service account that the access key belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
description | **string**<br>Description of the access key. 0-256 characters long. 
key_id | **string**<br>ID of the access key. The key is AWS compatible. 


## Create {#Create}

Creates an access key for the specified service account.

**rpc Create ([CreateAccessKeyRequest](#CreateAccessKeyRequest)) returns ([CreateAccessKeyResponse](#CreateAccessKeyResponse))**

### CreateAccessKeyRequest {#CreateAccessKeyRequest}

Field | Description
--- | ---
service_account_id | **string**<br>ID of the service account to create an access key for. To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/service_account_service#List) request. If not specified, it defaults to the subject that made the request. The maximum string length in characters is 50.
description | **string**<br>Description of the access key. The maximum string length in characters is 256.


### CreateAccessKeyResponse {#CreateAccessKeyResponse}

Field | Description
--- | ---
access_key | **[AccessKey](#AccessKey2)**<br>AccessKey resource. 
secret | **string**<br>Secret access key. The key is AWS compatible. 


### AccessKey {#AccessKey2}

Field | Description
--- | ---
id | **string**<br>ID of the AccessKey resource. It is used to manage secret credentials: an access key ID and a secret access key. 
service_account_id | **string**<br>ID of the service account that the access key belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
description | **string**<br>Description of the access key. 0-256 characters long. 
key_id | **string**<br>ID of the access key. The key is AWS compatible. 


## Update {#Update}

Updates the specified access key.

**rpc Update ([UpdateAccessKeyRequest](#UpdateAccessKeyRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateAccessKeyMetadata](#UpdateAccessKeyMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[AccessKey](#AccessKey3)<br>

### UpdateAccessKeyRequest {#UpdateAccessKeyRequest}

Field | Description
--- | ---
access_key_id | **string**<br>Required. ID of the AccessKey resource to update. To get the access key ID, use a [AccessKeyService.List](#List) request. The maximum string length in characters is 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the Accesskey resource are going to be updated. 
description | **string**<br>Description of the access key. The maximum string length in characters is 256.


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateAccessKeyMetadata](#UpdateAccessKeyMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[AccessKey](#AccessKey3)>**<br>if operation finished successfully. 


### UpdateAccessKeyMetadata {#UpdateAccessKeyMetadata}

Field | Description
--- | ---
access_key_id | **string**<br>ID of the AccessKey resource that is being updated. 


### AccessKey {#AccessKey3}

Field | Description
--- | ---
id | **string**<br>ID of the AccessKey resource. It is used to manage secret credentials: an access key ID and a secret access key. 
service_account_id | **string**<br>ID of the service account that the access key belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
description | **string**<br>Description of the access key. 0-256 characters long. 
key_id | **string**<br>ID of the access key. The key is AWS compatible. 


## Delete {#Delete}

Deletes the specified access key.

**rpc Delete ([DeleteAccessKeyRequest](#DeleteAccessKeyRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteAccessKeyMetadata](#DeleteAccessKeyMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteAccessKeyRequest {#DeleteAccessKeyRequest}

Field | Description
--- | ---
access_key_id | **string**<br>Required. ID of the access key to delete. To get the access key ID, use a [AccessKeyService.List](#List) request. The maximum string length in characters is 50.


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteAccessKeyMetadata](#DeleteAccessKeyMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteAccessKeyMetadata {#DeleteAccessKeyMetadata}

Field | Description
--- | ---
access_key_id | **string**<br>ID of the access key that is being deleted. 


## ListOperations {#ListOperations}

Retrieves the list of operations for the specified access key.

**rpc ListOperations ([ListAccessKeyOperationsRequest](#ListAccessKeyOperationsRequest)) returns ([ListAccessKeyOperationsResponse](#ListAccessKeyOperationsResponse))**

### ListAccessKeyOperationsRequest {#ListAccessKeyOperationsRequest}

Field | Description
--- | ---
access_key_id | **string**<br>Required. ID of the key to list operations for. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListAccessKeyOperationsResponse.next_page_token](#ListAccessKeyOperationsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListAccessKeyOperationsResponse.next_page_token](#ListAccessKeyOperationsResponse) returned by a previous list request. The maximum string length in characters is 2000.


### ListAccessKeyOperationsResponse {#ListAccessKeyOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation2)**<br>List of operations for the specified access key. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListAccessKeyOperationsRequest.page_size](#ListAccessKeyOperationsRequest), use the `next_page_token` as the value for the [ListAccessKeyOperationsRequest.page_token](#ListAccessKeyOperationsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


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


