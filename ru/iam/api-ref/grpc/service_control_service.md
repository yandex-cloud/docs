---
editable: false
sourcePath: en/_api-ref-grpc/iam/api-ref/grpc/service_control_service.md
---

# Identity and Access Management API, gRPC: ServiceControlService

A set of methods for managing Service resources.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the Service information in the specified resource container. |
| [List](#List) | Retrieves the list of Service in the specified resource container. |
| [Enable](#Enable) | Enable a service in the specified resource container. |
| [Resume](#Resume) | Resume a service in the specified resource container. |
| [Pause](#Pause) | Pause a service in the specified resource container. |
| [Disable](#Disable) | Disable a service in the specified resource container. |

## Calls ServiceControlService {#calls}

## Get {#Get}

Returns the Service information in the specified resource container. <br>To get the list of available Services, make a [List](#List) request.

**rpc Get ([GetServiceRequest](#GetServiceRequest)) returns ([Service](#Service))**

### GetServiceRequest {#GetServiceRequest}

Field | Description
--- | ---
service_id | **string**<br>Required. ID of the Service. The maximum string length in characters is 50.
resource | **[Resource](#Resource)**<br>Required. Resource container to get a service information in. <br>It is supported only resource-manager.cloud resource container now. 


### Resource {#Resource}

Field | Description
--- | ---
id | **string**<br>Required. ID of the resource. The maximum string length in characters is 50.
type | **string**<br>Required. The type of the resource, e.g. resource-manager.folder, billing.account, compute.snapshot, etc. The maximum string length in characters is 64.


### Service {#Service}

Field | Description
--- | ---
service_id | **string**<br>ID of the service. 
resource | **[Resource](#Resource1)**<br>Resource that the service belongs to. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of the last status update of the service. 
status | enum **Status**<br>Current status of the service. <ul><li>`ENABLED`: The service is enabled.</li><li>`PAUSED`: The service is paused.</li><li>`DISABLED`: The service is disabled.</li><li>`ENABLING`: The service is being enabled.</li><li>`RESUMING`: The service is being resumed.</li><li>`PAUSING`: The service is being paused.</li><li>`DISABLING`: The service is being disabled.</li><li>`ERROR`: The service is in error state.</li></ul>


## List {#List}

Retrieves the list of Service in the specified resource container.

**rpc List ([ListServicesRequest](#ListServicesRequest)) returns ([ListServicesResponse](#ListServicesResponse))**

### ListServicesRequest {#ListServicesRequest}

Field | Description
--- | ---
resource | **[Resource](#Resource1)**<br>Required. Resource container to list a services. <br>It is supported only resource-manager.cloud resource container now. 
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListServicesResponse.next_page_token](#ListServicesResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100 Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListServicesResponse.next_page_token](#ListServicesResponse) returned by a previous list request. The maximum string length in characters is 2000.


### Resource {#Resource1}

Field | Description
--- | ---
id | **string**<br>Required. ID of the resource. The maximum string length in characters is 50.
type | **string**<br>Required. The type of the resource, e.g. resource-manager.folder, billing.account, compute.snapshot, etc. The maximum string length in characters is 64.


### ListServicesResponse {#ListServicesResponse}

Field | Description
--- | ---
services[] | **[Service](#Service1)**<br>List of Services. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListServicesRequest.page_size](#ListServicesRequest), use the `next_page_token` as the value for the [ListServicesRequest.page_token](#ListServicesRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Service {#Service1}

Field | Description
--- | ---
service_id | **string**<br>ID of the service. 
resource | **[Resource](#Resource2)**<br>Resource that the service belongs to. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of the last status update of the service. 
status | enum **Status**<br>Current status of the service. <ul><li>`ENABLED`: The service is enabled.</li><li>`PAUSED`: The service is paused.</li><li>`DISABLED`: The service is disabled.</li><li>`ENABLING`: The service is being enabled.</li><li>`RESUMING`: The service is being resumed.</li><li>`PAUSING`: The service is being paused.</li><li>`DISABLING`: The service is being disabled.</li><li>`ERROR`: The service is in error state.</li></ul>


## Enable {#Enable}

Enable a service in the specified resource container.

**rpc Enable ([EnableServiceRequest](#EnableServiceRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[EnableServiceMetadata](#EnableServiceMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Service](#Service2)<br>

### EnableServiceRequest {#EnableServiceRequest}

Field | Description
--- | ---
service_id | **string**<br>Required. ID of the Service. The maximum string length in characters is 50.
resource | **[Resource](#Resource2)**<br>Required. Resource container to enable a service in. <br>It is supported only resource-manager.cloud resource container now. 


### Resource {#Resource2}

Field | Description
--- | ---
id | **string**<br>Required. ID of the resource. The maximum string length in characters is 50.
type | **string**<br>Required. The type of the resource, e.g. resource-manager.folder, billing.account, compute.snapshot, etc. The maximum string length in characters is 64.


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[EnableServiceMetadata](#EnableServiceMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Service](#Service2)>**<br>if operation finished successfully. 


### EnableServiceMetadata {#EnableServiceMetadata}

Field | Description
--- | ---
service_id | **string**<br>ID of the Service. 
resource | **[Resource](#Resource3)**<br>Resource container. 


### Service {#Service2}

Field | Description
--- | ---
service_id | **string**<br>ID of the service. 
resource | **[Resource](#Resource3)**<br>Resource that the service belongs to. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of the last status update of the service. 
status | enum **Status**<br>Current status of the service. <ul><li>`ENABLED`: The service is enabled.</li><li>`PAUSED`: The service is paused.</li><li>`DISABLED`: The service is disabled.</li><li>`ENABLING`: The service is being enabled.</li><li>`RESUMING`: The service is being resumed.</li><li>`PAUSING`: The service is being paused.</li><li>`DISABLING`: The service is being disabled.</li><li>`ERROR`: The service is in error state.</li></ul>


## Resume {#Resume}

Resume a service in the specified resource container.

**rpc Resume ([ResumeServiceRequest](#ResumeServiceRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[ResumeServiceMetadata](#ResumeServiceMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Service](#Service3)<br>

### ResumeServiceRequest {#ResumeServiceRequest}

Field | Description
--- | ---
service_id | **string**<br>Required. ID of the Service. The maximum string length in characters is 50.
resource | **[Resource](#Resource3)**<br>Required. Resource container to resume a service in. <br>It is supported only resource-manager.cloud resource container now. 


### Resource {#Resource3}

Field | Description
--- | ---
id | **string**<br>Required. ID of the resource. The maximum string length in characters is 50.
type | **string**<br>Required. The type of the resource, e.g. resource-manager.folder, billing.account, compute.snapshot, etc. The maximum string length in characters is 64.


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[ResumeServiceMetadata](#ResumeServiceMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Service](#Service3)>**<br>if operation finished successfully. 


### ResumeServiceMetadata {#ResumeServiceMetadata}

Field | Description
--- | ---
service_id | **string**<br>ID of the Service. 
resource | **[Resource](#Resource4)**<br>Resource container. 


### Service {#Service3}

Field | Description
--- | ---
service_id | **string**<br>ID of the service. 
resource | **[Resource](#Resource4)**<br>Resource that the service belongs to. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of the last status update of the service. 
status | enum **Status**<br>Current status of the service. <ul><li>`ENABLED`: The service is enabled.</li><li>`PAUSED`: The service is paused.</li><li>`DISABLED`: The service is disabled.</li><li>`ENABLING`: The service is being enabled.</li><li>`RESUMING`: The service is being resumed.</li><li>`PAUSING`: The service is being paused.</li><li>`DISABLING`: The service is being disabled.</li><li>`ERROR`: The service is in error state.</li></ul>


## Pause {#Pause}

Pause a service in the specified resource container.

**rpc Pause ([PauseServiceRequest](#PauseServiceRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[PauseServiceMetadata](#PauseServiceMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Service](#Service4)<br>

### PauseServiceRequest {#PauseServiceRequest}

Field | Description
--- | ---
service_id | **string**<br>Required. ID of the Service. The maximum string length in characters is 50.
resource | **[Resource](#Resource4)**<br>Required. Resource container to pause a service in. <br>It is supported only resource-manager.cloud resource container now. 
force | **bool**<br>Force pause. <br>It will pause service even if there is service resources that will be broke. 


### Resource {#Resource4}

Field | Description
--- | ---
id | **string**<br>Required. ID of the resource. The maximum string length in characters is 50.
type | **string**<br>Required. The type of the resource, e.g. resource-manager.folder, billing.account, compute.snapshot, etc. The maximum string length in characters is 64.


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[PauseServiceMetadata](#PauseServiceMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Service](#Service4)>**<br>if operation finished successfully. 


### PauseServiceMetadata {#PauseServiceMetadata}

Field | Description
--- | ---
service_id | **string**<br>ID of the Service. 
resource | **[Resource](#Resource5)**<br>Resource container. 


### Service {#Service4}

Field | Description
--- | ---
service_id | **string**<br>ID of the service. 
resource | **[Resource](#Resource5)**<br>Resource that the service belongs to. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of the last status update of the service. 
status | enum **Status**<br>Current status of the service. <ul><li>`ENABLED`: The service is enabled.</li><li>`PAUSED`: The service is paused.</li><li>`DISABLED`: The service is disabled.</li><li>`ENABLING`: The service is being enabled.</li><li>`RESUMING`: The service is being resumed.</li><li>`PAUSING`: The service is being paused.</li><li>`DISABLING`: The service is being disabled.</li><li>`ERROR`: The service is in error state.</li></ul>


## Disable {#Disable}

Disable a service in the specified resource container.

**rpc Disable ([DisableServiceRequest](#DisableServiceRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DisableServiceMetadata](#DisableServiceMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Service](#Service5)<br>

### DisableServiceRequest {#DisableServiceRequest}

Field | Description
--- | ---
service_id | **string**<br>Required. ID of the Service. The maximum string length in characters is 50.
resource | **[Resource](#Resource5)**<br>Required. Resource container to disable a service in. <br>It is supported only resource-manager.cloud resource container now. 


### Resource {#Resource5}

Field | Description
--- | ---
id | **string**<br>Required. ID of the resource. The maximum string length in characters is 50.
type | **string**<br>Required. The type of the resource, e.g. resource-manager.folder, billing.account, compute.snapshot, etc. The maximum string length in characters is 64.


### Operation {#Operation3}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DisableServiceMetadata](#DisableServiceMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Service](#Service5)>**<br>if operation finished successfully. 


### DisableServiceMetadata {#DisableServiceMetadata}

Field | Description
--- | ---
service_id | **string**<br>ID of the Service. 
resource | **[Resource](#Resource6)**<br>Resource container. 


### Service {#Service5}

Field | Description
--- | ---
service_id | **string**<br>ID of the service. 
resource | **[Resource](#Resource6)**<br>Resource that the service belongs to. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of the last status update of the service. 
status | enum **Status**<br>Current status of the service. <ul><li>`ENABLED`: The service is enabled.</li><li>`PAUSED`: The service is paused.</li><li>`DISABLED`: The service is disabled.</li><li>`ENABLING`: The service is being enabled.</li><li>`RESUMING`: The service is being resumed.</li><li>`PAUSING`: The service is being paused.</li><li>`DISABLING`: The service is being disabled.</li><li>`ERROR`: The service is in error state.</li></ul>


