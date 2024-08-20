---
editable: false
sourcePath: en/_api-ref-grpc/video/api-ref/grpc/channel_service.md
---

# Video API, gRPC: ChannelService

Channel management service.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specific channel. |
| [List](#List) | List channels for organization. |
| [Create](#Create) | Create channel. |
| [Update](#Update) | Update channel. |
| [Delete](#Delete) | Delete channel. |

## Calls ChannelService {#calls}

## Get {#Get}

Returns the specific channel.

**rpc Get ([GetChannelRequest](#GetChannelRequest)) returns ([Channel](#Channel))**

### GetChannelRequest {#GetChannelRequest}

Field | Description
--- | ---
channel_id | **string**<br>ID of the channel. 


### Channel {#Channel}

Field | Description
--- | ---
id | **string**<br>ID of the channel. 
organization_id | **string**<br>ID of the organization where channel should be created. 
title | **string**<br>Channel title. 
description | **string**<br>Channel description. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when channel was created. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of last channel update. 
labels | **map<string,string>**<br>Custom labels as `` key:value `` pairs. Maximum 64 per resource. 


## List {#List}

List channels for organization.

**rpc List ([ListChannelsRequest](#ListChannelsRequest)) returns ([ListChannelsResponse](#ListChannelsResponse))**

### ListChannelsRequest {#ListChannelsRequest}

Field | Description
--- | ---
organization_id | **string**<br>ID of the organization. 
page_size | **int64**<br>The maximum number of the results per page to return. Default value: 100. 
page_token | **string**<br>Page token for getting the next page of the result. 
order_by | **string**<br>By which column the listing should be ordered and in which direction, format is "createdAt desc". "id asc" if omitted. Possible fields: ["id", "createdAt", "updatedAt"] Both snake_case and camelCase are supported for fields. 
filter | **string**<br>Filter expression that filters resources listed in the response. Expressions are composed of terms connected by logic operators. Value in quotes: `'` or `"` Example: "key1='value' AND key2='value'" Supported operators: ["AND"]. Supported fields: ["title"] Both snake_case and camelCase are supported for fields. 


### ListChannelsResponse {#ListChannelsResponse}

Field | Description
--- | ---
channels[] | **[Channel](#Channel1)**<br>List of channels for specific organization. 
next_page_token | **string**<br>Token for getting the next page. 


### Channel {#Channel1}

Field | Description
--- | ---
id | **string**<br>ID of the channel. 
organization_id | **string**<br>ID of the organization where channel should be created. 
title | **string**<br>Channel title. 
description | **string**<br>Channel description. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when channel was created. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of last channel update. 
labels | **map<string,string>**<br>Custom labels as `` key:value `` pairs. Maximum 64 per resource. 


## Create {#Create}

Create channel.

**rpc Create ([CreateChannelRequest](#CreateChannelRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateChannelMetadata](#CreateChannelMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Channel](#Channel2)<br>

### CreateChannelRequest {#CreateChannelRequest}

Field | Description
--- | ---
organization_id | **string**<br>ID of the organization. 
title | **string**<br>Channel title. 
description | **string**<br>Channel description. 
labels | **map<string,string>**<br>Custom labels as `` key:value `` pairs. Maximum 64 per resource. 


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
organization_id | **string**<br>ID of the organization where channel should be created. 
title | **string**<br>Channel title. 
description | **string**<br>Channel description. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when channel was created. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of last channel update. 
labels | **map<string,string>**<br>Custom labels as `` key:value `` pairs. Maximum 64 per resource. 


## Update {#Update}

Update channel.

**rpc Update ([UpdateChannelRequest](#UpdateChannelRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateChannelMetadata](#UpdateChannelMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Channel](#Channel3)<br>

### UpdateChannelRequest {#UpdateChannelRequest}

Field | Description
--- | ---
channel_id | **string**<br>ID of the channel. 
field_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the channel are going to be updated. 
title | **string**<br>Channel title. 
description | **string**<br>Channel description. 
labels | **map<string,string>**<br>Custom labels as `` key:value `` pairs. Maximum 64 per resource. 


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
channel_id | **string**<br>ID of the channel. 


### Channel {#Channel3}

Field | Description
--- | ---
id | **string**<br>ID of the channel. 
organization_id | **string**<br>ID of the organization where channel should be created. 
title | **string**<br>Channel title. 
description | **string**<br>Channel description. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when channel was created. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of last channel update. 
labels | **map<string,string>**<br>Custom labels as `` key:value `` pairs. Maximum 64 per resource. 


## Delete {#Delete}

Delete channel.

**rpc Delete ([DeleteChannelRequest](#DeleteChannelRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteChannelMetadata](#DeleteChannelMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteChannelRequest {#DeleteChannelRequest}

Field | Description
--- | ---
channel_id | **string**<br>ID of the channel. 


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
channel_id | **string**<br>ID of the channel. 


