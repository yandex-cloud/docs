---
editable: false
sourcePath: en/_api-ref-grpc/cdn/api-ref/grpc/provider_service.md
---

# Cloud CDN API, gRPC: ProviderService

A set of methods for managing Provider Service resources.

| Call | Description |
| --- | --- |
| [Activate](#Activate) | Activate provider for specified client. |
| [ListActivated](#ListActivated) | List activated providers for specified client. |

## Calls ProviderService {#calls}

## Activate {#Activate}

Activate provider for specified client.

**rpc Activate ([ActivateProviderRequest](#ActivateProviderRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[ActivateProviderMetadata](#ActivateProviderMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### ActivateProviderRequest {#ActivateProviderRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder that the activate provider belongs to. The maximum string length in characters is 50.
provider_type | **string**<br>Required. Specify provider brand/type. <br>Possible values: `gcore`. The maximum string length in characters is 50.


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[ActivateProviderMetadata](#ActivateProviderMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### ActivateProviderMetadata {#ActivateProviderMetadata}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder that the activate provider belongs to. The maximum string length in characters is 50.


## ListActivated {#ListActivated}

List activated providers for specified client.

**rpc ListActivated ([ListActivatedProvidersRequest](#ListActivatedProvidersRequest)) returns ([ListActivatedProvidersResponse](#ListActivatedProvidersResponse))**

### ListActivatedProvidersRequest {#ListActivatedProvidersRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder that the activate provider belongs to. The maximum string length in characters is 50.


### ListActivatedProvidersResponse {#ListActivatedProvidersResponse}

Field | Description
--- | ---
providers[] | **string**<br>Creates a list of providers. 


