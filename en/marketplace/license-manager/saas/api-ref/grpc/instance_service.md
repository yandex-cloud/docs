---
editable: false
sourcePath: en/_api-ref-grpc/marketplace/license-manager/saas/license-manager/saas/api-ref/grpc/instance_service.md
---

# Yandex Cloud Marketplace License Manager for SaaS, gRPC: InstanceService

A set of methods for managing subscription instances.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified subscription instance. |

## Calls InstanceService {#calls}

## Get {#Get}

Returns the specified subscription instance. <br>To get the list of all available subscription instances, make a [List] request.

**rpc Get ([GetInstanceRequest](#GetInstanceRequest)) returns ([licensemanager.v1.Instance](./instance_service#v1))**

### GetInstanceRequest {#GetInstanceRequest}

Field | Description
--- | ---
instance_id | **string**<br>Required. ID of the subscription instance. 


