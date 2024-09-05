---
editable: false
sourcePath: en/_api-ref-grpc/iam/api-ref/grpc/federated_credential_service.md
---

# Identity and Access Management API, gRPC: FederatedCredentialService

A set of methods for managing federated credentials.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified federated credential. |
| [List](#List) | Retrieves the list of federated credentials for the specified service account. |
| [Create](#Create) | Creates a federated credential for the specified service account. |
| [Delete](#Delete) | Deletes the specified federated credential. |

## Calls FederatedCredentialService {#calls}

## Get {#Get}

Returns the specified federated credential. <br>To get the list of available federated credentials, make a [List](#List) request.

**rpc Get ([GetFederatedCredentialRequest](#GetFederatedCredentialRequest)) returns ([FederatedCredential](#FederatedCredential))**

### GetFederatedCredentialRequest {#GetFederatedCredentialRequest}

Field | Description
--- | ---
federated_credential_id | **string**<br>Required. ID of the federated credential to return. To get the federated credential ID, make a [FederatedCredentialService.List](#List) request. The maximum string length in characters is 50.


### FederatedCredential {#FederatedCredential}

Field | Description
--- | ---
id | **string**<br>Id of the federated credential. 
service_account_id | **string**<br>Id of the service account that the federated credential belongs to. 
federation_id | **string**<br>ID of the workload identity federation which is used for authentication. 
external_subject_id | **string**<br>Id of the external subject. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 


## List {#List}

Retrieves the list of federated credentials for the specified service account.

**rpc List ([ListFederatedCredentialsRequest](#ListFederatedCredentialsRequest)) returns ([ListFederatedCredentialsResponse](#ListFederatedCredentialsResponse))**

### ListFederatedCredentialsRequest {#ListFederatedCredentialsRequest}

Field | Description
--- | ---
service_account_id | **string**<br>Required. ID of the service account to list federated credentials for. To get the the service account ID make a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/service_account_service#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListFederatedCredentialsResponse.next_page_token](#ListFederatedCredentialsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListFederatedCredentialsResponse.next_page_token](#ListFederatedCredentialsResponse) returned by a previous list request. The maximum string length in characters is 2000.


### ListFederatedCredentialsResponse {#ListFederatedCredentialsResponse}

Field | Description
--- | ---
federated_credentials[] | **[FederatedCredential](#FederatedCredential1)**<br>List of federated credentials. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListFederatedCredentialsRequest.page_size](#ListFederatedCredentialsRequest), use the `next_page_token` as the value for the [ListFederatedCredentialsRequest.page_token](#ListFederatedCredentialsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### FederatedCredential {#FederatedCredential1}

Field | Description
--- | ---
id | **string**<br>Id of the federated credential. 
service_account_id | **string**<br>Id of the service account that the federated credential belongs to. 
federation_id | **string**<br>ID of the workload identity federation which is used for authentication. 
external_subject_id | **string**<br>Id of the external subject. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 


## Create {#Create}

Creates a federated credential for the specified service account.

**rpc Create ([CreateFederatedCredentialRequest](#CreateFederatedCredentialRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateFederatedCredentialMetadata](#CreateFederatedCredentialMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[FederatedCredential](#FederatedCredential2)<br>

### CreateFederatedCredentialRequest {#CreateFederatedCredentialRequest}

Field | Description
--- | ---
service_account_id | **string**<br>Required. ID of the service account to create a federated credential for. To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/service_account_service#List) request. The maximum string length in characters is 50.
federation_id | **string**<br>Required. ID of the workload identity federation that is used for authentication. The maximum string length in characters is 50.
external_subject_id | **string**<br>Required. Id of the external subject. The maximum string length in characters is 50.


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateFederatedCredentialMetadata](#CreateFederatedCredentialMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[FederatedCredential](#FederatedCredential2)>**<br>if operation finished successfully. 


### CreateFederatedCredentialMetadata {#CreateFederatedCredentialMetadata}

Field | Description
--- | ---
federated_credential_id | **string**<br>ID of the federated credential that is being created. 


### FederatedCredential {#FederatedCredential2}

Field | Description
--- | ---
id | **string**<br>Id of the federated credential. 
service_account_id | **string**<br>Id of the service account that the federated credential belongs to. 
federation_id | **string**<br>ID of the workload identity federation which is used for authentication. 
external_subject_id | **string**<br>Id of the external subject. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 


## Delete {#Delete}

Deletes the specified federated credential.

**rpc Delete ([DeleteFederatedCredentialRequest](#DeleteFederatedCredentialRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteFederatedCredentialMetadata](#DeleteFederatedCredentialMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteFederatedCredentialRequest {#DeleteFederatedCredentialRequest}

Field | Description
--- | ---
federated_credential_id | **string**<br>Required. ID of the federated credential key to delete. To get the federated credential ID, use a [FederatedCredentialService.List](#List) request. The maximum string length in characters is 50.


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteFederatedCredentialMetadata](#DeleteFederatedCredentialMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteFederatedCredentialMetadata {#DeleteFederatedCredentialMetadata}

Field | Description
--- | ---
federated_credential_id | **string**<br>ID of the federated credential that is being deleted. 


