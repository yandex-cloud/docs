---
editable: false
sourcePath: en/_api-ref-grpc/vpc/api-ref/grpc/gateway_service.md
---

# Virtual Private Cloud API, gRPC: GatewayService



| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified Gateway resource. |
| [List](#List) | Retrieves the list of Gateway resources in the specified folder. |
| [Create](#Create) | Creates a gateway in the specified folder. |
| [Update](#Update) | Updates the specified gateway. |
| [Delete](#Delete) | Deletes the specified gateway. |
| [ListOperations](#ListOperations) | List operations for the specified gateway. |
| [Move](#Move) | Move a gateway to another folder |

## Calls GatewayService {#calls}

## Get {#Get}

Returns the specified Gateway resource. <br>To get the list of all available Gateway resources, make a [List](#List) request.

**rpc Get ([GetGatewayRequest](#GetGatewayRequest)) returns ([Gateway](#Gateway))**

### GetGatewayRequest {#GetGatewayRequest}

Field | Description
--- | ---
gateway_id | **string**<br>Required. ID of the Gateway resource to return. <br>To get Gateway resource ID make a [GatewayService.List](#List) request. The maximum string length in characters is 50.


### Gateway {#Gateway}

Field | Description
--- | ---
id | **string**<br>ID of the gateway. Generated at creation time. 
folder_id | **string**<br>ID of the folder that the gateway belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the gateway. The name is unique within the folder. 
description | **string**<br>Description of the gateway. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 
gateway | **oneof:** `shared_egress_gateway`<br>Gateway specification
&nbsp;&nbsp;shared_egress_gateway | **[SharedEgressGateway](#SharedEgressGateway)**<br>Gateway specification 


### SharedEgressGateway {#SharedEgressGateway}



## List {#List}

Retrieves the list of Gateway resources in the specified folder.

**rpc List ([ListGatewaysRequest](#ListGatewaysRequest)) returns ([ListGatewaysResponse](#ListGatewaysResponse))**

### ListGatewaysRequest {#ListGatewaysRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list gateways in. <br>To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListGatewaysResponse.next_page_token](#ListGatewaysResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListGatewaysResponse.next_page_token](#ListGatewaysResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters Gateway listed in the response. <br>The expression must specify: <ol><li>The field name. Currently you can use filtering only on [Gateway.name](#Gateway1) field. </li><li>An `=` operator. </li><li>The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. </li></ol>Example of a filter: `name=my-gateway`. The maximum string length in characters is 1000.


### ListGatewaysResponse {#ListGatewaysResponse}

Field | Description
--- | ---
gateways[] | **[Gateway](#Gateway1)**<br>List of gateways. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListGatewaysRequest.page_size](#ListGatewaysRequest), use `next_page_token` as the value for the [ListGatewaysRequest.page_token](#ListGatewaysRequest) parameter in the next list request. <br>Each subsequent page will have its own `next_page_token` to continue paging through the results. 


### Gateway {#Gateway1}

Field | Description
--- | ---
id | **string**<br>ID of the gateway. Generated at creation time. 
folder_id | **string**<br>ID of the folder that the gateway belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the gateway. The name is unique within the folder. 
description | **string**<br>Description of the gateway. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 
gateway | **oneof:** `shared_egress_gateway`<br>Gateway specification
&nbsp;&nbsp;shared_egress_gateway | **[SharedEgressGateway](#SharedEgressGateway1)**<br>Gateway specification 


### SharedEgressGateway {#SharedEgressGateway1}



## Create {#Create}

Creates a gateway in the specified folder.

**rpc Create ([CreateGatewayRequest](#CreateGatewayRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateGatewayMetadata](#CreateGatewayMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Gateway](#Gateway2)<br>

### CreateGatewayRequest {#CreateGatewayRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create a gateway in. <br>To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 50.
name | **string**<br>Name of the gateway. The name must be unique within the folder. Value must match the regular expression ` \|[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the gateway. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Gateway labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
gateway | **oneof:** `shared_egress_gateway_spec`<br>Gateway configuration specification
&nbsp;&nbsp;shared_egress_gateway_spec | **[SharedEgressGatewaySpec](#SharedEgressGatewaySpec)**<br>Gateway configuration specification 


### SharedEgressGatewaySpec {#SharedEgressGatewaySpec}



### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateGatewayMetadata](#CreateGatewayMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Gateway](#Gateway2)>**<br>if operation finished successfully. 


### CreateGatewayMetadata {#CreateGatewayMetadata}

Field | Description
--- | ---
gateway_id | **string**<br>ID of the gateway that is being created. 


### Gateway {#Gateway2}

Field | Description
--- | ---
id | **string**<br>ID of the gateway. Generated at creation time. 
folder_id | **string**<br>ID of the folder that the gateway belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the gateway. The name is unique within the folder. 
description | **string**<br>Description of the gateway. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 
gateway | **oneof:** `shared_egress_gateway`<br>Gateway specification
&nbsp;&nbsp;shared_egress_gateway | **[SharedEgressGateway](#SharedEgressGateway2)**<br>Gateway specification 


### SharedEgressGateway {#SharedEgressGateway2}



## Update {#Update}

Updates the specified gateway.

**rpc Update ([UpdateGatewayRequest](#UpdateGatewayRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateGatewayMetadata](#UpdateGatewayMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Gateway](#Gateway3)<br>

### UpdateGatewayRequest {#UpdateGatewayRequest}

Field | Description
--- | ---
gateway_id | **string**<br>Required. ID of the gateway to update. <br>To get the gateway ID make a [GatewayService.List](#List) request. The maximum string length in characters is 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which attributes of the Gateway should be updated. 
name | **string**<br>New name for the gateway. The name must be unique within the folder. Value must match the regular expression ` \|[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>New description of the gateway. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Gateway labels as `key:value` pairs. <br>Existing set of labels is completely replaced by the provided set, so if you just want to add or remove a label: <ol><li>Get the current set of labels with a [GatewayService.Get](#Get) request. </li><li>Add or remove a label in this set. </li><li>Send the new set in this field.</li></ol> No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
gateway | **oneof:** `shared_egress_gateway_spec`<br>New Gateway configuration specification
&nbsp;&nbsp;shared_egress_gateway_spec | **[SharedEgressGatewaySpec](#SharedEgressGatewaySpec)**<br>New Gateway configuration specification 


### SharedEgressGatewaySpec {#SharedEgressGatewaySpec1}



### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateGatewayMetadata](#UpdateGatewayMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Gateway](#Gateway3)>**<br>if operation finished successfully. 


### UpdateGatewayMetadata {#UpdateGatewayMetadata}

Field | Description
--- | ---
gateway_id | **string**<br>ID of the Gateway that is being updated. 


### Gateway {#Gateway3}

Field | Description
--- | ---
id | **string**<br>ID of the gateway. Generated at creation time. 
folder_id | **string**<br>ID of the folder that the gateway belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the gateway. The name is unique within the folder. 
description | **string**<br>Description of the gateway. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 
gateway | **oneof:** `shared_egress_gateway`<br>Gateway specification
&nbsp;&nbsp;shared_egress_gateway | **[SharedEgressGateway](#SharedEgressGateway3)**<br>Gateway specification 


### SharedEgressGateway {#SharedEgressGateway3}



## Delete {#Delete}

Deletes the specified gateway.

**rpc Delete ([DeleteGatewayRequest](#DeleteGatewayRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteGatewayMetadata](#DeleteGatewayMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteGatewayRequest {#DeleteGatewayRequest}

Field | Description
--- | ---
gateway_id | **string**<br>Required. ID of the gateway to delete. <br>To get a gateway ID make a [GatewayService.List](#List) request. The maximum string length in characters is 50.


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteGatewayMetadata](#DeleteGatewayMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteGatewayMetadata {#DeleteGatewayMetadata}

Field | Description
--- | ---
gateway_id | **string**<br>ID of the gateway that is being deleted. 


## ListOperations {#ListOperations}

List operations for the specified gateway.

**rpc ListOperations ([ListGatewayOperationsRequest](#ListGatewayOperationsRequest)) returns ([ListGatewayOperationsResponse](#ListGatewayOperationsResponse))**

### ListGatewayOperationsRequest {#ListGatewayOperationsRequest}

Field | Description
--- | ---
gateway_id | **string**<br>Required. ID of the gateway to list operations for. <br>To get a gateway ID make a [GatewayService.List](#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListGatewayOperationsResponse.next_page_token](#ListGatewayOperationsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListGatewayOperationsResponse.next_page_token](#ListGatewayOperationsResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListGatewayOperationsResponse {#ListGatewayOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation3)**<br>List of operations for the specified gateway. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListGatewayOperationsRequest.page_size](#ListGatewayOperationsRequest), use `next_page_token` as the value for the [ListGatewayOperationsRequest.page_token](#ListGatewayOperationsRequest) parameter in the next list request. <br>Each subsequent page will have its own `next_page_token` to continue paging through the results. 


### Operation {#Operation3}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**<br>The normal response of the operation in case of success. If the original method returns no data on success, such as Delete, the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty). If the original method is the standard Create/Update, the response should be the target resource of the operation. Any method that returns a long-running operation should document the response type, if any. 


## Move {#Move}

Move a gateway to another folder

**rpc Move ([MoveGatewayRequest](#MoveGatewayRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[MoveGatewayMetadata](#MoveGatewayMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Gateway](#Gateway4)<br>

### MoveGatewayRequest {#MoveGatewayRequest}

Field | Description
--- | ---
gateway_id | **string**<br>Required.  The maximum string length in characters is 50.
destination_folder_id | **string**<br>Required.  The maximum string length in characters is 50.


### Operation {#Operation4}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[MoveGatewayMetadata](#MoveGatewayMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Gateway](#Gateway4)>**<br>if operation finished successfully. 


### MoveGatewayMetadata {#MoveGatewayMetadata}

Field | Description
--- | ---
gateway_id | **string**<br> 


### Gateway {#Gateway4}

Field | Description
--- | ---
id | **string**<br>ID of the gateway. Generated at creation time. 
folder_id | **string**<br>ID of the folder that the gateway belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the gateway. The name is unique within the folder. 
description | **string**<br>Description of the gateway. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 
gateway | **oneof:** `shared_egress_gateway`<br>Gateway specification
&nbsp;&nbsp;shared_egress_gateway | **[SharedEgressGateway](#SharedEgressGateway4)**<br>Gateway specification 


### SharedEgressGateway {#SharedEgressGateway4}



