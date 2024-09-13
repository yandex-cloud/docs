---
editable: false
sourcePath: en/_api-ref-grpc/talk-analytics/api-ref/grpc/project_service.md
---

# Talk Analytics API, gRPC: ProjectService



| Call | Description |
| --- | --- |
| [Create](#Create) | rpc for creating speechsense project |

## Calls ProjectService {#calls}

## Create {#Create}

rpc for creating speechsense project

**rpc Create ([CreateProjectRequest](#CreateProjectRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateProjectMetadata](#CreateProjectMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Project](#Project)<br>

### CreateProjectRequest {#CreateProjectRequest}

Field | Description
--- | ---
name | **string**<br>project name 
connection_id | **string**<br>id of connection the project should belong too 
description | **string**<br>project description 
filters[] | **[FieldFilter](#FieldFilter)**<br>project filters 


### FieldFilter {#FieldFilter}

Field | Description
--- | ---
key | **string**<br>connection metadata field key 
field_value | **string**<br>connection metadata field value 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateProjectMetadata](#CreateProjectMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Project](#Project)>**<br>if operation finished successfully. 


### CreateProjectMetadata {#CreateProjectMetadata}

Field | Description
--- | ---
id | **string**<br> 


### Project {#Project}

Field | Description
--- | ---
id | **string**<br> 
name | **string**<br> 
connection_id | **string**<br> 
description | **string**<br> 
created_by | **string**<br> 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
modified_by | **string**<br> 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
filters[] | **[FieldFilter](#FieldFilter1)**<br> 


