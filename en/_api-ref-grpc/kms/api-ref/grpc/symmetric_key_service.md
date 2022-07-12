---
editable: false
---

# SymmetricKeyService

Set of methods for managing symmetric KMS keys.

| Call | Description |
| --- | --- |
| [Create](#Create) | Creates a symmetric KMS key in the specified folder. |
| [Get](#Get) | Returns the specified symmetric KMS key. |
| [List](#List) | Returns the list of symmetric KMS keys in the specified folder. |
| [ListVersions](#ListVersions) | Returns the list of versions of the specified symmetric KMS key. |
| [Update](#Update) | Updates the specified symmetric KMS key. |
| [Delete](#Delete) | Deletes the specified symmetric KMS key. |
| [SetPrimaryVersion](#SetPrimaryVersion) | Sets the primary version for the specified key. |
| [ScheduleVersionDestruction](#ScheduleVersionDestruction) | Schedules the specified key version for destruction. |
| [CancelVersionDestruction](#CancelVersionDestruction) | Cancels previously scheduled version destruction, if the version hasn't been destroyed yet. |
| [Rotate](#Rotate) | Rotates the specified key: creates a new key version and makes it the primary version. |
| [ListOperations](#ListOperations) | Lists operations for the specified symmetric KMS key. |
| [ListAccessBindings](#ListAccessBindings) | Lists existing access bindings for the specified key. |
| [SetAccessBindings](#SetAccessBindings) | Sets access bindings for the key. |
| [UpdateAccessBindings](#UpdateAccessBindings) | Updates access bindings for the specified key. |

## Calls SymmetricKeyService {#calls}

## Create {#Create}

Creates a symmetric KMS key in the specified folder.

**rpc Create ([CreateSymmetricKeyRequest](#CreateSymmetricKeyRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateSymmetricKeyMetadata](#CreateSymmetricKeyMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[SymmetricKey](#SymmetricKey)<br>

### CreateSymmetricKeyRequest {#CreateSymmetricKeyRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create a symmetric KMS key in. The maximum string length in characters is 50.
name | **string**<br>Name of the key. The maximum string length in characters is 100.
description | **string**<br>Description of the key. The maximum string length in characters is 1024.
labels | **map<string,string>**<br>Custom labels for the symmetric KMS key as `key:value` pairs. Maximum 64 per key. For example, `"project": "mvp"` or `"source": "dictionary"`. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The maximum string length in characters for each key is 63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
default_algorithm | enum **SymmetricAlgorithm**<br>Encryption algorithm to be used with a new key version, generated with the next rotation. <ul><li>`AES_128`: AES algorithm with 128-bit keys.</li><li>`AES_192`: AES algorithm with 192-bit keys.</li><li>`AES_256`: AES algorithm with 256-bit keys.</li><li>`AES_256_HSM`: AES algorithm with 256-bit keys hosted by HSM</li></ul>
rotation_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Interval between automatic rotations. To disable automatic rotation, don't include this field in the creation request. 
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
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateSymmetricKeyMetadata](#CreateSymmetricKeyMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[SymmetricKey](#SymmetricKey)>**<br>if operation finished successfully. 


### CreateSymmetricKeyMetadata {#CreateSymmetricKeyMetadata}

Field | Description
--- | ---
key_id | **string**<br>ID of the key being created. 
primary_version_id | **string**<br>ID of the primary version of the key being created. 


### SymmetricKey {#SymmetricKey}

Field | Description
--- | ---
id | **string**<br>ID of the key. 
folder_id | **string**<br>ID of the folder that the key belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the key was created. 
name | **string**<br>Name of the key. 
description | **string**<br>Description of the key. 
labels | **map<string,string>**<br>Custom labels for the key as `key:value` pairs. Maximum 64 per key. 
status | enum **Status**<br>Current status of the key. <ul><li>`CREATING`: The key is being created.</li><li>`ACTIVE`: The key is active and can be used for encryption and decryption. Can be set to INACTIVE using the [SymmetricKeyService.Update](#Update) method.</li><li>`INACTIVE`: The key is inactive and unusable. Can be set to ACTIVE using the [SymmetricKeyService.Update](#Update) method.</li></ul>
primary_version | **[SymmetricKeyVersion](#SymmetricKeyVersion)**<br>Primary version of the key, used as the default for all encrypt/decrypt operations, when no version ID is specified. 
default_algorithm | enum **SymmetricAlgorithm**<br>Default encryption algorithm to be used with new versions of the key. <ul><li>`AES_128`: AES algorithm with 128-bit keys.</li><li>`AES_192`: AES algorithm with 192-bit keys.</li><li>`AES_256`: AES algorithm with 256-bit keys.</li><li>`AES_256_HSM`: AES algorithm with 256-bit keys hosted by HSM</li></ul>
rotated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of the last key rotation (time when the last version was created). Empty if the key does not have versions yet. 
rotation_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Time period between automatic key rotations. 
deletion_protection | **bool**<br>Flag that inhibits deletion of the key 


### SymmetricKeyVersion {#SymmetricKeyVersion}

Field | Description
--- | ---
id | **string**<br>ID of the key version. 
key_id | **string**<br>ID of the symmetric KMS key that the version belongs to. 
status | enum **Status**<br>Status of the key version. <ul><li>`ACTIVE`: The version is active and can be used for encryption and decryption.</li><li>`SCHEDULED_FOR_DESTRUCTION`: The version is scheduled for destruction, the time when it will be destroyed is specified in the [SymmetricKeyVersion.destroy_at](#SymmetricKeyVersion) field.</li><li>`DESTROYED`: The version is destroyed and cannot be recovered.</li></ul>
algorithm | enum **SymmetricAlgorithm**<br>Encryption algorithm that should be used when using the key version to encrypt plaintext. <ul><li>`AES_128`: AES algorithm with 128-bit keys.</li><li>`AES_192`: AES algorithm with 192-bit keys.</li><li>`AES_256`: AES algorithm with 256-bit keys.</li><li>`AES_256_HSM`: AES algorithm with 256-bit keys hosted by HSM</li></ul>
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the key version was created. 
primary | **bool**<br>Indication of a primary version, that is to be used by default for all cryptographic operations that don't have a key version explicitly specified. 
destroy_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the key version is going to be destroyed. Empty unless the status is `SCHEDULED_FOR_DESTRUCTION`. 
hosted_by_hsm | **bool**<br>Indication of the version that is hosted by HSM. 


## Get {#Get}

Returns the specified symmetric KMS key. <br>To get the list of available symmetric KMS keys, make a [SymmetricKeyService.List](#List) request.

**rpc Get ([GetSymmetricKeyRequest](#GetSymmetricKeyRequest)) returns ([SymmetricKey](#SymmetricKey1))**

### GetSymmetricKeyRequest {#GetSymmetricKeyRequest}

Field | Description
--- | ---
key_id | **string**<br>Required. ID of the symmetric KMS key to return. To get the ID of a symmetric KMS key use a [SymmetricKeyService.List](#List) request. The maximum string length in characters is 50.


### SymmetricKey {#SymmetricKey1}

Field | Description
--- | ---
id | **string**<br>ID of the key. 
folder_id | **string**<br>ID of the folder that the key belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the key was created. 
name | **string**<br>Name of the key. 
description | **string**<br>Description of the key. 
labels | **map<string,string>**<br>Custom labels for the key as `key:value` pairs. Maximum 64 per key. 
status | enum **Status**<br>Current status of the key. <ul><li>`CREATING`: The key is being created.</li><li>`ACTIVE`: The key is active and can be used for encryption and decryption. Can be set to INACTIVE using the [SymmetricKeyService.Update](#Update) method.</li><li>`INACTIVE`: The key is inactive and unusable. Can be set to ACTIVE using the [SymmetricKeyService.Update](#Update) method.</li></ul>
primary_version | **[SymmetricKeyVersion](#SymmetricKeyVersion1)**<br>Primary version of the key, used as the default for all encrypt/decrypt operations, when no version ID is specified. 
default_algorithm | enum **SymmetricAlgorithm**<br>Default encryption algorithm to be used with new versions of the key. <ul><li>`AES_128`: AES algorithm with 128-bit keys.</li><li>`AES_192`: AES algorithm with 192-bit keys.</li><li>`AES_256`: AES algorithm with 256-bit keys.</li><li>`AES_256_HSM`: AES algorithm with 256-bit keys hosted by HSM</li></ul>
rotated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of the last key rotation (time when the last version was created). Empty if the key does not have versions yet. 
rotation_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Time period between automatic key rotations. 
deletion_protection | **bool**<br>Flag that inhibits deletion of the key 


### SymmetricKeyVersion {#SymmetricKeyVersion1}

Field | Description
--- | ---
id | **string**<br>ID of the key version. 
key_id | **string**<br>ID of the symmetric KMS key that the version belongs to. 
status | enum **Status**<br>Status of the key version. <ul><li>`ACTIVE`: The version is active and can be used for encryption and decryption.</li><li>`SCHEDULED_FOR_DESTRUCTION`: The version is scheduled for destruction, the time when it will be destroyed is specified in the [SymmetricKeyVersion.destroy_at](#SymmetricKeyVersion1) field.</li><li>`DESTROYED`: The version is destroyed and cannot be recovered.</li></ul>
algorithm | enum **SymmetricAlgorithm**<br>Encryption algorithm that should be used when using the key version to encrypt plaintext. <ul><li>`AES_128`: AES algorithm with 128-bit keys.</li><li>`AES_192`: AES algorithm with 192-bit keys.</li><li>`AES_256`: AES algorithm with 256-bit keys.</li><li>`AES_256_HSM`: AES algorithm with 256-bit keys hosted by HSM</li></ul>
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the key version was created. 
primary | **bool**<br>Indication of a primary version, that is to be used by default for all cryptographic operations that don't have a key version explicitly specified. 
destroy_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the key version is going to be destroyed. Empty unless the status is `SCHEDULED_FOR_DESTRUCTION`. 
hosted_by_hsm | **bool**<br>Indication of the version that is hosted by HSM. 


## List {#List}

Returns the list of symmetric KMS keys in the specified folder.

**rpc List ([ListSymmetricKeysRequest](#ListSymmetricKeysRequest)) returns ([ListSymmetricKeysResponse](#ListSymmetricKeysResponse))**

### ListSymmetricKeysRequest {#ListSymmetricKeysRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list symmetric KMS keys in. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListSymmetricKeysResponse.next_page_token](#ListSymmetricKeysResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListSymmetricKeysResponse.next_page_token](#ListSymmetricKeysResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListSymmetricKeysResponse {#ListSymmetricKeysResponse}

Field | Description
--- | ---
keys[] | **[SymmetricKey](#SymmetricKey2)**<br>List of symmetric KMS keys in the specified folder. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is greater than the specified [ListSymmetricKeysRequest.page_size](#ListSymmetricKeysRequest), use the `next_page_token` as the value for the [ListSymmetricKeysRequest.page_token](#ListSymmetricKeysRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### SymmetricKey {#SymmetricKey2}

Field | Description
--- | ---
id | **string**<br>ID of the key. 
folder_id | **string**<br>ID of the folder that the key belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the key was created. 
name | **string**<br>Name of the key. 
description | **string**<br>Description of the key. 
labels | **map<string,string>**<br>Custom labels for the key as `key:value` pairs. Maximum 64 per key. 
status | enum **Status**<br>Current status of the key. <ul><li>`CREATING`: The key is being created.</li><li>`ACTIVE`: The key is active and can be used for encryption and decryption. Can be set to INACTIVE using the [SymmetricKeyService.Update](#Update) method.</li><li>`INACTIVE`: The key is inactive and unusable. Can be set to ACTIVE using the [SymmetricKeyService.Update](#Update) method.</li></ul>
primary_version | **[SymmetricKeyVersion](#SymmetricKeyVersion2)**<br>Primary version of the key, used as the default for all encrypt/decrypt operations, when no version ID is specified. 
default_algorithm | enum **SymmetricAlgorithm**<br>Default encryption algorithm to be used with new versions of the key. <ul><li>`AES_128`: AES algorithm with 128-bit keys.</li><li>`AES_192`: AES algorithm with 192-bit keys.</li><li>`AES_256`: AES algorithm with 256-bit keys.</li><li>`AES_256_HSM`: AES algorithm with 256-bit keys hosted by HSM</li></ul>
rotated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of the last key rotation (time when the last version was created). Empty if the key does not have versions yet. 
rotation_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Time period between automatic key rotations. 
deletion_protection | **bool**<br>Flag that inhibits deletion of the key 


### SymmetricKeyVersion {#SymmetricKeyVersion2}

Field | Description
--- | ---
id | **string**<br>ID of the key version. 
key_id | **string**<br>ID of the symmetric KMS key that the version belongs to. 
status | enum **Status**<br>Status of the key version. <ul><li>`ACTIVE`: The version is active and can be used for encryption and decryption.</li><li>`SCHEDULED_FOR_DESTRUCTION`: The version is scheduled for destruction, the time when it will be destroyed is specified in the [SymmetricKeyVersion.destroy_at](#SymmetricKeyVersion2) field.</li><li>`DESTROYED`: The version is destroyed and cannot be recovered.</li></ul>
algorithm | enum **SymmetricAlgorithm**<br>Encryption algorithm that should be used when using the key version to encrypt plaintext. <ul><li>`AES_128`: AES algorithm with 128-bit keys.</li><li>`AES_192`: AES algorithm with 192-bit keys.</li><li>`AES_256`: AES algorithm with 256-bit keys.</li><li>`AES_256_HSM`: AES algorithm with 256-bit keys hosted by HSM</li></ul>
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the key version was created. 
primary | **bool**<br>Indication of a primary version, that is to be used by default for all cryptographic operations that don't have a key version explicitly specified. 
destroy_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the key version is going to be destroyed. Empty unless the status is `SCHEDULED_FOR_DESTRUCTION`. 
hosted_by_hsm | **bool**<br>Indication of the version that is hosted by HSM. 


## ListVersions {#ListVersions}

Returns the list of versions of the specified symmetric KMS key.

**rpc ListVersions ([ListSymmetricKeyVersionsRequest](#ListSymmetricKeyVersionsRequest)) returns ([ListSymmetricKeyVersionsResponse](#ListSymmetricKeyVersionsResponse))**

### ListSymmetricKeyVersionsRequest {#ListSymmetricKeyVersionsRequest}

Field | Description
--- | ---
key_id | **string**<br>Required. ID of the symmetric KMS key to list versions for. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListSymmetricKeyVersionsResponse.next_page_token](#ListSymmetricKeyVersionsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListSymmetricKeyVersionsResponse.next_page_token](#ListSymmetricKeyVersionsResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListSymmetricKeyVersionsResponse {#ListSymmetricKeyVersionsResponse}

Field | Description
--- | ---
key_versions[] | **[SymmetricKeyVersion](#SymmetricKeyVersion3)**<br>List of versions for the specified symmetric KMS key. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is greater than the specified [ListSymmetricKeyVersionsRequest.page_size](#ListSymmetricKeyVersionsRequest), use the `next_page_token` as the value for the [ListSymmetricKeyVersionsRequest.page_token](#ListSymmetricKeyVersionsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### SymmetricKeyVersion {#SymmetricKeyVersion3}

Field | Description
--- | ---
id | **string**<br>ID of the key version. 
key_id | **string**<br>ID of the symmetric KMS key that the version belongs to. 
status | enum **Status**<br>Status of the key version. <ul><li>`ACTIVE`: The version is active and can be used for encryption and decryption.</li><li>`SCHEDULED_FOR_DESTRUCTION`: The version is scheduled for destruction, the time when it will be destroyed is specified in the [SymmetricKeyVersion.destroy_at](#SymmetricKeyVersion3) field.</li><li>`DESTROYED`: The version is destroyed and cannot be recovered.</li></ul>
algorithm | enum **SymmetricAlgorithm**<br>Encryption algorithm that should be used when using the key version to encrypt plaintext. <ul><li>`AES_128`: AES algorithm with 128-bit keys.</li><li>`AES_192`: AES algorithm with 192-bit keys.</li><li>`AES_256`: AES algorithm with 256-bit keys.</li><li>`AES_256_HSM`: AES algorithm with 256-bit keys hosted by HSM</li></ul>
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the key version was created. 
primary | **bool**<br>Indication of a primary version, that is to be used by default for all cryptographic operations that don't have a key version explicitly specified. 
destroy_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the key version is going to be destroyed. Empty unless the status is `SCHEDULED_FOR_DESTRUCTION`. 
hosted_by_hsm | **bool**<br>Indication of the version that is hosted by HSM. 


## Update {#Update}

Updates the specified symmetric KMS key.

**rpc Update ([UpdateSymmetricKeyRequest](#UpdateSymmetricKeyRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateSymmetricKeyMetadata](#UpdateSymmetricKeyMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[SymmetricKey](#SymmetricKey3)<br>

### UpdateSymmetricKeyRequest {#UpdateSymmetricKeyRequest}

Field | Description
--- | ---
key_id | **string**<br>Required. ID of the symmetric KMS key to update. To get the ID of a symmetric KMS key use a [SymmetricKeyService.List](#List) request. The maximum string length in characters is 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Required. Field mask that specifies which attributes of the symmetric KMS key are going to be updated. 
name | **string**<br>New name for the symmetric KMS key. The maximum string length in characters is 100.
description | **string**<br>New description for the symmetric KMS key. The maximum string length in characters is 1024.
status | **[SymmetricKey.Status](#SymmetricKey3)**<br>New status for the symmetric KMS key. Using the [SymmetricKeyService.Update](#Update) method you can only set ACTIVE or INACTIVE status. 
labels | **map<string,string>**<br>Custom labels for the symmetric KMS key as `key:value` pairs. Maximum 64 per key. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The maximum string length in characters for each key is 63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
default_algorithm | enum **SymmetricAlgorithm**<br>Default encryption algorithm to be used with new versions of the symmetric KMS key. <ul><li>`AES_128`: AES algorithm with 128-bit keys.</li><li>`AES_192`: AES algorithm with 192-bit keys.</li><li>`AES_256`: AES algorithm with 256-bit keys.</li><li>`AES_256_HSM`: AES algorithm with 256-bit keys hosted by HSM</li></ul>
rotation_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Time period between automatic symmetric KMS key rotations. 
deletion_protection | **bool**<br>Flag that inhibits deletion of the symmetric KMS key 


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateSymmetricKeyMetadata](#UpdateSymmetricKeyMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[SymmetricKey](#SymmetricKey3)>**<br>if operation finished successfully. 


### UpdateSymmetricKeyMetadata {#UpdateSymmetricKeyMetadata}

Field | Description
--- | ---
key_id | **string**<br>ID of the key being updated. 


### SymmetricKey {#SymmetricKey3}

Field | Description
--- | ---
id | **string**<br>ID of the key. 
folder_id | **string**<br>ID of the folder that the key belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the key was created. 
name | **string**<br>Name of the key. 
description | **string**<br>Description of the key. 
labels | **map<string,string>**<br>Custom labels for the key as `key:value` pairs. Maximum 64 per key. 
status | enum **Status**<br>Current status of the key. <ul><li>`CREATING`: The key is being created.</li><li>`ACTIVE`: The key is active and can be used for encryption and decryption. Can be set to INACTIVE using the [SymmetricKeyService.Update](#Update) method.</li><li>`INACTIVE`: The key is inactive and unusable. Can be set to ACTIVE using the [SymmetricKeyService.Update](#Update) method.</li></ul>
primary_version | **[SymmetricKeyVersion](#SymmetricKeyVersion4)**<br>Primary version of the key, used as the default for all encrypt/decrypt operations, when no version ID is specified. 
default_algorithm | enum **SymmetricAlgorithm**<br>Default encryption algorithm to be used with new versions of the key. <ul><li>`AES_128`: AES algorithm with 128-bit keys.</li><li>`AES_192`: AES algorithm with 192-bit keys.</li><li>`AES_256`: AES algorithm with 256-bit keys.</li><li>`AES_256_HSM`: AES algorithm with 256-bit keys hosted by HSM</li></ul>
rotated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of the last key rotation (time when the last version was created). Empty if the key does not have versions yet. 
rotation_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Time period between automatic key rotations. 
deletion_protection | **bool**<br>Flag that inhibits deletion of the key 


### SymmetricKeyVersion {#SymmetricKeyVersion4}

Field | Description
--- | ---
id | **string**<br>ID of the key version. 
key_id | **string**<br>ID of the symmetric KMS key that the version belongs to. 
status | enum **Status**<br>Status of the key version. <ul><li>`ACTIVE`: The version is active and can be used for encryption and decryption.</li><li>`SCHEDULED_FOR_DESTRUCTION`: The version is scheduled for destruction, the time when it will be destroyed is specified in the [SymmetricKeyVersion.destroy_at](#SymmetricKeyVersion4) field.</li><li>`DESTROYED`: The version is destroyed and cannot be recovered.</li></ul>
algorithm | enum **SymmetricAlgorithm**<br>Encryption algorithm that should be used when using the key version to encrypt plaintext. <ul><li>`AES_128`: AES algorithm with 128-bit keys.</li><li>`AES_192`: AES algorithm with 192-bit keys.</li><li>`AES_256`: AES algorithm with 256-bit keys.</li><li>`AES_256_HSM`: AES algorithm with 256-bit keys hosted by HSM</li></ul>
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the key version was created. 
primary | **bool**<br>Indication of a primary version, that is to be used by default for all cryptographic operations that don't have a key version explicitly specified. 
destroy_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the key version is going to be destroyed. Empty unless the status is `SCHEDULED_FOR_DESTRUCTION`. 
hosted_by_hsm | **bool**<br>Indication of the version that is hosted by HSM. 


## Delete {#Delete}

Deletes the specified symmetric KMS key. This action also automatically schedules the destruction of all of the key's versions in 72 hours. <br>The key and its versions appear absent in [SymmetricKeyService.Get](#Get) and [SymmetricKeyService.List](#List) requests, but can be restored within 72 hours with a request to tech support.

**rpc Delete ([DeleteSymmetricKeyRequest](#DeleteSymmetricKeyRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteSymmetricKeyMetadata](#DeleteSymmetricKeyMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[SymmetricKey](#SymmetricKey4)<br>

### DeleteSymmetricKeyRequest {#DeleteSymmetricKeyRequest}

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
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteSymmetricKeyMetadata](#DeleteSymmetricKeyMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[SymmetricKey](#SymmetricKey4)>**<br>if operation finished successfully. 


### DeleteSymmetricKeyMetadata {#DeleteSymmetricKeyMetadata}

Field | Description
--- | ---
key_id | **string**<br>ID of the key being deleted. 


### SymmetricKey {#SymmetricKey4}

Field | Description
--- | ---
id | **string**<br>ID of the key. 
folder_id | **string**<br>ID of the folder that the key belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the key was created. 
name | **string**<br>Name of the key. 
description | **string**<br>Description of the key. 
labels | **map<string,string>**<br>Custom labels for the key as `key:value` pairs. Maximum 64 per key. 
status | enum **Status**<br>Current status of the key. <ul><li>`CREATING`: The key is being created.</li><li>`ACTIVE`: The key is active and can be used for encryption and decryption. Can be set to INACTIVE using the [SymmetricKeyService.Update](#Update) method.</li><li>`INACTIVE`: The key is inactive and unusable. Can be set to ACTIVE using the [SymmetricKeyService.Update](#Update) method.</li></ul>
primary_version | **[SymmetricKeyVersion](#SymmetricKeyVersion5)**<br>Primary version of the key, used as the default for all encrypt/decrypt operations, when no version ID is specified. 
default_algorithm | enum **SymmetricAlgorithm**<br>Default encryption algorithm to be used with new versions of the key. <ul><li>`AES_128`: AES algorithm with 128-bit keys.</li><li>`AES_192`: AES algorithm with 192-bit keys.</li><li>`AES_256`: AES algorithm with 256-bit keys.</li><li>`AES_256_HSM`: AES algorithm with 256-bit keys hosted by HSM</li></ul>
rotated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of the last key rotation (time when the last version was created). Empty if the key does not have versions yet. 
rotation_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Time period between automatic key rotations. 
deletion_protection | **bool**<br>Flag that inhibits deletion of the key 


### SymmetricKeyVersion {#SymmetricKeyVersion5}

Field | Description
--- | ---
id | **string**<br>ID of the key version. 
key_id | **string**<br>ID of the symmetric KMS key that the version belongs to. 
status | enum **Status**<br>Status of the key version. <ul><li>`ACTIVE`: The version is active and can be used for encryption and decryption.</li><li>`SCHEDULED_FOR_DESTRUCTION`: The version is scheduled for destruction, the time when it will be destroyed is specified in the [SymmetricKeyVersion.destroy_at](#SymmetricKeyVersion5) field.</li><li>`DESTROYED`: The version is destroyed and cannot be recovered.</li></ul>
algorithm | enum **SymmetricAlgorithm**<br>Encryption algorithm that should be used when using the key version to encrypt plaintext. <ul><li>`AES_128`: AES algorithm with 128-bit keys.</li><li>`AES_192`: AES algorithm with 192-bit keys.</li><li>`AES_256`: AES algorithm with 256-bit keys.</li><li>`AES_256_HSM`: AES algorithm with 256-bit keys hosted by HSM</li></ul>
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the key version was created. 
primary | **bool**<br>Indication of a primary version, that is to be used by default for all cryptographic operations that don't have a key version explicitly specified. 
destroy_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the key version is going to be destroyed. Empty unless the status is `SCHEDULED_FOR_DESTRUCTION`. 
hosted_by_hsm | **bool**<br>Indication of the version that is hosted by HSM. 


## SetPrimaryVersion {#SetPrimaryVersion}

Sets the primary version for the specified key. The primary version is used by default for all encrypt/decrypt operations where no version ID is specified.

**rpc SetPrimaryVersion ([SetPrimarySymmetricKeyVersionRequest](#SetPrimarySymmetricKeyVersionRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[SetPrimarySymmetricKeyVersionMetadata](#SetPrimarySymmetricKeyVersionMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[SymmetricKey](#SymmetricKey5)<br>

### SetPrimarySymmetricKeyVersionRequest {#SetPrimarySymmetricKeyVersionRequest}

Field | Description
--- | ---
key_id | **string**<br>Required. ID of the key to set a primary version for. The maximum string length in characters is 50.
version_id | **string**<br>Required. ID of the version that should become primary for the specified key. The maximum string length in characters is 50.


### Operation {#Operation3}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[SetPrimarySymmetricKeyVersionMetadata](#SetPrimarySymmetricKeyVersionMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[SymmetricKey](#SymmetricKey5)>**<br>if operation finished successfully. 


### SetPrimarySymmetricKeyVersionMetadata {#SetPrimarySymmetricKeyVersionMetadata}

Field | Description
--- | ---
key_id | **string**<br>ID of the key that the primary version if being changed for. 
version_id | **string**<br>ID of the version that is being made primary for the key. 


### SymmetricKey {#SymmetricKey5}

Field | Description
--- | ---
id | **string**<br>ID of the key. 
folder_id | **string**<br>ID of the folder that the key belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the key was created. 
name | **string**<br>Name of the key. 
description | **string**<br>Description of the key. 
labels | **map<string,string>**<br>Custom labels for the key as `key:value` pairs. Maximum 64 per key. 
status | enum **Status**<br>Current status of the key. <ul><li>`CREATING`: The key is being created.</li><li>`ACTIVE`: The key is active and can be used for encryption and decryption. Can be set to INACTIVE using the [SymmetricKeyService.Update](#Update) method.</li><li>`INACTIVE`: The key is inactive and unusable. Can be set to ACTIVE using the [SymmetricKeyService.Update](#Update) method.</li></ul>
primary_version | **[SymmetricKeyVersion](#SymmetricKeyVersion6)**<br>Primary version of the key, used as the default for all encrypt/decrypt operations, when no version ID is specified. 
default_algorithm | enum **SymmetricAlgorithm**<br>Default encryption algorithm to be used with new versions of the key. <ul><li>`AES_128`: AES algorithm with 128-bit keys.</li><li>`AES_192`: AES algorithm with 192-bit keys.</li><li>`AES_256`: AES algorithm with 256-bit keys.</li><li>`AES_256_HSM`: AES algorithm with 256-bit keys hosted by HSM</li></ul>
rotated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of the last key rotation (time when the last version was created). Empty if the key does not have versions yet. 
rotation_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Time period between automatic key rotations. 
deletion_protection | **bool**<br>Flag that inhibits deletion of the key 


### SymmetricKeyVersion {#SymmetricKeyVersion6}

Field | Description
--- | ---
id | **string**<br>ID of the key version. 
key_id | **string**<br>ID of the symmetric KMS key that the version belongs to. 
status | enum **Status**<br>Status of the key version. <ul><li>`ACTIVE`: The version is active and can be used for encryption and decryption.</li><li>`SCHEDULED_FOR_DESTRUCTION`: The version is scheduled for destruction, the time when it will be destroyed is specified in the [SymmetricKeyVersion.destroy_at](#SymmetricKeyVersion6) field.</li><li>`DESTROYED`: The version is destroyed and cannot be recovered.</li></ul>
algorithm | enum **SymmetricAlgorithm**<br>Encryption algorithm that should be used when using the key version to encrypt plaintext. <ul><li>`AES_128`: AES algorithm with 128-bit keys.</li><li>`AES_192`: AES algorithm with 192-bit keys.</li><li>`AES_256`: AES algorithm with 256-bit keys.</li><li>`AES_256_HSM`: AES algorithm with 256-bit keys hosted by HSM</li></ul>
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the key version was created. 
primary | **bool**<br>Indication of a primary version, that is to be used by default for all cryptographic operations that don't have a key version explicitly specified. 
destroy_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the key version is going to be destroyed. Empty unless the status is `SCHEDULED_FOR_DESTRUCTION`. 
hosted_by_hsm | **bool**<br>Indication of the version that is hosted by HSM. 


## ScheduleVersionDestruction {#ScheduleVersionDestruction}

Schedules the specified key version for destruction. <br>Scheduled destruction can be cancelled with the [SymmetricKeyService.CancelVersionDestruction](#CancelVersionDestruction) method.

**rpc ScheduleVersionDestruction ([ScheduleSymmetricKeyVersionDestructionRequest](#ScheduleSymmetricKeyVersionDestructionRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[ScheduleSymmetricKeyVersionDestructionMetadata](#ScheduleSymmetricKeyVersionDestructionMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[SymmetricKeyVersion](#SymmetricKeyVersion7)<br>

### ScheduleSymmetricKeyVersionDestructionRequest {#ScheduleSymmetricKeyVersionDestructionRequest}

Field | Description
--- | ---
key_id | **string**<br>Required. ID of the key whose version should be scheduled for destruction. The maximum string length in characters is 50.
version_id | **string**<br>Required. ID of the version to be destroyed. The maximum string length in characters is 50.
pending_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Time interval between the version destruction request and actual destruction. Default value: 7 days. 


### Operation {#Operation4}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[ScheduleSymmetricKeyVersionDestructionMetadata](#ScheduleSymmetricKeyVersionDestructionMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[SymmetricKeyVersion](#SymmetricKeyVersion7)>**<br>if operation finished successfully. 


### ScheduleSymmetricKeyVersionDestructionMetadata {#ScheduleSymmetricKeyVersionDestructionMetadata}

Field | Description
--- | ---
key_id | **string**<br>ID of the key whose version is being scheduled for destruction. 
version_id | **string**<br>ID of the version that is being scheduled for destruction. 
destroy_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the version is scheduled to be destroyed. 


### SymmetricKeyVersion {#SymmetricKeyVersion7}

Field | Description
--- | ---
id | **string**<br>ID of the key version. 
key_id | **string**<br>ID of the symmetric KMS key that the version belongs to. 
status | enum **Status**<br>Status of the key version. <ul><li>`ACTIVE`: The version is active and can be used for encryption and decryption.</li><li>`SCHEDULED_FOR_DESTRUCTION`: The version is scheduled for destruction, the time when it will be destroyed is specified in the [SymmetricKeyVersion.destroy_at](#SymmetricKeyVersion7) field.</li><li>`DESTROYED`: The version is destroyed and cannot be recovered.</li></ul>
algorithm | enum **SymmetricAlgorithm**<br>Encryption algorithm that should be used when using the key version to encrypt plaintext. <ul><li>`AES_128`: AES algorithm with 128-bit keys.</li><li>`AES_192`: AES algorithm with 192-bit keys.</li><li>`AES_256`: AES algorithm with 256-bit keys.</li><li>`AES_256_HSM`: AES algorithm with 256-bit keys hosted by HSM</li></ul>
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the key version was created. 
primary | **bool**<br>Indication of a primary version, that is to be used by default for all cryptographic operations that don't have a key version explicitly specified. 
destroy_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the key version is going to be destroyed. Empty unless the status is `SCHEDULED_FOR_DESTRUCTION`. 
hosted_by_hsm | **bool**<br>Indication of the version that is hosted by HSM. 


## CancelVersionDestruction {#CancelVersionDestruction}

Cancels previously scheduled version destruction, if the version hasn't been destroyed yet.

**rpc CancelVersionDestruction ([CancelSymmetricKeyVersionDestructionRequest](#CancelSymmetricKeyVersionDestructionRequest)) returns ([operation.Operation](#Operation5))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CancelSymmetricKeyVersionDestructionMetadata](#CancelSymmetricKeyVersionDestructionMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[SymmetricKeyVersion](#SymmetricKeyVersion8)<br>

### CancelSymmetricKeyVersionDestructionRequest {#CancelSymmetricKeyVersionDestructionRequest}

Field | Description
--- | ---
key_id | **string**<br>Required. ID of the key to cancel a version's destruction for. The maximum string length in characters is 50.
version_id | **string**<br>Required. ID of the version whose scheduled destruction should be cancelled. The maximum string length in characters is 50.


### Operation {#Operation5}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CancelSymmetricKeyVersionDestructionMetadata](#CancelSymmetricKeyVersionDestructionMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[SymmetricKeyVersion](#SymmetricKeyVersion8)>**<br>if operation finished successfully. 


### CancelSymmetricKeyVersionDestructionMetadata {#CancelSymmetricKeyVersionDestructionMetadata}

Field | Description
--- | ---
key_id | **string**<br>ID of the key whose version's destruction is being cancelled. 
version_id | **string**<br>ID of the version whose scheduled destruction is being cancelled. 


### SymmetricKeyVersion {#SymmetricKeyVersion8}

Field | Description
--- | ---
id | **string**<br>ID of the key version. 
key_id | **string**<br>ID of the symmetric KMS key that the version belongs to. 
status | enum **Status**<br>Status of the key version. <ul><li>`ACTIVE`: The version is active and can be used for encryption and decryption.</li><li>`SCHEDULED_FOR_DESTRUCTION`: The version is scheduled for destruction, the time when it will be destroyed is specified in the [SymmetricKeyVersion.destroy_at](#SymmetricKeyVersion8) field.</li><li>`DESTROYED`: The version is destroyed and cannot be recovered.</li></ul>
algorithm | enum **SymmetricAlgorithm**<br>Encryption algorithm that should be used when using the key version to encrypt plaintext. <ul><li>`AES_128`: AES algorithm with 128-bit keys.</li><li>`AES_192`: AES algorithm with 192-bit keys.</li><li>`AES_256`: AES algorithm with 256-bit keys.</li><li>`AES_256_HSM`: AES algorithm with 256-bit keys hosted by HSM</li></ul>
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the key version was created. 
primary | **bool**<br>Indication of a primary version, that is to be used by default for all cryptographic operations that don't have a key version explicitly specified. 
destroy_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the key version is going to be destroyed. Empty unless the status is `SCHEDULED_FOR_DESTRUCTION`. 
hosted_by_hsm | **bool**<br>Indication of the version that is hosted by HSM. 


## Rotate {#Rotate}

Rotates the specified key: creates a new key version and makes it the primary version. The old version remains available for decryption of ciphertext encrypted with it.

**rpc Rotate ([RotateSymmetricKeyRequest](#RotateSymmetricKeyRequest)) returns ([operation.Operation](#Operation6))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RotateSymmetricKeyMetadata](#RotateSymmetricKeyMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[SymmetricKey](#SymmetricKey6)<br>

### RotateSymmetricKeyRequest {#RotateSymmetricKeyRequest}

Field | Description
--- | ---
key_id | **string**<br>Required. ID of the key to be rotated. The maximum string length in characters is 50.


### Operation {#Operation6}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[RotateSymmetricKeyMetadata](#RotateSymmetricKeyMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[SymmetricKey](#SymmetricKey6)>**<br>if operation finished successfully. 


### RotateSymmetricKeyMetadata {#RotateSymmetricKeyMetadata}

Field | Description
--- | ---
key_id | **string**<br>ID of the key being rotated. 
new_primary_version_id | **string**<br>ID of the version generated as a result of key rotation. 


### SymmetricKey {#SymmetricKey6}

Field | Description
--- | ---
id | **string**<br>ID of the key. 
folder_id | **string**<br>ID of the folder that the key belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the key was created. 
name | **string**<br>Name of the key. 
description | **string**<br>Description of the key. 
labels | **map<string,string>**<br>Custom labels for the key as `key:value` pairs. Maximum 64 per key. 
status | enum **Status**<br>Current status of the key. <ul><li>`CREATING`: The key is being created.</li><li>`ACTIVE`: The key is active and can be used for encryption and decryption. Can be set to INACTIVE using the [SymmetricKeyService.Update](#Update) method.</li><li>`INACTIVE`: The key is inactive and unusable. Can be set to ACTIVE using the [SymmetricKeyService.Update](#Update) method.</li></ul>
primary_version | **[SymmetricKeyVersion](#SymmetricKeyVersion9)**<br>Primary version of the key, used as the default for all encrypt/decrypt operations, when no version ID is specified. 
default_algorithm | enum **SymmetricAlgorithm**<br>Default encryption algorithm to be used with new versions of the key. <ul><li>`AES_128`: AES algorithm with 128-bit keys.</li><li>`AES_192`: AES algorithm with 192-bit keys.</li><li>`AES_256`: AES algorithm with 256-bit keys.</li><li>`AES_256_HSM`: AES algorithm with 256-bit keys hosted by HSM</li></ul>
rotated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of the last key rotation (time when the last version was created). Empty if the key does not have versions yet. 
rotation_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Time period between automatic key rotations. 
deletion_protection | **bool**<br>Flag that inhibits deletion of the key 


### SymmetricKeyVersion {#SymmetricKeyVersion9}

Field | Description
--- | ---
id | **string**<br>ID of the key version. 
key_id | **string**<br>ID of the symmetric KMS key that the version belongs to. 
status | enum **Status**<br>Status of the key version. <ul><li>`ACTIVE`: The version is active and can be used for encryption and decryption.</li><li>`SCHEDULED_FOR_DESTRUCTION`: The version is scheduled for destruction, the time when it will be destroyed is specified in the [SymmetricKeyVersion.destroy_at](#SymmetricKeyVersion9) field.</li><li>`DESTROYED`: The version is destroyed and cannot be recovered.</li></ul>
algorithm | enum **SymmetricAlgorithm**<br>Encryption algorithm that should be used when using the key version to encrypt plaintext. <ul><li>`AES_128`: AES algorithm with 128-bit keys.</li><li>`AES_192`: AES algorithm with 192-bit keys.</li><li>`AES_256`: AES algorithm with 256-bit keys.</li><li>`AES_256_HSM`: AES algorithm with 256-bit keys hosted by HSM</li></ul>
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the key version was created. 
primary | **bool**<br>Indication of a primary version, that is to be used by default for all cryptographic operations that don't have a key version explicitly specified. 
destroy_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the key version is going to be destroyed. Empty unless the status is `SCHEDULED_FOR_DESTRUCTION`. 
hosted_by_hsm | **bool**<br>Indication of the version that is hosted by HSM. 


## ListOperations {#ListOperations}

Lists operations for the specified symmetric KMS key.

**rpc ListOperations ([ListSymmetricKeyOperationsRequest](#ListSymmetricKeyOperationsRequest)) returns ([ListSymmetricKeyOperationsResponse](#ListSymmetricKeyOperationsResponse))**

### ListSymmetricKeyOperationsRequest {#ListSymmetricKeyOperationsRequest}

Field | Description
--- | ---
key_id | **string**<br>Required. ID of the symmetric KMS key to get operations for. <br>To get the key ID, use a [SymmetricKeyService.List](#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page that should be returned. If the number of available results is larger than `page_size`, the service returns a [ListSymmetricKeyOperationsResponse.next_page_token](#ListSymmetricKeyOperationsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListSymmetricKeyOperationsResponse.next_page_token](#ListSymmetricKeyOperationsResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListSymmetricKeyOperationsResponse {#ListSymmetricKeyOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation7)**<br>List of operations for the specified key. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListSymmetricKeyOperationsRequest.page_size](#ListSymmetricKeyOperationsRequest), use the `next_page_token` as the value for the [ListSymmetricKeyOperationsRequest.page_token](#ListSymmetricKeyOperationsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Operation {#Operation7}

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

**rpc SetAccessBindings ([SetAccessBindingsRequest](#SetAccessBindingsRequest)) returns ([operation.Operation](#Operation8))**

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


### Operation {#Operation8}

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

**rpc UpdateAccessBindings ([UpdateAccessBindingsRequest](#UpdateAccessBindingsRequest)) returns ([operation.Operation](#Operation9))**

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


### Operation {#Operation9}

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


