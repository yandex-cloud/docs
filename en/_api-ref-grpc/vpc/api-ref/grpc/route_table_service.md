---
editable: false
---

# RouteTableService

A set of methods for managing RouteTable resources.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified RouteTable resource. |
| [List](#List) | Retrieves the list of RouteTable resources in the specified folder. |
| [Create](#Create) | Creates a route table in the specified folder and network. |
| [Update](#Update) | Updates the specified route table. |
| [Delete](#Delete) | Deletes the specified route table. |
| [ListOperations](#ListOperations) | List operations for the specified route table. |
| [Move](#Move) | Move route table to another folder. |

## Calls RouteTableService {#calls}

## Get {#Get}

Returns the specified RouteTable resource. <br>To get the list of available RouteTable resources, make a [List](#List) request.

**rpc Get ([GetRouteTableRequest](#GetRouteTableRequest)) returns ([RouteTable](#RouteTable))**

### GetRouteTableRequest {#GetRouteTableRequest}

Field | Description
--- | ---
route_table_id | **string**<br>Required. ID of the RouteTable resource to return. To get the route table ID use a [RouteTableService.List](#List) request. The maximum string length in characters is 50.


### RouteTable {#RouteTable}

Field | Description
--- | ---
id | **string**<br>ID of the route table. 
folder_id | **string**<br>ID of the folder that the route table belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the route table. The name is unique within the project. 3-63 characters long. 
description | **string**<br>Optional description of the route table. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `` key:value `` pairs. Maximum of 64 per resource. 
network_id | **string**<br>ID of the network the route table belongs to. 
static_routes[] | **[StaticRoute](#StaticRoute)**<br>List of static routes. 


### StaticRoute {#StaticRoute}

Field | Description
--- | ---
destination | **oneof:** `destination_prefix`<br>
&nbsp;&nbsp;destination_prefix | **string**<br>Destination subnet in CIDR notation 
next_hop | **oneof:** `next_hop_address` or `gateway_id`<br>
&nbsp;&nbsp;next_hop_address | **string**<br>Next hop IP address 
&nbsp;&nbsp;gateway_id | **string**<br>Next hop gateway id 
labels | **map<string,string>**<br>Resource labels as `` key:value `` pairs. Maximum of 64 per resource. 


## List {#List}

Retrieves the list of RouteTable resources in the specified folder.

**rpc List ([ListRouteTablesRequest](#ListRouteTablesRequest)) returns ([ListRouteTablesResponse](#ListRouteTablesResponse))**

### ListRouteTablesRequest {#ListRouteTablesRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder that the route table belongs to. To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListRouteTablesResponse.next_page_token](#ListRouteTablesResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListRouteTablesResponse.next_page_token](#ListRouteTablesResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. The expression must specify: <ol><li>The field name. Currently you can use filtering only on [RouteTable.name](#RouteTable1) field. </li><li>An `=` operator. </li><li>The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.</li></ol> The maximum string length in characters is 1000.


### ListRouteTablesResponse {#ListRouteTablesResponse}

Field | Description
--- | ---
route_tables[] | **[RouteTable](#RouteTable1)**<br>List of RouteTable resources. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListRouteTablesRequest.page_size](#ListRouteTablesRequest), use the `next_page_token` as the value for the [ListRouteTablesRequest.page_token](#ListRouteTablesRequest) query parameter in the next list request. Subsequent list requests will have their own `next_page_token` to continue paging through the results. 


### RouteTable {#RouteTable1}

Field | Description
--- | ---
id | **string**<br>ID of the route table. 
folder_id | **string**<br>ID of the folder that the route table belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the route table. The name is unique within the project. 3-63 characters long. 
description | **string**<br>Optional description of the route table. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `` key:value `` pairs. Maximum of 64 per resource. 
network_id | **string**<br>ID of the network the route table belongs to. 
static_routes[] | **[StaticRoute](#StaticRoute1)**<br>List of static routes. 


### StaticRoute {#StaticRoute1}

Field | Description
--- | ---
destination | **oneof:** `destination_prefix`<br>
&nbsp;&nbsp;destination_prefix | **string**<br>Destination subnet in CIDR notation 
next_hop | **oneof:** `next_hop_address` or `gateway_id`<br>
&nbsp;&nbsp;next_hop_address | **string**<br>Next hop IP address 
&nbsp;&nbsp;gateway_id | **string**<br>Next hop gateway id 
labels | **map<string,string>**<br>Resource labels as `` key:value `` pairs. Maximum of 64 per resource. 


## Create {#Create}

Creates a route table in the specified folder and network. Method starts an asynchronous operation that can be cancelled while it is in progress.

**rpc Create ([CreateRouteTableRequest](#CreateRouteTableRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateRouteTableMetadata](#CreateRouteTableMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[RouteTable](#RouteTable2)<br>

### CreateRouteTableRequest {#CreateRouteTableRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder that the route table belongs to. To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 50.
name | **string**<br>Name of the route table. The name must be unique within the folder. Value must match the regular expression ` \|[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Description of the route table. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels, `` key:value `` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
network_id | **string**<br>Required. ID of the network the route table belongs to. The maximum string length in characters is 50.
static_routes[] | **[StaticRoute](#StaticRoute2)**<br>List of static routes. 


### StaticRoute {#StaticRoute2}

Field | Description
--- | ---
destination | **oneof:** `destination_prefix`<br>
&nbsp;&nbsp;destination_prefix | **string**<br>Destination subnet in CIDR notation 
next_hop | **oneof:** `next_hop_address` or `gateway_id`<br>
&nbsp;&nbsp;next_hop_address | **string**<br>Next hop IP address 
&nbsp;&nbsp;gateway_id | **string**<br>Next hop gateway id 
labels | **map<string,string>**<br>Resource labels as `` key:value `` pairs. Maximum of 64 per resource. 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateRouteTableMetadata](#CreateRouteTableMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[RouteTable](#RouteTable2)>**<br>if operation finished successfully. 


### CreateRouteTableMetadata {#CreateRouteTableMetadata}

Field | Description
--- | ---
route_table_id | **string**<br>ID of the route table that is being created. 


### RouteTable {#RouteTable2}

Field | Description
--- | ---
id | **string**<br>ID of the route table. 
folder_id | **string**<br>ID of the folder that the route table belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the route table. The name is unique within the project. 3-63 characters long. 
description | **string**<br>Optional description of the route table. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `` key:value `` pairs. Maximum of 64 per resource. 
network_id | **string**<br>ID of the network the route table belongs to. 
static_routes[] | **[StaticRoute](#StaticRoute3)**<br>List of static routes. 


## Update {#Update}

Updates the specified route table. Method starts an asynchronous operation that can be cancelled while it is in progress.

**rpc Update ([UpdateRouteTableRequest](#UpdateRouteTableRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateRouteTableMetadata](#UpdateRouteTableMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[RouteTable](#RouteTable3)<br>

### UpdateRouteTableRequest {#UpdateRouteTableRequest}

Field | Description
--- | ---
route_table_id | **string**<br>Required. ID of the RouteTable resource to update. The maximum string length in characters is 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the RouteTable resource are going to be updated. 
name | **string**<br>Name of the route table. The name must be unique within the folder. Value must match the regular expression ` \|[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Description of the route table. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `` key:value `` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
static_routes[] | **[StaticRoute](#StaticRoute3)**<br>List of static routes. 


### StaticRoute {#StaticRoute3}

Field | Description
--- | ---
destination | **oneof:** `destination_prefix`<br>
&nbsp;&nbsp;destination_prefix | **string**<br>Destination subnet in CIDR notation 
next_hop | **oneof:** `next_hop_address` or `gateway_id`<br>
&nbsp;&nbsp;next_hop_address | **string**<br>Next hop IP address 
&nbsp;&nbsp;gateway_id | **string**<br>Next hop gateway id 
labels | **map<string,string>**<br>Resource labels as `` key:value `` pairs. Maximum of 64 per resource. 


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateRouteTableMetadata](#UpdateRouteTableMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[RouteTable](#RouteTable3)>**<br>if operation finished successfully. 


### UpdateRouteTableMetadata {#UpdateRouteTableMetadata}

Field | Description
--- | ---
route_table_id | **string**<br>ID of the RouteTable resource that is being updated. 


### RouteTable {#RouteTable3}

Field | Description
--- | ---
id | **string**<br>ID of the route table. 
folder_id | **string**<br>ID of the folder that the route table belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the route table. The name is unique within the project. 3-63 characters long. 
description | **string**<br>Optional description of the route table. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `` key:value `` pairs. Maximum of 64 per resource. 
network_id | **string**<br>ID of the network the route table belongs to. 
static_routes[] | **[StaticRoute](#StaticRoute4)**<br>List of static routes. 


## Delete {#Delete}

Deletes the specified route table.

**rpc Delete ([DeleteRouteTableRequest](#DeleteRouteTableRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteRouteTableMetadata](#DeleteRouteTableMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteRouteTableRequest {#DeleteRouteTableRequest}

Field | Description
--- | ---
route_table_id | **string**<br>Required. ID of the route table to delete. To get the route table ID use a [RouteTableService.List](#List) request. The maximum string length in characters is 50.


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteRouteTableMetadata](#DeleteRouteTableMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteRouteTableMetadata {#DeleteRouteTableMetadata}

Field | Description
--- | ---
route_table_id | **string**<br>ID of the RouteTable resource that is being deleted. 


## ListOperations {#ListOperations}

List operations for the specified route table.

**rpc ListOperations ([ListRouteTableOperationsRequest](#ListRouteTableOperationsRequest)) returns ([ListRouteTableOperationsResponse](#ListRouteTableOperationsResponse))**

### ListRouteTableOperationsRequest {#ListRouteTableOperationsRequest}

Field | Description
--- | ---
route_table_id | **string**<br>Required. ID of the RouteTable resource to list operations for. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page that should be returned. If the number of available results is larger than `page_size`, the service returns a [ListRouteTableOperationsResponse.next_page_token](#ListRouteTableOperationsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListRouteTableOperationsResponse.next_page_token](#ListRouteTableOperationsResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListRouteTableOperationsResponse {#ListRouteTableOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation3)**<br>List of operations for the specified RouteTable resource. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListRouteTableOperationsRequest.page_size](#ListRouteTableOperationsRequest), use the `next_page_token` as the value for the [ListRouteTableOperationsRequest.page_token](#ListRouteTableOperationsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


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

Move route table to another folder.

**rpc Move ([MoveRouteTableRequest](#MoveRouteTableRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[MoveRouteTableMetadata](#MoveRouteTableMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[RouteTable](#RouteTable4)<br>

### MoveRouteTableRequest {#MoveRouteTableRequest}

Field | Description
--- | ---
route_table_id | **string**<br>Required. ID of the RouteTable resource to move. The maximum string length in characters is 50.
destination_folder_id | **string**<br>Required. ID of the destination folder. The maximum string length in characters is 50.


### Operation {#Operation4}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[MoveRouteTableMetadata](#MoveRouteTableMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[RouteTable](#RouteTable4)>**<br>if operation finished successfully. 


### MoveRouteTableMetadata {#MoveRouteTableMetadata}

Field | Description
--- | ---
route_table_id | **string**<br>ID of the RouteTable resource that is being moved. 


### RouteTable {#RouteTable4}

Field | Description
--- | ---
id | **string**<br>ID of the route table. 
folder_id | **string**<br>ID of the folder that the route table belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the route table. The name is unique within the project. 3-63 characters long. 
description | **string**<br>Optional description of the route table. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `` key:value `` pairs. Maximum of 64 per resource. 
network_id | **string**<br>ID of the network the route table belongs to. 
static_routes[] | **[StaticRoute](#StaticRoute4)**<br>List of static routes. 


### StaticRoute {#StaticRoute4}

Field | Description
--- | ---
destination | **oneof:** `destination_prefix`<br>
&nbsp;&nbsp;destination_prefix | **string**<br>Destination subnet in CIDR notation 
next_hop | **oneof:** `next_hop_address` or `gateway_id`<br>
&nbsp;&nbsp;next_hop_address | **string**<br>Next hop IP address 
&nbsp;&nbsp;gateway_id | **string**<br>Next hop gateway id 
labels | **map<string,string>**<br>Resource labels as `` key:value `` pairs. Maximum of 64 per resource. 


