---
editable: false
sourcePath: en/_api-ref-grpc/organization/api-ref/grpc/user_ssh_key_service.md
---

# Cloud Organization API, gRPC: UserSshKeyService



| Call | Description |
| --- | --- |
| [Get](#Get) |  |
| [List](#List) |  |
| [Create](#Create) |  |
| [Update](#Update) |  |
| [Delete](#Delete) |  |

## Calls UserSshKeyService {#calls}

## Get {#Get}



**rpc Get ([GetUserSshKeyRequest](#GetUserSshKeyRequest)) returns ([UserSshKey](#UserSshKey))**

### GetUserSshKeyRequest {#GetUserSshKeyRequest}

Field | Description
--- | ---
user_ssh_key_id | **string**<br>Required.  The maximum string length in characters is 50.


### UserSshKey {#UserSshKey}

Field | Description
--- | ---
id | **string**<br> 
subject_id | **string**<br> 
data | **string**<br> 
name | **string**<br> 
fingerprint | **string**<br> 
organization_id | **string**<br> 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
expires_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Used for temporary keys, if empty the key doesn't expire 


## List {#List}



**rpc List ([ListUserSshKeysRequest](#ListUserSshKeysRequest)) returns ([ListUserSshKeysResponse](#ListUserSshKeysResponse))**

### ListUserSshKeysRequest {#ListUserSshKeysRequest}

Field | Description
--- | ---
organization_id | **string**<br>Required.  The maximum string length in characters is 50.
subject_id | **string**<br> The maximum string length in characters is 50.
page_size | **int64**<br> Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br> The maximum string length in characters is 2000.


### ListUserSshKeysResponse {#ListUserSshKeysResponse}

Field | Description
--- | ---
ssh_keys[] | **[UserSshKey](#UserSshKey1)**<br> 
next_page_token | **string**<br> 


### UserSshKey {#UserSshKey1}

Field | Description
--- | ---
id | **string**<br> 
subject_id | **string**<br> 
data | **string**<br> 
name | **string**<br> 
fingerprint | **string**<br> 
organization_id | **string**<br> 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
expires_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Used for temporary keys, if empty the key doesn't expire 


## Create {#Create}



**rpc Create ([CreateUserSshKeyRequest](#CreateUserSshKeyRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateUserSshKeyMetadata](#CreateUserSshKeyMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[UserSshKey](#UserSshKey2)<br>

### CreateUserSshKeyRequest {#CreateUserSshKeyRequest}

Field | Description
--- | ---
organization_id | **string**<br>Required.  The maximum string length in characters is 50.
subject_id | **string**<br>Required.  The maximum string length in characters is 50.
name | **string**<br> The maximum string length in characters is 255.
data | **string**<br>Required.  The maximum string length in characters is 20000.
expires_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateUserSshKeyMetadata](#CreateUserSshKeyMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UserSshKey](#UserSshKey2)>**<br>if operation finished successfully. 


### CreateUserSshKeyMetadata {#CreateUserSshKeyMetadata}

Field | Description
--- | ---
user_ssh_key_id | **string**<br> 
organization_id | **string**<br> 


### UserSshKey {#UserSshKey2}

Field | Description
--- | ---
id | **string**<br> 
subject_id | **string**<br> 
data | **string**<br> 
name | **string**<br> 
fingerprint | **string**<br> 
organization_id | **string**<br> 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
expires_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Used for temporary keys, if empty the key doesn't expire 


## Update {#Update}



**rpc Update ([UpdateUserSshKeyRequest](#UpdateUserSshKeyRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateUserSshKeyMetadata](#UpdateUserSshKeyMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[UserSshKey](#UserSshKey3)<br>

### UpdateUserSshKeyRequest {#UpdateUserSshKeyRequest}

Field | Description
--- | ---
user_ssh_key_id | **string**<br>Required.  The maximum string length in characters is 50.
name | **string**<br> The maximum string length in characters is 255.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br> 
expires_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateUserSshKeyMetadata](#UpdateUserSshKeyMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UserSshKey](#UserSshKey3)>**<br>if operation finished successfully. 


### UpdateUserSshKeyMetadata {#UpdateUserSshKeyMetadata}

Field | Description
--- | ---
user_ssh_key_id | **string**<br> 


### UserSshKey {#UserSshKey3}

Field | Description
--- | ---
id | **string**<br> 
subject_id | **string**<br> 
data | **string**<br> 
name | **string**<br> 
fingerprint | **string**<br> 
organization_id | **string**<br> 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
expires_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Used for temporary keys, if empty the key doesn't expire 


## Delete {#Delete}



**rpc Delete ([DeleteUserSshKeyRequest](#DeleteUserSshKeyRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteUserSshKeyMetadata](#DeleteUserSshKeyMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteUserSshKeyRequest {#DeleteUserSshKeyRequest}

Field | Description
--- | ---
user_ssh_key_id | **string**<br>Required.  The maximum string length in characters is 50.


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteUserSshKeyMetadata](#DeleteUserSshKeyMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteUserSshKeyMetadata {#DeleteUserSshKeyMetadata}

Field | Description
--- | ---
user_ssh_key_id | **string**<br> 


