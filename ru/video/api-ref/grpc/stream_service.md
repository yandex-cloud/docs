---
editable: false
sourcePath: en/_api-ref-grpc/video/api-ref/grpc/stream_service.md
---

# Video API, gRPC: StreamService

Stream management service.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specific stream. |
| [List](#List) | List streams for channel. |
| [Create](#Create) | Create stream. |
| [Update](#Update) | Update stream. |
| [Delete](#Delete) | Delete stream. |
| [PerformAction](#PerformAction) | Perform an action on the episode. |

## Calls StreamService {#calls}

## Get {#Get}

Returns the specific stream.

**rpc Get ([GetStreamRequest](#GetStreamRequest)) returns ([Stream](#Stream))**

### GetStreamRequest {#GetStreamRequest}

Field | Description
--- | ---
stream_id | **string**<br>ID of the stream. 


### Stream {#Stream}

Field | Description
--- | ---
id | **string**<br>ID of the stream. 
channel_id | **string**<br>ID of the channel where the stream was created. 
line_id | **string**<br>ID of the line to which stream is linked. 
title | **string**<br>Stream title. 
description | **string**<br>Stream description. 
thumbnail_id | **string**<br>ID of the thumbnail. 
status | enum **StreamStatus**<br>Stream status. <ul><li>`STREAM_STATUS_UNSPECIFIED`: Stream status unspecified.</li><li>`OFFLINE`: Stream offline.</li><li>`PREPARING`: Preparing the infrastructure for receiving video signal.</li><li>`READY`: Everything is ready to launch stream.</li><li>`ONAIR`: Stream onair.</li><li>`FINISHED`: Stream finished.</li></ul>
start_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Stream start time. 
publish_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Stream publish time. Time when stream switched to ONAIR status. 
finish_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Stream finish time. 
stream_type | **oneof:** `on_demand` or `schedule`<br>Stream type.
&nbsp;&nbsp;on_demand | **[OnDemand](#OnDemand)**<br>On demand stream. It starts immediately when a signal appears. 
&nbsp;&nbsp;schedule | **[Schedule](#Schedule)**<br>Schedule stream. Determines when to start receiving the signal or finish time. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when stream was created. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of last stream update. 
labels | **map<string,string>**<br>Custom labels as `` key:value `` pairs. Maximum 64 per resource. 


### OnDemand {#OnDemand}

Empty.

### Schedule {#Schedule}

Field | Description
--- | ---
start_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
finish_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 


## List {#List}

List streams for channel.

**rpc List ([ListStreamsRequest](#ListStreamsRequest)) returns ([ListStreamsResponse](#ListStreamsResponse))**

### ListStreamsRequest {#ListStreamsRequest}

Field | Description
--- | ---
channel_id | **string**<br>ID of the channel. 
page_size | **int64**<br>The maximum number of the results per page to return. Default value: 100. 
page_token | **string**<br>Page token for getting the next page of the result. 
order_by | **string**<br>By which column the listing should be ordered and in which direction, format is "createdAt desc". "id asc" if omitted. Possible fields: ["id", "title", "startTime", "finishTime", "createdAt", "updatedAt"] Both snake_case and camelCase are supported for fields. 
filter | **string**<br>Filter expression that filters resources listed in the response. Expressions are composed of terms connected by logic operators. Value in quotes: `'` or `"` Example: "key1='value' AND key2='value'" Supported operators: ["AND"]. Supported fields: ["title", "lineId", "status"] Both snake_case and camelCase are supported for fields. 


### ListStreamsResponse {#ListStreamsResponse}

Field | Description
--- | ---
streams[] | **[Stream](#Stream1)**<br>List of streams for channel. 
next_page_token | **string**<br>Token for getting the next page. 


### Stream {#Stream1}

Field | Description
--- | ---
id | **string**<br>ID of the stream. 
channel_id | **string**<br>ID of the channel where the stream was created. 
line_id | **string**<br>ID of the line to which stream is linked. 
title | **string**<br>Stream title. 
description | **string**<br>Stream description. 
thumbnail_id | **string**<br>ID of the thumbnail. 
status | enum **StreamStatus**<br>Stream status. <ul><li>`STREAM_STATUS_UNSPECIFIED`: Stream status unspecified.</li><li>`OFFLINE`: Stream offline.</li><li>`PREPARING`: Preparing the infrastructure for receiving video signal.</li><li>`READY`: Everything is ready to launch stream.</li><li>`ONAIR`: Stream onair.</li><li>`FINISHED`: Stream finished.</li></ul>
start_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Stream start time. 
publish_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Stream publish time. Time when stream switched to ONAIR status. 
finish_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Stream finish time. 
stream_type | **oneof:** `on_demand` or `schedule`<br>Stream type.
&nbsp;&nbsp;on_demand | **[OnDemand](#OnDemand1)**<br>On demand stream. It starts immediately when a signal appears. 
&nbsp;&nbsp;schedule | **[Schedule](#Schedule1)**<br>Schedule stream. Determines when to start receiving the signal or finish time. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when stream was created. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of last stream update. 
labels | **map<string,string>**<br>Custom labels as `` key:value `` pairs. Maximum 64 per resource. 


### OnDemand {#OnDemand1}

Empty.

### Schedule {#Schedule1}

Field | Description
--- | ---
start_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
finish_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 


## Create {#Create}

Create stream.

**rpc Create ([CreateStreamRequest](#CreateStreamRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateStreamMetadata](#CreateStreamMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Stream](#Stream2)<br>

### CreateStreamRequest {#CreateStreamRequest}

Field | Description
--- | ---
channel_id | **string**<br>ID of the channel. 
line_id | **string**<br>ID of the line. 
title | **string**<br>Stream title. 
description | **string**<br>Stream description. 
thumbnail_id | **string**<br>ID of the thumbnail. 
labels | **map<string,string>**<br>Custom labels as `` key:value `` pairs. Maximum 64 per resource. 
stream_type | **oneof:** `on_demand` or `schedule`<br>Stream type.
&nbsp;&nbsp;on_demand | **[OnDemandParams](#OnDemandParams)**<br>On demand stream. It starts immediately when a signal appears. 
&nbsp;&nbsp;schedule | **[ScheduleParams](#ScheduleParams)**<br>Schedule stream. Determines when to start receiving the signal or finish time. 


### OnDemandParams {#OnDemandParams}

Empty.

### ScheduleParams {#ScheduleParams}

Field | Description
--- | ---
start_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
finish_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateStreamMetadata](#CreateStreamMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Stream](#Stream2)>**<br>if operation finished successfully. 


### CreateStreamMetadata {#CreateStreamMetadata}

Field | Description
--- | ---
stream_id | **string**<br>ID of the stream. 


### Stream {#Stream2}

Field | Description
--- | ---
id | **string**<br>ID of the stream. 
channel_id | **string**<br>ID of the channel where the stream was created. 
line_id | **string**<br>ID of the line to which stream is linked. 
title | **string**<br>Stream title. 
description | **string**<br>Stream description. 
thumbnail_id | **string**<br>ID of the thumbnail. 
status | enum **StreamStatus**<br>Stream status. <ul><li>`STREAM_STATUS_UNSPECIFIED`: Stream status unspecified.</li><li>`OFFLINE`: Stream offline.</li><li>`PREPARING`: Preparing the infrastructure for receiving video signal.</li><li>`READY`: Everything is ready to launch stream.</li><li>`ONAIR`: Stream onair.</li><li>`FINISHED`: Stream finished.</li></ul>
start_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Stream start time. 
publish_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Stream publish time. Time when stream switched to ONAIR status. 
finish_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Stream finish time. 
stream_type | **oneof:** `on_demand` or `schedule`<br>Stream type.
&nbsp;&nbsp;on_demand | **[OnDemand](#OnDemand2)**<br>On demand stream. It starts immediately when a signal appears. 
&nbsp;&nbsp;schedule | **[Schedule](#Schedule2)**<br>Schedule stream. Determines when to start receiving the signal or finish time. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when stream was created. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of last stream update. 
labels | **map<string,string>**<br>Custom labels as `` key:value `` pairs. Maximum 64 per resource. 


### OnDemand {#OnDemand2}

Empty.

### Schedule {#Schedule2}

Field | Description
--- | ---
start_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
finish_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 


## Update {#Update}

Update stream.

**rpc Update ([UpdateStreamRequest](#UpdateStreamRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateStreamMetadata](#UpdateStreamMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Stream](#Stream3)<br>

### UpdateStreamRequest {#UpdateStreamRequest}

Field | Description
--- | ---
stream_id | **string**<br>ID of the stream. 
field_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the stream are going to be updated. 
line_id | **string**<br>ID of the line. 
title | **string**<br>Stream title. 
description | **string**<br>Stream description. 
thumbnail_id | **string**<br>ID of the thumbnail. 
labels | **map<string,string>**<br>Custom labels as `` key:value `` pairs. Maximum 64 per resource. 
stream_type | **oneof:** `on_demand` or `schedule`<br>Stream type.
&nbsp;&nbsp;on_demand | **[OnDemandParams](#OnDemandParams)**<br>On demand stream. It starts immediately when a signal appears. 
&nbsp;&nbsp;schedule | **[ScheduleParams](#ScheduleParams)**<br>Schedule stream. Determines when to start receiving the signal or finish time. 


### OnDemandParams {#OnDemandParams1}

Empty.

### ScheduleParams {#ScheduleParams1}

Field | Description
--- | ---
start_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
finish_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateStreamMetadata](#UpdateStreamMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Stream](#Stream3)>**<br>if operation finished successfully. 


### UpdateStreamMetadata {#UpdateStreamMetadata}

Field | Description
--- | ---
stream_id | **string**<br>ID of the stream. 


### Stream {#Stream3}

Field | Description
--- | ---
id | **string**<br>ID of the stream. 
channel_id | **string**<br>ID of the channel where the stream was created. 
line_id | **string**<br>ID of the line to which stream is linked. 
title | **string**<br>Stream title. 
description | **string**<br>Stream description. 
thumbnail_id | **string**<br>ID of the thumbnail. 
status | enum **StreamStatus**<br>Stream status. <ul><li>`STREAM_STATUS_UNSPECIFIED`: Stream status unspecified.</li><li>`OFFLINE`: Stream offline.</li><li>`PREPARING`: Preparing the infrastructure for receiving video signal.</li><li>`READY`: Everything is ready to launch stream.</li><li>`ONAIR`: Stream onair.</li><li>`FINISHED`: Stream finished.</li></ul>
start_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Stream start time. 
publish_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Stream publish time. Time when stream switched to ONAIR status. 
finish_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Stream finish time. 
stream_type | **oneof:** `on_demand` or `schedule`<br>Stream type.
&nbsp;&nbsp;on_demand | **[OnDemand](#OnDemand3)**<br>On demand stream. It starts immediately when a signal appears. 
&nbsp;&nbsp;schedule | **[Schedule](#Schedule3)**<br>Schedule stream. Determines when to start receiving the signal or finish time. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when stream was created. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of last stream update. 
labels | **map<string,string>**<br>Custom labels as `` key:value `` pairs. Maximum 64 per resource. 


### OnDemand {#OnDemand3}

Empty.

### Schedule {#Schedule3}

Field | Description
--- | ---
start_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
finish_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 


## Delete {#Delete}

Delete stream.

**rpc Delete ([DeleteStreamRequest](#DeleteStreamRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteStreamMetadata](#DeleteStreamMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteStreamRequest {#DeleteStreamRequest}

Field | Description
--- | ---
stream_id | **string**<br>ID of the stream. 


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteStreamMetadata](#DeleteStreamMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteStreamMetadata {#DeleteStreamMetadata}

Field | Description
--- | ---
stream_id | **string**<br>ID of the stream. 


## PerformAction {#PerformAction}

Perform an action on the episode.

**rpc PerformAction ([PerformStreamActionRequest](#PerformStreamActionRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[PerformStreamActionMetadata](#PerformStreamActionMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Stream](#Stream4)<br>

### PerformStreamActionRequest {#PerformStreamActionRequest}

Field | Description
--- | ---
stream_id | **string**<br>ID of the stream. 
action | **oneof:** `publish` or `stop`<br>
&nbsp;&nbsp;publish | **[PublishAction](#PublishAction)**<br> 
&nbsp;&nbsp;stop | **[StopAction](#StopAction)**<br> 


### PublishAction {#PublishAction}

Empty.

### StopAction {#StopAction}

Empty.

### Operation {#Operation3}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[PerformStreamActionMetadata](#PerformStreamActionMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Stream](#Stream4)>**<br>if operation finished successfully. 


### PerformStreamActionMetadata {#PerformStreamActionMetadata}

Field | Description
--- | ---
stream_id | **string**<br>ID of the stream. 


### Stream {#Stream4}

Field | Description
--- | ---
id | **string**<br>ID of the stream. 
channel_id | **string**<br>ID of the channel where the stream was created. 
line_id | **string**<br>ID of the line to which stream is linked. 
title | **string**<br>Stream title. 
description | **string**<br>Stream description. 
thumbnail_id | **string**<br>ID of the thumbnail. 
status | enum **StreamStatus**<br>Stream status. <ul><li>`STREAM_STATUS_UNSPECIFIED`: Stream status unspecified.</li><li>`OFFLINE`: Stream offline.</li><li>`PREPARING`: Preparing the infrastructure for receiving video signal.</li><li>`READY`: Everything is ready to launch stream.</li><li>`ONAIR`: Stream onair.</li><li>`FINISHED`: Stream finished.</li></ul>
start_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Stream start time. 
publish_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Stream publish time. Time when stream switched to ONAIR status. 
finish_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Stream finish time. 
stream_type | **oneof:** `on_demand` or `schedule`<br>Stream type.
&nbsp;&nbsp;on_demand | **[OnDemand](#OnDemand4)**<br>On demand stream. It starts immediately when a signal appears. 
&nbsp;&nbsp;schedule | **[Schedule](#Schedule4)**<br>Schedule stream. Determines when to start receiving the signal or finish time. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when stream was created. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of last stream update. 
labels | **map<string,string>**<br>Custom labels as `` key:value `` pairs. Maximum 64 per resource. 


### OnDemand {#OnDemand4}

Empty.

### Schedule {#Schedule4}

Field | Description
--- | ---
start_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
finish_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 


