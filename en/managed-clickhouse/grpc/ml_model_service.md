---
editable: false
---

# MlModelService



| Call | Description |
| --- | --- |
| [Get](#Get) |  |
| [List](#List) |  |
| [Create](#Create) |  |
| [Update](#Update) |  |
| [Delete](#Delete) |  |

## Calls MlModelService {#calls}

## Get {#Get}



**rpc Get ([GetMlModelRequest](#GetMlModelRequest)) returns ([MlModel](#MlModel))**

### GetMlModelRequest {#GetMlModelRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required.   The maximum string length in characters is 50.
ml_model_name | **string**<br>Required.   The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### MlModel {#MlModel}

Field | Description
--- | ---
name | **string**<br> 
cluster_id | **string**<br> 
type | enum **MlModelType**<br> <ul><ul/>
uri | **string**<br> 


## List {#List}



**rpc List ([ListMlModelsRequest](#ListMlModelsRequest)) returns ([ListMlModelsResponse](#ListMlModelsResponse))**

### ListMlModelsRequest {#ListMlModelsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required.   The maximum string length in characters is 50.
page_size | **int64**<br> The maximum value is 1000.
page_token | **string**<br> The maximum string length in characters is 100.


### ListMlModelsResponse {#ListMlModelsResponse}

Field | Description
--- | ---
ml_models[] | **[MlModel](#MlModel1)**<br> 
next_page_token | **string**<br> 


### MlModel {#MlModel}

Field | Description
--- | ---
name | **string**<br> 
cluster_id | **string**<br> 
type | enum **MlModelType**<br> <ul><ul/>
uri | **string**<br> 


## Create {#Create}



**rpc Create ([CreateMlModelRequest](#CreateMlModelRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateMlModelMetadata](#CreateMlModelMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[MlModel](#MlModel2)<br>

### CreateMlModelRequest {#CreateMlModelRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required.   The maximum string length in characters is 50.
ml_model_name | **string**<br>Required.   The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
type | enum **MlModelType**<br>Required.  <ul><ul/>
uri | **string**<br>Required.  


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateMlModelMetadata](#CreateMlModelMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[MlModel](#MlModel2)>**<br>if operation finished successfully. 


### CreateMlModelMetadata {#CreateMlModelMetadata}

Field | Description
--- | ---
cluster_id | **string**<br> 
ml_model_name | **string**<br> 


### MlModel {#MlModel}

Field | Description
--- | ---
name | **string**<br> 
cluster_id | **string**<br> 
type | enum **MlModelType**<br> <ul><ul/>
uri | **string**<br> 


## Update {#Update}



**rpc Update ([UpdateMlModelRequest](#UpdateMlModelRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateMlModelMetadata](#UpdateMlModelMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[MlModel](#MlModel3)<br>

### UpdateMlModelRequest {#UpdateMlModelRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required.   The maximum string length in characters is 50.
ml_mode_name | **string**<br>Required.   The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br> 
uri | **string**<br> 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateMlModelMetadata](#UpdateMlModelMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[MlModel](#MlModel3)>**<br>if operation finished successfully. 


### UpdateMlModelMetadata {#UpdateMlModelMetadata}

Field | Description
--- | ---
cluster_id | **string**<br> 
ml_model_name | **string**<br> 


### MlModel {#MlModel}

Field | Description
--- | ---
name | **string**<br> 
cluster_id | **string**<br> 
type | enum **MlModelType**<br> <ul><ul/>
uri | **string**<br> 


## Delete {#Delete}



**rpc Delete ([DeleteMlModelRequest](#DeleteMlModelRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteMlModelMetadata](#DeleteMlModelMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteMlModelRequest {#DeleteMlModelRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required.   The maximum string length in characters is 50.
ml_model_name | **string**<br>Required.   The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteMlModelMetadata](#DeleteMlModelMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteMlModelMetadata {#DeleteMlModelMetadata}

Field | Description
--- | ---
cluster_id | **string**<br> 
ml_model_name | **string**<br> 


