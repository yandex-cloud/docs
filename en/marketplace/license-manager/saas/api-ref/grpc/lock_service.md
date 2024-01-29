---
editable: false
sourcePath: en/_api-ref-grpc/marketplace/license-manager/saas/license-manager/saas/api-ref/grpc/lock_service.md
---

# Yandex Cloud Marketplace License Manager for SaaS, gRPC: LockService

A set of methods for managing subscription locks.

| Call | Description |
| --- | --- |
| [Ensure](#Ensure) | Checks if the she specified subscription is already locked to the specified resource. |
| [Get](#Get) | Returns the specified subscription lock. |

## Calls LockService {#calls}

## Ensure {#Ensure}

Checks if the she specified subscription is already locked to the specified resource. If it is not locked, locks the subscription to the resource.

**rpc Ensure ([EnsureLockRequest](#EnsureLockRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[EnsureLockMetadata](#EnsureLockMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[licensemanager.v1.Lock](./instance_service#v1)<br>

### EnsureLockRequest {#EnsureLockRequest}

Field | Description
--- | ---
instance_token | **string**<br>Required. Signed JWT token which contains information about subscription. 
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
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[EnsureLockMetadata](#EnsureLockMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[licensemanager.v1.Lock](./instance_service#v1)>**<br>if operation finished successfully. 


### EnsureLockMetadata {#EnsureLockMetadata}

Field | Description
--- | ---
lock_id | **string**<br>ID of the subscription lock. 


## Get {#Get}

Returns the specified subscription lock.

**rpc Get ([GetLockRequest](#GetLockRequest)) returns ([licensemanager.v1.Lock](./instance_service#v1))**

### GetLockRequest {#GetLockRequest}

Field | Description
--- | ---
lock_id | **string**<br>Required. ID of the subscription lock. 


