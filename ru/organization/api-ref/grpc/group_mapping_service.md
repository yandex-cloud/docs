---
editable: false
sourcePath: en/_api-ref-grpc/organization/api-ref/grpc/group_mapping_service.md
---

# Cloud Organization API, gRPC: GroupMappingService

RPC service dedicated for federation group mapping.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns a group mapping configured for the specific federation If a federation does not exist this call will return an error NOT_FOUND will be returned If a federation exist, but has not ever been configured for group mapping the call FAILED_PRECONDITION will be returned. |
| [Create](#Create) | Adds a group mapping for a federation If mapping already exist, ALREADY_EXISTS will be returned |
| [Update](#Update) | Updates an existing group mapping for a federation Errors: - if federation is not found In case of any error, no changes are applied to existing group mapping <br>This call is idempotent. |
| [Delete](#Delete) | Deletes a group mapping. |
| [ListItems](#ListItems) | Returns all the group mappings items <br>Filtering is only supported by external_group_id or internal_group_id |
| [UpdateItems](#UpdateItems) | Updates group mapping items for a specified federation Errors: - if federation is not found - if internal group in the mapping added does not exist In case of any error, no changes are applied to existing group mapping <br>This call is idempotent. |

## Calls GroupMappingService {#calls}

## Get {#Get}

Returns a group mapping configured for the specific federation If a federation does not exist this call will return an error NOT_FOUND will be returned If a federation exist, but has not ever been configured for group mapping the call FAILED_PRECONDITION will be returned.

**rpc Get ([GetGroupMappingRequest](#GetGroupMappingRequest)) returns ([GetGroupMappingResponse](#GetGroupMappingResponse))**

### GetGroupMappingRequest {#GetGroupMappingRequest}

Field | Description
--- | ---
federation_id | **string**<br>Required.  The maximum string length in characters is 50.


### GetGroupMappingResponse {#GetGroupMappingResponse}

Field | Description
--- | ---
group_mapping | **[GroupMapping](./#GroupMapping)**<br> 


### GroupMapping {#GroupMapping}

Field | Description
--- | ---
federation_id | **string**<br>Federation id 
enabled | **bool**<br>Flag to show whether group synchronization should be enabled for this federation. 


## Create {#Create}

Adds a group mapping for a federation If mapping already exist, ALREADY_EXISTS will be returned

**rpc Create ([CreateGroupMappingRequest](#CreateGroupMappingRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateGroupMappingMetadata](#CreateGroupMappingMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[GroupMapping](./#GroupMapping1)<br>

### CreateGroupMappingRequest {#CreateGroupMappingRequest}

Field | Description
--- | ---
federation_id | **string**<br>Required. Federation the group mapping will be created for The maximum string length in characters is 50.
enabled | **bool**<br>A new state of synchronization to update (if mentioned in updated_fields). 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateGroupMappingMetadata](#CreateGroupMappingMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[GroupMapping](./#GroupMapping1)>**<br>if operation finished successfully. 


### CreateGroupMappingMetadata {#CreateGroupMappingMetadata}

Field | Description
--- | ---
federation_id | **string**<br> 


### GroupMapping {#GroupMapping1}

Field | Description
--- | ---
federation_id | **string**<br>Federation id 
enabled | **bool**<br>Flag to show whether group synchronization should be enabled for this federation. 


## Update {#Update}

Updates an existing group mapping for a federation Errors: <ul><li>if federation is not found </li></ul>In case of any error, no changes are applied to existing group mapping <br>This call is idempotent. The following actions do nothing: <ul><li>enabling when already enabled </li><li>disabling when disabled </li></ul>Such parts of request will be ignored. Others will be applied.

**rpc Update ([UpdateGroupMappingRequest](#UpdateGroupMappingRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateGroupMappingMetadata](#UpdateGroupMappingMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[GroupMapping](./#GroupMapping2)<br>

### UpdateGroupMappingRequest {#UpdateGroupMappingRequest}

Field | Description
--- | ---
federation_id | **string**<br>Required. Federation the group mapping update is requested The maximum string length in characters is 50.
updated_fields | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Required. A set of fields that should be updated 
enabled | **bool**<br>A new state of synchronization to update (if mentioned in updated_fields). 


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateGroupMappingMetadata](#UpdateGroupMappingMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[GroupMapping](./#GroupMapping2)>**<br>if operation finished successfully. 


### UpdateGroupMappingMetadata {#UpdateGroupMappingMetadata}

Field | Description
--- | ---
federation_id | **string**<br> 


### GroupMapping {#GroupMapping2}

Field | Description
--- | ---
federation_id | **string**<br>Federation id 
enabled | **bool**<br>Flag to show whether group synchronization should be enabled for this federation. 


## Delete {#Delete}

Deletes a group mapping. This will remove all the mapping items cascade.

**rpc Delete ([DeleteGroupMappingRequest](#DeleteGroupMappingRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteGroupMappingMetadata](#DeleteGroupMappingMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteGroupMappingRequest {#DeleteGroupMappingRequest}

Field | Description
--- | ---
federation_id | **string**<br>Required. Federation the group mapping deletion is requested The maximum string length in characters is 50.


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteGroupMappingMetadata](#DeleteGroupMappingMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteGroupMappingMetadata {#DeleteGroupMappingMetadata}

Field | Description
--- | ---
federation_id | **string**<br> 


## ListItems {#ListItems}

Returns all the group mappings items <br>Filtering is only supported by external_group_id or internal_group_id

**rpc ListItems ([ListGroupMappingItemsRequest](#ListGroupMappingItemsRequest)) returns ([ListGroupMappingItemsResponse](#ListGroupMappingItemsResponse))**

### ListGroupMappingItemsRequest {#ListGroupMappingItemsRequest}

Field | Description
--- | ---
federation_id | **string**<br>Required.  The maximum string length in characters is 50.
page_size | **int64**<br> Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br> The maximum string length in characters is 2000.
filter | **string**<br> The maximum string length in characters is 1000.


### ListGroupMappingItemsResponse {#ListGroupMappingItemsResponse}

Field | Description
--- | ---
group_mapping_items[] | **[GroupMappingItem](#GroupMappingItem)**<br> 
next_page_token | **string**<br> 


### GroupMappingItem {#GroupMappingItem}

Field | Description
--- | ---
external_group_id | **string**<br>Required. External group id (received from identity provider) The maximum string length in characters is 1000.
internal_group_id | **string**<br>Required. Internal cloud group id The maximum string length in characters is 50.


## UpdateItems {#UpdateItems}

Updates group mapping items for a specified federation Errors: <ul><li>if federation is not found </li><li>if internal group in the mapping added does not exist </li></ul>In case of any error, no changes are applied to existing group mapping <br>This call is idempotent. The following actions do nothing: <ul><li>adding group mapping items that are already present </li><li>removing group mapping items that are not present </li></ul>Such parts of request will be ignored. Others will be applied.

**rpc UpdateItems ([UpdateGroupMappingItemsRequest](#UpdateGroupMappingItemsRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateGroupMappingItemsMetadata](#UpdateGroupMappingItemsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[UpdateGroupMappingItemsResponse](#UpdateGroupMappingItemsResponse)<br>

### UpdateGroupMappingItemsRequest {#UpdateGroupMappingItemsRequest}

Field | Description
--- | ---
federation_id | **string**<br>Required. Federation the group mapping update is requested The maximum string length in characters is 50.
group_mapping_item_deltas[] | **[GroupMappingItemDelta](#GroupMappingItemDelta)**<br>A collection of mapping items to add or remove (ignores update_fields). The number of elements must be in the range 1-1000.


### GroupMappingItemDelta {#GroupMappingItemDelta}

Field | Description
--- | ---
item | **[GroupMappingItem](#GroupMappingItem1)**<br> 
action | enum **Action**<br> <ul><li>`ADD`: Group mapping item is to be added</li><li>`REMOVE`: Group mapping item is to be removed</li></ul>


### GroupMappingItem {#GroupMappingItem1}

Field | Description
--- | ---
external_group_id | **string**<br>Required. External group id (received from identity provider) The maximum string length in characters is 1000.
internal_group_id | **string**<br>Required. Internal cloud group id The maximum string length in characters is 50.


### Operation {#Operation3}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateGroupMappingItemsMetadata](#UpdateGroupMappingItemsMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateGroupMappingItemsResponse](#UpdateGroupMappingItemsResponse)>**<br>if operation finished successfully. 


### UpdateGroupMappingItemsMetadata {#UpdateGroupMappingItemsMetadata}

Field | Description
--- | ---
federation_id | **string**<br> 


### UpdateGroupMappingItemsResponse {#UpdateGroupMappingItemsResponse}

Field | Description
--- | ---
group_mapping_item_deltas[] | **[GroupMappingItemDelta](#GroupMappingItemDelta)**<br>Effective changes that were applied 


