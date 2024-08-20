---
editable: false
sourcePath: en/_api-ref-grpc/video/api-ref/grpc/stream_line_service.md
---

# Video API, gRPC: StreamLineService

Stream line management service.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specific stream line. |
| [List](#List) | List lines for channel. |
| [Create](#Create) | Create stream line. |
| [Update](#Update) | Update stream line. |
| [Delete](#Delete) | Delete stream line. |
| [PerformAction](#PerformAction) | Perform an action on the line. |
| [GetStreamKey](#GetStreamKey) | Returns unique stream key. |
| [UpdateStreamKey](#UpdateStreamKey) | Change stream key. |

## Calls StreamLineService {#calls}

## Get {#Get}

Returns the specific stream line.

**rpc Get ([GetStreamLineRequest](#GetStreamLineRequest)) returns ([StreamLine](#StreamLine))**

### GetStreamLineRequest {#GetStreamLineRequest}

Field | Description
--- | ---
stream_line_id | **string**<br>ID of the line. 


### StreamLine {#StreamLine}

Field | Description
--- | ---
id | **string**<br>ID of the line. 
channel_id | **string**<br>ID of the channel where the line was created. 
title | **string**<br>Line title. 
thumbnail_id | **string**<br>ID of the thumbnail. 
input_type | **oneof:** `rtmp_push`, `srt_push`, `rtmp_pull`, `srt_pull`, `tcp_pull` or `rtsp_pull`<br>Video signal settings.
&nbsp;&nbsp;rtmp_push | **[RTMPPushInput](#RTMPPushInput)**<br>RTMP push input type. 
&nbsp;&nbsp;srt_push | **[SRTPushInput](#SRTPushInput)**<br>SRT push input type. 
&nbsp;&nbsp;rtmp_pull | **[RTMPPullInput](#RTMPPullInput)**<br>RTMP pull input type. 
&nbsp;&nbsp;srt_pull | **[SRTPullInput](#SRTPullInput)**<br>SRT pull input type. 
&nbsp;&nbsp;tcp_pull | **[TCPPullInput](#TCPPullInput)**<br>TCP pull input type. 
&nbsp;&nbsp;rtsp_pull | **[RTSPPullInput](#RTSPPullInput)**<br>RTSP pull input type. 
line_type | **oneof:** `manual_line` or `auto_line`<br>Line type.
&nbsp;&nbsp;manual_line | **[ManualLine](#ManualLine)**<br>Manual control of stream. 
&nbsp;&nbsp;auto_line | **[AutoLine](#AutoLine)**<br>Automatic control of stream. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when line was created. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of last line update. 
labels | **map<string,string>**<br>Custom labels as `` key:value `` pairs. Maximum 64 per resource. 


### RTMPPushInput {#RTMPPushInput}

Field | Description
--- | ---
url | **string**<br>RTMP server url. 


### SRTPushInput {#SRTPushInput}

Field | Description
--- | ---
url | **string**<br>SRT server url. 


### RTMPPullInput {#RTMPPullInput}

Field | Description
--- | ---
url | **string**<br>RTMP url for receiving video signal. 


### SRTPullInput {#SRTPullInput}

Field | Description
--- | ---
url | **string**<br>SRT url for receiving video signal. 


### TCPPullInput {#TCPPullInput}

Field | Description
--- | ---
url | **string**<br>TCP url for receiving video signal. 


### RTSPPullInput {#RTSPPullInput}

Field | Description
--- | ---
url | **string**<br>RTSP url for receiving video signal. 


### ManualLine {#ManualLine}

Empty.

### AutoLine {#AutoLine}

Field | Description
--- | ---
status | enum **AutoLineStatus**<br>Status of auto line. <ul><li>`AUTO_LINE_STATUS_UNSPECIFIED`: Auto line status unspecified.</li><li>`DEACTIVATED`: Auto line deactivated.</li><li>`ACTIVE`: Auto line active.</li></ul>


## List {#List}

List lines for channel.

**rpc List ([ListStreamLinesRequest](#ListStreamLinesRequest)) returns ([ListStreamLinesResponse](#ListStreamLinesResponse))**

### ListStreamLinesRequest {#ListStreamLinesRequest}

Field | Description
--- | ---
channel_id | **string**<br>ID of the channel. 
page_size | **int64**<br>The maximum number of the results per page to return. Default value: 100. 
page_token | **string**<br>Page token for getting the next page of the result. 
order_by | **string**<br>By which column the listing should be ordered and in which direction, format is "createdAt desc". "id asc" if omitted. Possible fields: ["id", "title", "createdAt", "updatedAt"] Both snake_case and camelCase are supported for fields. 
filter | **string**<br>Filter expression that filters resources listed in the response. Expressions are composed of terms connected by logic operators. Value in quotes: `'` or `"` Example: "key1='value' AND key2='value'" Supported operators: ["AND"]. Supported fields: ["title"] Both snake_case and camelCase are supported for fields. 


### ListStreamLinesResponse {#ListStreamLinesResponse}

Field | Description
--- | ---
stream_lines[] | **[StreamLine](#StreamLine1)**<br>List of lines for channel. 
next_page_token | **string**<br>Token for getting the next page. 


### StreamLine {#StreamLine1}

Field | Description
--- | ---
id | **string**<br>ID of the line. 
channel_id | **string**<br>ID of the channel where the line was created. 
title | **string**<br>Line title. 
thumbnail_id | **string**<br>ID of the thumbnail. 
input_type | **oneof:** `rtmp_push`, `srt_push`, `rtmp_pull`, `srt_pull`, `tcp_pull` or `rtsp_pull`<br>Video signal settings.
&nbsp;&nbsp;rtmp_push | **[RTMPPushInput](#RTMPPushInput1)**<br>RTMP push input type. 
&nbsp;&nbsp;srt_push | **[SRTPushInput](#SRTPushInput1)**<br>SRT push input type. 
&nbsp;&nbsp;rtmp_pull | **[RTMPPullInput](#RTMPPullInput1)**<br>RTMP pull input type. 
&nbsp;&nbsp;srt_pull | **[SRTPullInput](#SRTPullInput1)**<br>SRT pull input type. 
&nbsp;&nbsp;tcp_pull | **[TCPPullInput](#TCPPullInput1)**<br>TCP pull input type. 
&nbsp;&nbsp;rtsp_pull | **[RTSPPullInput](#RTSPPullInput1)**<br>RTSP pull input type. 
line_type | **oneof:** `manual_line` or `auto_line`<br>Line type.
&nbsp;&nbsp;manual_line | **[ManualLine](#ManualLine1)**<br>Manual control of stream. 
&nbsp;&nbsp;auto_line | **[AutoLine](#AutoLine1)**<br>Automatic control of stream. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when line was created. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of last line update. 
labels | **map<string,string>**<br>Custom labels as `` key:value `` pairs. Maximum 64 per resource. 


### RTMPPushInput {#RTMPPushInput1}

Field | Description
--- | ---
url | **string**<br>RTMP server url. 


### SRTPushInput {#SRTPushInput1}

Field | Description
--- | ---
url | **string**<br>SRT server url. 


### RTMPPullInput {#RTMPPullInput1}

Field | Description
--- | ---
url | **string**<br>RTMP url for receiving video signal. 


### SRTPullInput {#SRTPullInput1}

Field | Description
--- | ---
url | **string**<br>SRT url for receiving video signal. 


### TCPPullInput {#TCPPullInput1}

Field | Description
--- | ---
url | **string**<br>TCP url for receiving video signal. 


### RTSPPullInput {#RTSPPullInput1}

Field | Description
--- | ---
url | **string**<br>RTSP url for receiving video signal. 


### ManualLine {#ManualLine1}

Empty.

### AutoLine {#AutoLine1}

Field | Description
--- | ---
status | enum **AutoLineStatus**<br>Status of auto line. <ul><li>`AUTO_LINE_STATUS_UNSPECIFIED`: Auto line status unspecified.</li><li>`DEACTIVATED`: Auto line deactivated.</li><li>`ACTIVE`: Auto line active.</li></ul>


## Create {#Create}

Create stream line.

**rpc Create ([CreateStreamLineRequest](#CreateStreamLineRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateStreamLineMetadata](#CreateStreamLineMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[StreamLine](#StreamLine2)<br>

### CreateStreamLineRequest {#CreateStreamLineRequest}

Field | Description
--- | ---
channel_id | **string**<br>ID of the channel. 
title | **string**<br>Line title. 
thumbnail_id | **string**<br>ID of the thumbnail. 
labels | **map<string,string>**<br>Custom labels as `` key:value `` pairs. Maximum 64 per resource. 
input_params | **oneof:** `rtmp_push`, `srt_push`, `rtmp_pull`, `srt_pull`, `tcp_pull` or `rtsp_pull`<br>Video signal settings.
&nbsp;&nbsp;rtmp_push | **[RTMPPushParams](#RTMPPushParams)**<br>RTMP push input type. 
&nbsp;&nbsp;srt_push | **[SRTPushParams](#SRTPushParams)**<br>SRT push input type. 
&nbsp;&nbsp;rtmp_pull | **[RTMPPullParams](#RTMPPullParams)**<br>RTMP pull input type. 
&nbsp;&nbsp;srt_pull | **[SRTPullParams](#SRTPullParams)**<br>SRT pull input type. 
&nbsp;&nbsp;tcp_pull | **[TCPPullParams](#TCPPullParams)**<br>TCP pull input type. 
&nbsp;&nbsp;rtsp_pull | **[RTSPPullParams](#RTSPPullParams)**<br>RTSP pull input type. 
line_type_params | **oneof:** `manual_line` or `auto_line`<br>Line type.
&nbsp;&nbsp;manual_line | **[ManualLineParams](#ManualLineParams)**<br>Manual control of stream. 
&nbsp;&nbsp;auto_line | **[AutoLineParams](#AutoLineParams)**<br>Automatic control of stream. 


### RTMPPushParams {#RTMPPushParams}

Empty.

### SRTPushParams {#SRTPushParams}

Empty.

### RTMPPullParams {#RTMPPullParams}

Field | Description
--- | ---
url | **string**<br>URL of a RTMP streaming server. 


### SRTPullParams {#SRTPullParams}

Field | Description
--- | ---
url | **string**<br>URL of a SRT streaming server. 


### TCPPullParams {#TCPPullParams}

Field | Description
--- | ---
url | **string**<br>URL of a TCP streaming server. 


### RTSPPullParams {#RTSPPullParams}

Field | Description
--- | ---
url | **string**<br>URL of a RTSP streaming server. 


### ManualLineParams {#ManualLineParams}

Empty.

### AutoLineParams {#AutoLineParams}

Empty.

### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateStreamLineMetadata](#CreateStreamLineMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[StreamLine](#StreamLine2)>**<br>if operation finished successfully. 


### CreateStreamLineMetadata {#CreateStreamLineMetadata}

Field | Description
--- | ---
stream_line_id | **string**<br>ID of the line. 


### StreamLine {#StreamLine2}

Field | Description
--- | ---
id | **string**<br>ID of the line. 
channel_id | **string**<br>ID of the channel where the line was created. 
title | **string**<br>Line title. 
thumbnail_id | **string**<br>ID of the thumbnail. 
input_type | **oneof:** `rtmp_push`, `srt_push`, `rtmp_pull`, `srt_pull`, `tcp_pull` or `rtsp_pull`<br>Video signal settings.
&nbsp;&nbsp;rtmp_push | **[RTMPPushInput](#RTMPPushInput2)**<br>RTMP push input type. 
&nbsp;&nbsp;srt_push | **[SRTPushInput](#SRTPushInput2)**<br>SRT push input type. 
&nbsp;&nbsp;rtmp_pull | **[RTMPPullInput](#RTMPPullInput2)**<br>RTMP pull input type. 
&nbsp;&nbsp;srt_pull | **[SRTPullInput](#SRTPullInput2)**<br>SRT pull input type. 
&nbsp;&nbsp;tcp_pull | **[TCPPullInput](#TCPPullInput2)**<br>TCP pull input type. 
&nbsp;&nbsp;rtsp_pull | **[RTSPPullInput](#RTSPPullInput2)**<br>RTSP pull input type. 
line_type | **oneof:** `manual_line` or `auto_line`<br>Line type.
&nbsp;&nbsp;manual_line | **[ManualLine](#ManualLine2)**<br>Manual control of stream. 
&nbsp;&nbsp;auto_line | **[AutoLine](#AutoLine2)**<br>Automatic control of stream. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when line was created. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of last line update. 
labels | **map<string,string>**<br>Custom labels as `` key:value `` pairs. Maximum 64 per resource. 


### RTMPPushInput {#RTMPPushInput2}

Field | Description
--- | ---
url | **string**<br>RTMP server url. 


### SRTPushInput {#SRTPushInput2}

Field | Description
--- | ---
url | **string**<br>SRT server url. 


### RTMPPullInput {#RTMPPullInput2}

Field | Description
--- | ---
url | **string**<br>RTMP url for receiving video signal. 


### SRTPullInput {#SRTPullInput2}

Field | Description
--- | ---
url | **string**<br>SRT url for receiving video signal. 


### TCPPullInput {#TCPPullInput2}

Field | Description
--- | ---
url | **string**<br>TCP url for receiving video signal. 


### RTSPPullInput {#RTSPPullInput2}

Field | Description
--- | ---
url | **string**<br>RTSP url for receiving video signal. 


### ManualLine {#ManualLine2}

Empty.

### AutoLine {#AutoLine2}

Field | Description
--- | ---
status | enum **AutoLineStatus**<br>Status of auto line. <ul><li>`AUTO_LINE_STATUS_UNSPECIFIED`: Auto line status unspecified.</li><li>`DEACTIVATED`: Auto line deactivated.</li><li>`ACTIVE`: Auto line active.</li></ul>


## Update {#Update}

Update stream line.

**rpc Update ([UpdateStreamLineRequest](#UpdateStreamLineRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateStreamLineMetadata](#UpdateStreamLineMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[StreamLine](#StreamLine3)<br>

### UpdateStreamLineRequest {#UpdateStreamLineRequest}

Field | Description
--- | ---
stream_line_id | **string**<br>ID of the line. 
field_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the line are going to be updated. 
title | **string**<br>Line title. 
thumbnail_id | **string**<br>ID of the thumbnail. 
labels | **map<string,string>**<br>Custom labels as `` key:value `` pairs. Maximum 64 per resource. 
input_params | **oneof:** `rtmp_push`, `srt_push`, `rtmp_pull`, `srt_pull`, `tcp_pull` or `rtsp_pull`<br>Video signal settings.
&nbsp;&nbsp;rtmp_push | **[RTMPPushParams](#RTMPPushParams)**<br>RTMP push input type. 
&nbsp;&nbsp;srt_push | **[SRTPushParams](#SRTPushParams)**<br>SRT push input type. 
&nbsp;&nbsp;rtmp_pull | **[RTMPPullParams](#RTMPPullParams)**<br>RTMP pull input type. 
&nbsp;&nbsp;srt_pull | **[SRTPullParams](#SRTPullParams)**<br>SRT pull input type. 
&nbsp;&nbsp;tcp_pull | **[TCPPullParams](#TCPPullParams)**<br>TCP pull input type. 
&nbsp;&nbsp;rtsp_pull | **[RTSPPullParams](#RTSPPullParams)**<br>RTSP pull input type. 


### RTMPPushParams {#RTMPPushParams1}

Empty.

### SRTPushParams {#SRTPushParams1}

Empty.

### RTMPPullParams {#RTMPPullParams1}

Field | Description
--- | ---
url | **string**<br>URL of a RTMP streaming server. 


### SRTPullParams {#SRTPullParams1}

Field | Description
--- | ---
url | **string**<br>URL of a SRT streaming server. 


### TCPPullParams {#TCPPullParams1}

Field | Description
--- | ---
url | **string**<br>URL of a TCP streaming server. 


### RTSPPullParams {#RTSPPullParams1}

Field | Description
--- | ---
url | **string**<br>URL of a RTSP streaming server. 


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateStreamLineMetadata](#UpdateStreamLineMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[StreamLine](#StreamLine3)>**<br>if operation finished successfully. 


### UpdateStreamLineMetadata {#UpdateStreamLineMetadata}

Field | Description
--- | ---
stream_line_id | **string**<br>ID of the line. 


### StreamLine {#StreamLine3}

Field | Description
--- | ---
id | **string**<br>ID of the line. 
channel_id | **string**<br>ID of the channel where the line was created. 
title | **string**<br>Line title. 
thumbnail_id | **string**<br>ID of the thumbnail. 
input_type | **oneof:** `rtmp_push`, `srt_push`, `rtmp_pull`, `srt_pull`, `tcp_pull` or `rtsp_pull`<br>Video signal settings.
&nbsp;&nbsp;rtmp_push | **[RTMPPushInput](#RTMPPushInput3)**<br>RTMP push input type. 
&nbsp;&nbsp;srt_push | **[SRTPushInput](#SRTPushInput3)**<br>SRT push input type. 
&nbsp;&nbsp;rtmp_pull | **[RTMPPullInput](#RTMPPullInput3)**<br>RTMP pull input type. 
&nbsp;&nbsp;srt_pull | **[SRTPullInput](#SRTPullInput3)**<br>SRT pull input type. 
&nbsp;&nbsp;tcp_pull | **[TCPPullInput](#TCPPullInput3)**<br>TCP pull input type. 
&nbsp;&nbsp;rtsp_pull | **[RTSPPullInput](#RTSPPullInput3)**<br>RTSP pull input type. 
line_type | **oneof:** `manual_line` or `auto_line`<br>Line type.
&nbsp;&nbsp;manual_line | **[ManualLine](#ManualLine3)**<br>Manual control of stream. 
&nbsp;&nbsp;auto_line | **[AutoLine](#AutoLine3)**<br>Automatic control of stream. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when line was created. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of last line update. 
labels | **map<string,string>**<br>Custom labels as `` key:value `` pairs. Maximum 64 per resource. 


### RTMPPushInput {#RTMPPushInput3}

Field | Description
--- | ---
url | **string**<br>RTMP server url. 


### SRTPushInput {#SRTPushInput3}

Field | Description
--- | ---
url | **string**<br>SRT server url. 


### RTMPPullInput {#RTMPPullInput3}

Field | Description
--- | ---
url | **string**<br>RTMP url for receiving video signal. 


### SRTPullInput {#SRTPullInput3}

Field | Description
--- | ---
url | **string**<br>SRT url for receiving video signal. 


### TCPPullInput {#TCPPullInput3}

Field | Description
--- | ---
url | **string**<br>TCP url for receiving video signal. 


### RTSPPullInput {#RTSPPullInput3}

Field | Description
--- | ---
url | **string**<br>RTSP url for receiving video signal. 


### ManualLine {#ManualLine3}

Empty.

### AutoLine {#AutoLine3}

Field | Description
--- | ---
status | enum **AutoLineStatus**<br>Status of auto line. <ul><li>`AUTO_LINE_STATUS_UNSPECIFIED`: Auto line status unspecified.</li><li>`DEACTIVATED`: Auto line deactivated.</li><li>`ACTIVE`: Auto line active.</li></ul>


## Delete {#Delete}

Delete stream line.

**rpc Delete ([DeleteStreamLineRequest](#DeleteStreamLineRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteStreamLineMetadata](#DeleteStreamLineMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteStreamLineRequest {#DeleteStreamLineRequest}

Field | Description
--- | ---
stream_line_id | **string**<br>ID of the line. 


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteStreamLineMetadata](#DeleteStreamLineMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteStreamLineMetadata {#DeleteStreamLineMetadata}

Field | Description
--- | ---
stream_line_id | **string**<br>ID of the line. 


## PerformAction {#PerformAction}

Perform an action on the line.

**rpc PerformAction ([PerformLineActionRequest](#PerformLineActionRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[PerformLineActionMetadata](#PerformLineActionMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[StreamLine](#StreamLine4)<br>

### PerformLineActionRequest {#PerformLineActionRequest}

Field | Description
--- | ---
stream_line_id | **string**<br>ID of the line. 
action | **oneof:** `activate` or `deactivate`<br>
&nbsp;&nbsp;activate | **[ActivateAction](#ActivateAction)**<br> 
&nbsp;&nbsp;deactivate | **[DeactivateAction](#DeactivateAction)**<br> 


### ActivateAction {#ActivateAction}

Empty.

### DeactivateAction {#DeactivateAction}

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
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[PerformLineActionMetadata](#PerformLineActionMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[StreamLine](#StreamLine4)>**<br>if operation finished successfully. 


### PerformLineActionMetadata {#PerformLineActionMetadata}

Field | Description
--- | ---
stream_line_id | **string**<br>ID of the line. 


### StreamLine {#StreamLine4}

Field | Description
--- | ---
id | **string**<br>ID of the line. 
channel_id | **string**<br>ID of the channel where the line was created. 
title | **string**<br>Line title. 
thumbnail_id | **string**<br>ID of the thumbnail. 
input_type | **oneof:** `rtmp_push`, `srt_push`, `rtmp_pull`, `srt_pull`, `tcp_pull` or `rtsp_pull`<br>Video signal settings.
&nbsp;&nbsp;rtmp_push | **[RTMPPushInput](#RTMPPushInput4)**<br>RTMP push input type. 
&nbsp;&nbsp;srt_push | **[SRTPushInput](#SRTPushInput4)**<br>SRT push input type. 
&nbsp;&nbsp;rtmp_pull | **[RTMPPullInput](#RTMPPullInput4)**<br>RTMP pull input type. 
&nbsp;&nbsp;srt_pull | **[SRTPullInput](#SRTPullInput4)**<br>SRT pull input type. 
&nbsp;&nbsp;tcp_pull | **[TCPPullInput](#TCPPullInput4)**<br>TCP pull input type. 
&nbsp;&nbsp;rtsp_pull | **[RTSPPullInput](#RTSPPullInput4)**<br>RTSP pull input type. 
line_type | **oneof:** `manual_line` or `auto_line`<br>Line type.
&nbsp;&nbsp;manual_line | **[ManualLine](#ManualLine4)**<br>Manual control of stream. 
&nbsp;&nbsp;auto_line | **[AutoLine](#AutoLine4)**<br>Automatic control of stream. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when line was created. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of last line update. 
labels | **map<string,string>**<br>Custom labels as `` key:value `` pairs. Maximum 64 per resource. 


### RTMPPushInput {#RTMPPushInput4}

Field | Description
--- | ---
url | **string**<br>RTMP server url. 


### SRTPushInput {#SRTPushInput4}

Field | Description
--- | ---
url | **string**<br>SRT server url. 


### RTMPPullInput {#RTMPPullInput4}

Field | Description
--- | ---
url | **string**<br>RTMP url for receiving video signal. 


### SRTPullInput {#SRTPullInput4}

Field | Description
--- | ---
url | **string**<br>SRT url for receiving video signal. 


### TCPPullInput {#TCPPullInput4}

Field | Description
--- | ---
url | **string**<br>TCP url for receiving video signal. 


### RTSPPullInput {#RTSPPullInput4}

Field | Description
--- | ---
url | **string**<br>RTSP url for receiving video signal. 


### ManualLine {#ManualLine4}

Empty.

### AutoLine {#AutoLine4}

Field | Description
--- | ---
status | enum **AutoLineStatus**<br>Status of auto line. <ul><li>`AUTO_LINE_STATUS_UNSPECIFIED`: Auto line status unspecified.</li><li>`DEACTIVATED`: Auto line deactivated.</li><li>`ACTIVE`: Auto line active.</li></ul>


## GetStreamKey {#GetStreamKey}

Returns unique stream key.

**rpc GetStreamKey ([GetStreamKeyRequest](#GetStreamKeyRequest)) returns ([PushStreamKey](#PushStreamKey))**

### GetStreamKeyRequest {#GetStreamKeyRequest}

Field | Description
--- | ---
stream_line_id | **string**<br>ID of the line. 


### PushStreamKey {#PushStreamKey}

Field | Description
--- | ---
key | **string**<br>Unique stream key. 


## UpdateStreamKey {#UpdateStreamKey}

Change stream key.

**rpc UpdateStreamKey ([UpdateStreamKeyRequest](#UpdateStreamKeyRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateStreamKeyMetadata](#UpdateStreamKeyMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[PushStreamKey](#PushStreamKey1)<br>

### UpdateStreamKeyRequest {#UpdateStreamKeyRequest}

Field | Description
--- | ---
stream_line_id | **string**<br>ID of the line. 


### Operation {#Operation4}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateStreamKeyMetadata](#UpdateStreamKeyMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[PushStreamKey](#PushStreamKey1)>**<br>if operation finished successfully. 


### UpdateStreamKeyMetadata {#UpdateStreamKeyMetadata}

Field | Description
--- | ---
stream_line_id | **string**<br>ID of the line. 


### PushStreamKey {#PushStreamKey1}

Field | Description
--- | ---
key | **string**<br>Unique stream key. 


