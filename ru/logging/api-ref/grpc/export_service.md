---
editable: false
sourcePath: en/_api-ref-grpc/logging/api-ref/grpc/export_service.md
---

# Cloud Logging Service, gRPC: ExportService



| Call | Description |
| --- | --- |
| [Run](#Run) |  |

## Calls ExportService {#calls}

## Run {#Run}



**rpc Run ([RunExportRequest](#RunExportRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RunExportMetadata](#RunExportMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[RunExportDetails](#RunExportDetails)<br>

### RunExportRequest {#RunExportRequest}

Field | Description
--- | ---
group_id | **string**<br>Required.  The maximum string length in characters is 64.
sink_id | **string**<br>Required.  The maximum string length in characters is 64.
params | **[ExportParams](#ExportParams)**<br>Required.  
result_filename | **string**<br>Required.  
since | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Required.  
until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Required.  


### ExportParams {#ExportParams}

Field | Description
--- | ---
resource_types[] | **string**<br> The maximum string length in characters for each value is 63. The maximum number of elements is 100.
resource_ids[] | **string**<br> The maximum string length in characters for each value is 63. The maximum number of elements is 100.
stream_names[] | **string**<br> The maximum string length in characters for each value is 63. The maximum number of elements is 100.
levels[] | **[LogLevel.Level](#LogLevel)**<br> The maximum number of elements is 10.
filter | **string**<br> The maximum string length in characters is 1000.


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[RunExportMetadata](#RunExportMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[RunExportDetails](#RunExportDetails)>**<br>if operation finished successfully. 


### RunExportMetadata {#RunExportMetadata}

Field | Description
--- | ---
group_id | **string**<br> 
sink_id | **string**<br> 
result_filename | **string**<br> 


### RunExportDetails {#RunExportDetails}

Field | Description
--- | ---
group_id | **string**<br> 
sink_id | **string**<br> 
params | **[ExportParams](#ExportParams1)**<br> 
result_filename | **string**<br> 
since | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
until | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 


