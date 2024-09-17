---
editable: false
sourcePath: en/_api-ref-grpc/billing/api-ref/grpc/customer_service.md
---

# Billing API, gRPC: CustomerService

A set of methods for managing Customer resources.

| Call | Description |
| --- | --- |
| [List](#List) | Retrieves the list of customers associated with the specified reseller. |
| [Invite](#Invite) | Invites customer to the specified reseller. |
| [CreateResellerServed](#CreateResellerServed) | Creates new reseller-served customer. |
| [Activate](#Activate) | Activates specified customer. |
| [Suspend](#Suspend) | Suspend specified customer. |

## Calls CustomerService {#calls}

## List {#List}

Retrieves the list of customers associated with the specified reseller.

**rpc List ([ListCustomersRequest](#ListCustomersRequest)) returns ([ListCustomersResponse](#ListCustomersResponse))**

### ListCustomersRequest {#ListCustomersRequest}

Field | Description
--- | ---
reseller_id | **string**<br>Required. ID of the reseller. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListCustomersResponse.next_page_token](#ListCustomersResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListCustomersResponse.next_page_token](#ListCustomersResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListCustomersResponse {#ListCustomersResponse}

Field | Description
--- | ---
customers[] | **[Customer](#Customer)**<br>List of customers. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListCustomersRequest.page_size](#ListCustomersRequest), use `next_page_token` as the value for the [ListCustomersRequest.page_token](#ListCustomersRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Customer {#Customer}

Field | Description
--- | ---
id | **string**<br>ID of the customer. 
billing_account_id | **string**<br>ID of the `yandex.cloud.billing.v1.BillingAccount` assigned to the customer. 


## Invite {#Invite}

Invites customer to the specified reseller.

**rpc Invite ([InviteCustomerRequest](#InviteCustomerRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CustomerMetadata](#CustomerMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Customer](#Customer1)<br>

### InviteCustomerRequest {#InviteCustomerRequest}

Field | Description
--- | ---
reseller_id | **string**<br>Required. Billing account ID of the reseller that the customer will be associated with. The maximum string length in characters is 50.
name | **string**<br>Required. Name of the customer. 
invitation_email | **string**<br>Required. Customer email to send invitation to. 
person | **[CustomerPerson](#CustomerPerson)**<br>Required. Person of the customer. 


### CustomerPerson {#CustomerPerson}

Field | Description
--- | ---
name | **string**<br>Optional. Name of the person. <br>String length is not limited. 
longname | **string**<br>Optional. Long name of the person. <br>String length is not limited. 
phone | **string**<br>Optional. Phone of the person. <br>Must be a valid telephone number or a valid [phoneword](https://en.m.wikipedia.org/wiki/Phoneword). 
email | **string**<br>Optional. Email of the person. <br>Must be a valid [email address](https://en.wikipedia.org/wiki/Email_address). 
post_code | **string**<br>Optional. Post code of the person. <br>String length is not limited. 
post_address | **string**<br>Optional. Post address of the person. <br>String length is not limited. 
legal_address | **string**<br>Optional. Legal address of the person. <br>String length is not limited. 
tin | **string**<br>Optional. Tax identification number of the person. <br>String length is not limited. 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CustomerMetadata](#CustomerMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Customer](#Customer1)>**<br>if operation finished successfully. 


### CustomerMetadata {#CustomerMetadata}

Field | Description
--- | ---
reseller_id | **string**<br>ID of the reseller. 
customer_id | **string**<br>ID of the customer. 


### Customer {#Customer1}

Field | Description
--- | ---
id | **string**<br>ID of the customer. 
billing_account_id | **string**<br>ID of the `yandex.cloud.billing.v1.BillingAccount` assigned to the customer. 


## CreateResellerServed {#CreateResellerServed}

Creates new reseller-served customer.

**rpc CreateResellerServed ([CreateResellerServedCustomerRequest](#CreateResellerServedCustomerRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CustomerMetadata](#CustomerMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Customer](#Customer2)<br>

### CreateResellerServedCustomerRequest {#CreateResellerServedCustomerRequest}

Field | Description
--- | ---
reseller_id | **string**<br>Required. ID of the reseller that customer will be associated with. <br>Value must match either one of the two regular expressions: `^([0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}|[0-9a-f]{32})$` or `^[a-z][-a-zA-Z0-9.]{0,48}[a-zA-Z0-9]$`. The maximum string length in characters is 50.
name | **string**<br>Required. Name of the customer. <br>String length is not limited. 
person | **[CustomerPerson](#CustomerPerson1)**<br>Required. Person of the customer. 


### CustomerPerson {#CustomerPerson1}

Field | Description
--- | ---
name | **string**<br>Optional. Name of the person. <br>String length is not limited. 
longname | **string**<br>Optional. Long name of the person. <br>String length is not limited. 
phone | **string**<br>Optional. Phone of the person. <br>Must be a valid telephone number or a valid [phoneword](https://en.m.wikipedia.org/wiki/Phoneword). 
email | **string**<br>Optional. Email of the person. <br>Must be a valid [email address](https://en.wikipedia.org/wiki/Email_address). 
post_code | **string**<br>Optional. Post code of the person. <br>String length is not limited. 
post_address | **string**<br>Optional. Post address of the person. <br>String length is not limited. 
legal_address | **string**<br>Optional. Legal address of the person. <br>String length is not limited. 
tin | **string**<br>Optional. Tax identification number of the person. <br>String length is not limited. 


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CustomerMetadata](#CustomerMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Customer](#Customer2)>**<br>if operation finished successfully. 


### CustomerMetadata {#CustomerMetadata1}

Field | Description
--- | ---
reseller_id | **string**<br>ID of the reseller. 
customer_id | **string**<br>ID of the customer. 


### Customer {#Customer2}

Field | Description
--- | ---
id | **string**<br>ID of the customer. 
billing_account_id | **string**<br>ID of the `yandex.cloud.billing.v1.BillingAccount` assigned to the customer. 


## Activate {#Activate}

Activates specified customer. After customer is activated, he can use resources associated with his billing account.

**rpc Activate ([ActivateCustomerRequest](#ActivateCustomerRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CustomerMetadata](#CustomerMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Customer](#Customer3)<br>

### ActivateCustomerRequest {#ActivateCustomerRequest}

Field | Description
--- | ---
customer_id | **string**<br>Required. ID of the customer. To get the customer ID, use [CustomerService.List](#List) request. The maximum string length in characters is 50.


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CustomerMetadata](#CustomerMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Customer](#Customer3)>**<br>if operation finished successfully. 


### CustomerMetadata {#CustomerMetadata2}

Field | Description
--- | ---
reseller_id | **string**<br>ID of the reseller. 
customer_id | **string**<br>ID of the customer. 


### Customer {#Customer3}

Field | Description
--- | ---
id | **string**<br>ID of the customer. 
billing_account_id | **string**<br>ID of the `yandex.cloud.billing.v1.BillingAccount` assigned to the customer. 


## Suspend {#Suspend}

Suspend specified customer. After customer is suspended, he can't use resources associated with his billing account.

**rpc Suspend ([SuspendCustomerRequest](#SuspendCustomerRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CustomerMetadata](#CustomerMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Customer](#Customer4)<br>

### SuspendCustomerRequest {#SuspendCustomerRequest}

Field | Description
--- | ---
customer_id | **string**<br>Required. ID of the customer. To get the customer ID, use [CustomerService.List](#List) request. The maximum string length in characters is 50.


### Operation {#Operation3}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CustomerMetadata](#CustomerMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Customer](#Customer4)>**<br>if operation finished successfully. 


### CustomerMetadata {#CustomerMetadata3}

Field | Description
--- | ---
reseller_id | **string**<br>ID of the reseller. 
customer_id | **string**<br>ID of the customer. 


### Customer {#Customer4}

Field | Description
--- | ---
id | **string**<br>ID of the customer. 
billing_account_id | **string**<br>ID of the `yandex.cloud.billing.v1.BillingAccount` assigned to the customer. 


