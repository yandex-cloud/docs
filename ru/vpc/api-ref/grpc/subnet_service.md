---
editable: false
sourcePath: en/_api-ref-grpc/vpc/api-ref/grpc/subnet_service.md
---

# Virtual Private Cloud API, gRPC: SubnetService

A set of methods for managing Subnet resources.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified Subnet resource. |
| [List](#List) | Retrieves the list of Subnet resources in the specified folder. |
| [Create](#Create) | Creates a subnet in the specified folder and network. |
| [Update](#Update) | Updates the specified subnet. |
| [AddCidrBlocks](#AddCidrBlocks) | Adds CIDR blocks to the specified subnet. |
| [RemoveCidrBlocks](#RemoveCidrBlocks) | Removes CIDR blocks from the specified subnet. |
| [Delete](#Delete) | Deletes the specified subnet. |
| [ListOperations](#ListOperations) | List operations for the specified subnet. |
| [Move](#Move) | Move subnet to another folder. |
| [Relocate](#Relocate) |  |
| [ListUsedAddresses](#ListUsedAddresses) | List used addresses in specified subnet. |

## Calls SubnetService {#calls}

## Get {#Get}

Returns the specified Subnet resource. <br>To get the list of available Subnet resources, make a [List](#List) request.

**rpc Get ([GetSubnetRequest](#GetSubnetRequest)) returns ([Subnet](#Subnet))**

### GetSubnetRequest {#GetSubnetRequest}

Field | Description
--- | ---
subnet_id | **string**<br>Required. ID of the Subnet resource to return. To get the subnet ID use a [SubnetService.List](#List) request. The maximum string length in characters is 50.


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


## List {#List}

Retrieves the list of Subnet resources in the specified folder.

**rpc List ([ListSubnetsRequest](#ListSubnetsRequest)) returns ([ListSubnetsResponse](#ListSubnetsResponse))**

### ListSubnetsRequest {#ListSubnetsRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list subnets in. To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListSubnetsResponse.next_page_token](#ListSubnetsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListSubnetsResponse.next_page_token](#ListSubnetsResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. The expression must specify: <ol><li>The field name. Currently you can use filtering only on [Subnet.name](#Subnet1) field. </li><li>An `=` operator. </li><li>The value in double quotes (`"`). Must be 3-63 characters long and match the regular expression `[a-z][-a-z0-9]{1,61}[a-z0-9]`.</li></ol> The maximum string length in characters is 1000.


### ListSubnetsResponse {#ListSubnetsResponse}

Field | Description
--- | ---
subnets[] | **[Subnet](#Subnet1)**<br>List of Subnet resources. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListSubnetsRequest.page_size](#ListSubnetsRequest), use the `next_page_token` as the value for the [ListSubnetsRequest.page_token](#ListSubnetsRequest) query parameter in the next list request. Subsequent list requests will have their own `next_page_token` to continue paging through the results. 


### Subnet {#Subnet1}

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
dhcp_options | **[DhcpOptions](#DhcpOptions1)**<br> 


### DhcpOptions {#DhcpOptions1}

Field | Description
--- | ---
domain_name_servers[] | **string**<br> 
domain_name | **string**<br> 
ntp_servers[] | **string**<br> 


## Create {#Create}

Creates a subnet in the specified folder and network. Method starts an asynchronous operation that can be cancelled while it is in progress.

**rpc Create ([CreateSubnetRequest](#CreateSubnetRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateSubnetMetadata](#CreateSubnetMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Subnet](#Subnet2)<br>

### CreateSubnetRequest {#CreateSubnetRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create a subnet in. To get folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 50.
name | **string**<br>Name of the subnet. The name must be unique within the folder. Value must match the regular expression ` \|[a-zA-Z]([-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])? `.
description | **string**<br>Description of the subnet. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels, `` key:value `` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
network_id | **string**<br>Required. ID of the network to create subnet in. The maximum string length in characters is 50.
zone_id | **string**<br>Required. ID of the availability zone where the subnet resides. To get a list of available zones, use the [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List) request. The maximum string length in characters is 50.
v4_cidr_blocks[] | **string**<br>Required. CIDR block. The range of internal addresses that are defined for this subnet. For example, 10.0.0.0/22 or 192.168.0.0/24. Minimum subnet size is /28, maximum subnet size is /16. 
route_table_id | **string**<br>ID of route table the subnet is linked to. The maximum string length in characters is 50.
dhcp_options | **[DhcpOptions](#DhcpOptions2)**<br> 


### DhcpOptions {#DhcpOptions2}

Field | Description
--- | ---
domain_name_servers[] | **string**<br> 
domain_name | **string**<br> 
ntp_servers[] | **string**<br> 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateSubnetMetadata](#CreateSubnetMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Subnet](#Subnet2)>**<br>if operation finished successfully. 


### CreateSubnetMetadata {#CreateSubnetMetadata}

Field | Description
--- | ---
subnet_id | **string**<br>ID of the subnet that is being created. 


### Subnet {#Subnet2}

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
dhcp_options | **[DhcpOptions](#DhcpOptions3)**<br> 


## Update {#Update}

Updates the specified subnet. Method starts an asynchronous operation that can be cancelled while it is in progress.

**rpc Update ([UpdateSubnetRequest](#UpdateSubnetRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateSubnetMetadata](#UpdateSubnetMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Subnet](#Subnet3)<br>

### UpdateSubnetRequest {#UpdateSubnetRequest}

Field | Description
--- | ---
subnet_id | **string**<br>Required. ID of the Subnet resource to update. The maximum string length in characters is 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the Subnet resource are going to be updated. 
name | **string**<br>Name of the subnet. The name must be unique within the folder. Value must match the regular expression ` \|[a-zA-Z]([-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])? `.
description | **string**<br>Description of the subnet. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `` key:value `` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `.
route_table_id | **string**<br>ID of route table the subnet is linked to. The maximum string length in characters is 50.
dhcp_options | **[DhcpOptions](#DhcpOptions3)**<br> 
v4_cidr_blocks[] | **string**<br>New CIDR blocks which will overwrite the existing ones. 


### DhcpOptions {#DhcpOptions3}

Field | Description
--- | ---
domain_name_servers[] | **string**<br> 
domain_name | **string**<br> 
ntp_servers[] | **string**<br> 


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateSubnetMetadata](#UpdateSubnetMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Subnet](#Subnet3)>**<br>if operation finished successfully. 


### UpdateSubnetMetadata {#UpdateSubnetMetadata}

Field | Description
--- | ---
subnet_id | **string**<br>ID of the Subnet resource that is being updated. 


### Subnet {#Subnet3}

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
dhcp_options | **[DhcpOptions](#DhcpOptions4)**<br> 


## AddCidrBlocks {#AddCidrBlocks}

Adds CIDR blocks to the specified subnet. Method starts an asynchronous operation that can be cancelled while it is in progress.

**rpc AddCidrBlocks ([AddSubnetCidrBlocksRequest](#AddSubnetCidrBlocksRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateSubnetMetadata](#UpdateSubnetMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Subnet](#Subnet4)<br>

### AddSubnetCidrBlocksRequest {#AddSubnetCidrBlocksRequest}

Field | Description
--- | ---
subnet_id | **string**<br>Required. ID of the Subnet resource that is being updated. The maximum string length in characters is 50.
v4_cidr_blocks[] | **string**<br>CIDR block. The range of internal addresses that should be added to this subnet. For example, 10.0.0.0/22 or 192.168.0.0/24. Minimum subnet size is /28, maximum subnet size is /16. 


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateSubnetMetadata](#UpdateSubnetMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Subnet](#Subnet4)>**<br>if operation finished successfully. 


### UpdateSubnetMetadata {#UpdateSubnetMetadata1}

Field | Description
--- | ---
subnet_id | **string**<br>ID of the Subnet resource that is being updated. 


### Subnet {#Subnet4}

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
dhcp_options | **[DhcpOptions](#DhcpOptions4)**<br> 


### DhcpOptions {#DhcpOptions4}

Field | Description
--- | ---
domain_name_servers[] | **string**<br> 
domain_name | **string**<br> 
ntp_servers[] | **string**<br> 


## RemoveCidrBlocks {#RemoveCidrBlocks}

Removes CIDR blocks from the specified subnet. Method starts an asynchronous operation that can be cancelled while it is in progress.

**rpc RemoveCidrBlocks ([RemoveSubnetCidrBlocksRequest](#RemoveSubnetCidrBlocksRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateSubnetMetadata](#UpdateSubnetMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Subnet](#Subnet5)<br>

### RemoveSubnetCidrBlocksRequest {#RemoveSubnetCidrBlocksRequest}

Field | Description
--- | ---
subnet_id | **string**<br>Required. ID of the Subnet resource that is being updated. The maximum string length in characters is 50.
v4_cidr_blocks[] | **string**<br>CIDR block. The range of internal addresses that are removed from this subnet. 


### Operation {#Operation3}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateSubnetMetadata](#UpdateSubnetMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Subnet](#Subnet5)>**<br>if operation finished successfully. 


### UpdateSubnetMetadata {#UpdateSubnetMetadata2}

Field | Description
--- | ---
subnet_id | **string**<br>ID of the Subnet resource that is being updated. 


### Subnet {#Subnet5}

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
dhcp_options | **[DhcpOptions](#DhcpOptions5)**<br> 


### DhcpOptions {#DhcpOptions5}

Field | Description
--- | ---
domain_name_servers[] | **string**<br> 
domain_name | **string**<br> 
ntp_servers[] | **string**<br> 


## Delete {#Delete}

Deletes the specified subnet.

**rpc Delete ([DeleteSubnetRequest](#DeleteSubnetRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteSubnetMetadata](#DeleteSubnetMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteSubnetRequest {#DeleteSubnetRequest}

Field | Description
--- | ---
subnet_id | **string**<br>Required. ID of the subnet to delete. To get the subnet ID use a [SubnetService.List](#List) request. The maximum string length in characters is 50.


### Operation {#Operation4}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteSubnetMetadata](#DeleteSubnetMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteSubnetMetadata {#DeleteSubnetMetadata}

Field | Description
--- | ---
subnet_id | **string**<br>ID of the Subnet resource that is being deleted. 


## ListOperations {#ListOperations}

List operations for the specified subnet.

**rpc ListOperations ([ListSubnetOperationsRequest](#ListSubnetOperationsRequest)) returns ([ListSubnetOperationsResponse](#ListSubnetOperationsResponse))**

### ListSubnetOperationsRequest {#ListSubnetOperationsRequest}

Field | Description
--- | ---
subnet_id | **string**<br>Required. ID of the Subnet resource to list operations for. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page that should be returned. If the number of available results is larger than `page_size`, the service returns a [ListSubnetOperationsResponse.next_page_token](#ListSubnetOperationsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListSubnetOperationsResponse.next_page_token](#ListSubnetOperationsResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListSubnetOperationsResponse {#ListSubnetOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation5)**<br>List of operations for the specified Subnet resource. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListSubnetOperationsRequest.page_size](#ListSubnetOperationsRequest), use the `next_page_token` as the value for the [ListSubnetOperationsRequest.page_token](#ListSubnetOperationsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


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


## Move {#Move}

Move subnet to another folder.

**rpc Move ([MoveSubnetRequest](#MoveSubnetRequest)) returns ([operation.Operation](#Operation6))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[MoveSubnetMetadata](#MoveSubnetMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Subnet](#Subnet6)<br>

### MoveSubnetRequest {#MoveSubnetRequest}

Field | Description
--- | ---
subnet_id | **string**<br>Required. ID of the Subnet resource to move. The maximum string length in characters is 50.
destination_folder_id | **string**<br>Required. ID of the destination folder. The maximum string length in characters is 50.


### Operation {#Operation6}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[MoveSubnetMetadata](#MoveSubnetMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Subnet](#Subnet6)>**<br>if operation finished successfully. 


### MoveSubnetMetadata {#MoveSubnetMetadata}

Field | Description
--- | ---
subnet_id | **string**<br>ID of the Subnet resource that is being moved. 


### Subnet {#Subnet6}

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
dhcp_options | **[DhcpOptions](#DhcpOptions6)**<br> 


### DhcpOptions {#DhcpOptions6}

Field | Description
--- | ---
domain_name_servers[] | **string**<br> 
domain_name | **string**<br> 
ntp_servers[] | **string**<br> 


## Relocate {#Relocate}



**rpc Relocate ([RelocateSubnetRequest](#RelocateSubnetRequest)) returns ([operation.Operation](#Operation7))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RelocateSubnetMetadata](#RelocateSubnetMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Subnet](#Subnet7)<br>

### RelocateSubnetRequest {#RelocateSubnetRequest}

Field | Description
--- | ---
subnet_id | **string**<br>Required.  The maximum string length in characters is 50.
destination_zone_id | **string**<br>Required.  


### Operation {#Operation7}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[RelocateSubnetMetadata](#RelocateSubnetMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Subnet](#Subnet7)>**<br>if operation finished successfully. 


### RelocateSubnetMetadata {#RelocateSubnetMetadata}

Field | Description
--- | ---
subnet_id | **string**<br> 


### Subnet {#Subnet7}

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
dhcp_options | **[DhcpOptions](#DhcpOptions7)**<br> 


### DhcpOptions {#DhcpOptions7}

Field | Description
--- | ---
domain_name_servers[] | **string**<br> 
domain_name | **string**<br> 
ntp_servers[] | **string**<br> 


## ListUsedAddresses {#ListUsedAddresses}

List used addresses in specified subnet.

**rpc ListUsedAddresses ([ListUsedAddressesRequest](#ListUsedAddressesRequest)) returns ([ListUsedAddressesResponse](#ListUsedAddressesResponse))**

### ListUsedAddressesRequest {#ListUsedAddressesRequest}

Field | Description
--- | ---
subnet_id | **string**<br>Required.  
page_size | **int64**<br> 
page_token | **string**<br> 
filter | **string**<br> 


### ListUsedAddressesResponse {#ListUsedAddressesResponse}

Field | Description
--- | ---
addresses[] | **[UsedAddress](#UsedAddress)**<br> 
next_page_token | **string**<br> 


### UsedAddress {#UsedAddress}

Field | Description
--- | ---
address | **string**<br> 
ip_version | enum **IpVersion**<br> 
references[] | **[reference.Reference](./#reference)**<br> 


