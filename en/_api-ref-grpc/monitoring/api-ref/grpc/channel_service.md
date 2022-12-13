---
editable: false
---

# Monitoring API, gRPC: ChannelService

A set of methods for managing Channel resources.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified Channel resource. |
| [List](#List) | Retrieves the list of Channel resources. |
| [Create](#Create) | Creates a channel. |
| [Update](#Update) | Updates the specified channel. |
| [Delete](#Delete) | Deletes the specified channel. |
| [ListOperations](#ListOperations) | Lists operations for the specified channel. |

## Calls ChannelService {#calls}

## Get {#Get}

Returns the specified Channel resource. <br>To get the list of available Channel resources, make a [List](#List) request.

**rpc Get ([GetChannelRequest](#GetChannelRequest)) returns ([Channel](#Channel))**

### GetChannelRequest {#GetChannelRequest}

Field | Description
--- | ---
channel_id | **string**<br>Required. ID of the Channel resource to return. The maximum string length in characters is 50.


### Channel {#Channel}

Field | Description
--- | ---
id | **string**<br>ID of the channel. 
folder_id | **string**<br>ID of the folder that the channel belongs on. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the channel. 
description | **string**<br>Description of the channel. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 
type | **oneof:** `cloud_email`, `cloud_sms` or `cloud_mobile_push`<br>
&nbsp;&nbsp;cloud_email | **[CloudEmailChannel](#CloudEmailChannel)**<br>E-Mail channel. 
&nbsp;&nbsp;cloud_sms | **[CloudSmsChannel](#CloudSmsChannel)**<br>Sms channel. 
&nbsp;&nbsp;cloud_mobile_push | **[CloudMobilePushChannel](#CloudMobilePushChannel)**<br>Mobile application push channel. 


### CloudEmailChannel {#CloudEmailChannel}

Field | Description
--- | ---
recipients[] | **string**<br> 


### CloudSmsChannel {#CloudSmsChannel}

Field | Description
--- | ---
recipients[] | **string**<br> 


### CloudMobilePushChannel {#CloudMobilePushChannel}

Field | Description
--- | ---
recipients[] | **string**<br> 


## List {#List}

Retrieves the list of Channel resources.

**rpc List ([ListChannelsRequest](#ListChannelsRequest)) returns ([ListChannelsResponse](#ListChannelsResponse))**

### ListChannelsRequest {#ListChannelsRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to list channels in. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListChannelsResponse.next_page_token](#ListChannelsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListChannelsResponse.next_page_token](#ListChannelsResponse) returned by a previous list request. The maximum string length in characters is 100.
filter | **string**<br>A filter expression that filters resources listed in the response. Currently you can use filtering only on the [Channel.id](#Channel1) or [Channel.name](#Channel1) field. The maximum string length in characters is 1000.


### ListChannelsResponse {#ListChannelsResponse}

Field | Description
--- | ---
channels[] | **[Channel](#Channel1)**<br>List of Channel resources. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListChannelsRequest.page_size](#ListChannelsRequest), use the `next_page_token` as the value for the [ListChannelsRequest.page_token](#ListChannelsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### Channel {#Channel1}

Field | Description
--- | ---
id | **string**<br>ID of the channel. 
folder_id | **string**<br>ID of the folder that the channel belongs on. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the channel. 
description | **string**<br>Description of the channel. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 
type | **oneof:** `cloud_email`, `cloud_sms` or `cloud_mobile_push`<br>
&nbsp;&nbsp;cloud_email | **[CloudEmailChannel](#CloudEmailChannel1)**<br>E-Mail channel. 
&nbsp;&nbsp;cloud_sms | **[CloudSmsChannel](#CloudSmsChannel1)**<br>Sms channel. 
&nbsp;&nbsp;cloud_mobile_push | **[CloudMobilePushChannel](#CloudMobilePushChannel1)**<br>Mobile application push channel. 


### CloudEmailChannel {#CloudEmailChannel1}

Field | Description
--- | ---
recipients[] | **string**<br> 


### CloudSmsChannel {#CloudSmsChannel1}

Field | Description
--- | ---
recipients[] | **string**<br> 


### CloudMobilePushChannel {#CloudMobilePushChannel1}

Field | Description
--- | ---
recipients[] | **string**<br> 


## Create {#Create}

Creates a channel.

**rpc Create ([CreateChannelRequest](#CreateChannelRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateChannelMetadata](#CreateChannelMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Channel](#Channel2)<br>

### CreateChannelRequest {#CreateChannelRequest}

Field | Description
--- | ---
folder_id | **string**<br>Required. ID of the folder to create channel in. The maximum string length in characters is 50.
name | **string**<br>Name of the channel. Value must match the regular expression ` \|[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the channel. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
type | **oneof:** `cloud_email`, `cloud_sms` or `cloud_mobile_push`<br>
&nbsp;&nbsp;cloud_email | **[CloudEmailChannel](#CloudEmailChannel2)**<br>E-Mail channel. 
&nbsp;&nbsp;cloud_sms | **[CloudSmsChannel](#CloudSmsChannel2)**<br>SMS channel. 
&nbsp;&nbsp;cloud_mobile_push | **[CloudMobilePushChannel](#CloudMobilePushChannel2)**<br>Mobile application push channel. 


### CloudEmailChannel {#CloudEmailChannel2}

Field | Description
--- | ---
recipients[] | **string**<br> 


### CloudSmsChannel {#CloudSmsChannel2}

Field | Description
--- | ---
recipients[] | **string**<br> 


### CloudMobilePushChannel {#CloudMobilePushChannel2}

Field | Description
--- | ---
recipients[] | **string**<br> 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateChannelMetadata](#CreateChannelMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Channel](#Channel2)>**<br>if operation finished successfully. 


### CreateChannelMetadata {#CreateChannelMetadata}

Field | Description
--- | ---
channel_id | **string**<br>ID of the channel. 


### Channel {#Channel2}

Field | Description
--- | ---
id | **string**<br>ID of the channel. 
folder_id | **string**<br>ID of the folder that the channel belongs on. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the channel. 
description | **string**<br>Description of the channel. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 
type | **oneof:** `cloud_email`, `cloud_sms` or `cloud_mobile_push`<br>
&nbsp;&nbsp;cloud_email | **[CloudEmailChannel](#CloudEmailChannel3)**<br>E-Mail channel. 
&nbsp;&nbsp;cloud_sms | **[CloudSmsChannel](#CloudSmsChannel3)**<br>Sms channel. 
&nbsp;&nbsp;cloud_mobile_push | **[CloudMobilePushChannel](#CloudMobilePushChannel3)**<br>Mobile application push channel. 


## Update {#Update}

Updates the specified channel.

**rpc Update ([UpdateChannelRequest](#UpdateChannelRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateChannelMetadata](#UpdateChannelMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Channel](#Channel3)<br>

### UpdateChannelRequest {#UpdateChannelRequest}

Field | Description
--- | ---
channel_id | **string**<br>Required. ID of the Channel resource to update. The maximum string length in characters is 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the Channel resource are going to be updated. 
name | **string**<br>Name of the channel. Value must match the regular expression ` \|[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Description of the channel. The maximum string length in characters is 256.
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. <br>Existing set of `labels` is completely replaced by the provided set. No more than 64 per resource. The maximum string length in characters for each value is 63. Each value must match the regular expression ` [-_./\\@0-9a-z]* `. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_./\\@0-9a-z]* `.
type | **oneof:** `cloud_email`, `cloud_sms` or `cloud_mobile_push`<br>
&nbsp;&nbsp;cloud_email | **[CloudEmailChannel](#CloudEmailChannel3)**<br>E-Mail channel. 
&nbsp;&nbsp;cloud_sms | **[CloudSmsChannel](#CloudSmsChannel3)**<br>SMS channel. 
&nbsp;&nbsp;cloud_mobile_push | **[CloudMobilePushChannel](#CloudMobilePushChannel3)**<br>Mobile application push channel. 


### CloudEmailChannel {#CloudEmailChannel3}

Field | Description
--- | ---
recipients[] | **string**<br> 


### CloudSmsChannel {#CloudSmsChannel3}

Field | Description
--- | ---
recipients[] | **string**<br> 


### CloudMobilePushChannel {#CloudMobilePushChannel3}

Field | Description
--- | ---
recipients[] | **string**<br> 


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateChannelMetadata](#UpdateChannelMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Channel](#Channel3)>**<br>if operation finished successfully. 


### UpdateChannelMetadata {#UpdateChannelMetadata}

Field | Description
--- | ---
channel_id | **string**<br>ID of the channel that is being updated. 


### Channel {#Channel3}

Field | Description
--- | ---
id | **string**<br>ID of the channel. 
folder_id | **string**<br>ID of the folder that the channel belongs on. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
name | **string**<br>Name of the channel. 
description | **string**<br>Description of the channel. 
labels | **map<string,string>**<br>Resource labels as `key:value` pairs. 
type | **oneof:** `cloud_email`, `cloud_sms` or `cloud_mobile_push`<br>
&nbsp;&nbsp;cloud_email | **[CloudEmailChannel](#CloudEmailChannel4)**<br>E-Mail channel. 
&nbsp;&nbsp;cloud_sms | **[CloudSmsChannel](#CloudSmsChannel4)**<br>Sms channel. 
&nbsp;&nbsp;cloud_mobile_push | **[CloudMobilePushChannel](#CloudMobilePushChannel4)**<br>Mobile application push channel. 


## Delete {#Delete}

Deletes the specified channel.

**rpc Delete ([DeleteChannelRequest](#DeleteChannelRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteChannelMetadata](#DeleteChannelMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteChannelRequest {#DeleteChannelRequest}

Field | Description
--- | ---
channel_id | **string**<br>Required. ID of the channel to delete. The maximum string length in characters is 50.


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteChannelMetadata](#DeleteChannelMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteChannelMetadata {#DeleteChannelMetadata}

Field | Description
--- | ---
channel_id | **string**<br>ID of the channel that is being deleted. 


## ListOperations {#ListOperations}

Lists operations for the specified channel.

**rpc ListOperations ([ListChannelOperationsRequest](#ListChannelOperationsRequest)) returns ([ListChannelOperationsResponse](#ListChannelOperationsResponse))**

### ListChannelOperationsRequest {#ListChannelOperationsRequest}

Field | Description
--- | ---
channel_id | **string**<br>Required. ID of the channel to list operations for. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListChannelOperationsResponse.next_page_token](#ListChannelOperationsResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListChannelOperationsResponse.next_page_token](#ListChannelOperationsResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListChannelOperationsResponse {#ListChannelOperationsResponse}

Field | Description
--- | ---
operations[] | **[operation.Operation](#Operation3)**<br>List of operations for the specified channel. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListChannelOperationsRequest.page_size](#ListChannelOperationsRequest), use the `next_page_token` as the value for the [ListChannelOperationsRequest.page_token](#ListChannelOperationsRequest) query parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


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


