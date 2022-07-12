---
editable: false
---

# MlModelService

A set of methods for managing machine learning models.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified machine learning model. |
| [List](#List) | Retrieves the list of machine learning models in the specified cluster. |
| [Create](#Create) | Creates a machine learning model in the specified cluster. |
| [Update](#Update) | Updates the specified machine learning model. |
| [Delete](#Delete) | Deletes the specified machine learning model. |

## Calls MlModelService {#calls}

## Get {#Get}

Returns the specified machine learning model. <br>To get the list of all available models, make a [List](#List) request.

**rpc Get ([GetMlModelRequest](#GetMlModelRequest)) returns ([MlModel](#MlModel))**

### GetMlModelRequest {#GetMlModelRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the cluster that the model belongs to. The maximum string length in characters is 50.
ml_model_name | **string**<br>Required. Name of the model to return. <br>To get a model name make a [MlModelService.List](#List) request. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### MlModel {#MlModel}

Field | Description
--- | ---
name | **string**<br>Name of the the model. 
cluster_id | **string**<br>ID of the ClickHouse cluster that the model belongs to. 
type | enum **MlModelType**<br>Type of the model. <ul><li>`ML_MODEL_TYPE_CATBOOST`: CatBoost model.</li></ul>
uri | **string**<br>Model file URL. You can only use models stored in Object Storage. 


## List {#List}

Retrieves the list of machine learning models in the specified cluster.

**rpc List ([ListMlModelsRequest](#ListMlModelsRequest)) returns ([ListMlModelsResponse](#ListMlModelsResponse))**

### ListMlModelsRequest {#ListMlModelsRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the cluster that models belongs to. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListMlModelsResponse.next_page_token](#ListMlModelsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListMlModelsResponse.next_page_token](#ListMlModelsResponse) returned by the previous list request. The maximum string length in characters is 100.


### ListMlModelsResponse {#ListMlModelsResponse}

Field | Description
--- | ---
ml_models[] | **[MlModel](#MlModel1)**<br>List of models in the specified cluster. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListMlModelsRequest.page_size](#ListMlModelsRequest), use `next_page_token` as the value for the [ListMlModelsRequest.page_token](#ListMlModelsRequest) parameter in the next list request. <br>Each subsequent page will have its own `next_page_token` to continue paging through the results. 


### MlModel {#MlModel1}

Field | Description
--- | ---
name | **string**<br>Name of the the model. 
cluster_id | **string**<br>ID of the ClickHouse cluster that the model belongs to. 
type | enum **MlModelType**<br>Type of the model. <ul><li>`ML_MODEL_TYPE_CATBOOST`: CatBoost model.</li></ul>
uri | **string**<br>Model file URL. You can only use models stored in Object Storage. 


## Create {#Create}

Creates a machine learning model in the specified cluster.

**rpc Create ([CreateMlModelRequest](#CreateMlModelRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateMlModelMetadata](#CreateMlModelMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[MlModel](#MlModel2)<br>

### CreateMlModelRequest {#CreateMlModelRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the cluster to create a model in. <br>To get a cluster ID make a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
ml_model_name | **string**<br>Required. Model name. The model name is one of the arguments of the modelEvaluate() function, which is used to call the model in ClickHouse. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
type | enum **MlModelType**<br>Required. Type of the model. <ul><li>`ML_MODEL_TYPE_CATBOOST`: CatBoost model.</li></ul>
uri | **string**<br>Required. Model file URL. You can only use models stored in Object Storage. 


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
cluster_id | **string**<br>ID of the cluster that a model is being added to. 
ml_model_name | **string**<br>Name of the the model that is being created. 


### MlModel {#MlModel2}

Field | Description
--- | ---
name | **string**<br>Name of the the model. 
cluster_id | **string**<br>ID of the ClickHouse cluster that the model belongs to. 
type | enum **MlModelType**<br>Type of the model. <ul><li>`ML_MODEL_TYPE_CATBOOST`: CatBoost model.</li></ul>
uri | **string**<br>Model file URL. You can only use models stored in Object Storage. 


## Update {#Update}

Updates the specified machine learning model.

**rpc Update ([UpdateMlModelRequest](#UpdateMlModelRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateMlModelMetadata](#UpdateMlModelMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[MlModel](#MlModel3)<br>

### UpdateMlModelRequest {#UpdateMlModelRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the cluster to update the model in. <br>To get a cluster ID make a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
ml_model_name | **string**<br>Required. Name of the the model to update. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br> 
uri | **string**<br>The new model file URL. You can only use models stored in Object Storage. 


### Operation {#Operation1}

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
cluster_id | **string**<br>ID of the cluster that contains the model being updated. 
ml_model_name | **string**<br>Name of the the model that is being updated. 


### MlModel {#MlModel3}

Field | Description
--- | ---
name | **string**<br>Name of the the model. 
cluster_id | **string**<br>ID of the ClickHouse cluster that the model belongs to. 
type | enum **MlModelType**<br>Type of the model. <ul><li>`ML_MODEL_TYPE_CATBOOST`: CatBoost model.</li></ul>
uri | **string**<br>Model file URL. You can only use models stored in Object Storage. 


## Delete {#Delete}

Deletes the specified machine learning model.

**rpc Delete ([DeleteMlModelRequest](#DeleteMlModelRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteMlModelMetadata](#DeleteMlModelMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteMlModelRequest {#DeleteMlModelRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the cluster to delete the model in. <br>To get a cluster ID make a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
ml_model_name | **string**<br>Required. Name of the the model to delete. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_-]* `.


### Operation {#Operation2}

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
cluster_id | **string**<br>ID of the cluster that contains the model being deleted. 
ml_model_name | **string**<br>Name of the the model that is being deleted. 


