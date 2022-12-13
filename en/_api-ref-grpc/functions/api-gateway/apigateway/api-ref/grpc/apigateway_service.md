---
editable: false
---

# API Gateway Service, gRPC: ApiGatewayService

A set of methods for managing API gateways.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified API gateway. |
| [List](#List) | Retrieves the list of API gateways in the specified folder. |
| [Create](#Create) | Creates an API gateway in the specified folder. |
| [Update](#Update) | Updates the specified API gateway. |
| [Delete](#Delete) | Deletes the specified API gateway. |
| [AddDomain](#AddDomain) | Attaches domain to the specified API gateway. |
| [RemoveDomain](#RemoveDomain) | Detaches domain from the specified API gateway. |
| [GetOpenapiSpec](#GetOpenapiSpec) | Returns the OpenAPI specification of specified API gateway. |
| [ListOperations](#ListOperations) | Lists operations for the specified API gateway. |
| [ListAccessBindings](#ListAccessBindings) | Lists existing access bindings for the specified API gateway. |
| [SetAccessBindings](#SetAccessBindings) | Sets access bindings for the specified API gateway. |
| [UpdateAccessBindings](#UpdateAccessBindings) | Updates access bindings for the specified API gateway. |

## Calls ApiGatewayService {#calls}

## Get {#Get}

Returns the specified API gateway. Note that only API gateway basic attributes are returned. To get associated openapi specification, make a [GetOpenapiSpec](getOpenapiSpec) request. <br>To get the list of all available API gateways, make a [List](#List) request.

**rpc Get ([GetApiGatewayRequest](#GetApiGatewayRequest)) returns ([ApiGateway](#ApiGateway))**

### GetApiGatewayRequest {#GetApiGatewayRequest}

Field | Description
--- | ---
api_gateway_id | **string**<br>Required. ID of the API gateway to return. <br>To get a API gateway ID make a [ApiGatewayService.List](#List) request. 


### ApiGateway {#ApiGateway}

Field | Description
--- | ---
id | **string**<br>ID of the API gateway. Generated at creation time. 
folder_id | **string**<br>ID of the folder that the API gateway belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the API-gateway. 
name | **string**<br>Name of the API gateway. The name is unique within the folder. 
description | **string**<br>Description of the API gateway. 
labels | **map<string,string>**<br>API gateway labels as `key:value` pairs. 
status | enum **Status**<br>Status of the API gateway. <ul><li>`CREATING`: API gateway is being created.</li><li>`ACTIVE`: API gateway is ready for use.</li><li>`DELETING`: API gateway is being deleted.</li><li>`ERROR`: API gateway failed. The only allowed action is delete.</li><li>`UPDATING`: API gateway is being updated.</li></ul>
domain | **string**<br>Default domain for the API gateway. Generated at creation time. 
log_group_id | **string**<br>ID of the log group for the API gateway. 
attached_domains[] | **[AttachedDomain](#AttachedDomain)**<br>List of domains attached to API gateway. 
connectivity | **[Connectivity](#Connectivity)**<br>Network access. If specified the gateway will be attached to specified network/subnet(s). 


### AttachedDomain {#AttachedDomain}

Field | Description
--- | ---
domain_id | **string**<br>ID of the domain. 
certificate_id | **string**<br>ID of the domain certificate. 
enabled | **bool**<br>Enabling flag. 
domain | **string**<br>Name of the domain. 


### Connectivity {#Connectivity}

Field | Description
--- | ---
network_id | **string**<br>Network the gateway will have access to. It's essential to specify network with subnets in all availability zones. 
subnet_id[] | **string**<br>Complete list of subnets (from the same network) the gateway can be attached to. It's essential to specify at least one subnet for each availability zones. 


## List {#List}

Retrieves the list of API gateways in the specified folder.

**rpc List ([ListApiGatewayRequest](#ListApiGatewayRequest)) returns ([ListApiGatewayResponse](#ListApiGatewayResponse))**

### ListApiGatewayRequest {#ListApiGatewayRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list API gateways in. <br>To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. 
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `pageSize`, the service returns a [ListApiGatewayResponse.next_page_token](#ListApiGatewayResponse) that can be used to get the next page of results in subsequent list requests. <br>Default value: 100. 
page_token | **string**<br>Page token. To get the next page of results, set `pageToken` to the [ListApiGatewayResponse.next_page_token](#ListApiGatewayResponse) returned by a previous list request. 
filter | **string**<br>A filter expression that filters functions listed in the response. <br>The expression must specify: <ol><li>The field name. Currently filtering can only be applied to the [ApiGateway.name](index) field. </li><li>An `=` operator. </li><li>The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z]([-a-z0-9]{0,61}[a-z0-9])?`. </li></ol>Example of a filter: `name=my-apigw`. 


### ListApiGatewayResponse {#ListApiGatewayResponse}

Field | Description
--- | ---
api_gateways[] | **[ApiGateway](#ApiGateway1)**<br>List of API gateways in the specified folder. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListApiGatewayRequest.page_size](#ListApiGatewayRequest), use `nextPageToken` as the value for the [ListApiGatewayRequest.page_token](#ListApiGatewayRequest) parameter in the next list request. <br>Each subsequent page will have its own `nextPageToken` to continue paging through the results. 


### ApiGateway {#ApiGateway1}

Field | Description
--- | ---
id | **string**<br>ID of the API gateway. Generated at creation time. 
folder_id | **string**<br>ID of the folder that the API gateway belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the API-gateway. 
name | **string**<br>Name of the API gateway. The name is unique within the folder. 
description | **string**<br>Description of the API gateway. 
labels | **map<string,string>**<br>API gateway labels as `key:value` pairs. 
status | enum **Status**<br>Status of the API gateway. <ul><li>`CREATING`: API gateway is being created.</li><li>`ACTIVE`: API gateway is ready for use.</li><li>`DELETING`: API gateway is being deleted.</li><li>`ERROR`: API gateway failed. The only allowed action is delete.</li><li>`UPDATING`: API gateway is being updated.</li></ul>
domain | **string**<br>Default domain for the API gateway. Generated at creation time. 
log_group_id | **string**<br>ID of the log group for the API gateway. 
attached_domains[] | **[AttachedDomain](#AttachedDomain1)**<br>List of domains attached to API gateway. 
connectivity | **[Connectivity](#Connectivity1)**<br>Network access. If specified the gateway will be attached to specified network/subnet(s). 


### AttachedDomain {#AttachedDomain1}

Field | Description
--- | ---
domain_id | **string**<br>ID of the domain. 
certificate_id | **string**<br>ID of the domain certificate. 
enabled | **bool**<br>Enabling flag. 
domain | **string**<br>Name of the domain. 


### Connectivity {#Connectivity1}

Field | Description
--- | ---
network_id | **string**<br>Network the gateway will have access to. It's essential to specify network with subnets in all availability zones. 
subnet_id[] | **string**<br>Complete list of subnets (from the same network) the gateway can be attached to. It's essential to specify at least one subnet for each availability zones. 


## Create {#Create}

Creates an API gateway in the specified folder.

**rpc Create ([CreateApiGatewayRequest](#CreateApiGatewayRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateApiGatewayMetadata](#CreateApiGatewayMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[ApiGateway](#ApiGateway2)<br>

### CreateApiGatewayRequest {#CreateApiGatewayRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create an API gateway in. <br>To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. 
name | **string**<br>Name of the API gateway. The name must be unique within the folder. Value must match the regular expression ` \|[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the API gateway. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
spec | **oneof:** `openapi_spec`<br>OpenAPI specification of API gateway.
&nbsp;&nbsp;openapi_spec | **string**<br>The text of specification, JSON or YAML. 
connectivity | **[Connectivity](#Connectivity2)**<br>Gateway connectivity. If specified the gateway will be attached to specified network/subnet(s). 


### Connectivity {#Connectivity2}

Field | Description
--- | ---
network_id | **string**<br>Network the gateway will have access to. It's essential to specify network with subnets in all availability zones. 
subnet_id[] | **string**<br>Complete list of subnets (from the same network) the gateway can be attached to. It's essential to specify at least one subnet for each availability zones. 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateApiGatewayMetadata](#CreateApiGatewayMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[ApiGateway](#ApiGateway2)>**<br>if operation finished successfully. 


### CreateApiGatewayMetadata {#CreateApiGatewayMetadata}

Field | Description
--- | ---
api_gateway_id | **string**<br>ID of the API gateway that is being created. 


### ApiGateway {#ApiGateway2}

Field | Description
--- | ---
id | **string**<br>ID of the API gateway. Generated at creation time. 
folder_id | **string**<br>ID of the folder that the API gateway belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the API-gateway. 
name | **string**<br>Name of the API gateway. The name is unique within the folder. 
description | **string**<br>Description of the API gateway. 
labels | **map<string,string>**<br>API gateway labels as `key:value` pairs. 
status | enum **Status**<br>Status of the API gateway. <ul><li>`CREATING`: API gateway is being created.</li><li>`ACTIVE`: API gateway is ready for use.</li><li>`DELETING`: API gateway is being deleted.</li><li>`ERROR`: API gateway failed. The only allowed action is delete.</li><li>`UPDATING`: API gateway is being updated.</li></ul>
domain | **string**<br>Default domain for the API gateway. Generated at creation time. 
log_group_id | **string**<br>ID of the log group for the API gateway. 
attached_domains[] | **[AttachedDomain](#AttachedDomain2)**<br>List of domains attached to API gateway. 
connectivity | **[Connectivity](#Connectivity3)**<br>Network access. If specified the gateway will be attached to specified network/subnet(s). 


### AttachedDomain {#AttachedDomain2}

Field | Description
--- | ---
domain_id | **string**<br>ID of the domain. 
certificate_id | **string**<br>ID of the domain certificate. 
enabled | **bool**<br>Enabling flag. 
domain | **string**<br>Name of the domain. 


## Update {#Update}

Updates the specified API gateway.

**rpc Update ([UpdateApiGatewayRequest](#UpdateApiGatewayRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateApiGatewayMetadata](#UpdateApiGatewayMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[ApiGateway](#ApiGateway3)<br>

### UpdateApiGatewayRequest {#UpdateApiGatewayRequest}

Field | Description
--- | ---
api_gateway_id | **string**<br>Required. ID of the API gateway to update. <br>To get a API gateway ID make a [ApiGatewayService.List](#List) request. 
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which attributes of the API gateway should be updated. 
name | **string**<br>New name for the API gateway. The name must be unique within the folder. Value must match the regular expression ` \|[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>New description for the API gateway. The maximum string length in characters is 256.
labels | **map<string,string>**<br>API gateway labels as `key:value` pairs. <br>Existing set of labels is completely replaced by the provided set, so if you just want to add or remove a label, request the current set of labels with a [yandex.cloud.serverless.apigateway.v1.ApiGatewayService.Get](/docs/functions/api-gateway/api-ref/grpc/apigateway_service#Get) request. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
spec | **oneof:** `openapi_spec`<br>New OpenAPI specification of API gateway.
&nbsp;&nbsp;openapi_spec | **string**<br>The text of specification, JSON or YAML. 
connectivity | **[Connectivity](#Connectivity3)**<br>Gateway connectivity. If specified the gateway will be attached to specified network/subnet(s). 


### Connectivity {#Connectivity3}

Field | Description
--- | ---
network_id | **string**<br>Network the gateway will have access to. It's essential to specify network with subnets in all availability zones. 
subnet_id[] | **string**<br>Complete list of subnets (from the same network) the gateway can be attached to. It's essential to specify at least one subnet for each availability zones. 


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateApiGatewayMetadata](#UpdateApiGatewayMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[ApiGateway](#ApiGateway3)>**<br>if operation finished successfully. 


### UpdateApiGatewayMetadata {#UpdateApiGatewayMetadata}

Field | Description
--- | ---
api_gateway_id | **string**<br>ID of the API gateway that is being updated. 


### ApiGateway {#ApiGateway3}

Field | Description
--- | ---
id | **string**<br>ID of the API gateway. Generated at creation time. 
folder_id | **string**<br>ID of the folder that the API gateway belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp for the API-gateway. 
name | **string**<br>Name of the API gateway. The name is unique within the folder. 
description | **string**<br>Description of the API gateway. 
labels | **map<string,string>**<br>API gateway labels as `key:value` pairs. 
status | enum **Status**<br>Status of the API gateway. <ul><li>`CREATING`: API gateway is being created.</li><li>`ACTIVE`: API gateway is ready for use.</li><li>`DELETING`: API gateway is being deleted.</li><li>`ERROR`: API gateway failed. The only allowed action is delete.</li><li>`UPDATING`: API gateway is being updated.</li></ul>
domain | **string**<br>Default domain for the API gateway. Generated at creation time. 
log_group_id | **string**<br>ID of the log group for the API gateway. 
attached_domains[] | **[AttachedDomain](#AttachedDomain3)**<br>List of domains attached to API gateway. 
connectivity | **[Connectivity](#Connectivity4)**<br>Network access. If specified the gateway will be attached to specified network/subnet(s). 


### AttachedDomain {#AttachedDomain3}

Field | Description
--- | ---
domain_id | **string**<br>ID of the domain. 
certificate_id | **string**<br>ID of the domain certificate. 
enabled | **bool**<br>Enabling flag. 
domain | **string**<br>Name of the domain. 


## Delete {#Delete}

Deletes the specified API gateway.

**rpc Delete ([DeleteApiGatewayRequest](#DeleteApiGatewayRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteApiGatewayMetadata](#DeleteApiGatewayMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteApiGatewayRequest {#DeleteApiGatewayRequest}

Field | Description
--- | ---
api_gateway_id | **string**<br>Required. ID of the API gateway to update. <br>To get a API gateway ID make a [ApiGatewayService.List](#List) request. 


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteApiGatewayMetadata](#DeleteApiGatewayMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteApiGatewayMetadata {#DeleteApiGatewayMetadata}

Field | Description
--- | ---
api_gateway_id | **string**<br>ID of the API gateway that is being deleted. 


## AddDomain {#AddDomain}

Attaches domain to the specified API gateway.

**rpc AddDomain ([AddDomainRequest](#AddDomainRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[AddDomainMetadata](#AddDomainMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### AddDomainRequest {#AddDomainRequest}

Field | Description
--- | ---
api_gateway_id | **string**<br>Required. ID of the API gateway that the domain is attached to. 
domain_name | **string**<br>Name of the attaching domain. 
certificate_id | **string**<br>ID of certificate for the attaching domain. 


### Operation {#Operation3}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[AddDomainMetadata](#AddDomainMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### AddDomainMetadata {#AddDomainMetadata}

Field | Description
--- | ---
api_gateway_id | **string**<br>ID of the API gateway that the domain is attached to. 
domain_id | **string**<br>ID of the attached domain. 
domain_name | **string**<br>Name of the attaching domain. 
certificate_id | **string**<br>ID of the certificate for provided domain. 


## RemoveDomain {#RemoveDomain}

Detaches domain from the specified API gateway.

**rpc RemoveDomain ([RemoveDomainRequest](#RemoveDomainRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RemoveDomainMetadata](#RemoveDomainMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### RemoveDomainRequest {#RemoveDomainRequest}

Field | Description
--- | ---
api_gateway_id | **string**<br>Required. ID of the API gateway from which the domain is being detached. 
domain_id | **string**<br>Required. ID of the detaching domain. 


### Operation {#Operation4}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[RemoveDomainMetadata](#RemoveDomainMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### RemoveDomainMetadata {#RemoveDomainMetadata}

Field | Description
--- | ---
api_gateway_id | **string**<br>ID of the API gateway from which the domain is being detached. 
domain_id | **string**<br>ID of the detaching domain. 


## GetOpenapiSpec {#GetOpenapiSpec}

Returns the OpenAPI specification of specified API gateway.

**rpc GetOpenapiSpec ([GetOpenapiSpecRequest](#GetOpenapiSpecRequest)) returns ([GetOpenapiSpecResponse](#GetOpenapiSpecResponse))**

### GetOpenapiSpecRequest {#GetOpenapiSpecRequest}

Field | Description
--- | ---
api_gateway_id | **string**<br>Required. ID of the API gateway to get specification from. 
format | enum **Format**<br>Format of returned specification. Default is the original format used in [CreateApiGatewayRequest](#CreateApiGatewayRequest). 


### GetOpenapiSpecResponse {#GetOpenapiSpecResponse}

Field | Description
--- | ---
api_gateway_id | **string**<br>ID of the API gateway. 
openapi_spec | **string**<br>The text of specification, JSON or YAML. 


## ListOperations {#ListOperations}

Lists operations for the specified API gateway.

**rpc ListOperations ([ListOperationsRequest](#ListOperationsRequest)) returns ([ListOperationsResponse](#ListOperationsResponse))**

### ListOperationsRequest {#ListOperationsRequest}

Field | Description
--- | ---
api_gateway_id | **string**<br>Required. ID of the API gateway to list operations for. 
page_size | **int64**<br>The maximum number of results per page that should be returned. If the number of available results is larger than `pageSize`, the service returns a [ListOperationsResponse.next_page_token](#ListOperationsResponse) that can be used to get the next page of results in subsequent list requests. <br>Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `pageToken` to the [ListOperationsResponse.next_page_token](#ListOperationsResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. <br>The expression must specify: <ol><li>The field name. Currently filtering can be applied to the [operation.Operation.done](#Operation5), [operation.Operation.created_by](#Operation5) field. </li><li>An `=` operator. </li><li>The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. </li></ol>Examples of a filter: `done=false`, `created_by='John.Doe'`. The maximum string length in characters is 1000.


### ListOperationsResponse {#ListOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation5)**<br>List of operations for the specified API gateway. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListOperationsRequest.page_size](#ListOperationsRequest), use `nextPageToken` as the value for the [ListOperationsRequest.page_token](#ListOperationsRequest) parameter in the next list request. <br>Each subsequent page will have its own `nextPageToken` to continue paging through the results. 


### Operation {#Operation5}

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


## ListAccessBindings {#ListAccessBindings}

Lists existing access bindings for the specified API gateway.

**rpc ListAccessBindings ([ListAccessBindingsRequest](#ListAccessBindingsRequest)) returns ([ListAccessBindingsResponse](#ListAccessBindingsResponse))**

### ListAccessBindingsRequest {#ListAccessBindingsRequest}

Field | Description
--- | ---
resource_id | **string**<br>Required. ID of the resource to list access bindings for. <br>To get the resource ID, use a corresponding List request. For example, use the [yandex.cloud.resourcemanager.v1.CloudService.List](/docs/resource-manager/api-ref/grpc/cloud_service#List) request to get the Cloud resource ID. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page that should be returned. If the number of available results is larger than `page_size`, the service returns a [ListAccessBindingsResponse.next_page_token](#ListAccessBindingsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token. Set `page_token` to the [ListAccessBindingsResponse.next_page_token](#ListAccessBindingsResponse) returned by a previous list request to get the next page of results. The maximum string length in characters is 100.


### ListAccessBindingsResponse {#ListAccessBindingsResponse}

Field | Description
--- | ---
access_bindings[] | **[AccessBinding](#AccessBinding)**<br>List of access bindings for the specified resource. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListAccessBindingsRequest.page_size](#ListAccessBindingsRequest), use the `next_page_token` as the value for the [ListAccessBindingsRequest.page_token](#ListAccessBindingsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### AccessBinding {#AccessBinding}

Field | Description
--- | ---
role_id | **string**<br>Required. ID of the `yandex.cloud.iam.v1.Role` that is assigned to the `subject`. The maximum string length in characters is 50.
subject | **[Subject](#Subject)**<br>Required. Identity for which access binding is being created. It can represent an account with a unique ID or several accounts with a system identifier. 


### Subject {#Subject}

Field | Description
--- | ---
id | **string**<br>Required. ID of the subject. <br>It can contain one of the following values: <ul><li>`allAuthenticatedUsers`: A special system identifier that represents anyone </li></ul>who is authenticated. It can be used only if the `type` is `system`. <ul><li>`allUsers`: A special system identifier that represents anyone. No authentication is required. </li></ul>For example, you don't need to specify the IAM token in an API query. <ul><li>`<cloud generated id>`: An identifier that represents a user account. </li></ul>It can be used only if the `type` is `userAccount`, `federatedUser` or `serviceAccount`. The maximum string length in characters is 50.
type | **string**<br>Required. Type of the subject. <br>It can contain one of the following values: <ul><li>`userAccount`: An account on Yandex or Yandex.Connect, added to Yandex.Cloud. </li><li>`serviceAccount`: A service account. This type represents the `yandex.cloud.iam.v1.ServiceAccount` resource. </li><li>`federatedUser`: A federated account. This type represents a user from an identity federation, like Active Directory. </li><li>`system`: System group. This type represents several accounts with a common system identifier. </li></ul><br>For more information, see [Subject to which the role is assigned](/docs/iam/concepts/access-control/#subject). The maximum string length in characters is 100.


## SetAccessBindings {#SetAccessBindings}

Sets access bindings for the specified API gateway.

**rpc SetAccessBindings ([SetAccessBindingsRequest](#SetAccessBindingsRequest)) returns ([operation.Operation](#Operation6))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[SetAccessBindingsMetadata](#SetAccessBindingsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### SetAccessBindingsRequest {#SetAccessBindingsRequest}

Field | Description
--- | ---
resource_id | **string**<br>Required. ID of the resource for which access bindings are being set. <br>To get the resource ID, use a corresponding List request. The maximum string length in characters is 50.
access_bindings[] | **[AccessBinding](#AccessBinding)**<br>Required. Access bindings to be set. For more information, see [Access Bindings](/docs/iam/concepts/access-control/#access-bindings). 


### AccessBinding {#AccessBinding1}

Field | Description
--- | ---
role_id | **string**<br>Required. ID of the `yandex.cloud.iam.v1.Role` that is assigned to the `subject`. The maximum string length in characters is 50.
subject | **[Subject](#Subject)**<br>Required. Identity for which access binding is being created. It can represent an account with a unique ID or several accounts with a system identifier. 


### Subject {#Subject1}

Field | Description
--- | ---
id | **string**<br>Required. ID of the subject. <br>It can contain one of the following values: <ul><li>`allAuthenticatedUsers`: A special system identifier that represents anyone </li></ul>who is authenticated. It can be used only if the `type` is `system`. <ul><li>`allUsers`: A special system identifier that represents anyone. No authentication is required. </li></ul>For example, you don't need to specify the IAM token in an API query. <ul><li>`<cloud generated id>`: An identifier that represents a user account. </li></ul>It can be used only if the `type` is `userAccount`, `federatedUser` or `serviceAccount`. The maximum string length in characters is 50.
type | **string**<br>Required. Type of the subject. <br>It can contain one of the following values: <ul><li>`userAccount`: An account on Yandex or Yandex.Connect, added to Yandex.Cloud. </li><li>`serviceAccount`: A service account. This type represents the `yandex.cloud.iam.v1.ServiceAccount` resource. </li><li>`federatedUser`: A federated account. This type represents a user from an identity federation, like Active Directory. </li><li>`system`: System group. This type represents several accounts with a common system identifier. </li></ul><br>For more information, see [Subject to which the role is assigned](/docs/iam/concepts/access-control/#subject). The maximum string length in characters is 100.


### Operation {#Operation6}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[SetAccessBindingsMetadata](#SetAccessBindingsMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### SetAccessBindingsMetadata {#SetAccessBindingsMetadata}

Field | Description
--- | ---
resource_id | **string**<br>ID of the resource for which access bindings are being set. 


## UpdateAccessBindings {#UpdateAccessBindings}

Updates access bindings for the specified API gateway.

**rpc UpdateAccessBindings ([UpdateAccessBindingsRequest](#UpdateAccessBindingsRequest)) returns ([operation.Operation](#Operation7))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateAccessBindingsMetadata](#UpdateAccessBindingsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### UpdateAccessBindingsRequest {#UpdateAccessBindingsRequest}

Field | Description
--- | ---
resource_id | **string**<br>Required. ID of the resource for which access bindings are being updated. The maximum string length in characters is 50.
access_binding_deltas[] | **[AccessBindingDelta](#AccessBindingDelta)**<br>Required. Updates to access bindings. The number of elements must be greater than 0.


### AccessBindingDelta {#AccessBindingDelta}

Field | Description
--- | ---
action | enum **AccessBindingAction**<br>Required. The action that is being performed on an access binding. <ul><li>`ADD`: Addition of an access binding.</li><li>`REMOVE`: Removal of an access binding.</li></ul>
access_binding | **[AccessBinding](#AccessBinding)**<br>Required. Access binding. For more information, see [Access Bindings](/docs/iam/concepts/access-control/#access-bindings). 


### AccessBinding {#AccessBinding2}

Field | Description
--- | ---
role_id | **string**<br>Required. ID of the `yandex.cloud.iam.v1.Role` that is assigned to the `subject`. The maximum string length in characters is 50.
subject | **[Subject](#Subject)**<br>Required. Identity for which access binding is being created. It can represent an account with a unique ID or several accounts with a system identifier. 


### Subject {#Subject2}

Field | Description
--- | ---
id | **string**<br>Required. ID of the subject. <br>It can contain one of the following values: <ul><li>`allAuthenticatedUsers`: A special system identifier that represents anyone </li></ul>who is authenticated. It can be used only if the `type` is `system`. <ul><li>`allUsers`: A special system identifier that represents anyone. No authentication is required. </li></ul>For example, you don't need to specify the IAM token in an API query. <ul><li>`<cloud generated id>`: An identifier that represents a user account. </li></ul>It can be used only if the `type` is `userAccount`, `federatedUser` or `serviceAccount`. The maximum string length in characters is 50.
type | **string**<br>Required. Type of the subject. <br>It can contain one of the following values: <ul><li>`userAccount`: An account on Yandex or Yandex.Connect, added to Yandex.Cloud. </li><li>`serviceAccount`: A service account. This type represents the `yandex.cloud.iam.v1.ServiceAccount` resource. </li><li>`federatedUser`: A federated account. This type represents a user from an identity federation, like Active Directory. </li><li>`system`: System group. This type represents several accounts with a common system identifier. </li></ul><br>For more information, see [Subject to which the role is assigned](/docs/iam/concepts/access-control/#subject). The maximum string length in characters is 100.


### Operation {#Operation7}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateAccessBindingsMetadata](#UpdateAccessBindingsMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### UpdateAccessBindingsMetadata {#UpdateAccessBindingsMetadata}

Field | Description
--- | ---
resource_id | **string**<br>ID of the resource for which access bindings are being updated. 


