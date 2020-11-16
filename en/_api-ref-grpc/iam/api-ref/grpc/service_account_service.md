---
editable: false
---

# ServiceAccountService

A set of methods for managing ServiceAccount resources.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified ServiceAccount resource. |
| [List](#List) | Retrieves the list of ServiceAccount resources in the specified folder. |
| [Create](#Create) | Creates a service account in the specified folder. |
| [Update](#Update) | Updates the specified service account. |
| [Delete](#Delete) | Deletes the specified service account. |
| [ListAccessBindings](#ListAccessBindings) | access Lists access bindings for the specified service account. |
| [SetAccessBindings](#SetAccessBindings) | Sets access bindings for the service account. |
| [UpdateAccessBindings](#UpdateAccessBindings) | Updates access bindings for the specified service account. |
| [ListOperations](#ListOperations) | Lists operations for the specified service account. |

## Calls ServiceAccountService {#calls}

## Get {#Get}

Returns the specified ServiceAccount resource. <br>To get the list of available ServiceAccount resources, make a [List](#List) request.

**rpc Get ([GetServiceAccountRequest](#GetServiceAccountRequest)) returns ([ServiceAccount](#ServiceAccount))**

### GetServiceAccountRequest {#GetServiceAccountRequest}

Field | Description
--- | ---
service_account_id | **string**<br>Required. ID of the ServiceAccount resource to return. To get the service account ID, use a [ServiceAccountService.List](#List) request. The maximum string length in characters is 50.


### ServiceAccount {#ServiceAccount}

Field | Description
--- | ---
id | **string**<br>ID of the service account. 
folder_id | **string**<br>ID of the folder that the service account belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the service account. The name is unique within the cloud. 3-63 characters long. 
description | **string**<br>Description of the service account. 0-256 characters long. 


## List {#List}

Retrieves the list of ServiceAccount resources in the specified folder.

**rpc List ([ListServiceAccountsRequest](#ListServiceAccountsRequest)) returns ([ListServiceAccountsResponse](#ListServiceAccountsResponse))**

### ListServiceAccountsRequest {#ListServiceAccountsRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list service accounts in. To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/grpc/folder_service#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListServiceAccountsResponse.next_page_token](#ListServiceAccountsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100 The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListServiceAccountsResponse.next_page_token](#ListServiceAccountsResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br><ol><li>The field name. Currently you can use filtering only on the [ServiceAccount.name](#ServiceAccount1) field. </li><li>An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. </li><li>The value. Must be 3-63 characters long and match the regular expression `^[a-z][-a-z0-9]{1,61}[a-z0-9]$`.</li></ol> The maximum string length in characters is 1000.


### ListServiceAccountsResponse {#ListServiceAccountsResponse}

Field | Description
--- | ---
service_accounts[] | **[ServiceAccount](#ServiceAccount1)**<br>List of ServiceAccount resources. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListServiceAccountsRequest.page_size](#ListServiceAccountsRequest), use the `next_page_token` as the value for the [ListServiceAccountsRequest.page_token](#ListServiceAccountsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### ServiceAccount {#ServiceAccount1}

Field | Description
--- | ---
id | **string**<br>ID of the service account. 
folder_id | **string**<br>ID of the folder that the service account belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the service account. The name is unique within the cloud. 3-63 characters long. 
description | **string**<br>Description of the service account. 0-256 characters long. 


## Create {#Create}

Creates a service account in the specified folder.

**rpc Create ([CreateServiceAccountRequest](#CreateServiceAccountRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateServiceAccountMetadata](#CreateServiceAccountMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[ServiceAccount](#ServiceAccount2)<br>

### CreateServiceAccountRequest {#CreateServiceAccountRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create a service account in. To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/grpc/folder_service#List) request. The maximum string length in characters is 50.
name | **string**<br>Required. Name of the service account. The name must be unique within the cloud. Value must match the regular expression ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Description of the service account. The maximum string length in characters is 256.


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateServiceAccountMetadata](#CreateServiceAccountMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[ServiceAccount](#ServiceAccount2)>**<br>if operation finished successfully. 


### CreateServiceAccountMetadata {#CreateServiceAccountMetadata}

Field | Description
--- | ---
service_account_id | **string**<br>ID of the service account that is being created. 


### ServiceAccount {#ServiceAccount2}

Field | Description
--- | ---
id | **string**<br>ID of the service account. 
folder_id | **string**<br>ID of the folder that the service account belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the service account. The name is unique within the cloud. 3-63 characters long. 
description | **string**<br>Description of the service account. 0-256 characters long. 


## Update {#Update}

Updates the specified service account.

**rpc Update ([UpdateServiceAccountRequest](#UpdateServiceAccountRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateServiceAccountMetadata](#UpdateServiceAccountMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[ServiceAccount](#ServiceAccount3)<br>

### UpdateServiceAccountRequest {#UpdateServiceAccountRequest}

Field | Description
--- | ---
service_account_id | **string**<br>Required. ID of the ServiceAccount resource to update. To get the service account ID, use a [ServiceAccountService.List](#List) request. The maximum string length in characters is 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the ServiceAccount resource are going to be updated. 
name | **string**<br>Required. Name of the service account. The name must be unique within the cloud. Value must match the regular expression ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Description of the service account. The maximum string length in characters is 256.


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateServiceAccountMetadata](#UpdateServiceAccountMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[ServiceAccount](#ServiceAccount3)>**<br>if operation finished successfully. 


### UpdateServiceAccountMetadata {#UpdateServiceAccountMetadata}

Field | Description
--- | ---
service_account_id | **string**<br>ID of the ServiceAccount resource that is being updated. 


### ServiceAccount {#ServiceAccount3}

Field | Description
--- | ---
id | **string**<br>ID of the service account. 
folder_id | **string**<br>ID of the folder that the service account belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the service account. The name is unique within the cloud. 3-63 characters long. 
description | **string**<br>Description of the service account. 0-256 characters long. 


## Delete {#Delete}

Deletes the specified service account.

**rpc Delete ([DeleteServiceAccountRequest](#DeleteServiceAccountRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteServiceAccountMetadata](#DeleteServiceAccountMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteServiceAccountRequest {#DeleteServiceAccountRequest}

Field | Description
--- | ---
service_account_id | **string**<br>Required. ID of the service account to delete. To get the service account ID, use a [ServiceAccountService.List](#List) request. The maximum string length in characters is 50.


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteServiceAccountMetadata](#DeleteServiceAccountMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteServiceAccountMetadata {#DeleteServiceAccountMetadata}

Field | Description
--- | ---
service_account_id | **string**<br>ID of the service account that is being deleted. 


## ListAccessBindings {#ListAccessBindings}

access Lists access bindings for the specified service account.

**rpc ListAccessBindings ([ListAccessBindingsRequest](#ListAccessBindingsRequest)) returns ([ListAccessBindingsResponse](#ListAccessBindingsResponse))**

### ListAccessBindingsRequest {#ListAccessBindingsRequest}

Field | Description
--- | ---
resource_id | **string**<br>Required. ID of the resource to list access bindings for. <br>To get the resource ID, use a corresponding List request. For example, use the [yandex.cloud.resourcemanager.v1.CloudService.List](/docs/resource-manager/grpc/cloud_service#List) request to get the Cloud resource ID. The maximum string length in characters is 50.
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
id | **string**<br>Required. <ul><li>`allAuthenticatedUsers`: A special system identifier that represents anyone </li><li>`allUsers`: A special system identifier that represents anyone. No authentication is required. </li><li>`<cloud generated id>`: An identifier that represents a user account. </li></ul> The maximum string length in characters is 50.
type | **string**<br>Required. <ul><li>`userAccount`: An account on Yandex or Yandex.Connect, added to Yandex.Cloud. </li><li>`serviceAccount`: A service account. This type represents the [yandex.cloud.iam.v1.ServiceAccount](#ServiceAccount) resource. </li><li>`federatedUser`: A federated account. This type represents a user from an identity federation, like Active Directory. </li><li>`system`: System group. This type represents several accounts with a common system identifier. </li></ul> The maximum string length in characters is 100.


## SetAccessBindings {#SetAccessBindings}

Sets access bindings for the service account.

**rpc SetAccessBindings ([SetAccessBindingsRequest](#SetAccessBindingsRequest)) returns ([operation.Operation](#Operation3))**

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
id | **string**<br>Required. <ul><li>`allAuthenticatedUsers`: A special system identifier that represents anyone </li><li>`allUsers`: A special system identifier that represents anyone. No authentication is required. </li><li>`<cloud generated id>`: An identifier that represents a user account. </li></ul> The maximum string length in characters is 50.
type | **string**<br>Required. <ul><li>`userAccount`: An account on Yandex or Yandex.Connect, added to Yandex.Cloud. </li><li>`serviceAccount`: A service account. This type represents the [yandex.cloud.iam.v1.ServiceAccount](#ServiceAccount) resource. </li><li>`federatedUser`: A federated account. This type represents a user from an identity federation, like Active Directory. </li><li>`system`: System group. This type represents several accounts with a common system identifier. </li></ul> The maximum string length in characters is 100.


### Operation {#Operation3}

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

Updates access bindings for the specified service account.

**rpc UpdateAccessBindings ([UpdateAccessBindingsRequest](#UpdateAccessBindingsRequest)) returns ([operation.Operation](#Operation4))**

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
action | enum **AccessBindingAction**<br>Required. The action that is being performed on an access binding. <ul><li>`ADD`: Addition of an access binding.</li><li>`REMOVE`: Removal of an access binding.</li><ul/>
access_binding | **[AccessBinding](#AccessBinding)**<br>Required. Access binding. For more information, see [Access Bindings](/docs/iam/concepts/access-control/#access-bindings). 


### AccessBinding {#AccessBinding2}

Field | Description
--- | ---
role_id | **string**<br>Required. ID of the `yandex.cloud.iam.v1.Role` that is assigned to the `subject`. The maximum string length in characters is 50.
subject | **[Subject](#Subject)**<br>Required. Identity for which access binding is being created. It can represent an account with a unique ID or several accounts with a system identifier. 


### Subject {#Subject2}

Field | Description
--- | ---
id | **string**<br>Required. <ul><li>`allAuthenticatedUsers`: A special system identifier that represents anyone </li><li>`allUsers`: A special system identifier that represents anyone. No authentication is required. </li><li>`<cloud generated id>`: An identifier that represents a user account. </li></ul> The maximum string length in characters is 50.
type | **string**<br>Required. <ul><li>`userAccount`: An account on Yandex or Yandex.Connect, added to Yandex.Cloud. </li><li>`serviceAccount`: A service account. This type represents the [yandex.cloud.iam.v1.ServiceAccount](#ServiceAccount) resource. </li><li>`federatedUser`: A federated account. This type represents a user from an identity federation, like Active Directory. </li><li>`system`: System group. This type represents several accounts with a common system identifier. </li></ul> The maximum string length in characters is 100.


### Operation {#Operation4}

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


## ListOperations {#ListOperations}

Lists operations for the specified service account.

**rpc ListOperations ([ListServiceAccountOperationsRequest](#ListServiceAccountOperationsRequest)) returns ([ListServiceAccountOperationsResponse](#ListServiceAccountOperationsResponse))**

### ListServiceAccountOperationsRequest {#ListServiceAccountOperationsRequest}

Field | Description
--- | ---
service_account_id | **string**<br>Required. ID of the ServiceAccount resource to list operations for. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListServiceAccountOperationsResponse.next_page_token](#ListServiceAccountOperationsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListServiceAccountOperationsResponse.next_page_token](#ListServiceAccountOperationsResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListServiceAccountOperationsResponse {#ListServiceAccountOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation5)**<br>List of operations for the specified service account. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListServiceAccountOperationsRequest.page_size](#ListServiceAccountOperationsRequest), use the `next_page_token` as the value for the [ListServiceAccountOperationsRequest.page_token](#ListServiceAccountOperationsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Operation {#Operation5}

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


