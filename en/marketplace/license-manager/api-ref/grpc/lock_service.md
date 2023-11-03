---
editable: false
sourcePath: en/_api-ref-grpc/marketplace/license-manager/license-manager/api-ref/grpc/lock_service.md
---

# Yandex Cloud Marketplace License Manager, gRPC: LockService

A set of methods for managing subscription locks.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified subscription lock. |
| [GetByInstanceAndResource](#GetByInstanceAndResource) | Returns the subscription lock for specified subscription instance and resource. |
| [List](#List) | Returns subscriptions locks for specified resource and folder. |
| [Create](#Create) | Locks the specified subscription instance to the resource. |
| [Ensure](#Ensure) | Checks if the she specified subscription is already locked to the specified resource. |
| [Delete](#Delete) | Unlocks the specified subscription lock. |

## Calls LockService {#calls}

## Get {#Get}

Returns the specified subscription lock.

**rpc Get ([GetLockRequest](#GetLockRequest)) returns ([Lock](#Lock))**

### GetLockRequest {#GetLockRequest}

Field | Description
--- | ---
lock_id | **string**<br>Required. ID of the subscription lock. 


### Lock {#Lock}

Field | Description
--- | ---
id | **string**<br>ID of the subscription lock. 
instance_id | **string**<br>ID of the subscription instance. 
resource_id | **string**<br>ID of the resource. 
start_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Timestamp of the start of the subscription lock. 
end_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Timestamp of the end of the subscription lock. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Update timestamp. 
state | enum **State**<br>Subscription lock state. <ul><li>`UNLOCKED`: Subscription unlocked.</li><li>`LOCKED`: Subscription locked to the resource.</li><li>`DELETED`: Subscription lock deleted.</li></ul>
template_id | **string**<br>ID of the subscription template. 


## GetByInstanceAndResource {#GetByInstanceAndResource}

Returns the subscription lock for specified subscription instance and resource.

**rpc GetByInstanceAndResource ([GetLockByInstanceAndResourceRequest](#GetLockByInstanceAndResourceRequest)) returns ([Lock](#Lock1))**

### GetLockByInstanceAndResourceRequest {#GetLockByInstanceAndResourceRequest}

Field | Description
--- | ---
instance_id | **string**<br>Required. ID of the subscription instance. 
resource_id | **string**<br>Required. ID of the resource to which the subscription will be locked. 


### Lock {#Lock1}

Field | Description
--- | ---
id | **string**<br>ID of the subscription lock. 
instance_id | **string**<br>ID of the subscription instance. 
resource_id | **string**<br>ID of the resource. 
start_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Timestamp of the start of the subscription lock. 
end_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Timestamp of the end of the subscription lock. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Update timestamp. 
state | enum **State**<br>Subscription lock state. <ul><li>`UNLOCKED`: Subscription unlocked.</li><li>`LOCKED`: Subscription locked to the resource.</li><li>`DELETED`: Subscription lock deleted.</li></ul>
template_id | **string**<br>ID of the subscription template. 


## List {#List}

Returns subscriptions locks for specified resource and folder.

**rpc List ([ListLocksRequest](#ListLocksRequest)) returns ([ListLocksResponse](#ListLocksResponse))**

### ListLocksRequest {#ListLocksRequest}

Field | Description
--- | ---
resource_id | **string**<br>Required. ID of the resource that the subscription locks belong to. 
folder_id | **string**<br>Required. ID of the folder that the subscription locks belong to. 
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListLocksResponse.next_page_token](#ListLocksResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListLocksResponse.next_page_token](#ListLocksResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters subscription locks listed in the response. <br>The expression must specify: <ol><li>The field name. Currently you can use filtering only on [Lock.product_id](#Lock2) field. </li><li>An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. </li><li>The value. Must be 3-63 characters long and match the regular expression `^[a-z][-a-z0-9]{1,61}[a-z0-9]`. </li></ol>Example of a filter: `product_id=my-product-id`. The maximum string length in characters is 1000.
order_by | **string**<br>Sorting order for the list of subscription locks. The maximum string length in characters is 100.


### ListLocksResponse {#ListLocksResponse}

Field | Description
--- | ---
locks[] | **[Lock](#Lock2)**<br>List of subscription locks. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListLocksRequest.page_size](#ListLocksRequest), use `next_page_token` as the value for the [ListLocksRequest.page_token](#ListLocksRequest) parameter in the next list request. <br>Each subsequent page will have its own `next_page_token` to continue paging through the results. 


### Lock {#Lock2}

Field | Description
--- | ---
id | **string**<br>ID of the subscription lock. 
instance_id | **string**<br>ID of the subscription instance. 
resource_id | **string**<br>ID of the resource. 
start_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Timestamp of the start of the subscription lock. 
end_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Timestamp of the end of the subscription lock. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Update timestamp. 
state | enum **State**<br>Subscription lock state. <ul><li>`UNLOCKED`: Subscription unlocked.</li><li>`LOCKED`: Subscription locked to the resource.</li><li>`DELETED`: Subscription lock deleted.</li></ul>
template_id | **string**<br>ID of the subscription template. 


## Create {#Create}

Locks the specified subscription instance to the resource.

**rpc Create ([CreateLockRequest](#CreateLockRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateLockMetadata](#CreateLockMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Lock](#Lock3)<br>

### CreateLockRequest {#CreateLockRequest}

Field | Description
--- | ---
instance_id | **string**<br>Required. ID of the subscription instance. 
resource_id | **string**<br>Required. ID of the resource to which the subscription will be locked. 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateLockMetadata](#CreateLockMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Lock](#Lock3)>**<br>if operation finished successfully. 


### CreateLockMetadata {#CreateLockMetadata}

Field | Description
--- | ---
lock_id | **string**<br>ID of the subscription lock. 


### Lock {#Lock3}

Field | Description
--- | ---
id | **string**<br>ID of the subscription lock. 
instance_id | **string**<br>ID of the subscription instance. 
resource_id | **string**<br>ID of the resource. 
start_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Timestamp of the start of the subscription lock. 
end_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Timestamp of the end of the subscription lock. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Update timestamp. 
state | enum **State**<br>Subscription lock state. <ul><li>`UNLOCKED`: Subscription unlocked.</li><li>`LOCKED`: Subscription locked to the resource.</li><li>`DELETED`: Subscription lock deleted.</li></ul>
template_id | **string**<br>ID of the subscription template. 


## Ensure {#Ensure}

Checks if the she specified subscription is already locked to the specified resource. If it is not locked, locks the subscription to the resource.

**rpc Ensure ([EnsureLockRequest](#EnsureLockRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[EnsureLockMetadata](#EnsureLockMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Lock](#Lock4)<br>

### EnsureLockRequest {#EnsureLockRequest}

Field | Description
--- | ---
instance_id | **string**<br>Required. ID of the subscription instance. 
resource_id | **string**<br>Required. ID of the resource to which the subscription will be locked. 


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[EnsureLockMetadata](#EnsureLockMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Lock](#Lock4)>**<br>if operation finished successfully. 


### EnsureLockMetadata {#EnsureLockMetadata}

Field | Description
--- | ---
lock_id | **string**<br>ID of the subscription lock. 


### Lock {#Lock4}

Field | Description
--- | ---
id | **string**<br>ID of the subscription lock. 
instance_id | **string**<br>ID of the subscription instance. 
resource_id | **string**<br>ID of the resource. 
start_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Timestamp of the start of the subscription lock. 
end_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Timestamp of the end of the subscription lock. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Update timestamp. 
state | enum **State**<br>Subscription lock state. <ul><li>`UNLOCKED`: Subscription unlocked.</li><li>`LOCKED`: Subscription locked to the resource.</li><li>`DELETED`: Subscription lock deleted.</li></ul>
template_id | **string**<br>ID of the subscription template. 


## Delete {#Delete}

Unlocks the specified subscription lock.

**rpc Delete ([DeleteLockRequest](#DeleteLockRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteLockMetadata](#DeleteLockMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteLockRequest {#DeleteLockRequest}

Field | Description
--- | ---
lock_id | **string**<br>Required. ID of the subscription lock. 


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteLockMetadata](#DeleteLockMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteLockMetadata {#DeleteLockMetadata}

Field | Description
--- | ---
lock_id | **string**<br>ID of the subscription lock. 


