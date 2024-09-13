---
editable: false
sourcePath: en/_api-ref-grpc/cloud-desktop/api-ref/grpc/desktop_group_service.md
---

# Cloud Desktop API, gRPC: DesktopGroupService

A set of methods for managing desktop group resources.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified desktop group resource. |
| [List](#List) | Retrieves the list of desktop group resources. |
| [ListDesktops](#ListDesktops) | Retrieves the list of desktops resources. |
| [ListOperations](#ListOperations) | Returns list of the operations for the specified desktop group. |
| [Create](#Create) | Creates desktop group in the specified folder. |
| [Delete](#Delete) | Deletes the specified desktop group. |
| [ListAccessBindings](#ListAccessBindings) | Returns a list of the access bindings for the specified desktop group. |
| [SetAccessBindings](#SetAccessBindings) | Sets access bindings for the specified desktop group. |
| [UpdateAccessBindings](#UpdateAccessBindings) | Updates access bindings of the specified desktop group. |

## Calls DesktopGroupService {#calls}

## Get {#Get}

Returns the specified desktop group resource. <br>To get the list of available desktop groups, make a [List](#List) request.

**rpc Get ([GetDesktopGroupRequest](#GetDesktopGroupRequest)) returns ([DesktopGroup](#DesktopGroup))**

### GetDesktopGroupRequest {#GetDesktopGroupRequest}

Field | Description
--- | ---
desktop_group_id | **string**<br>Required. ID of the desktop group resource to return. <br>To get the desktop group ID use a [DesktopGroupService.List](#List) request. The maximum string length in characters is 50.


### DesktopGroup {#DesktopGroup}

Field | Description
--- | ---
id | **string**<br>Desktop group ID. 
folder_id | **string**<br>ID of the folder that the desktop group belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
status | enum **Status**<br>Status of the desktop group. <ul><li>`CREATING`: Desktop group is being created.</li><li>`ACTIVE`: Desktop group is ready to use.</li><li>`DELETING`: Desktop group is being deleted.</li></ul>
name | **string**<br>Name of the desktop group. 
description | **string**<br>Description of the desktop group. 
resources_spec | **[ResourcesSpec](#ResourcesSpec)**<br>Resource specification of the desktop group. 
network_interface_spec | **[NetworkInterfaceSpec](#NetworkInterfaceSpec)**<br>Network interface specification of the desktop group. 


### ResourcesSpec {#ResourcesSpec}

Field | Description
--- | ---
memory | **int64**<br>RAM volume, in bytes. The minimum value is 1.
cores | **int64**<br>Number of CPU cores. The minimum value is 1.
core_fraction | **int64**<br>Baseline level of CPU performance with the ability to burst performance above that baseline level. This field sets baseline performance for each core. Acceptable values are 0 to 100, inclusive.


### NetworkInterfaceSpec {#NetworkInterfaceSpec}

Field | Description
--- | ---
network_id | **string**<br>Required. ID of the network interface specification. The maximum string length in characters is 50.
subnet_ids[] | **string**<br>List of subnet IDs. The number of elements must be greater than 0. The maximum string length in characters for each value is 50.


## List {#List}

Retrieves the list of desktop group resources.

**rpc List ([ListDesktopGroupsRequest](#ListDesktopGroupsRequest)) returns ([ListDesktopGroupsResponse](#ListDesktopGroupsResponse))**

### ListDesktopGroupsRequest {#ListDesktopGroupsRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list desktop groups in. <br>To get the folder ID use a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListDesktopGroupsResponse.next_page_token](#ListDesktopGroupsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListDesktopGroupsResponse.next_page_token](#ListDesktopGroupsResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. The expression must specify: <ol><li>The field name. Currently you can use filtering only on [DesktopGroup.name](#DesktopGroup1) field. </li><li>An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. </li><li>Value or a list of values to compare against the values of the field.</li></ol> The maximum string length in characters is 1000.
order_by | **string**<br>Sorting the list by [DesktopGroup.name](#DesktopGroup1), [DesktopGroup.created_at](#DesktopGroup1) and [DesktopGroup.status](#DesktopGroup1) fields. The default sorting order is ascending. The maximum string length in characters is 100.


### ListDesktopGroupsResponse {#ListDesktopGroupsResponse}

Field | Description
--- | ---
desktop_groups[] | **[DesktopGroup](#DesktopGroup1)**<br>List of desktop groups. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListDesktopGroupsRequest.page_size](#ListDesktopGroupsRequest), use the `next_page_token` as the value for the [ListDesktopGroupsRequest.page_token](#ListDesktopGroupsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### DesktopGroup {#DesktopGroup1}

Field | Description
--- | ---
id | **string**<br>Desktop group ID. 
folder_id | **string**<br>ID of the folder that the desktop group belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
status | enum **Status**<br>Status of the desktop group. <ul><li>`CREATING`: Desktop group is being created.</li><li>`ACTIVE`: Desktop group is ready to use.</li><li>`DELETING`: Desktop group is being deleted.</li></ul>
name | **string**<br>Name of the desktop group. 
description | **string**<br>Description of the desktop group. 
resources_spec | **[ResourcesSpec](#ResourcesSpec1)**<br>Resource specification of the desktop group. 
network_interface_spec | **[NetworkInterfaceSpec](#NetworkInterfaceSpec1)**<br>Network interface specification of the desktop group. 


### ResourcesSpec {#ResourcesSpec1}

Field | Description
--- | ---
memory | **int64**<br>RAM volume, in bytes. The minimum value is 1.
cores | **int64**<br>Number of CPU cores. The minimum value is 1.
core_fraction | **int64**<br>Baseline level of CPU performance with the ability to burst performance above that baseline level. This field sets baseline performance for each core. Acceptable values are 0 to 100, inclusive.


### NetworkInterfaceSpec {#NetworkInterfaceSpec1}

Field | Description
--- | ---
network_id | **string**<br>Required. ID of the network interface specification. The maximum string length in characters is 50.
subnet_ids[] | **string**<br>List of subnet IDs. The number of elements must be greater than 0. The maximum string length in characters for each value is 50.


## ListDesktops {#ListDesktops}

Retrieves the list of desktops resources.

**rpc ListDesktops ([ListDesktopGroupDesktopsRequest](#ListDesktopGroupDesktopsRequest)) returns ([ListDesktopGroupDesktopsResponse](#ListDesktopGroupDesktopsResponse))**

### ListDesktopGroupDesktopsRequest {#ListDesktopGroupDesktopsRequest}

Field | Description
--- | ---
desktop_group_id | **string**<br>Required. ID of the desktop group. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListDesktopGroupDesktopsResponse.next_page_token](#ListDesktopGroupDesktopsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListDesktopGroupDesktopsResponse.next_page_token](#ListDesktopGroupDesktopsResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. The expression must specify: <ol><li>The field name. Currently you can use filtering only on [Desktop.name](#Desktop) field. </li><li>An operator. Can be either `=` or `!=` for single values, `IN` or `NOT IN` for lists of values. </li><li>Value or a list of values to compare against the values of the field.</li></ol> The maximum string length in characters is 1000.
order_by | **string**<br>Sorting the list by [Desktop.name](#Desktop), [Desktop.created_at](#Desktop) and [Desktop.status](#Desktop) fields. The default sorting order is ascending. The maximum string length in characters is 100.


### ListDesktopGroupDesktopsResponse {#ListDesktopGroupDesktopsResponse}

Field | Description
--- | ---
desktops[] | **[Desktop](#Desktop)**<br>List of desktops. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListDesktopGroupDesktopsRequest.page_size](#ListDesktopGroupDesktopsRequest), use the `next_page_token` as the value for the [ListDesktopsDGS Request.page_token] query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Desktop {#Desktop}

Field | Description
--- | ---
id | **string**<br>Desktop ID. 
folder_id | **string**<br>ID of the folder that the desktop belongs to. 
desktop_group_id | **string**<br>ID of the desktop group that the desktop belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
status | enum **Status**<br>Status of the desktop. <ul><li>`CREATING`: Desktop is being created.</li><li>`ACTIVE`: Desktop is ready to use.</li><li>`DELETING`: Desktop is being deleted.</li></ul>
name | **string**<br>Name of the desktop. 
resources | **[Resources](#Resources)**<br>Resources of the desktop. 
network_interfaces[] | **[NetworkInterface](#NetworkInterface)**<br> 
users[] | **[User](#User)**<br> 


### Resources {#Resources}

Field | Description
--- | ---
memory | **int64**<br> The minimum value is 1.
cores | **int64**<br> The minimum value is 1.
core_fraction | **int64**<br> Acceptable values are 0 to 100, inclusive.


### NetworkInterface {#NetworkInterface}

Field | Description
--- | ---
network_id | **string**<br>Required.  The maximum string length in characters is 50.
subnet_id | **string**<br>Required.  The maximum string length in characters is 50.


### User {#User}

Field | Description
--- | ---
subject_id | **string**<br>Required. Identity of the access binding. 


## ListOperations {#ListOperations}

Returns list of the operations for the specified desktop group.

**rpc ListOperations ([ListDesktopGroupOperationsRequest](#ListDesktopGroupOperationsRequest)) returns ([ListDesktopGroupOperationsResponse](#ListDesktopGroupOperationsResponse))**

### ListDesktopGroupOperationsRequest {#ListDesktopGroupOperationsRequest}

Field | Description
--- | ---
desktop_group_id | **string**<br>Required. ID of the desktop group. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListDesktopGroupOperationsResponse.next_page_token](#ListDesktopGroupOperationsResponse) that can be used to get the next page of results in subsequent list requests. Default value: 100. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListDesktopGroupOperationsResponse.next_page_token](#ListDesktopGroupOperationsResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>Sorting the list by [DesktopGroup.name](#DesktopGroup2) field. The default sorting order is ascending. The maximum string length in characters is 1000.


### ListDesktopGroupOperationsResponse {#ListDesktopGroupOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation)**<br>List of operations for the specified desktop group. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListDesktopGroupOperationsRequest.page_size](#ListDesktopGroupOperationsRequest), use the `next_page_token` as the value for the [ListDesktopGroupOperationsRequest.page_token](#ListDesktopGroupOperationsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Operation {#Operation}

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


## Create {#Create}

Creates desktop group in the specified folder.

**rpc Create ([CreateDesktopGroupRequest](#CreateDesktopGroupRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateDesktopGroupMetadata](#CreateDesktopGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[DesktopGroup](#DesktopGroup2)<br>

### CreateDesktopGroupRequest {#CreateDesktopGroupRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create a DesktopGroup in. <br>To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) request. The maximum string length in characters is 50.
desktop_image_id | **string**<br>Required. An image used to create a desktop boot disk The maximum string length in characters is 50.
name | **string**<br>Name of the DesktopGroup. The name must be unique within the folder. Value must match the regular expression ` [a-z]([-a-z0-9]{0,61}[a-z0-9]) `.
description | **string**<br>Description of the DesktopGroup. The maximum string length in characters is 1024.
resources_spec | **[ResourcesSpec](#ResourcesSpec2)**<br>Resource specification of the desktop group. 
network_interface_spec | **[NetworkInterfaceSpec](#NetworkInterfaceSpec2)**<br>Network interface specification of the desktop group. 


### ResourcesSpec {#ResourcesSpec2}

Field | Description
--- | ---
memory | **int64**<br>RAM volume, in bytes. The minimum value is 1.
cores | **int64**<br>Number of CPU cores. The minimum value is 1.
core_fraction | **int64**<br>Baseline level of CPU performance with the ability to burst performance above that baseline level. This field sets baseline performance for each core. Acceptable values are 0 to 100, inclusive.


### NetworkInterfaceSpec {#NetworkInterfaceSpec2}

Field | Description
--- | ---
network_id | **string**<br>Required. ID of the network interface specification. The maximum string length in characters is 50.
subnet_ids[] | **string**<br>List of subnet IDs. The number of elements must be greater than 0. The maximum string length in characters for each value is 50.


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateDesktopGroupMetadata](#CreateDesktopGroupMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DesktopGroup](#DesktopGroup2)>**<br>if operation finished successfully. 


### CreateDesktopGroupMetadata {#CreateDesktopGroupMetadata}

Field | Description
--- | ---
desktop_group_id | **string**<br>ID of the desktop group that is being created. 


### DesktopGroup {#DesktopGroup2}

Field | Description
--- | ---
id | **string**<br>Desktop group ID. 
folder_id | **string**<br>ID of the folder that the desktop group belongs to. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. 
status | enum **Status**<br>Status of the desktop group. <ul><li>`CREATING`: Desktop group is being created.</li><li>`ACTIVE`: Desktop group is ready to use.</li><li>`DELETING`: Desktop group is being deleted.</li></ul>
name | **string**<br>Name of the desktop group. 
description | **string**<br>Description of the desktop group. 
resources_spec | **[ResourcesSpec](#ResourcesSpec3)**<br>Resource specification of the desktop group. 
network_interface_spec | **[NetworkInterfaceSpec](#NetworkInterfaceSpec3)**<br>Network interface specification of the desktop group. 


## Delete {#Delete}

Deletes the specified desktop group.

**rpc Delete ([DeleteDesktopGroupRequest](#DeleteDesktopGroupRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteDesktopGroupMetadata](#DeleteDesktopGroupMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteDesktopGroupRequest {#DeleteDesktopGroupRequest}

Field | Description
--- | ---
desktop_group_id | **string**<br>Required. ID of the desktop group to delete. <br>To get a desktop group ID make a [DesktopGroupService.List](#List) request. The maximum string length in characters is 50.


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteDesktopGroupMetadata](#DeleteDesktopGroupMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteDesktopGroupMetadata {#DeleteDesktopGroupMetadata}

Field | Description
--- | ---
desktop_group_id | **string**<br>ID of the desktop group that is being deleted. 


## ListAccessBindings {#ListAccessBindings}

Returns a list of the access bindings for the specified desktop group.

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

Sets access bindings for the specified desktop group.

**rpc SetAccessBindings ([SetAccessBindingsRequest](#SetAccessBindingsRequest)) returns ([operation.Operation](#Operation3))**

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


### Operation {#Operation3}

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

Updates access bindings of the specified desktop group.

**rpc UpdateAccessBindings ([UpdateAccessBindingsRequest](#UpdateAccessBindingsRequest)) returns ([operation.Operation](#Operation4))**

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


### Operation {#Operation4}

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


