---
editable: false
---

# Key Management Service API, gRPC: AsymmetricEncryptionKeyService

Set of methods for managing asymmetric KMS keys.

| Call | Description |
| --- | --- |
| [Create](#Create) | control plane Creates an asymmetric KMS key in the specified folder. |
| [Get](#Get) | Returns the specified asymmetric KMS key. |
| [List](#List) | Returns the list of asymmetric KMS keys in the specified folder. |
| [Update](#Update) | Updates the specified asymmetric KMS key. |
| [Delete](#Delete) | Deletes the specified asymmetric KMS key. |
| [ListOperations](#ListOperations) | Lists operations for the specified asymmetric KMS key. |
| [ListAccessBindings](#ListAccessBindings) | Lists existing access bindings for the specified key. |
| [SetAccessBindings](#SetAccessBindings) | Sets access bindings for the key. |
| [UpdateAccessBindings](#UpdateAccessBindings) | Updates access bindings for the specified key. |

## Calls AsymmetricEncryptionKeyService {#calls}

## Create {#Create}

control plane Creates an asymmetric KMS key in the specified folder.

**rpc Create ([CreateAsymmetricEncryptionKeyRequest](#CreateAsymmetricEncryptionKeyRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateAsymmetricEncryptionKeyMetadata](#CreateAsymmetricEncryptionKeyMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[AsymmetricEncryptionKey](#AsymmetricEncryptionKey)<br>

### CreateAsymmetricEncryptionKeyRequest {#CreateAsymmetricEncryptionKeyRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create a asymmetric KMS key in. The maximum string length in characters is 50.
name | **string**<br>Name of the key. The maximum string length in characters is 100.
description | **string**<br>Description of the key. The maximum string length in characters is 1024.
labels | **map<string,string>**<br>Custom labels for the asymmetric KMS key as `key:value` pairs. Maximum 64 per key. For example, `"project": "mvp"` or `"source": "dictionary"`. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The maximum string length in characters for each key is 63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
encryption_algorithm | enum **AsymmetricEncryptionAlgorithm**<br>Asymmetric encryption algorithm. <ul><li>`RSA_2048_ENC_OAEP_SHA_256`: RSA-2048 encryption with OAEP padding and SHA-256</li><li>`RSA_3072_ENC_OAEP_SHA_256`: RSA-3072 encryption with OAEP padding and SHA-256</li><li>`RSA_4096_ENC_OAEP_SHA_256`: RSA-4096 encryption with OAEP padding and SHA-256</li></ul>
deletion_protection | **bool**<br>Flag that inhibits deletion of the symmetric KMS key 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateAsymmetricEncryptionKeyMetadata](#CreateAsymmetricEncryptionKeyMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[AsymmetricEncryptionKey](#AsymmetricEncryptionKey)>**<br>if operation finished successfully. 


### CreateAsymmetricEncryptionKeyMetadata {#CreateAsymmetricEncryptionKeyMetadata}

Field | Description
--- | ---
key_id | **string**<br>ID of the key being created. 


### AsymmetricEncryptionKey {#AsymmetricEncryptionKey}

Field | Description
--- | ---
id | **string**<br>ID of the key. 
folder_id | **string**<br>ID of the folder that the key belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the key was created. 
name | **string**<br>Name of the key. 
description | **string**<br>Description of the key. 
labels | **map<string,string>**<br>Custom labels for the key as `key:value` pairs. Maximum 64 per key. 
status | enum **Status**<br>Current status of the key. <ul><li>`CREATING`: The key is being created.</li><li>`ACTIVE`: The key is active and can be used for encryption and decryption or signature and verification. Can be set to INACTIVE using the [AsymmetricKeyService.Update] method.</li><li>`INACTIVE`: The key is inactive and unusable. Can be set to ACTIVE using the [AsymmetricKeyService.Update] method.</li></ul>
encryption_algorithm | enum **AsymmetricEncryptionAlgorithm**<br>Asymmetric Encryption Algorithm ID. <ul><li>`RSA_2048_ENC_OAEP_SHA_256`: RSA-2048 encryption with OAEP padding and SHA-256</li><li>`RSA_3072_ENC_OAEP_SHA_256`: RSA-3072 encryption with OAEP padding and SHA-256</li><li>`RSA_4096_ENC_OAEP_SHA_256`: RSA-4096 encryption with OAEP padding and SHA-256</li></ul>
deletion_protection | **bool**<br>Flag that inhibits deletion of the key 


## Get {#Get}

Returns the specified asymmetric KMS key. <br>To get the list of available asymmetric KMS keys, make a [SymmetricKeyService.List](./symmetric_key_service#List) request.

**rpc Get ([GetAsymmetricEncryptionKeyRequest](#GetAsymmetricEncryptionKeyRequest)) returns ([AsymmetricEncryptionKey](#AsymmetricEncryptionKey1))**

### GetAsymmetricEncryptionKeyRequest {#GetAsymmetricEncryptionKeyRequest}

Field | Description
--- | ---
key_id | **string**<br>Required. ID of the asymmetric KMS key to return. To get the ID of an asymmetric KMS key use a [AsymmetricEncryptionKeyService.List](#List) request. The maximum string length in characters is 50.


### AsymmetricEncryptionKey {#AsymmetricEncryptionKey1}

Field | Description
--- | ---
id | **string**<br>ID of the key. 
folder_id | **string**<br>ID of the folder that the key belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the key was created. 
name | **string**<br>Name of the key. 
description | **string**<br>Description of the key. 
labels | **map<string,string>**<br>Custom labels for the key as `key:value` pairs. Maximum 64 per key. 
status | enum **Status**<br>Current status of the key. <ul><li>`CREATING`: The key is being created.</li><li>`ACTIVE`: The key is active and can be used for encryption and decryption or signature and verification. Can be set to INACTIVE using the [AsymmetricKeyService.Update] method.</li><li>`INACTIVE`: The key is inactive and unusable. Can be set to ACTIVE using the [AsymmetricKeyService.Update] method.</li></ul>
encryption_algorithm | enum **AsymmetricEncryptionAlgorithm**<br>Asymmetric Encryption Algorithm ID. <ul><li>`RSA_2048_ENC_OAEP_SHA_256`: RSA-2048 encryption with OAEP padding and SHA-256</li><li>`RSA_3072_ENC_OAEP_SHA_256`: RSA-3072 encryption with OAEP padding and SHA-256</li><li>`RSA_4096_ENC_OAEP_SHA_256`: RSA-4096 encryption with OAEP padding and SHA-256</li></ul>
deletion_protection | **bool**<br>Flag that inhibits deletion of the key 


## List {#List}

Returns the list of asymmetric KMS keys in the specified folder.

**rpc List ([ListAsymmetricEncryptionKeysRequest](#ListAsymmetricEncryptionKeysRequest)) returns ([ListAsymmetricEncryptionKeysResponse](#ListAsymmetricEncryptionKeysResponse))**

### ListAsymmetricEncryptionKeysRequest {#ListAsymmetricEncryptionKeysRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list asymmetric KMS keys in. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListAsymmetricEncryptionKeysResponse.next_page_token](#ListAsymmetricEncryptionKeysResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListAsymmetricEncryptionKeysResponse.next_page_token](#ListAsymmetricEncryptionKeysResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListAsymmetricEncryptionKeysResponse {#ListAsymmetricEncryptionKeysResponse}

Field | Description
--- | ---
keys[] | **[AsymmetricEncryptionKey](#AsymmetricEncryptionKey2)**<br>List of asymmetric KMS keys in the specified folder. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is greater than the specified [ListAsymmetricEncryptionKeysRequest.page_size](#ListAsymmetricEncryptionKeysRequest), use the `next_page_token` as the value for the [ListAsymmetricEncryptionKeysRequest.page_token](#ListAsymmetricEncryptionKeysRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### AsymmetricEncryptionKey {#AsymmetricEncryptionKey2}

Field | Description
--- | ---
id | **string**<br>ID of the key. 
folder_id | **string**<br>ID of the folder that the key belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the key was created. 
name | **string**<br>Name of the key. 
description | **string**<br>Description of the key. 
labels | **map<string,string>**<br>Custom labels for the key as `key:value` pairs. Maximum 64 per key. 
status | enum **Status**<br>Current status of the key. <ul><li>`CREATING`: The key is being created.</li><li>`ACTIVE`: The key is active and can be used for encryption and decryption or signature and verification. Can be set to INACTIVE using the [AsymmetricKeyService.Update] method.</li><li>`INACTIVE`: The key is inactive and unusable. Can be set to ACTIVE using the [AsymmetricKeyService.Update] method.</li></ul>
encryption_algorithm | enum **AsymmetricEncryptionAlgorithm**<br>Asymmetric Encryption Algorithm ID. <ul><li>`RSA_2048_ENC_OAEP_SHA_256`: RSA-2048 encryption with OAEP padding and SHA-256</li><li>`RSA_3072_ENC_OAEP_SHA_256`: RSA-3072 encryption with OAEP padding and SHA-256</li><li>`RSA_4096_ENC_OAEP_SHA_256`: RSA-4096 encryption with OAEP padding and SHA-256</li></ul>
deletion_protection | **bool**<br>Flag that inhibits deletion of the key 


## Update {#Update}

Updates the specified asymmetric KMS key.

**rpc Update ([UpdateAsymmetricEncryptionKeyRequest](#UpdateAsymmetricEncryptionKeyRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateAsymmetricEncryptionKeyMetadata](#UpdateAsymmetricEncryptionKeyMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[AsymmetricEncryptionKey](#AsymmetricEncryptionKey3)<br>

### UpdateAsymmetricEncryptionKeyRequest {#UpdateAsymmetricEncryptionKeyRequest}

Field | Description
--- | ---
key_id | **string**<br>Required. ID of the asymmetric KMS key to update. To get the ID of a asymmetric KMS key use a [AsymmetricEncryptionKeyService.List](#List) request. The maximum string length in characters is 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Required. Field mask that specifies which attributes of the asymmetric KMS key are going to be updated. 
name | **string**<br>New name for the asymmetric KMS key. The maximum string length in characters is 100.
description | **string**<br>New description for the asymmetric KMS key. The maximum string length in characters is 1024.
status | **[AsymmetricEncryptionKey.Status](#AsymmetricEncryptionKey3)**<br>New status for the asymmetric KMS key. Using the [AsymmetricEncryptionKeyService.Update](#Update) method you can only set ACTIVE or INACTIVE status. 
labels | **map<string,string>**<br>Custom labels for the asymmetric KMS key as `key:value` pairs. Maximum 64 per key. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The maximum string length in characters for each key is 63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
deletion_protection | **bool**<br>Flag that inhibits deletion of the asymmetric KMS key 


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateAsymmetricEncryptionKeyMetadata](#UpdateAsymmetricEncryptionKeyMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[AsymmetricEncryptionKey](#AsymmetricEncryptionKey3)>**<br>if operation finished successfully. 


### UpdateAsymmetricEncryptionKeyMetadata {#UpdateAsymmetricEncryptionKeyMetadata}

Field | Description
--- | ---
key_id | **string**<br>ID of the key being updated. 


### AsymmetricEncryptionKey {#AsymmetricEncryptionKey3}

Field | Description
--- | ---
id | **string**<br>ID of the key. 
folder_id | **string**<br>ID of the folder that the key belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the key was created. 
name | **string**<br>Name of the key. 
description | **string**<br>Description of the key. 
labels | **map<string,string>**<br>Custom labels for the key as `key:value` pairs. Maximum 64 per key. 
status | enum **Status**<br>Current status of the key. <ul><li>`CREATING`: The key is being created.</li><li>`ACTIVE`: The key is active and can be used for encryption and decryption or signature and verification. Can be set to INACTIVE using the [AsymmetricKeyService.Update] method.</li><li>`INACTIVE`: The key is inactive and unusable. Can be set to ACTIVE using the [AsymmetricKeyService.Update] method.</li></ul>
encryption_algorithm | enum **AsymmetricEncryptionAlgorithm**<br>Asymmetric Encryption Algorithm ID. <ul><li>`RSA_2048_ENC_OAEP_SHA_256`: RSA-2048 encryption with OAEP padding and SHA-256</li><li>`RSA_3072_ENC_OAEP_SHA_256`: RSA-3072 encryption with OAEP padding and SHA-256</li><li>`RSA_4096_ENC_OAEP_SHA_256`: RSA-4096 encryption with OAEP padding and SHA-256</li></ul>
deletion_protection | **bool**<br>Flag that inhibits deletion of the key 


## Delete {#Delete}

Deletes the specified asymmetric KMS key. This action also automatically schedules the destruction of all of the key's versions in 72 hours. <br>The key and its versions appear absent in [AsymmetricEncryptionKeyService.Get](#Get) and [AsymmetricEncryptionKeyService.List](#List) requests, but can be restored within 72 hours with a request to tech support.

**rpc Delete ([DeleteAsymmetricEncryptionKeyRequest](#DeleteAsymmetricEncryptionKeyRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteAsymmetricEncryptionKeyMetadata](#DeleteAsymmetricEncryptionKeyMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[AsymmetricEncryptionKey](#AsymmetricEncryptionKey4)<br>

### DeleteAsymmetricEncryptionKeyRequest {#DeleteAsymmetricEncryptionKeyRequest}

Field | Description
--- | ---
key_id | **string**<br>Required. ID of the key to be deleted. The maximum string length in characters is 50.


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteAsymmetricEncryptionKeyMetadata](#DeleteAsymmetricEncryptionKeyMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[AsymmetricEncryptionKey](#AsymmetricEncryptionKey4)>**<br>if operation finished successfully. 


### DeleteAsymmetricEncryptionKeyMetadata {#DeleteAsymmetricEncryptionKeyMetadata}

Field | Description
--- | ---
key_id | **string**<br>ID of the key being deleted. 


### AsymmetricEncryptionKey {#AsymmetricEncryptionKey4}

Field | Description
--- | ---
id | **string**<br>ID of the key. 
folder_id | **string**<br>ID of the folder that the key belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the key was created. 
name | **string**<br>Name of the key. 
description | **string**<br>Description of the key. 
labels | **map<string,string>**<br>Custom labels for the key as `key:value` pairs. Maximum 64 per key. 
status | enum **Status**<br>Current status of the key. <ul><li>`CREATING`: The key is being created.</li><li>`ACTIVE`: The key is active and can be used for encryption and decryption or signature and verification. Can be set to INACTIVE using the [AsymmetricKeyService.Update] method.</li><li>`INACTIVE`: The key is inactive and unusable. Can be set to ACTIVE using the [AsymmetricKeyService.Update] method.</li></ul>
encryption_algorithm | enum **AsymmetricEncryptionAlgorithm**<br>Asymmetric Encryption Algorithm ID. <ul><li>`RSA_2048_ENC_OAEP_SHA_256`: RSA-2048 encryption with OAEP padding and SHA-256</li><li>`RSA_3072_ENC_OAEP_SHA_256`: RSA-3072 encryption with OAEP padding and SHA-256</li><li>`RSA_4096_ENC_OAEP_SHA_256`: RSA-4096 encryption with OAEP padding and SHA-256</li></ul>
deletion_protection | **bool**<br>Flag that inhibits deletion of the key 


## ListOperations {#ListOperations}

Lists operations for the specified asymmetric KMS key.

**rpc ListOperations ([ListAsymmetricEncryptionKeyOperationsRequest](#ListAsymmetricEncryptionKeyOperationsRequest)) returns ([ListAsymmetricEncryptionKeyOperationsResponse](#ListAsymmetricEncryptionKeyOperationsResponse))**

### ListAsymmetricEncryptionKeyOperationsRequest {#ListAsymmetricEncryptionKeyOperationsRequest}

Field | Description
--- | ---
key_id | **string**<br>Required. ID of the symmetric KMS key to get operations for. <br>To get the key ID, use a [AsymmetricKeyEncryptionService.List] request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page that should be returned. If the number of available results is larger than `page_size`, the service returns a [ListAsymmetricEncryptionKeyOperationsResponse.next_page_token](#ListAsymmetricEncryptionKeyOperationsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListAsymmetricKeyOperationsResponse.next_page_token] returned by a previous list request. The maximum string length in characters is 100.


### ListAsymmetricEncryptionKeyOperationsResponse {#ListAsymmetricEncryptionKeyOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation3)**<br>List of operations for the specified key. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListAsymmetricEncryptionKeyOperationsRequest.page_size](#ListAsymmetricEncryptionKeyOperationsRequest), use the `next_page_token` as the value for the [ListAsymmetricEncryptionKeyOperationsRequest.page_token](#ListAsymmetricEncryptionKeyOperationsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Operation {#Operation3}

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


## ListAccessBindings {#ListAccessBindings}

Lists existing access bindings for the specified key.

**rpc ListAccessBindings ([ListAccessBindingsRequest](#ListAccessBindingsRequest)) returns ([ListAccessBindingsResponse](#ListAccessBindingsResponse))**

### ListAccessBindingsRequest {#ListAccessBindingsRequest}

Field | Description
--- | ---
resource_id | **string**<br>Required. ID of the resource to list access bindings for. <br>To get the resource ID, use a corresponding List request. For example, use the [yandex.cloud.resourcemanager.v1.CloudService.List](/docs/resource-manager/api-ref/grpc/cloud_service#List) request to get the Cloud resource ID. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page that should be returned. If the number of available results is larger than `page_size`, the service returns a [ListAccessBindingsResponse.next_page_token](#ListAccessBindingsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token. Set `page_token` to the [ListAccessBindingsResponse.next_page_token](#ListAccessBindingsResponse) returned by a previous list request to get the next page of results. The maximum string length in characters is 100.


### ListAccessBindingsResponse {#ListAccessBindingsResponse}

Field | Description
--- | ---
access_bindings[] | **[AccessBinding](#AccessBinding)**<br>List of access bindings for the specified resource. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListAccessBindingsRequest.page_size](#ListAccessBindingsRequest), use the `next_page_token` as the value for the [ListAccessBindingsRequest.page_token](#ListAccessBindingsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### AccessBinding {#AccessBinding}

Field | Description
--- | ---
role_id | **string**<br>Required. ID of the `yandex.cloud.iam.v1.Role` that is assigned to the `subject`. The maximum string length in characters is 50.
subject | **[Subject](#Subject)**<br>Required. Identity for which access binding is being created. It can represent an account with a unique ID or several accounts with a system identifier. 


### Subject {#Subject}

Field | Description
--- | ---
id | **string**<br>Required. ID of the subject. <br>It can contain one of the following values: <ul><li>`allAuthenticatedUsers`: A special system identifier that represents anyone </li></ul>who is authenticated. It can be used only if the `type` is `system`. <ul><li>`allUsers`: A special system identifier that represents anyone. No authentication is required. </li></ul>For example, you don't need to specify the IAM token in an API query. <ul><li>`<cloud generated id>`: An identifier that represents a user account. </li></ul>It can be used only if the `type` is `userAccount`, `federatedUser` or `serviceAccount`. The maximum string length in characters is 50.
type | **string**<br>Required. Type of the subject. <br>It can contain one of the following values: <ul><li>`userAccount`: An account on Yandex or Yandex.Connect, added to Yandex.Cloud. </li><li>`serviceAccount`: A service account. This type represents the `yandex.cloud.iam.v1.ServiceAccount` resource. </li><li>`federatedUser`: A federated account. This type represents a user from an identity federation, like Active Directory. </li><li>`system`: System group. This type represents several accounts with a common system identifier. </li></ul><br>For more information, see [Subject to which the role is assigned](/docs/iam/concepts/access-control/#subject). The maximum string length in characters is 100.


## SetAccessBindings {#SetAccessBindings}

Sets access bindings for the key.

**rpc SetAccessBindings ([SetAccessBindingsRequest](#SetAccessBindingsRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[SetAccessBindingsMetadata](#SetAccessBindingsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### SetAccessBindingsRequest {#SetAccessBindingsRequest}

Field | Description
--- | ---
resource_id | **string**<br>Required. ID of the resource for which access bindings are being set. <br>To get the resource ID, use a corresponding List request. The maximum string length in characters is 50.
access_bindings[] | **[AccessBinding](#AccessBinding)**<br>Required. Access bindings to be set. For more information, see [Access Bindings](/docs/iam/concepts/access-control/#access-bindings). 


### AccessBinding {#AccessBinding1}

Field | Description
--- | ---
role_id | **string**<br>Required. ID of the `yandex.cloud.iam.v1.Role` that is assigned to the `subject`. The maximum string length in characters is 50.
subject | **[Subject](#Subject)**<br>Required. Identity for which access binding is being created. It can represent an account with a unique ID or several accounts with a system identifier. 


### Subject {#Subject1}

Field | Description
--- | ---
id | **string**<br>Required. ID of the subject. <br>It can contain one of the following values: <ul><li>`allAuthenticatedUsers`: A special system identifier that represents anyone </li></ul>who is authenticated. It can be used only if the `type` is `system`. <ul><li>`allUsers`: A special system identifier that represents anyone. No authentication is required. </li></ul>For example, you don't need to specify the IAM token in an API query. <ul><li>`<cloud generated id>`: An identifier that represents a user account. </li></ul>It can be used only if the `type` is `userAccount`, `federatedUser` or `serviceAccount`. The maximum string length in characters is 50.
type | **string**<br>Required. Type of the subject. <br>It can contain one of the following values: <ul><li>`userAccount`: An account on Yandex or Yandex.Connect, added to Yandex.Cloud. </li><li>`serviceAccount`: A service account. This type represents the `yandex.cloud.iam.v1.ServiceAccount` resource. </li><li>`federatedUser`: A federated account. This type represents a user from an identity federation, like Active Directory. </li><li>`system`: System group. This type represents several accounts with a common system identifier. </li></ul><br>For more information, see [Subject to which the role is assigned](/docs/iam/concepts/access-control/#subject). The maximum string length in characters is 100.


### Operation {#Operation4}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[SetAccessBindingsMetadata](#SetAccessBindingsMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### SetAccessBindingsMetadata {#SetAccessBindingsMetadata}

Field | Description
--- | ---
resource_id | **string**<br>ID of the resource for which access bindings are being set. 


## UpdateAccessBindings {#UpdateAccessBindings}

Updates access bindings for the specified key.

**rpc UpdateAccessBindings ([UpdateAccessBindingsRequest](#UpdateAccessBindingsRequest)) returns ([operation.Operation](#Operation5))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateAccessBindingsMetadata](#UpdateAccessBindingsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### UpdateAccessBindingsRequest {#UpdateAccessBindingsRequest}

Field | Description
--- | ---
resource_id | **string**<br>Required. ID of the resource for which access bindings are being updated. The maximum string length in characters is 50.
access_binding_deltas[] | **[AccessBindingDelta](#AccessBindingDelta)**<br>Required. Updates to access bindings. The number of elements must be greater than 0.


### AccessBindingDelta {#AccessBindingDelta}

Field | Description
--- | ---
action | enum **AccessBindingAction**<br>Required. The action that is being performed on an access binding. <ul><li>`ADD`: Addition of an access binding.</li><li>`REMOVE`: Removal of an access binding.</li></ul>
access_binding | **[AccessBinding](#AccessBinding)**<br>Required. Access binding. For more information, see [Access Bindings](/docs/iam/concepts/access-control/#access-bindings). 


### AccessBinding {#AccessBinding2}

Field | Description
--- | ---
role_id | **string**<br>Required. ID of the `yandex.cloud.iam.v1.Role` that is assigned to the `subject`. The maximum string length in characters is 50.
subject | **[Subject](#Subject)**<br>Required. Identity for which access binding is being created. It can represent an account with a unique ID or several accounts with a system identifier. 


### Subject {#Subject2}

Field | Description
--- | ---
id | **string**<br>Required. ID of the subject. <br>It can contain one of the following values: <ul><li>`allAuthenticatedUsers`: A special system identifier that represents anyone </li></ul>who is authenticated. It can be used only if the `type` is `system`. <ul><li>`allUsers`: A special system identifier that represents anyone. No authentication is required. </li></ul>For example, you don't need to specify the IAM token in an API query. <ul><li>`<cloud generated id>`: An identifier that represents a user account. </li></ul>It can be used only if the `type` is `userAccount`, `federatedUser` or `serviceAccount`. The maximum string length in characters is 50.
type | **string**<br>Required. Type of the subject. <br>It can contain one of the following values: <ul><li>`userAccount`: An account on Yandex or Yandex.Connect, added to Yandex.Cloud. </li><li>`serviceAccount`: A service account. This type represents the `yandex.cloud.iam.v1.ServiceAccount` resource. </li><li>`federatedUser`: A federated account. This type represents a user from an identity federation, like Active Directory. </li><li>`system`: System group. This type represents several accounts with a common system identifier. </li></ul><br>For more information, see [Subject to which the role is assigned](/docs/iam/concepts/access-control/#subject). The maximum string length in characters is 100.


### Operation {#Operation5}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateAccessBindingsMetadata](#UpdateAccessBindingsMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### UpdateAccessBindingsMetadata {#UpdateAccessBindingsMetadata}

Field | Description
--- | ---
resource_id | **string**<br>ID of the resource for which access bindings are being updated. 


