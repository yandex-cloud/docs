---
editable: false
---

# Billing API, gRPC: BillingAccountService

A set of methods for managing BillingAccount resources.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified billing account. |
| [List](#List) | Retrieves the list of billing accounts available for current user. |
| [ListBillableObjectBindings](#ListBillableObjectBindings) | Retrieves the list of billable object bindings associated with the specified billing account. |
| [BindBillableObject](#BindBillableObject) | Binds billable object to the specified billing account. |
| [ListAccessBindings](#ListAccessBindings) | Lists access bindings for the specified billing account. |
| [UpdateAccessBindings](#UpdateAccessBindings) | Updates access bindings for the specified billing account. |

## Calls BillingAccountService {#calls}

## Get {#Get}

Returns the specified billing account.

**rpc Get ([GetBillingAccountRequest](#GetBillingAccountRequest)) returns ([BillingAccount](#BillingAccount))**

### GetBillingAccountRequest {#GetBillingAccountRequest}

Field | Description
--- | ---
id | **string**<br>Required. ID of the billing account to return. To get the billing account ID, use [BillingAccountService.List](#List) request. The maximum string length in characters is 50.


### BillingAccount {#BillingAccount}

Field | Description
--- | ---
id | **string**<br>ID of the billing account. 
name | **string**<br>Name of the billing account. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
country_code | **string**<br>ISO 3166-1 alpha-2 country code of the billing account. 
currency | **string**<br>Currency of the billing account. Can be one of the following: <ul><li>`RUB` </li><li>`USD` </li><li>`KZT`</li></ul> 
active | **bool**<br>Represents whether corresponding billable objects can be used or not. 
balance | **string**<br>Current balance of the billing account. 


## List {#List}

Retrieves the list of billing accounts available for current user.

**rpc List ([ListBillingAccountsRequest](#ListBillingAccountsRequest)) returns ([ListBillingAccountsResponse](#ListBillingAccountsResponse))**

### ListBillingAccountsRequest {#ListBillingAccountsRequest}

Field | Description
--- | ---
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListBillingAccountsResponse.next_page_token](#ListBillingAccountsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListBillingAccountsResponse.next_page_token](#ListBillingAccountsResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListBillingAccountsResponse {#ListBillingAccountsResponse}

Field | Description
--- | ---
billing_accounts[] | **[BillingAccount](#BillingAccount1)**<br>List of billing accounts. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListBillingAccountsRequest.page_size](#ListBillingAccountsRequest), use `next_page_token` as the value for the [ListBillingAccountsRequest.page_token](#ListBillingAccountsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### BillingAccount {#BillingAccount1}

Field | Description
--- | ---
id | **string**<br>ID of the billing account. 
name | **string**<br>Name of the billing account. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
country_code | **string**<br>ISO 3166-1 alpha-2 country code of the billing account. 
currency | **string**<br>Currency of the billing account. Can be one of the following: <ul><li>`RUB` </li><li>`USD` </li><li>`KZT`</li></ul> 
active | **bool**<br>Represents whether corresponding billable objects can be used or not. 
balance | **string**<br>Current balance of the billing account. 


## ListBillableObjectBindings {#ListBillableObjectBindings}

Retrieves the list of billable object bindings associated with the specified billing account.

**rpc ListBillableObjectBindings ([ListBillableObjectBindingsRequest](#ListBillableObjectBindingsRequest)) returns ([ListBillableObjectBindingsResponse](#ListBillableObjectBindingsResponse))**

### ListBillableObjectBindingsRequest {#ListBillableObjectBindingsRequest}

Field | Description
--- | ---
billing_account_id | **string**<br>Required. ID of the billing account to list associated billable object bindings. To get the billing account ID, use [BillingAccountService.List](#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListBillableObjectBindingsResponse.next_page_token](#ListBillableObjectBindingsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListBillableObjectBindingsResponse.next_page_token](#ListBillableObjectBindingsResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListBillableObjectBindingsResponse {#ListBillableObjectBindingsResponse}

Field | Description
--- | ---
billable_object_bindings[] | **[BillableObjectBinding](#BillableObjectBinding)**<br>List of billable object bindings. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListBillableObjectBindingsRequest.page_size](#ListBillableObjectBindingsRequest), use `next_page_token` as the value for the [ListBillableObjectBindingsRequest.page_token](#ListBillableObjectBindingsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### BillableObjectBinding {#BillableObjectBinding}

Field | Description
--- | ---
effective_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Timestamp when binding was created. 
billable_object | **[BillableObject](#BillableObject)**<br>Object that is bound to billing account. 


### BillableObject {#BillableObject}

Field | Description
--- | ---
id | **string**<br>ID of the object in other service. 
type | **string**<br>Billable object type. Can be one of the following: <ul><li>`cloud`</li></ul> 


## BindBillableObject {#BindBillableObject}

Binds billable object to the specified billing account.

**rpc BindBillableObject ([BindBillableObjectRequest](#BindBillableObjectRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[BindBillableObjectMetadata](#BindBillableObjectMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[BillableObjectBinding](#BillableObjectBinding1)<br>

### BindBillableObjectRequest {#BindBillableObjectRequest}

Field | Description
--- | ---
billing_account_id | **string**<br>Required. ID of the billing account to bind billable object. To get the billing account ID, use [BillingAccountService.List](#List) request. The maximum string length in characters is 50.
billable_object | **[BillableObject](#BillableObject1)**<br>`yandex.cloud.billing.v1.BillableObject` to bind with billing account. 


### BillableObject {#BillableObject1}

Field | Description
--- | ---
id | **string**<br>ID of the object in other service. 
type | **string**<br>Billable object type. Can be one of the following: <ul><li>`cloud`</li></ul> 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[BindBillableObjectMetadata](#BindBillableObjectMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[BillableObjectBinding](#BillableObjectBinding1)>**<br>if operation finished successfully. 


### BindBillableObjectMetadata {#BindBillableObjectMetadata}

Field | Description
--- | ---
billable_object_id | **string**<br>ID of the `yandex.cloud.billing.v1.BillableObject` that was bound to billing account. 


### BillableObjectBinding {#BillableObjectBinding1}

Field | Description
--- | ---
effective_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Timestamp when binding was created. 
billable_object | **[BillableObject](#BillableObject2)**<br>Object that is bound to billing account. 


## ListAccessBindings {#ListAccessBindings}

Lists access bindings for the specified billing account.

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


## UpdateAccessBindings {#UpdateAccessBindings}

Updates access bindings for the specified billing account.

**rpc UpdateAccessBindings ([UpdateAccessBindingsRequest](#UpdateAccessBindingsRequest)) returns ([operation.Operation](#Operation1))**

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


### Operation {#Operation1}

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


