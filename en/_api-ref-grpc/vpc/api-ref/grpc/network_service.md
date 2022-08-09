---
editable: false
---

# NetworkService

A set of methods for managing Network resources.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified Network resource. |
| [List](#List) | Retrieves the list of Network resources in the specified folder. |
| [Create](#Create) | Creates a network in the specified folder using the data specified in the request. |
| [Update](#Update) | Updates the specified network. |
| [Delete](#Delete) | Deletes the specified network. |
| [ListSubnets](#ListSubnets) | Lists subnets from the specified network. |
| [ListSecurityGroups](#ListSecurityGroups) | Lists security groups from the specified network. |
| [ListRouteTables](#ListRouteTables) | Lists route tables from the specified network. |
| [ListOperations](#ListOperations) | Lists operations for the specified network. |
| [Move](#Move) | Move network to another folder. |

## Calls NetworkService {#calls}

## Get {#Get}

Returns the specified Network resource. <br>Get the list of available Network resources by making a [List](#List) request.

**rpc Get ([GetNetworkRequest](#GetNetworkRequest)) returns ([Network](#Network))**

### GetNetworkRequest {#GetNetworkRequest}

Field | Description
--- | ---
network_id | **string**<br>Required. ID of the Network resource to return. To get the network ID, use a [NetworkService.List](#List) request. The maximum string length in characters is 50.


### Network {#Network}

Field | Description
--- | ---
id | **string**<br>ID of the network. 
folder_id | **string**<br>ID of the folder that the network belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the network. The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Optional description of the network. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `` key:value `` pairs. Maximum of 64 per resource. 
default_security_group_id | **string**<br>ID of default security group for network. 


## List {#List}

Retrieves the list of Network resources in the specified folder.

**rpc List ([ListNetworksRequest](#ListNetworksRequest)) returns ([ListNetworksResponse](#ListNetworksResponse))**

### ListNetworksRequest {#ListNetworksRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list networks in. To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListNetworksResponse.next_page_token](#ListNetworksResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListNetworksResponse.next_page_token](#ListNetworksResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. The expression must specify: <ol><li>The field name. Currently you can use filtering only on the [Network.name](#Network1) field. </li><li>An `=` operator. </li><li>The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.</li></ol> The maximum string length in characters is 1000.


### ListNetworksResponse {#ListNetworksResponse}

Field | Description
--- | ---
networks[] | **[Network](#Network1)**<br>List of Network resources. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListNetworksRequest.page_size](#ListNetworksRequest), use the `next_page_token` as the value for the [ListNetworksRequest.page_token](#ListNetworksRequest) query parameter in the next list request. Subsequent list requests will have their own `next_page_token` to continue paging through the results. 


### Network {#Network1}

Field | Description
--- | ---
id | **string**<br>ID of the network. 
folder_id | **string**<br>ID of the folder that the network belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the network. The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Optional description of the network. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `` key:value `` pairs. Maximum of 64 per resource. 
default_security_group_id | **string**<br>ID of default security group for network. 


## Create {#Create}

Creates a network in the specified folder using the data specified in the request. Method starts an asynchronous operation that can be cancelled while it is in progress.

**rpc Create ([CreateNetworkRequest](#CreateNetworkRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateNetworkMetadata](#CreateNetworkMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Network](#Network2)<br>

### CreateNetworkRequest {#CreateNetworkRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder for this request to create a network in. To get the folder ID, use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 50.
name | **string**<br>Name of the network. The name must be unique within the folder. Value must match the regular expression ` \|[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Description of the network. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `` key:value `` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateNetworkMetadata](#CreateNetworkMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Network](#Network2)>**<br>if operation finished successfully. 


### CreateNetworkMetadata {#CreateNetworkMetadata}

Field | Description
--- | ---
network_id | **string**<br>ID of the Network that is being created. 


### Network {#Network2}

Field | Description
--- | ---
id | **string**<br>ID of the network. 
folder_id | **string**<br>ID of the folder that the network belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the network. The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Optional description of the network. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `` key:value `` pairs. Maximum of 64 per resource. 
default_security_group_id | **string**<br>ID of default security group for network. 


## Update {#Update}

Updates the specified network. Method starts an asynchronous operation that can be cancelled while it is in progress.

**rpc Update ([UpdateNetworkRequest](#UpdateNetworkRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateNetworkMetadata](#UpdateNetworkMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Network](#Network3)<br>

### UpdateNetworkRequest {#UpdateNetworkRequest}

Field | Description
--- | ---
network_id | **string**<br>Required. ID of the Network resource to update. To get the network ID use a [NetworkService.List](#List) request. The maximum string length in characters is 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the Network resource are going to be updated. 
name | **string**<br>Name of the network. The name must be unique within the folder. Value must match the regular expression ` \|[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Description of the network. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `` key:value `` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateNetworkMetadata](#UpdateNetworkMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Network](#Network3)>**<br>if operation finished successfully. 


### UpdateNetworkMetadata {#UpdateNetworkMetadata}

Field | Description
--- | ---
network_id | **string**<br>ID of the Network resource that is being updated. 


### Network {#Network3}

Field | Description
--- | ---
id | **string**<br>ID of the network. 
folder_id | **string**<br>ID of the folder that the network belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the network. The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Optional description of the network. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `` key:value `` pairs. Maximum of 64 per resource. 
default_security_group_id | **string**<br>ID of default security group for network. 


## Delete {#Delete}

Deletes the specified network.

**rpc Delete ([DeleteNetworkRequest](#DeleteNetworkRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteNetworkMetadata](#DeleteNetworkMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteNetworkRequest {#DeleteNetworkRequest}

Field | Description
--- | ---
network_id | **string**<br>Required. ID of the Network resource to update. To get the network ID, use a [NetworkService.List](#List) request. The maximum string length in characters is 50.


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteNetworkMetadata](#DeleteNetworkMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteNetworkMetadata {#DeleteNetworkMetadata}

Field | Description
--- | ---
network_id | **string**<br>ID of the network that is being deleted. 


## ListSubnets {#ListSubnets}

Lists subnets from the specified network.

**rpc ListSubnets ([ListNetworkSubnetsRequest](#ListNetworkSubnetsRequest)) returns ([ListNetworkSubnetsResponse](#ListNetworkSubnetsResponse))**

### ListNetworkSubnetsRequest {#ListNetworkSubnetsRequest}

Field | Description
--- | ---
network_id | **string**<br>Required. ID of the Network resource to list subnets for. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page that should be returned. If the number of available results is larger than `page_size`, the service returns a [ListNetworkSubnetsResponse.next_page_token](#ListNetworkSubnetsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token. Set `page_token` to the [ListNetworkSubnetsResponse.next_page_token](#ListNetworkSubnetsResponse) returned by a previous list request to get the next page of results. The maximum string length in characters is 100.


### ListNetworkSubnetsResponse {#ListNetworkSubnetsResponse}

Field | Description
--- | ---
subnets[] | **[Subnet](#Subnet)**<br>List of subnets that belong to the network which is specified in the request. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListNetworkSubnetsRequest.page_size](#ListNetworkSubnetsRequest), use the `next_page_token` as the value for the [ListNetworkSubnetsRequest.page_token](#ListNetworkSubnetsRequest) query parameter in the next list request. Subsequent list requests will have their own `next_page_token` to continue paging through the results. 


### Subnet {#Subnet}

Field | Description
--- | ---
id | **string**<br>ID of the subnet. 
folder_id | **string**<br>ID of the folder that the subnet belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the subnet. The name is unique within the project. 3-63 characters long. 
description | **string**<br>Optional description of the subnet. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `` key:value `` pairs. Maximum of 64 per resource. 
network_id | **string**<br>ID of the network the subnet belongs to. 
zone_id | **string**<br>ID of the availability zone where the subnet resides. 
v4_cidr_blocks[] | **string**<br>CIDR block. The range of internal addresses that are defined for this subnet. This field can be set only at Subnet resource creation time and cannot be changed. For example, 10.0.0.0/22 or 192.168.0.0/24. Minimum subnet size is /28, maximum subnet size is /16. 
v6_cidr_blocks[] | **string**<br>IPv6 not available yet. 
route_table_id | **string**<br>ID of route table the subnet is linked to. 
dhcp_options | **[DhcpOptions](#DhcpOptions)**<br> 


### DhcpOptions {#DhcpOptions}

Field | Description
--- | ---
domain_name_servers[] | **string**<br> 
domain_name | **string**<br> 
ntp_servers[] | **string**<br> 


## ListSecurityGroups {#ListSecurityGroups}

Lists security groups from the specified network.

**rpc ListSecurityGroups ([ListNetworkSecurityGroupsRequest](#ListNetworkSecurityGroupsRequest)) returns ([ListNetworkSecurityGroupsResponse](#ListNetworkSecurityGroupsResponse))**

### ListNetworkSecurityGroupsRequest {#ListNetworkSecurityGroupsRequest}

Field | Description
--- | ---
network_id | **string**<br>Required. ID of the Network resource to list security groups for. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page that should be returned. If the number of available results is larger than `page_size`, the service returns a [ListNetworkSecurityGroupsResponse.next_page_token](#ListNetworkSecurityGroupsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token. Set `page_token` to the [ListNetworkSecurityGroupsResponse.next_page_token](#ListNetworkSecurityGroupsResponse) returned by a previous list request to get the next page of results. The maximum string length in characters is 100.


### ListNetworkSecurityGroupsResponse {#ListNetworkSecurityGroupsResponse}

Field | Description
--- | ---
security_groups[] | **[SecurityGroup](#SecurityGroup)**<br>List of security groups that belong to the network which is specified in the request. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListNetworkSecurityGroupsRequest.page_size](#ListNetworkSecurityGroupsRequest), use the `next_page_token` as the value for the [ListNetworkSecurityGroupsRequest.page_token](#ListNetworkSecurityGroupsRequest) query parameter in the next list request. Subsequent list requests will have their own `next_page_token` to continue paging through the results. 


### SecurityGroup {#SecurityGroup}

Field | Description
--- | ---
id | **string**<br> 
folder_id | **string**<br> 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br> 
description | **string**<br> 
labels | **map<string,string>**<br> 
network_id | **string**<br> 
status | enum **Status**<br> <ul><li>`UPDATING`: updating is a long operation because we must update all instances in SG</li></ul>
rules[] | **[SecurityGroupRule](#SecurityGroupRule)**<br> 
default_for_network | **bool**<br> 


### SecurityGroupRule {#SecurityGroupRule}

Field | Description
--- | ---
id | **string**<br> 
description | **string**<br> 
labels | **map<string,string>**<br> 
direction | enum **Direction**<br>Required.  
ports | **[PortRange](#PortRange)**<br> 
protocol_name | **string**<br>null value means any protocol values from https://www.iana.org/assignments/protocol-numbers/protocol-numbers.xhtml 
protocol_number | **int64**<br> 
target | **oneof:** `cidr_blocks`, `security_group_id` or `predefined_target`<br>
&nbsp;&nbsp;cidr_blocks | **[CidrBlocks](#CidrBlocks)**<br> 
&nbsp;&nbsp;security_group_id | **string**<br> 
&nbsp;&nbsp;predefined_target | **string**<br> 


### PortRange {#PortRange}

Field | Description
--- | ---
from_port | **int64**<br> Acceptable values are 0 to 65535, inclusive.
to_port | **int64**<br> Acceptable values are 0 to 65535, inclusive.


### CidrBlocks {#CidrBlocks}

Field | Description
--- | ---
v4_cidr_blocks[] | **string**<br> 
v6_cidr_blocks[] | **string**<br> 


## ListRouteTables {#ListRouteTables}

Lists route tables from the specified network.

**rpc ListRouteTables ([ListNetworkRouteTablesRequest](#ListNetworkRouteTablesRequest)) returns ([ListNetworkRouteTablesResponse](#ListNetworkRouteTablesResponse))**

### ListNetworkRouteTablesRequest {#ListNetworkRouteTablesRequest}

Field | Description
--- | ---
network_id | **string**<br>Required. ID of the Network resource to list route tables for. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page that should be returned. If the number of available results is larger than `page_size`, the service returns a [ListNetworkRouteTablesResponse.next_page_token](#ListNetworkRouteTablesResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token. Set `page_token` to the [ListNetworkRouteTablesResponse.next_page_token](#ListNetworkRouteTablesResponse) returned by a previous list request to get the next page of results. The maximum string length in characters is 100.


### ListNetworkRouteTablesResponse {#ListNetworkRouteTablesResponse}

Field | Description
--- | ---
route_tables[] | **[RouteTable](#RouteTable)**<br>List of route tables that belong to the network which is specified in the request. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListNetworkRouteTablesRequest.page_size](#ListNetworkRouteTablesRequest), use the `next_page_token` as the value for the [ListNetworkRouteTablesRequest.page_token](#ListNetworkRouteTablesRequest) query parameter in the next list request. Subsequent list requests will have their own `next_page_token` to continue paging through the results. 


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


## ListOperations {#ListOperations}

Lists operations for the specified network.

**rpc ListOperations ([ListNetworkOperationsRequest](#ListNetworkOperationsRequest)) returns ([ListNetworkOperationsResponse](#ListNetworkOperationsResponse))**

### ListNetworkOperationsRequest {#ListNetworkOperationsRequest}

Field | Description
--- | ---
network_id | **string**<br>Required. ID of the Network resource to list operations for. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page that should be returned. If the number of available results is larger than `page_size`, the service returns a [ListNetworkOperationsResponse.next_page_token](#ListNetworkOperationsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListNetworkOperationsResponse.next_page_token](#ListNetworkOperationsResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListNetworkOperationsResponse {#ListNetworkOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation3)**<br>List of operations for the specified network. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListNetworkOperationsRequest.page_size](#ListNetworkOperationsRequest), use the `next_page_token` as the value for the [ListNetworkOperationsRequest.page_token](#ListNetworkOperationsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


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

Move network to another folder.

**rpc Move ([MoveNetworkRequest](#MoveNetworkRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[MoveNetworkMetadata](#MoveNetworkMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Network](#Network4)<br>

### MoveNetworkRequest {#MoveNetworkRequest}

Field | Description
--- | ---
network_id | **string**<br>Required. ID of the Network resource to move. The maximum string length in characters is 50.
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
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[MoveNetworkMetadata](#MoveNetworkMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Network](#Network4)>**<br>if operation finished successfully. 


### MoveNetworkMetadata {#MoveNetworkMetadata}

Field | Description
--- | ---
network_id | **string**<br>ID of the network that is being moved. 


### Network {#Network4}

Field | Description
--- | ---
id | **string**<br>ID of the network. 
folder_id | **string**<br>ID of the folder that the network belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
name | **string**<br>Name of the network. The name is unique within the folder. 3-63 characters long. 
description | **string**<br>Optional description of the network. 0-256 characters long. 
labels | **map<string,string>**<br>Resource labels as `` key:value `` pairs. Maximum of 64 per resource. 
default_security_group_id | **string**<br>ID of default security group for network. 


