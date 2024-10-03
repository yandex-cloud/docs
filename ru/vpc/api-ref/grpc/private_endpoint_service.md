---
editable: false
sourcePath: en/_api-ref-grpc/vpc/api-ref/grpc/private_endpoint_service.md
---

# Virtual Private Cloud API, gRPC: PrivateEndpointService

A set of methods for managing PrivateEndpoint resources.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified Private Endpoint resource. |
| [List](#List) | Retrieves the list of PrivateEndpoint resources in the specified folder. |
| [Create](#Create) | Creates an private endpoint in the specified folder and network. |
| [Update](#Update) | Updates the specified private endpoint. |
| [Delete](#Delete) | Deletes the specified private endpoint. |
| [ListOperations](#ListOperations) | List operations for the specified private endpoint. |

## Calls PrivateEndpointService {#calls}

## Get {#Get}

Returns the specified Private Endpoint resource. <br>To get the list of all available PrivateEndpoint resources, make a [List](#List) request.

**rpc Get ([GetPrivateEndpointRequest](#GetPrivateEndpointRequest)) returns ([PrivateEndpoint](#PrivateEndpoint))**

### GetPrivateEndpointRequest {#GetPrivateEndpointRequest}

Field | Description
--- | ---
private_endpoint_id | **string**<br>Required. ID of the PrivateEndpoint resource to return. <br>To get PrivateEndpoint resource ID make a [PrivateEndpointService.List](#List) request. The maximum string length in characters is 50.


### PrivateEndpoint {#PrivateEndpoint}

Field | Description
--- | ---
id | **string**<br>ID of the private endpoint. Generated at creation time. 
folder_id | **string**<br>ID of the folder that the private endpoint belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the private endpoint. The name is unique within the folder. Value must match the regular expression ``\|[a-zA-Z]([-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])?``. 
description | **string**<br>Description of the private endpoint. 0-256 characters long. 
labels | **map<string,string>**<br>Private endpoint labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression `[-_0-9a-z]*`. The string length in characters for each key must be 1-63. Each key must match the regular expression `[a-z][-_0-9a-z]*`. 
network_id | **string**<br>ID of the network that the private endpoint belongs to. 
status | enum **Status**<br>Status of the private endpoint. <ul><li>`PENDING`: Private endpoint is still creating / updating.</li><li>`AVAILABLE`: Private endpoint is available.</li><li>`DELETING`: Private endpoint is deleting.</li></ul>
address | **[EndpointAddress](#EndpointAddress)**<br>Private endpoint ip address details. 
dns_options | **[DnsOptions](#DnsOptions)**<br>Private endpoint dns options. 
service | **oneof:** `object_storage`<br>Service to connect with via private endpoint.
&nbsp;&nbsp;object_storage | **[ObjectStorage](#ObjectStorage)**<br>Yandex Cloud Object Storage. 


### ObjectStorage {#ObjectStorage}

Empty.

### DnsOptions {#DnsOptions}

Field | Description
--- | ---
private_dns_records_enabled | **bool**<br>If enabled - vpc will create private dns records for specified service. 


### EndpointAddress {#EndpointAddress}

Field | Description
--- | ---
subnet_id | **string**<br>ID of the subnet that the private endpoint address belongs to. 
address | **string**<br>IP address of the private endpoint. 
address_id | **string**<br>ID of the private endpoint address. 


## List {#List}

Retrieves the list of PrivateEndpoint resources in the specified folder.

**rpc List ([ListPrivateEndpointsRequest](#ListPrivateEndpointsRequest)) returns ([ListPrivateEndpointsResponse](#ListPrivateEndpointsResponse))**

### ListPrivateEndpointsRequest {#ListPrivateEndpointsRequest}

Field | Description
--- | ---
container | **oneof:** `folder_id`<br>
&nbsp;&nbsp;folder_id | **string**<br>ID of the folder to list private endpoints in. <br>To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListPrivateEndpointsResponse.next_page_token](#ListPrivateEndpointsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListPrivateEndpointsResponse.next_page_token](#ListPrivateEndpointsResponse) returned by a previous list request. The maximum string length in characters is 1000.
filter | **string**<br>A filter expression that filters PrivateEndpoint listed in the response. <br>The expression must specify: <ol><li>The field name. Currently you can use filtering only on </li></ol>[PrivateEndpoint.name](#PrivateEndpoint1) field. <ol><li>An `=` operator. </li><li>The value in double quotes (`"`). Must be 3-63 characters long and match </li></ol>the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`. Example of a filter: `name=my-private-endpoint`. The maximum string length in characters is 1000.


### ListPrivateEndpointsResponse {#ListPrivateEndpointsResponse}

Field | Description
--- | ---
private_endpoints[] | **[PrivateEndpoint](#PrivateEndpoint1)**<br>List of private endpoints. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListPrivateEndpointsRequest.page_size](#ListPrivateEndpointsRequest), use `next_page_token` as the value for the [ListPrivateEndpointsRequest.page_token](#ListPrivateEndpointsRequest) parameter in the next list request. <br>Each subsequent page will have its own `next_page_token` to continue paging through the results. 


### PrivateEndpoint {#PrivateEndpoint1}

Field | Description
--- | ---
id | **string**<br>ID of the private endpoint. Generated at creation time. 
folder_id | **string**<br>ID of the folder that the private endpoint belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the private endpoint. The name is unique within the folder. Value must match the regular expression ``\|[a-zA-Z]([-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])?``. 
description | **string**<br>Description of the private endpoint. 0-256 characters long. 
labels | **map<string,string>**<br>Private endpoint labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression `[-_0-9a-z]*`. The string length in characters for each key must be 1-63. Each key must match the regular expression `[a-z][-_0-9a-z]*`. 
network_id | **string**<br>ID of the network that the private endpoint belongs to. 
status | enum **Status**<br>Status of the private endpoint. <ul><li>`PENDING`: Private endpoint is still creating / updating.</li><li>`AVAILABLE`: Private endpoint is available.</li><li>`DELETING`: Private endpoint is deleting.</li></ul>
address | **[EndpointAddress](#EndpointAddress1)**<br>Private endpoint ip address details. 
dns_options | **[DnsOptions](#DnsOptions1)**<br>Private endpoint dns options. 
service | **oneof:** `object_storage`<br>Service to connect with via private endpoint.
&nbsp;&nbsp;object_storage | **[ObjectStorage](#ObjectStorage1)**<br>Yandex Cloud Object Storage. 


### ObjectStorage {#ObjectStorage1}

Empty.

### DnsOptions {#DnsOptions1}

Field | Description
--- | ---
private_dns_records_enabled | **bool**<br>If enabled - vpc will create private dns records for specified service. 


### EndpointAddress {#EndpointAddress1}

Field | Description
--- | ---
subnet_id | **string**<br>ID of the subnet that the private endpoint address belongs to. 
address | **string**<br>IP address of the private endpoint. 
address_id | **string**<br>ID of the private endpoint address. 


## Create {#Create}

Creates an private endpoint in the specified folder and network.

**rpc Create ([CreatePrivateEndpointRequest](#CreatePrivateEndpointRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreatePrivateEndpointMetadata](#CreatePrivateEndpointMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[PrivateEndpoint](#PrivateEndpoint2)<br>

### CreatePrivateEndpointRequest {#CreatePrivateEndpointRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create a private endpoint in. <br>To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 50.
name | **string**<br>Name of the private endpoint. The name must be unique within the folder. Value must match the regular expression ` \|[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the private endpoint. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Private endpoint labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
network_id | **string**<br>Required. ID of the network to create a private endpoint in. The maximum string length in characters is 50.
address_spec | **[AddressSpec](#AddressSpec)**<br>Private endpoint address specification. 
dns_options | **[PrivateEndpoint.DnsOptions](#PrivateEndpoint2)**<br>Private endpoint dns options. 
service | **oneof:** `object_storage`<br>Service to connect with via private endpoint.
&nbsp;&nbsp;object_storage | **[PrivateEndpoint.ObjectStorage](#PrivateEndpoint2)**<br>Yandex Cloud Object Storage. 


### AddressSpec {#AddressSpec}

Field | Description
--- | ---
address | **oneof:** `address_id` or `internal_ipv4_address_spec`<br>
&nbsp;&nbsp;address_id | **string**<br>ID of IP address to associate with private endpoint. 
&nbsp;&nbsp;internal_ipv4_address_spec | **[InternalIpv4AddressSpec](#InternalIpv4AddressSpec)**<br>Internal ipv4 address specification. 


### InternalIpv4AddressSpec {#InternalIpv4AddressSpec}

Field | Description
--- | ---
subnet_id | **string**<br>Required. ID of the subnet that address belongs to. The maximum string length in characters is 50.
address | **string**<br>Value of address. 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreatePrivateEndpointMetadata](#CreatePrivateEndpointMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[PrivateEndpoint](#PrivateEndpoint2)>**<br>if operation finished successfully. 


### CreatePrivateEndpointMetadata {#CreatePrivateEndpointMetadata}

Field | Description
--- | ---
private_endpoint_id | **string**<br>ID of the private endpoint that is being created. 


### PrivateEndpoint {#PrivateEndpoint2}

Field | Description
--- | ---
id | **string**<br>ID of the private endpoint. Generated at creation time. 
folder_id | **string**<br>ID of the folder that the private endpoint belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the private endpoint. The name is unique within the folder. Value must match the regular expression ``\|[a-zA-Z]([-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])?``. 
description | **string**<br>Description of the private endpoint. 0-256 characters long. 
labels | **map<string,string>**<br>Private endpoint labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression `[-_0-9a-z]*`. The string length in characters for each key must be 1-63. Each key must match the regular expression `[a-z][-_0-9a-z]*`. 
network_id | **string**<br>ID of the network that the private endpoint belongs to. 
status | enum **Status**<br>Status of the private endpoint. <ul><li>`PENDING`: Private endpoint is still creating / updating.</li><li>`AVAILABLE`: Private endpoint is available.</li><li>`DELETING`: Private endpoint is deleting.</li></ul>
address | **[EndpointAddress](#EndpointAddress2)**<br>Private endpoint ip address details. 
dns_options | **[DnsOptions](#DnsOptions2)**<br>Private endpoint dns options. 
service | **oneof:** `object_storage`<br>Service to connect with via private endpoint.
&nbsp;&nbsp;object_storage | **[ObjectStorage](#ObjectStorage2)**<br>Yandex Cloud Object Storage. 


### ObjectStorage {#ObjectStorage2}

Empty.

### DnsOptions {#DnsOptions2}

Field | Description
--- | ---
private_dns_records_enabled | **bool**<br>If enabled - vpc will create private dns records for specified service. 


### EndpointAddress {#EndpointAddress2}

Field | Description
--- | ---
subnet_id | **string**<br>ID of the subnet that the private endpoint address belongs to. 
address | **string**<br>IP address of the private endpoint. 
address_id | **string**<br>ID of the private endpoint address. 


## Update {#Update}

Updates the specified private endpoint.

**rpc Update ([UpdatePrivateEndpointRequest](#UpdatePrivateEndpointRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdatePrivateEndpointMetadata](#UpdatePrivateEndpointMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[PrivateEndpoint](#PrivateEndpoint3)<br>

### UpdatePrivateEndpointRequest {#UpdatePrivateEndpointRequest}

Field | Description
--- | ---
private_endpoint_id | **string**<br>Required. ID of the private endpoint to update. <br>To get the private endpoint ID make a [PrivateEndpointService.List](#List) request. The maximum string length in characters is 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which attributes of the PrivateEndpoint should be updated. 
name | **string**<br>New name for the private endpoint. The name must be unique within the folder. Value must match the regular expression ` \|[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>New description of the private endpoint. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Private endpoint labels as `key:value` pairs. <br>Existing set of labels is completely replaced by the provided set, so if you just want to add or remove a label: <ol><li>Get the current set of labels with a [PrivateEndpointService.Get](#Get) </li></ol>request. <ol><li>Add or remove a label in this set. </li><li>Send the new set in this field.</li></ol> No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
address_spec | **[AddressSpec](#AddressSpec)**<br>Private endpoint address specification. 
dns_options | **[PrivateEndpoint.DnsOptions](#PrivateEndpoint3)**<br>Private endpoint dns options. 


### AddressSpec {#AddressSpec1}

Field | Description
--- | ---
address | **oneof:** `address_id` or `internal_ipv4_address_spec`<br>
&nbsp;&nbsp;address_id | **string**<br>ID of IP address to associate with private endpoint. 
&nbsp;&nbsp;internal_ipv4_address_spec | **[InternalIpv4AddressSpec](#InternalIpv4AddressSpec)**<br>Internal ipv4 address specification. 


### InternalIpv4AddressSpec {#InternalIpv4AddressSpec1}

Field | Description
--- | ---
subnet_id | **string**<br>Required. ID of the subnet that address belongs to. The maximum string length in characters is 50.
address | **string**<br>Value of address. 


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdatePrivateEndpointMetadata](#UpdatePrivateEndpointMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[PrivateEndpoint](#PrivateEndpoint3)>**<br>if operation finished successfully. 


### UpdatePrivateEndpointMetadata {#UpdatePrivateEndpointMetadata}

Field | Description
--- | ---
private_endpoint_id | **string**<br>ID of the private endpoint that is being updated. 


### PrivateEndpoint {#PrivateEndpoint3}

Field | Description
--- | ---
id | **string**<br>ID of the private endpoint. Generated at creation time. 
folder_id | **string**<br>ID of the folder that the private endpoint belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the private endpoint. The name is unique within the folder. Value must match the regular expression ``\|[a-zA-Z]([-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])?``. 
description | **string**<br>Description of the private endpoint. 0-256 characters long. 
labels | **map<string,string>**<br>Private endpoint labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression `[-_0-9a-z]*`. The string length in characters for each key must be 1-63. Each key must match the regular expression `[a-z][-_0-9a-z]*`. 
network_id | **string**<br>ID of the network that the private endpoint belongs to. 
status | enum **Status**<br>Status of the private endpoint. <ul><li>`PENDING`: Private endpoint is still creating / updating.</li><li>`AVAILABLE`: Private endpoint is available.</li><li>`DELETING`: Private endpoint is deleting.</li></ul>
address | **[EndpointAddress](#EndpointAddress3)**<br>Private endpoint ip address details. 
dns_options | **[DnsOptions](#DnsOptions3)**<br>Private endpoint dns options. 
service | **oneof:** `object_storage`<br>Service to connect with via private endpoint.
&nbsp;&nbsp;object_storage | **[ObjectStorage](#ObjectStorage3)**<br>Yandex Cloud Object Storage. 


### ObjectStorage {#ObjectStorage3}

Empty.

### DnsOptions {#DnsOptions3}

Field | Description
--- | ---
private_dns_records_enabled | **bool**<br>If enabled - vpc will create private dns records for specified service. 


### EndpointAddress {#EndpointAddress3}

Field | Description
--- | ---
subnet_id | **string**<br>ID of the subnet that the private endpoint address belongs to. 
address | **string**<br>IP address of the private endpoint. 
address_id | **string**<br>ID of the private endpoint address. 


## Delete {#Delete}

Deletes the specified private endpoint.

**rpc Delete ([DeletePrivateEndpointRequest](#DeletePrivateEndpointRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeletePrivateEndpointMetadata](#DeletePrivateEndpointMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeletePrivateEndpointRequest {#DeletePrivateEndpointRequest}

Field | Description
--- | ---
private_endpoint_id | **string**<br>Required. ID of the private endpoint to delete. <br>To get a private endpoint ID make a [PrivateEndpointService.List](#List) request. The maximum string length in characters is 50.


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeletePrivateEndpointMetadata](#DeletePrivateEndpointMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeletePrivateEndpointMetadata {#DeletePrivateEndpointMetadata}

Field | Description
--- | ---
private_endpoint_id | **string**<br>ID of the private endpoint that is being deleted. 


## ListOperations {#ListOperations}

List operations for the specified private endpoint.

**rpc ListOperations ([ListPrivateEndpointOperationsRequest](#ListPrivateEndpointOperationsRequest)) returns ([ListPrivateEndpointOperationsResponse](#ListPrivateEndpointOperationsResponse))**

### ListPrivateEndpointOperationsRequest {#ListPrivateEndpointOperationsRequest}

Field | Description
--- | ---
private_endpoint_id | **string**<br>Required. ID of the private endpoint to list operations for. <br>To get a private endpoint ID make a [PrivateEndpointService.List](#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListPrivateEndpointOperationsResponse.next_page_token](#ListPrivateEndpointOperationsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListPrivateEndpointOperationsResponse.next_page_token](#ListPrivateEndpointOperationsResponse) returned by a previous list request. The maximum string length in characters is 1000.


### ListPrivateEndpointOperationsResponse {#ListPrivateEndpointOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation3)**<br>List of operations for the specified private endpoint. 
next_page_token | **string**<br>Token for getting the next page of the list. If the number of results is greater than the specified [ListPrivateEndpointOperationsRequest.page_size](#ListPrivateEndpointOperationsRequest), use `next_page_token` as the value for the [ListPrivateEndpointOperationsRequest.page_token](#ListPrivateEndpointOperationsRequest) parameter in the next list request. <br>Each subsequent page will have its own `next_page_token` to continue paging through the results. 


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


