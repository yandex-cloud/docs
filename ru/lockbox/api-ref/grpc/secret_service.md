---
editable: false
sourcePath: en/_api-ref-grpc/lockbox/api-ref/grpc/secret_service.md
---

# Lockbox API, gRPC: SecretService

A set of methods for managing secrets.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified secret. |
| [List](#List) | Retrieves the list of secrets in the specified folder. |
| [Create](#Create) | Creates a secret in the specified folder. |
| [Update](#Update) | Updates the specified secret. |
| [Delete](#Delete) | Deletes the specified secret. |
| [Activate](#Activate) | Activates the specified secret. |
| [Deactivate](#Deactivate) | Deactivates the specified secret. |
| [ListVersions](#ListVersions) | Retrieves the list of versions of the specified secret. |
| [AddVersion](#AddVersion) | Adds new version based on a previous one. |
| [ScheduleVersionDestruction](#ScheduleVersionDestruction) | Schedules the specified version for destruction. |
| [CancelVersionDestruction](#CancelVersionDestruction) | Cancels previously scheduled version destruction, if the version hasn't been destroyed yet. |
| [ListOperations](#ListOperations) | Lists operations for the specified secret. |
| [ListAccessBindings](#ListAccessBindings) | Lists existing access bindings for the specified secret. |
| [SetAccessBindings](#SetAccessBindings) | Sets access bindings for the secret. |
| [UpdateAccessBindings](#UpdateAccessBindings) | Updates access bindings for the secret. |

## Calls SecretService {#calls}

## Get {#Get}

Returns the specified secret. <br>To get the list of all available secrets, make a [List](#List) request. Use [PayloadService.Get](./payload_service#Get) to get the payload (confidential data themselves) of the secret.

**rpc Get ([GetSecretRequest](#GetSecretRequest)) returns ([Secret](#Secret))**

### GetSecretRequest {#GetSecretRequest}

Field | Description
--- | ---
secret_id | **string**<br>Required. ID of the secret to return. <br>To get a secret ID make a [List](#List) request. The maximum string length in characters is 50.


### Secret {#Secret}

Field | Description
--- | ---
id | **string**<br>ID of the secret. 
folder_id | **string**<br>ID of the folder that the secret belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the secret. 
description | **string**<br>Description of the secret. 
labels | **map<string,string>**<br>Custom labels for the secret as `key:value` pairs. Maximum 64 per key. 
kms_key_id | **string**<br>Optional ID of the KMS key will be used to encrypt and decrypt the secret. 
status | enum **Status**<br>Status of the secret. <ul><li>`CREATING`: The secret is being created.</li><li>`ACTIVE`: The secret is active and the secret payload can be accessed. <br>Can be set to INACTIVE using the [SecretService.Deactivate](#Deactivate) method.</li><li>`INACTIVE`: The secret is inactive and unusable. <br>Can be set to ACTIVE using the [SecretService.Deactivate](#Deactivate) method.</li></ul>
current_version | **[Version](#Version)**<br>Current (i.e. the `latest`) version of the secret. 
deletion_protection | **bool**<br>Flag that inhibits deletion of the secret. 


### Version {#Version}

Field | Description
--- | ---
id | **string**<br>ID of the version. 
secret_id | **string**<br>ID of the secret that the version belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the version was created. 
destroy_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the version is going to be destroyed. Empty unless the status is `SCHEDULED_FOR_DESTRUCTION`. 
description | **string**<br>Description of the version. 
status | enum **Status**<br>Status of the secret. <ul><li>`ACTIVE`: The version is active and the secret payload can be accessed.</li><li>`SCHEDULED_FOR_DESTRUCTION`: The version is scheduled for destruction, the time when it will be destroyed is specified in the [Version.destroy_at](#Version) field.</li><li>`DESTROYED`: The version is destroyed and cannot be recovered.</li></ul>
payload_entry_keys[] | **string**<br>Keys of the entries contained in the version payload. 


## List {#List}

Retrieves the list of secrets in the specified folder.

**rpc List ([ListSecretsRequest](#ListSecretsRequest)) returns ([ListSecretsResponse](#ListSecretsResponse))**

### ListSecretsRequest {#ListSecretsRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list secrets in. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListSecretsRequest.next_page_token](#ListSecretsRequest) that can be used to get the next page of results in subsequent list requests. Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListSecretsRequest.next_page_token](#ListSecretsRequest) returned by a previous list request. The maximum string length in characters is 100.


### ListSecretsResponse {#ListSecretsResponse}

Field | Description
--- | ---
secrets[] | **[Secret](#Secret1)**<br>List of secrets in the specified folder. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is greater than the specified [ListSecretsRequest.page_size](#ListSecretsRequest), use the `next_page_token` as the value for the [ListSecretsRequest.page_token](#ListSecretsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Secret {#Secret1}

Field | Description
--- | ---
id | **string**<br>ID of the secret. 
folder_id | **string**<br>ID of the folder that the secret belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the secret. 
description | **string**<br>Description of the secret. 
labels | **map<string,string>**<br>Custom labels for the secret as `key:value` pairs. Maximum 64 per key. 
kms_key_id | **string**<br>Optional ID of the KMS key will be used to encrypt and decrypt the secret. 
status | enum **Status**<br>Status of the secret. <ul><li>`CREATING`: The secret is being created.</li><li>`ACTIVE`: The secret is active and the secret payload can be accessed. <br>Can be set to INACTIVE using the [SecretService.Deactivate](#Deactivate) method.</li><li>`INACTIVE`: The secret is inactive and unusable. <br>Can be set to ACTIVE using the [SecretService.Deactivate](#Deactivate) method.</li></ul>
current_version | **[Version](#Version1)**<br>Current (i.e. the `latest`) version of the secret. 
deletion_protection | **bool**<br>Flag that inhibits deletion of the secret. 


### Version {#Version1}

Field | Description
--- | ---
id | **string**<br>ID of the version. 
secret_id | **string**<br>ID of the secret that the version belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the version was created. 
destroy_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the version is going to be destroyed. Empty unless the status is `SCHEDULED_FOR_DESTRUCTION`. 
description | **string**<br>Description of the version. 
status | enum **Status**<br>Status of the secret. <ul><li>`ACTIVE`: The version is active and the secret payload can be accessed.</li><li>`SCHEDULED_FOR_DESTRUCTION`: The version is scheduled for destruction, the time when it will be destroyed is specified in the [Version.destroy_at](#Version1) field.</li><li>`DESTROYED`: The version is destroyed and cannot be recovered.</li></ul>
payload_entry_keys[] | **string**<br>Keys of the entries contained in the version payload. 


## Create {#Create}

Creates a secret in the specified folder.

**rpc Create ([CreateSecretRequest](#CreateSecretRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateSecretMetadata](#CreateSecretMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Secret](#Secret2)<br>

### CreateSecretRequest {#CreateSecretRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create a secret in. The maximum string length in characters is 50.
name | **string**<br>Name of the secret. The maximum string length in characters is 100.
description | **string**<br>Description of the secret. The maximum string length in characters is 1024.
labels | **map<string,string>**<br>Custom labels for the secret as `key:value` pairs. Maximum 64 per key. For example, `"project": "mvp"` or `"source": "dictionary"`. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The maximum string length in characters for each key is 63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
kms_key_id | **string**<br>Optional ID of the KMS key will be used to encrypt and decrypt the secret. The maximum string length in characters is 50.
version_description | **string**<br>Description of the first version. The maximum string length in characters is 256.
version_payload_entries[] | **[PayloadEntryChange](#PayloadEntryChange)**<br>Payload entries added to the first version. The maximum number of elements is 32.
deletion_protection | **bool**<br>Flag that inhibits deletion of the secret. 


### PayloadEntryChange {#PayloadEntryChange}

Field | Description
--- | ---
key | **string**<br>Required. Non-confidential key of the entry. The maximum string length in characters is 256. Value must match the regular expression ` [-_./\\\\@0-9a-zA-Z]+ `.
value | **oneof:** `text_value` or `binary_value`<br>Confidential value of the entry.
&nbsp;&nbsp;text_value | **string**<br>Use the field to set a text value. The maximum string length in characters is 65536.
&nbsp;&nbsp;binary_value | **bytes**<br>Use the field to set a binary value. The maximum string length in characters is 65536.


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateSecretMetadata](#CreateSecretMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Secret](#Secret2)>**<br>if operation finished successfully. 


### CreateSecretMetadata {#CreateSecretMetadata}

Field | Description
--- | ---
secret_id | **string**<br>ID of the secret being created. 
version_id | **string**<br>ID of the current version of the secret being created. 


### Secret {#Secret2}

Field | Description
--- | ---
id | **string**<br>ID of the secret. 
folder_id | **string**<br>ID of the folder that the secret belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the secret. 
description | **string**<br>Description of the secret. 
labels | **map<string,string>**<br>Custom labels for the secret as `key:value` pairs. Maximum 64 per key. 
kms_key_id | **string**<br>Optional ID of the KMS key will be used to encrypt and decrypt the secret. 
status | enum **Status**<br>Status of the secret. <ul><li>`CREATING`: The secret is being created.</li><li>`ACTIVE`: The secret is active and the secret payload can be accessed. <br>Can be set to INACTIVE using the [SecretService.Deactivate](#Deactivate) method.</li><li>`INACTIVE`: The secret is inactive and unusable. <br>Can be set to ACTIVE using the [SecretService.Deactivate](#Deactivate) method.</li></ul>
current_version | **[Version](#Version2)**<br>Current (i.e. the `latest`) version of the secret. 
deletion_protection | **bool**<br>Flag that inhibits deletion of the secret. 


### Version {#Version2}

Field | Description
--- | ---
id | **string**<br>ID of the version. 
secret_id | **string**<br>ID of the secret that the version belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the version was created. 
destroy_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the version is going to be destroyed. Empty unless the status is `SCHEDULED_FOR_DESTRUCTION`. 
description | **string**<br>Description of the version. 
status | enum **Status**<br>Status of the secret. <ul><li>`ACTIVE`: The version is active and the secret payload can be accessed.</li><li>`SCHEDULED_FOR_DESTRUCTION`: The version is scheduled for destruction, the time when it will be destroyed is specified in the [Version.destroy_at](#Version2) field.</li><li>`DESTROYED`: The version is destroyed and cannot be recovered.</li></ul>
payload_entry_keys[] | **string**<br>Keys of the entries contained in the version payload. 


## Update {#Update}

Updates the specified secret.

**rpc Update ([UpdateSecretRequest](#UpdateSecretRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateSecretMetadata](#UpdateSecretMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Secret](#Secret3)<br>

### UpdateSecretRequest {#UpdateSecretRequest}

Field | Description
--- | ---
secret_id | **string**<br>Required. ID of the secret to update. The maximum string length in characters is 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Required. Field mask that specifies which attributes of the secret are going to be updated. 
name | **string**<br>New name of the secret. The maximum string length in characters is 100.
description | **string**<br>New description of the secret. The maximum string length in characters is 1024.
labels | **map<string,string>**<br>Custom labels for the secret as `key:value` pairs. Maximum 64 per key. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The maximum string length in characters for each key is 63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
deletion_protection | **bool**<br>Flag that inhibits deletion of the secret. 


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateSecretMetadata](#UpdateSecretMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Secret](#Secret3)>**<br>if operation finished successfully. 


### UpdateSecretMetadata {#UpdateSecretMetadata}

Field | Description
--- | ---
secret_id | **string**<br>Required. ID of the secret being updated. The maximum string length in characters is 50.


### Secret {#Secret3}

Field | Description
--- | ---
id | **string**<br>ID of the secret. 
folder_id | **string**<br>ID of the folder that the secret belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the secret. 
description | **string**<br>Description of the secret. 
labels | **map<string,string>**<br>Custom labels for the secret as `key:value` pairs. Maximum 64 per key. 
kms_key_id | **string**<br>Optional ID of the KMS key will be used to encrypt and decrypt the secret. 
status | enum **Status**<br>Status of the secret. <ul><li>`CREATING`: The secret is being created.</li><li>`ACTIVE`: The secret is active and the secret payload can be accessed. <br>Can be set to INACTIVE using the [SecretService.Deactivate](#Deactivate) method.</li><li>`INACTIVE`: The secret is inactive and unusable. <br>Can be set to ACTIVE using the [SecretService.Deactivate](#Deactivate) method.</li></ul>
current_version | **[Version](#Version3)**<br>Current (i.e. the `latest`) version of the secret. 
deletion_protection | **bool**<br>Flag that inhibits deletion of the secret. 


### Version {#Version3}

Field | Description
--- | ---
id | **string**<br>ID of the version. 
secret_id | **string**<br>ID of the secret that the version belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the version was created. 
destroy_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the version is going to be destroyed. Empty unless the status is `SCHEDULED_FOR_DESTRUCTION`. 
description | **string**<br>Description of the version. 
status | enum **Status**<br>Status of the secret. <ul><li>`ACTIVE`: The version is active and the secret payload can be accessed.</li><li>`SCHEDULED_FOR_DESTRUCTION`: The version is scheduled for destruction, the time when it will be destroyed is specified in the [Version.destroy_at](#Version3) field.</li><li>`DESTROYED`: The version is destroyed and cannot be recovered.</li></ul>
payload_entry_keys[] | **string**<br>Keys of the entries contained in the version payload. 


## Delete {#Delete}

Deletes the specified secret.

**rpc Delete ([DeleteSecretRequest](#DeleteSecretRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteSecretMetadata](#DeleteSecretMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Secret](#Secret4)<br>

### DeleteSecretRequest {#DeleteSecretRequest}

Field | Description
--- | ---
secret_id | **string**<br>Required. ID of the secret to be deleted. The maximum string length in characters is 50.


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteSecretMetadata](#DeleteSecretMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Secret](#Secret4)>**<br>if operation finished successfully. 


### DeleteSecretMetadata {#DeleteSecretMetadata}

Field | Description
--- | ---
secret_id | **string**<br>ID of the secret being deleted. 


### Secret {#Secret4}

Field | Description
--- | ---
id | **string**<br>ID of the secret. 
folder_id | **string**<br>ID of the folder that the secret belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the secret. 
description | **string**<br>Description of the secret. 
labels | **map<string,string>**<br>Custom labels for the secret as `key:value` pairs. Maximum 64 per key. 
kms_key_id | **string**<br>Optional ID of the KMS key will be used to encrypt and decrypt the secret. 
status | enum **Status**<br>Status of the secret. <ul><li>`CREATING`: The secret is being created.</li><li>`ACTIVE`: The secret is active and the secret payload can be accessed. <br>Can be set to INACTIVE using the [SecretService.Deactivate](#Deactivate) method.</li><li>`INACTIVE`: The secret is inactive and unusable. <br>Can be set to ACTIVE using the [SecretService.Deactivate](#Deactivate) method.</li></ul>
current_version | **[Version](#Version4)**<br>Current (i.e. the `latest`) version of the secret. 
deletion_protection | **bool**<br>Flag that inhibits deletion of the secret. 


### Version {#Version4}

Field | Description
--- | ---
id | **string**<br>ID of the version. 
secret_id | **string**<br>ID of the secret that the version belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the version was created. 
destroy_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the version is going to be destroyed. Empty unless the status is `SCHEDULED_FOR_DESTRUCTION`. 
description | **string**<br>Description of the version. 
status | enum **Status**<br>Status of the secret. <ul><li>`ACTIVE`: The version is active and the secret payload can be accessed.</li><li>`SCHEDULED_FOR_DESTRUCTION`: The version is scheduled for destruction, the time when it will be destroyed is specified in the [Version.destroy_at](#Version4) field.</li><li>`DESTROYED`: The version is destroyed and cannot be recovered.</li></ul>
payload_entry_keys[] | **string**<br>Keys of the entries contained in the version payload. 


## Activate {#Activate}

Activates the specified secret.

**rpc Activate ([ActivateSecretRequest](#ActivateSecretRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[ActivateSecretMetadata](#ActivateSecretMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Secret](#Secret5)<br>

### ActivateSecretRequest {#ActivateSecretRequest}

Field | Description
--- | ---
secret_id | **string**<br>Required. ID of the secret to be activated. The maximum string length in characters is 50.


### Operation {#Operation3}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[ActivateSecretMetadata](#ActivateSecretMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Secret](#Secret5)>**<br>if operation finished successfully. 


### ActivateSecretMetadata {#ActivateSecretMetadata}

Field | Description
--- | ---
secret_id | **string**<br>ID of the secret being activated. 


### Secret {#Secret5}

Field | Description
--- | ---
id | **string**<br>ID of the secret. 
folder_id | **string**<br>ID of the folder that the secret belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the secret. 
description | **string**<br>Description of the secret. 
labels | **map<string,string>**<br>Custom labels for the secret as `key:value` pairs. Maximum 64 per key. 
kms_key_id | **string**<br>Optional ID of the KMS key will be used to encrypt and decrypt the secret. 
status | enum **Status**<br>Status of the secret. <ul><li>`CREATING`: The secret is being created.</li><li>`ACTIVE`: The secret is active and the secret payload can be accessed. <br>Can be set to INACTIVE using the [SecretService.Deactivate](#Deactivate) method.</li><li>`INACTIVE`: The secret is inactive and unusable. <br>Can be set to ACTIVE using the [SecretService.Deactivate](#Deactivate) method.</li></ul>
current_version | **[Version](#Version5)**<br>Current (i.e. the `latest`) version of the secret. 
deletion_protection | **bool**<br>Flag that inhibits deletion of the secret. 


### Version {#Version5}

Field | Description
--- | ---
id | **string**<br>ID of the version. 
secret_id | **string**<br>ID of the secret that the version belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the version was created. 
destroy_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the version is going to be destroyed. Empty unless the status is `SCHEDULED_FOR_DESTRUCTION`. 
description | **string**<br>Description of the version. 
status | enum **Status**<br>Status of the secret. <ul><li>`ACTIVE`: The version is active and the secret payload can be accessed.</li><li>`SCHEDULED_FOR_DESTRUCTION`: The version is scheduled for destruction, the time when it will be destroyed is specified in the [Version.destroy_at](#Version5) field.</li><li>`DESTROYED`: The version is destroyed and cannot be recovered.</li></ul>
payload_entry_keys[] | **string**<br>Keys of the entries contained in the version payload. 


## Deactivate {#Deactivate}

Deactivates the specified secret.

**rpc Deactivate ([DeactivateSecretRequest](#DeactivateSecretRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeactivateSecretMetadata](#DeactivateSecretMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Secret](#Secret6)<br>

### DeactivateSecretRequest {#DeactivateSecretRequest}

Field | Description
--- | ---
secret_id | **string**<br>Required. ID of the secret to be deactivated. The maximum string length in characters is 50.


### Operation {#Operation4}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeactivateSecretMetadata](#DeactivateSecretMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Secret](#Secret6)>**<br>if operation finished successfully. 


### DeactivateSecretMetadata {#DeactivateSecretMetadata}

Field | Description
--- | ---
secret_id | **string**<br>ID of the secret being deactivated. 


### Secret {#Secret6}

Field | Description
--- | ---
id | **string**<br>ID of the secret. 
folder_id | **string**<br>ID of the folder that the secret belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the secret. 
description | **string**<br>Description of the secret. 
labels | **map<string,string>**<br>Custom labels for the secret as `key:value` pairs. Maximum 64 per key. 
kms_key_id | **string**<br>Optional ID of the KMS key will be used to encrypt and decrypt the secret. 
status | enum **Status**<br>Status of the secret. <ul><li>`CREATING`: The secret is being created.</li><li>`ACTIVE`: The secret is active and the secret payload can be accessed. <br>Can be set to INACTIVE using the [SecretService.Deactivate](#Deactivate) method.</li><li>`INACTIVE`: The secret is inactive and unusable. <br>Can be set to ACTIVE using the [SecretService.Deactivate](#Deactivate) method.</li></ul>
current_version | **[Version](#Version6)**<br>Current (i.e. the `latest`) version of the secret. 
deletion_protection | **bool**<br>Flag that inhibits deletion of the secret. 


### Version {#Version6}

Field | Description
--- | ---
id | **string**<br>ID of the version. 
secret_id | **string**<br>ID of the secret that the version belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the version was created. 
destroy_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the version is going to be destroyed. Empty unless the status is `SCHEDULED_FOR_DESTRUCTION`. 
description | **string**<br>Description of the version. 
status | enum **Status**<br>Status of the secret. <ul><li>`ACTIVE`: The version is active and the secret payload can be accessed.</li><li>`SCHEDULED_FOR_DESTRUCTION`: The version is scheduled for destruction, the time when it will be destroyed is specified in the [Version.destroy_at](#Version6) field.</li><li>`DESTROYED`: The version is destroyed and cannot be recovered.</li></ul>
payload_entry_keys[] | **string**<br>Keys of the entries contained in the version payload. 


## ListVersions {#ListVersions}

Retrieves the list of versions of the specified secret.

**rpc ListVersions ([ListVersionsRequest](#ListVersionsRequest)) returns ([ListVersionsResponse](#ListVersionsResponse))**

### ListVersionsRequest {#ListVersionsRequest}

Field | Description
--- | ---
secret_id | **string**<br>Required. ID of the secret to list versions for. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListVersionsRequest.next_page_token](#ListVersionsRequest) that can be used to get the next page of results in subsequent list requests. Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListVersionsRequest.next_page_token](#ListVersionsRequest) returned by a previous list request. The maximum string length in characters is 100.


### ListVersionsResponse {#ListVersionsResponse}

Field | Description
--- | ---
versions[] | **[Version](#Version7)**<br>List of versions for the specified secret. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is greater than the specified [ListVersionsRequest.page_size](#ListVersionsRequest), use the `next_page_token` as the value for the [ListVersionsRequest.page_token](#ListVersionsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Version {#Version7}

Field | Description
--- | ---
id | **string**<br>ID of the version. 
secret_id | **string**<br>ID of the secret that the version belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the version was created. 
destroy_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the version is going to be destroyed. Empty unless the status is `SCHEDULED_FOR_DESTRUCTION`. 
description | **string**<br>Description of the version. 
status | enum **Status**<br>Status of the secret. <ul><li>`ACTIVE`: The version is active and the secret payload can be accessed.</li><li>`SCHEDULED_FOR_DESTRUCTION`: The version is scheduled for destruction, the time when it will be destroyed is specified in the [Version.destroy_at](#Version7) field.</li><li>`DESTROYED`: The version is destroyed and cannot be recovered.</li></ul>
payload_entry_keys[] | **string**<br>Keys of the entries contained in the version payload. 


## AddVersion {#AddVersion}

Adds new version based on a previous one.

**rpc AddVersion ([AddVersionRequest](#AddVersionRequest)) returns ([operation.Operation](#Operation5))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[AddVersionMetadata](#AddVersionMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Version](#Version8)<br>

### AddVersionRequest {#AddVersionRequest}

Field | Description
--- | ---
secret_id | **string**<br>Required. ID of the secret. The maximum string length in characters is 50.
description | **string**<br>Description of the version. The maximum string length in characters is 1024.
payload_entries[] | **[PayloadEntryChange](#PayloadEntryChange)**<br>Describe how payload entries of the base version change in the added version. The maximum number of elements is 32.
base_version_id | **string**<br>Optional base version id. Defaults to the current version if not specified The maximum string length in characters is 50.


### PayloadEntryChange {#PayloadEntryChange1}

Field | Description
--- | ---
key | **string**<br>Required. Non-confidential key of the entry. The maximum string length in characters is 256. Value must match the regular expression ` [-_./\\\\@0-9a-zA-Z]+ `.
value | **oneof:** `text_value` or `binary_value`<br>Confidential value of the entry.
&nbsp;&nbsp;text_value | **string**<br>Use the field to set a text value. The maximum string length in characters is 65536.
&nbsp;&nbsp;binary_value | **bytes**<br>Use the field to set a binary value. The maximum string length in characters is 65536.


### Operation {#Operation5}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[AddVersionMetadata](#AddVersionMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Version](#Version8)>**<br>if operation finished successfully. 


### AddVersionMetadata {#AddVersionMetadata}

Field | Description
--- | ---
secret_id | **string**<br>ID of the secret. 
version_id | **string**<br>ID of the added version. 


### Version {#Version8}

Field | Description
--- | ---
id | **string**<br>ID of the version. 
secret_id | **string**<br>ID of the secret that the version belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the version was created. 
destroy_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the version is going to be destroyed. Empty unless the status is `SCHEDULED_FOR_DESTRUCTION`. 
description | **string**<br>Description of the version. 
status | enum **Status**<br>Status of the secret. <ul><li>`ACTIVE`: The version is active and the secret payload can be accessed.</li><li>`SCHEDULED_FOR_DESTRUCTION`: The version is scheduled for destruction, the time when it will be destroyed is specified in the [Version.destroy_at](#Version8) field.</li><li>`DESTROYED`: The version is destroyed and cannot be recovered.</li></ul>
payload_entry_keys[] | **string**<br>Keys of the entries contained in the version payload. 


## ScheduleVersionDestruction {#ScheduleVersionDestruction}

Schedules the specified version for destruction. <br>Scheduled destruction can be cancelled with the [SecretService.CancelVersionDestruction](#CancelVersionDestruction) method.

**rpc ScheduleVersionDestruction ([ScheduleVersionDestructionRequest](#ScheduleVersionDestructionRequest)) returns ([operation.Operation](#Operation6))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[ScheduleVersionDestructionMetadata](#ScheduleVersionDestructionMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Version](#Version9)<br>

### ScheduleVersionDestructionRequest {#ScheduleVersionDestructionRequest}

Field | Description
--- | ---
secret_id | **string**<br>Required. ID of the secret whose version should be scheduled for destruction. The maximum string length in characters is 50.
version_id | **string**<br>Required. ID of the version to be destroyed. The maximum string length in characters is 50.
pending_period | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Time interval between the version destruction request and actual destruction. Default value: 7 days. 


### Operation {#Operation6}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[ScheduleVersionDestructionMetadata](#ScheduleVersionDestructionMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Version](#Version9)>**<br>if operation finished successfully. 


### ScheduleVersionDestructionMetadata {#ScheduleVersionDestructionMetadata}

Field | Description
--- | ---
secret_id | **string**<br>ID of the secret whose version is being scheduled for destruction. 
version_id | **string**<br>ID of the version that is being scheduled for destruction. 
destroy_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Destruction timestamp. 


### Version {#Version9}

Field | Description
--- | ---
id | **string**<br>ID of the version. 
secret_id | **string**<br>ID of the secret that the version belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the version was created. 
destroy_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the version is going to be destroyed. Empty unless the status is `SCHEDULED_FOR_DESTRUCTION`. 
description | **string**<br>Description of the version. 
status | enum **Status**<br>Status of the secret. <ul><li>`ACTIVE`: The version is active and the secret payload can be accessed.</li><li>`SCHEDULED_FOR_DESTRUCTION`: The version is scheduled for destruction, the time when it will be destroyed is specified in the [Version.destroy_at](#Version9) field.</li><li>`DESTROYED`: The version is destroyed and cannot be recovered.</li></ul>
payload_entry_keys[] | **string**<br>Keys of the entries contained in the version payload. 


## CancelVersionDestruction {#CancelVersionDestruction}

Cancels previously scheduled version destruction, if the version hasn't been destroyed yet.

**rpc CancelVersionDestruction ([CancelVersionDestructionRequest](#CancelVersionDestructionRequest)) returns ([operation.Operation](#Operation7))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CancelVersionDestructionMetadata](#CancelVersionDestructionMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Version](#Version10)<br>

### CancelVersionDestructionRequest {#CancelVersionDestructionRequest}

Field | Description
--- | ---
secret_id | **string**<br>Required. ID of the secret to cancel a version's destruction for. The maximum string length in characters is 50.
version_id | **string**<br>Required. ID of the secret whose scheduled destruction should be cancelled. The maximum string length in characters is 50.


### Operation {#Operation7}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CancelVersionDestructionMetadata](#CancelVersionDestructionMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Version](#Version10)>**<br>if operation finished successfully. 


### CancelVersionDestructionMetadata {#CancelVersionDestructionMetadata}

Field | Description
--- | ---
secret_id | **string**<br>ID of the secret whose version's destruction is being cancelled. 
version_id | **string**<br>ID of the version whose scheduled destruction is being cancelled. 


### Version {#Version10}

Field | Description
--- | ---
id | **string**<br>ID of the version. 
secret_id | **string**<br>ID of the secret that the version belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the version was created. 
destroy_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when the version is going to be destroyed. Empty unless the status is `SCHEDULED_FOR_DESTRUCTION`. 
description | **string**<br>Description of the version. 
status | enum **Status**<br>Status of the secret. <ul><li>`ACTIVE`: The version is active and the secret payload can be accessed.</li><li>`SCHEDULED_FOR_DESTRUCTION`: The version is scheduled for destruction, the time when it will be destroyed is specified in the [Version.destroy_at](#Version10) field.</li><li>`DESTROYED`: The version is destroyed and cannot be recovered.</li></ul>
payload_entry_keys[] | **string**<br>Keys of the entries contained in the version payload. 


## ListOperations {#ListOperations}

Lists operations for the specified secret.

**rpc ListOperations ([ListSecretOperationsRequest](#ListSecretOperationsRequest)) returns ([ListSecretOperationsResponse](#ListSecretOperationsResponse))**

### ListSecretOperationsRequest {#ListSecretOperationsRequest}

Field | Description
--- | ---
secret_id | **string**<br>Required. ID of the secret to get operations for. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page that should be returned. If the number of available results is larger than `page_size`, the service returns a [ListSecretOperationsRequest.next_page_token](#ListSecretOperationsRequest) that can be used to get the next page of results in subsequent list requests. Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListSecretOperationsRequest.next_page_token](#ListSecretOperationsRequest) returned by a previous list request. The maximum string length in characters is 100.


### ListSecretOperationsResponse {#ListSecretOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation8)**<br>List of operations for the specified secret. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListSecretOperationsResponse.page_size](#ListSecretOperationsResponse), use the `next_page_token` as the value for the [ListSecretOperationsResponse.page_token](#ListSecretOperationsResponse) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Operation {#Operation8}

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

Lists existing access bindings for the specified secret.

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

Sets access bindings for the secret.

**rpc SetAccessBindings ([SetAccessBindingsRequest](#SetAccessBindingsRequest)) returns ([operation.Operation](#Operation9))**

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


### Operation {#Operation9}

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

Updates access bindings for the secret.

**rpc UpdateAccessBindings ([UpdateAccessBindingsRequest](#UpdateAccessBindingsRequest)) returns ([operation.Operation](#Operation10))**

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


### Operation {#Operation10}

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


