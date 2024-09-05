---
editable: false
sourcePath: en/_api-ref-grpc/iam/api-ref/grpc/federation_service.md
---

# Identity and Access Management API, gRPC: FederationService

A set of methods for managing OIDC workload identity federations.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified OIDC workload identity federation. |
| [List](#List) | Retrieves the list of OIDC workload identity federations in the specified folder. |
| [Create](#Create) | Creates an OIDC workload identity federation in the specified folder. |
| [Update](#Update) | Updates the specified OIDC workload identity federation. |
| [Delete](#Delete) | Deletes the specified OIDC workload identity federation. |

## Calls FederationService {#calls}

## Get {#Get}

Returns the specified OIDC workload identity federation. <br>To get the list of available OIDC workload identity federation, make a [List](#List) request.

**rpc Get ([GetFederationRequest](#GetFederationRequest)) returns ([Federation](#Federation))**

### GetFederationRequest {#GetFederationRequest}

Field | Description
--- | ---
federation_id | **string**<br>Required. ID of the OIDC workload identity federation to return. To get the OIDC workload identity federation ID, make a [FederationService.List](#List) request. The maximum string length in characters is 50.


### Federation {#Federation}

Field | Description
--- | ---
id | **string**<br>Id of the OIDC workload identity federation. 
name | **string**<br>Name of the OIDC workload identity federation The name is unique within the folder. 3-63 characters long. 
folder_id | **string**<br>ID of the folder that the OIDC workload identity federation belongs to. 
description | **string**<br>Description of the service account. 0-256 characters long. 
enabled | **bool**<br>True - the OIDC workload identity federation is enabled and can be used for authentication. False - the OIDC workload identity federation is disabled and cannot be used for authentication. 
audiences[] | **string**<br>List of trusted values for aud claim. 
issuer | **string**<br>URL of the external IdP server to be used for authentication. 
jwks_url | **string**<br>URL reference to trusted keys in format of JSON Web Key Set. 
labels | **map<string,string>**<br>Resource labels as `` key:value `` pairs 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 


## List {#List}

Retrieves the list of OIDC workload identity federations in the specified folder.

**rpc List ([ListFederationsRequest](#ListFederationsRequest)) returns ([ListFederationsResponse](#ListFederationsResponse))**

### ListFederationsRequest {#ListFederationsRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list OIDC workload identity federations in. To get the folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListFederationsResponse.next_page_token](#ListFederationsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100 Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListFederationsResponse.next_page_token](#ListFederationsResponse) returned by a previous list request. The maximum string length in characters is 2000.


### ListFederationsResponse {#ListFederationsResponse}

Field | Description
--- | ---
federations[] | **[Federation](#Federation1)**<br>List of OIDC workload identity federations. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListFederationsRequest.page_size](#ListFederationsRequest), use the `next_page_token` as the value for the [ListFederationsRequest.page_token](#ListFederationsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Federation {#Federation1}

Field | Description
--- | ---
id | **string**<br>Id of the OIDC workload identity federation. 
name | **string**<br>Name of the OIDC workload identity federation The name is unique within the folder. 3-63 characters long. 
folder_id | **string**<br>ID of the folder that the OIDC workload identity federation belongs to. 
description | **string**<br>Description of the service account. 0-256 characters long. 
enabled | **bool**<br>True - the OIDC workload identity federation is enabled and can be used for authentication. False - the OIDC workload identity federation is disabled and cannot be used for authentication. 
audiences[] | **string**<br>List of trusted values for aud claim. 
issuer | **string**<br>URL of the external IdP server to be used for authentication. 
jwks_url | **string**<br>URL reference to trusted keys in format of JSON Web Key Set. 
labels | **map<string,string>**<br>Resource labels as `` key:value `` pairs 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 


## Create {#Create}

Creates an OIDC workload identity federation in the specified folder.

**rpc Create ([CreateFederationRequest](#CreateFederationRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateFederationMetadata](#CreateFederationMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Federation](#Federation2)<br>

### CreateFederationRequest {#CreateFederationRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create an OIDC workload identity federation in. To get the folder ID, make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 50.
name | **string**<br>Required. Name of the OIDC workload identity federation. The name must be unique within the folder. Value must match the regular expression ` [a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the OIDC workload identity federation. The maximum string length in characters is 256.
disabled | **bool**<br>True - the OIDC workload identity federation is disabled and cannot be used for authentication. False - the OIDC workload identity federation is enabled and can be used for authentication. 
audiences[] | **string**<br>List of trusted values for aud claim. The maximum number of elements is 100. The maximum string length in characters for each value is 255.
issuer | **string**<br>Required. URL of the external IdP server to be used for authentication. The maximum string length in characters is 8000.
jwks_url | **string**<br>Required. URL reference to trusted keys in format of JSON Web Key Set. The maximum string length in characters is 8000.
labels | **map<string,string>**<br>Resource labels as `` key:value `` pairs 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateFederationMetadata](#CreateFederationMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Federation](#Federation2)>**<br>if operation finished successfully. 


### CreateFederationMetadata {#CreateFederationMetadata}

Field | Description
--- | ---
federation_id | **string**<br>ID of the OIDC workload identity federation that is being created. 


### Federation {#Federation2}

Field | Description
--- | ---
id | **string**<br>Id of the OIDC workload identity federation. 
name | **string**<br>Name of the OIDC workload identity federation The name is unique within the folder. 3-63 characters long. 
folder_id | **string**<br>ID of the folder that the OIDC workload identity federation belongs to. 
description | **string**<br>Description of the service account. 0-256 characters long. 
enabled | **bool**<br>True - the OIDC workload identity federation is enabled and can be used for authentication. False - the OIDC workload identity federation is disabled and cannot be used for authentication. 
audiences[] | **string**<br>List of trusted values for aud claim. 
issuer | **string**<br>URL of the external IdP server to be used for authentication. 
jwks_url | **string**<br>URL reference to trusted keys in format of JSON Web Key Set. 
labels | **map<string,string>**<br>Resource labels as `` key:value `` pairs 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 


## Update {#Update}

Updates the specified OIDC workload identity federation.

**rpc Update ([UpdateFederationRequest](#UpdateFederationRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateFederationMetadata](#UpdateFederationMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Federation](#Federation3)<br>

### UpdateFederationRequest {#UpdateFederationRequest}

Field | Description
--- | ---
federation_id | **string**<br>Required. ID of the OIDC workload identity federation to update. To get the OIDC workload identity federation ID, make a [FederationService.List](#List) request. The maximum string length in characters is 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the OIDC workload identity federation are going to be updated. 
name | **string**<br>Name of the OIDC workload identity federation. The name must be unique within the folder. Value must match the regular expression ` [a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the OIDC workload identity federation. The maximum string length in characters is 256.
disabled | **bool**<br>True - the OIDC workload identity federation is disabled and cannot be used for authentication. False - the OIDC workload identity federation is enabled and can be used for authentication. 
audiences[] | **string**<br>List of trusted values for aud claim. The maximum number of elements is 100. The maximum string length in characters for each value is 255.
jwks_url | **string**<br>URL reference to trusted keys in format of JSON Web Key Set. The maximum string length in characters is 8000.
labels | **map<string,string>**<br>Resource labels as `` key:value `` pairs 


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateFederationMetadata](#UpdateFederationMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Federation](#Federation3)>**<br>if operation finished successfully. 


### UpdateFederationMetadata {#UpdateFederationMetadata}

Field | Description
--- | ---
federation_id | **string**<br>ID of the OIDC workload identity federation that is being updated. 


### Federation {#Federation3}

Field | Description
--- | ---
id | **string**<br>Id of the OIDC workload identity federation. 
name | **string**<br>Name of the OIDC workload identity federation The name is unique within the folder. 3-63 characters long. 
folder_id | **string**<br>ID of the folder that the OIDC workload identity federation belongs to. 
description | **string**<br>Description of the service account. 0-256 characters long. 
enabled | **bool**<br>True - the OIDC workload identity federation is enabled and can be used for authentication. False - the OIDC workload identity federation is disabled and cannot be used for authentication. 
audiences[] | **string**<br>List of trusted values for aud claim. 
issuer | **string**<br>URL of the external IdP server to be used for authentication. 
jwks_url | **string**<br>URL reference to trusted keys in format of JSON Web Key Set. 
labels | **map<string,string>**<br>Resource labels as `` key:value `` pairs 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 


## Delete {#Delete}

Deletes the specified OIDC workload identity federation.

**rpc Delete ([DeleteFederationRequest](#DeleteFederationRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteFederationMetadata](#DeleteFederationMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteFederationRequest {#DeleteFederationRequest}

Field | Description
--- | ---
federation_id | **string**<br>Required. ID of the OIDC workload identity federation to delete. To get the OIDC workload identity federation ID, make a [FederationService.List](#List) request. The maximum string length in characters is 50.


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteFederationMetadata](#DeleteFederationMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteFederationMetadata {#DeleteFederationMetadata}

Field | Description
--- | ---
federation_id | **string**<br>ID of the OIDC workload identity federation that is being deleted. 


