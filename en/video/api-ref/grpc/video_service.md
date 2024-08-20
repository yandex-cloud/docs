---
editable: false
sourcePath: en/_api-ref-grpc/video/api-ref/grpc/video_service.md
---

# Video API, gRPC: VideoService

Video management service.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specific video. |
| [List](#List) | List videos for channel. |
| [Create](#Create) | Create video. |
| [Update](#Update) | Update video. |
| [Delete](#Delete) | Delete video. |
| [PerformAction](#PerformAction) | Perform an action on the episode. |
| [GetPlayerURL](#GetPlayerURL) | Returns url to the player. |

## Calls VideoService {#calls}

## Get {#Get}

Returns the specific video.

**rpc Get ([GetVideoRequest](#GetVideoRequest)) returns ([Video](#Video))**

### GetVideoRequest {#GetVideoRequest}

Field | Description
--- | ---
video_id | **string**<br>ID of the video. 


### Video {#Video}

Field | Description
--- | ---
id | **string**<br>ID of the video. 
channel_id | **string**<br>ID of the channel where the video was created. 
title | **string**<br>Video title. 
description | **string**<br>Video description. 
thumbnail_id | **string**<br>ID of the thumbnail. 
status | enum **VideoStatus**<br>Video status. <ul><li>`VIDEO_STATUS_UNSPECIFIED`: Video status unspecified.</li><li>`WAIT_UPLOADING`: Waiting for the whole number of bytes to be loaded.</li><li>`PROCESSING`: Video processing.</li><li>`READY`: Video is ready, processing is completed.</li><li>`ERROR`: An error occurred during video processing.</li></ul>
duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Video duration. Optional, may be empty until the transcoding result is ready. 
visibility_status | enum **VisibilityStatus**<br>Video visibility status. <ul><li>`VISIBILITY_STATUS_UNSPECIFIED`: Visibility status unspecified.</li><li>`PUBLISHED`: Video is published and available for viewing.</li><li>`UNPUBLISHED`: Video is unpublished, only admin can watch.</li></ul>
source | **oneof:** `tusd`<br>Source type.
&nbsp;&nbsp;tusd | **[VideoTUSDSource](#VideoTUSDSource)**<br>Upload video using the tus protocol. 
access_rights | **oneof:** `public_access` or `auth_system_access`<br>Video access rights.
&nbsp;&nbsp;public_access | **[VideoPublicAccessRights](#VideoPublicAccessRights)**<br>Video is available to everyone. 
&nbsp;&nbsp;auth_system_access | **[VideoAuthSystemAccessRights](#VideoAuthSystemAccessRights)**<br>Checking access rights using the authorization system. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when video was created. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of last video update. 
labels | **map<string,string>**<br>Custom labels as `` key:value `` pairs. Maximum 64 per resource. 


### VideoTUSDSource {#VideoTUSDSource}

Field | Description
--- | ---
url | **string**<br>URL for uploading video via the tus protocol. 


### VideoPublicAccessRights {#VideoPublicAccessRights}

Empty.

### VideoAuthSystemAccessRights {#VideoAuthSystemAccessRights}

Empty.

## List {#List}

List videos for channel.

**rpc List ([ListVideoRequest](#ListVideoRequest)) returns ([ListVideoResponse](#ListVideoResponse))**

### ListVideoRequest {#ListVideoRequest}

Field | Description
--- | ---
channel_id | **string**<br>ID of the channel. 
page_size | **int64**<br>The maximum number of the results per page to return. Default value: 100. 
page_token | **string**<br>Page token for getting the next page of the result. 
order_by | **string**<br>By which column the listing should be ordered and in which direction, format is "createdAt desc". "id asc" if omitted. Possible fields: ["id", "createdAt", "updatedAt"] Both snake_case and camelCase are supported for fields. 
filter | **string**<br>Filter expression that filters resources listed in the response. Expressions are composed of terms connected by logic operators. Value in quotes: `'` or `"` Example: "key1='value' AND key2='value'" Supported operators: ["AND"]. Supported fields: ["title", "status", "visibility_status"] Both snake_case and camelCase are supported for fields. 


### ListVideoResponse {#ListVideoResponse}

Field | Description
--- | ---
videos[] | **[Video](#Video1)**<br> 
next_page_token | **string**<br>Token for getting the next page. 


### Video {#Video1}

Field | Description
--- | ---
id | **string**<br>ID of the video. 
channel_id | **string**<br>ID of the channel where the video was created. 
title | **string**<br>Video title. 
description | **string**<br>Video description. 
thumbnail_id | **string**<br>ID of the thumbnail. 
status | enum **VideoStatus**<br>Video status. <ul><li>`VIDEO_STATUS_UNSPECIFIED`: Video status unspecified.</li><li>`WAIT_UPLOADING`: Waiting for the whole number of bytes to be loaded.</li><li>`PROCESSING`: Video processing.</li><li>`READY`: Video is ready, processing is completed.</li><li>`ERROR`: An error occurred during video processing.</li></ul>
duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Video duration. Optional, may be empty until the transcoding result is ready. 
visibility_status | enum **VisibilityStatus**<br>Video visibility status. <ul><li>`VISIBILITY_STATUS_UNSPECIFIED`: Visibility status unspecified.</li><li>`PUBLISHED`: Video is published and available for viewing.</li><li>`UNPUBLISHED`: Video is unpublished, only admin can watch.</li></ul>
source | **oneof:** `tusd`<br>Source type.
&nbsp;&nbsp;tusd | **[VideoTUSDSource](#VideoTUSDSource1)**<br>Upload video using the tus protocol. 
access_rights | **oneof:** `public_access` or `auth_system_access`<br>Video access rights.
&nbsp;&nbsp;public_access | **[VideoPublicAccessRights](#VideoPublicAccessRights1)**<br>Video is available to everyone. 
&nbsp;&nbsp;auth_system_access | **[VideoAuthSystemAccessRights](#VideoAuthSystemAccessRights1)**<br>Checking access rights using the authorization system. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when video was created. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of last video update. 
labels | **map<string,string>**<br>Custom labels as `` key:value `` pairs. Maximum 64 per resource. 


### VideoTUSDSource {#VideoTUSDSource1}

Field | Description
--- | ---
url | **string**<br>URL for uploading video via the tus protocol. 


### VideoPublicAccessRights {#VideoPublicAccessRights1}

Empty.

### VideoAuthSystemAccessRights {#VideoAuthSystemAccessRights1}

Empty.

## Create {#Create}

Create video.

**rpc Create ([CreateVideoRequest](#CreateVideoRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateVideoMetadata](#CreateVideoMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Video](#Video2)<br>

### CreateVideoRequest {#CreateVideoRequest}

Field | Description
--- | ---
channel_id | **string**<br>ID of the channel. 
title | **string**<br>Video title. 
description | **string**<br>Video description. 
thumbnail_id | **string**<br>ID of the thumbnail. 
labels | **map<string,string>**<br>Custom labels as `` key:value `` pairs. Maximum 64 per resource. 
source | **oneof:** `tusd`<br>Source type.
&nbsp;&nbsp;tusd | **[VideoTUSDParams](#VideoTUSDParams)**<br>Upload video using the tus protocol. 
access_rights | **oneof:** `public_access` or `auth_system_access`<br>Video access rights.
&nbsp;&nbsp;public_access | **[VideoPublicAccessParams](#VideoPublicAccessParams)**<br>Video is available to everyone. 
&nbsp;&nbsp;auth_system_access | **[VideoAuthSystemAccessParams](#VideoAuthSystemAccessParams)**<br>Checking access rights using the authorization system. 


### VideoTUSDParams {#VideoTUSDParams}

Field | Description
--- | ---
file_size | **int64**<br>File size. 
file_name | **string**<br>File name. 


### VideoPublicAccessParams {#VideoPublicAccessParams}

Empty.

### VideoAuthSystemAccessParams {#VideoAuthSystemAccessParams}

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
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateVideoMetadata](#CreateVideoMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Video](#Video2)>**<br>if operation finished successfully. 


### CreateVideoMetadata {#CreateVideoMetadata}

Field | Description
--- | ---
video_id | **string**<br>ID of the video. 


### Video {#Video2}

Field | Description
--- | ---
id | **string**<br>ID of the video. 
channel_id | **string**<br>ID of the channel where the video was created. 
title | **string**<br>Video title. 
description | **string**<br>Video description. 
thumbnail_id | **string**<br>ID of the thumbnail. 
status | enum **VideoStatus**<br>Video status. <ul><li>`VIDEO_STATUS_UNSPECIFIED`: Video status unspecified.</li><li>`WAIT_UPLOADING`: Waiting for the whole number of bytes to be loaded.</li><li>`PROCESSING`: Video processing.</li><li>`READY`: Video is ready, processing is completed.</li><li>`ERROR`: An error occurred during video processing.</li></ul>
duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Video duration. Optional, may be empty until the transcoding result is ready. 
visibility_status | enum **VisibilityStatus**<br>Video visibility status. <ul><li>`VISIBILITY_STATUS_UNSPECIFIED`: Visibility status unspecified.</li><li>`PUBLISHED`: Video is published and available for viewing.</li><li>`UNPUBLISHED`: Video is unpublished, only admin can watch.</li></ul>
source | **oneof:** `tusd`<br>Source type.
&nbsp;&nbsp;tusd | **[VideoTUSDSource](#VideoTUSDSource2)**<br>Upload video using the tus protocol. 
access_rights | **oneof:** `public_access` or `auth_system_access`<br>Video access rights.
&nbsp;&nbsp;public_access | **[VideoPublicAccessRights](#VideoPublicAccessRights2)**<br>Video is available to everyone. 
&nbsp;&nbsp;auth_system_access | **[VideoAuthSystemAccessRights](#VideoAuthSystemAccessRights2)**<br>Checking access rights using the authorization system. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when video was created. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of last video update. 
labels | **map<string,string>**<br>Custom labels as `` key:value `` pairs. Maximum 64 per resource. 


### VideoTUSDSource {#VideoTUSDSource2}

Field | Description
--- | ---
url | **string**<br>URL for uploading video via the tus protocol. 


### VideoPublicAccessRights {#VideoPublicAccessRights2}

Empty.

### VideoAuthSystemAccessRights {#VideoAuthSystemAccessRights2}

Empty.

## Update {#Update}

Update video.

**rpc Update ([UpdateVideoRequest](#UpdateVideoRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateVideoMetadata](#UpdateVideoMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Video](#Video3)<br>

### UpdateVideoRequest {#UpdateVideoRequest}

Field | Description
--- | ---
video_id | **string**<br>ID of the video. 
field_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the video are going to be updated. 
title | **string**<br>Video title. 
description | **string**<br>Video description. 
thumbnail_id | **string**<br>ID of the thumbnail. 
labels | **map<string,string>**<br>Custom labels as `` key:value `` pairs. Maximum 64 per resource. 
access_rights | **oneof:** `public_access` or `auth_system_access`<br>
&nbsp;&nbsp;public_access | **[VideoPublicAccessParams](#VideoPublicAccessParams)**<br> 
&nbsp;&nbsp;auth_system_access | **[VideoAuthSystemAccessParams](#VideoAuthSystemAccessParams)**<br> 


### VideoPublicAccessParams {#VideoPublicAccessParams1}

Empty.

### VideoAuthSystemAccessParams {#VideoAuthSystemAccessParams1}

Empty.

### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateVideoMetadata](#UpdateVideoMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Video](#Video3)>**<br>if operation finished successfully. 


### UpdateVideoMetadata {#UpdateVideoMetadata}

Field | Description
--- | ---
video_id | **string**<br>ID of the video. 


### Video {#Video3}

Field | Description
--- | ---
id | **string**<br>ID of the video. 
channel_id | **string**<br>ID of the channel where the video was created. 
title | **string**<br>Video title. 
description | **string**<br>Video description. 
thumbnail_id | **string**<br>ID of the thumbnail. 
status | enum **VideoStatus**<br>Video status. <ul><li>`VIDEO_STATUS_UNSPECIFIED`: Video status unspecified.</li><li>`WAIT_UPLOADING`: Waiting for the whole number of bytes to be loaded.</li><li>`PROCESSING`: Video processing.</li><li>`READY`: Video is ready, processing is completed.</li><li>`ERROR`: An error occurred during video processing.</li></ul>
duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Video duration. Optional, may be empty until the transcoding result is ready. 
visibility_status | enum **VisibilityStatus**<br>Video visibility status. <ul><li>`VISIBILITY_STATUS_UNSPECIFIED`: Visibility status unspecified.</li><li>`PUBLISHED`: Video is published and available for viewing.</li><li>`UNPUBLISHED`: Video is unpublished, only admin can watch.</li></ul>
source | **oneof:** `tusd`<br>Source type.
&nbsp;&nbsp;tusd | **[VideoTUSDSource](#VideoTUSDSource3)**<br>Upload video using the tus protocol. 
access_rights | **oneof:** `public_access` or `auth_system_access`<br>Video access rights.
&nbsp;&nbsp;public_access | **[VideoPublicAccessRights](#VideoPublicAccessRights3)**<br>Video is available to everyone. 
&nbsp;&nbsp;auth_system_access | **[VideoAuthSystemAccessRights](#VideoAuthSystemAccessRights3)**<br>Checking access rights using the authorization system. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when video was created. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of last video update. 
labels | **map<string,string>**<br>Custom labels as `` key:value `` pairs. Maximum 64 per resource. 


### VideoTUSDSource {#VideoTUSDSource3}

Field | Description
--- | ---
url | **string**<br>URL for uploading video via the tus protocol. 


### VideoPublicAccessRights {#VideoPublicAccessRights3}

Empty.

### VideoAuthSystemAccessRights {#VideoAuthSystemAccessRights3}

Empty.

## Delete {#Delete}

Delete video.

**rpc Delete ([DeleteVideoRequest](#DeleteVideoRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteVideoMetadata](#DeleteVideoMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteVideoRequest {#DeleteVideoRequest}

Field | Description
--- | ---
video_id | **string**<br>ID of the video. 


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteVideoMetadata](#DeleteVideoMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteVideoMetadata {#DeleteVideoMetadata}

Field | Description
--- | ---
video_id | **string**<br>ID of the video. 


## PerformAction {#PerformAction}

Perform an action on the episode.

**rpc PerformAction ([PerformVideoActionRequest](#PerformVideoActionRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[PerformVideoActionMetadata](#PerformVideoActionMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Video](#Video4)<br>

### PerformVideoActionRequest {#PerformVideoActionRequest}

Field | Description
--- | ---
video_id | **string**<br>ID of the video. 
action | **oneof:** `publish` or `unpublish`<br>
&nbsp;&nbsp;publish | **[PublishVideoAction](#PublishVideoAction)**<br> 
&nbsp;&nbsp;unpublish | **[UnpublishVideoAction](#UnpublishVideoAction)**<br> 


### PublishVideoAction {#PublishVideoAction}

Empty.

### UnpublishVideoAction {#UnpublishVideoAction}

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
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[PerformVideoActionMetadata](#PerformVideoActionMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Video](#Video4)>**<br>if operation finished successfully. 


### PerformVideoActionMetadata {#PerformVideoActionMetadata}

Field | Description
--- | ---
video_id | **string**<br>ID of the video. 


### Video {#Video4}

Field | Description
--- | ---
id | **string**<br>ID of the video. 
channel_id | **string**<br>ID of the channel where the video was created. 
title | **string**<br>Video title. 
description | **string**<br>Video description. 
thumbnail_id | **string**<br>ID of the thumbnail. 
status | enum **VideoStatus**<br>Video status. <ul><li>`VIDEO_STATUS_UNSPECIFIED`: Video status unspecified.</li><li>`WAIT_UPLOADING`: Waiting for the whole number of bytes to be loaded.</li><li>`PROCESSING`: Video processing.</li><li>`READY`: Video is ready, processing is completed.</li><li>`ERROR`: An error occurred during video processing.</li></ul>
duration | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**<br>Video duration. Optional, may be empty until the transcoding result is ready. 
visibility_status | enum **VisibilityStatus**<br>Video visibility status. <ul><li>`VISIBILITY_STATUS_UNSPECIFIED`: Visibility status unspecified.</li><li>`PUBLISHED`: Video is published and available for viewing.</li><li>`UNPUBLISHED`: Video is unpublished, only admin can watch.</li></ul>
source | **oneof:** `tusd`<br>Source type.
&nbsp;&nbsp;tusd | **[VideoTUSDSource](#VideoTUSDSource4)**<br>Upload video using the tus protocol. 
access_rights | **oneof:** `public_access` or `auth_system_access`<br>Video access rights.
&nbsp;&nbsp;public_access | **[VideoPublicAccessRights](#VideoPublicAccessRights4)**<br>Video is available to everyone. 
&nbsp;&nbsp;auth_system_access | **[VideoAuthSystemAccessRights](#VideoAuthSystemAccessRights4)**<br>Checking access rights using the authorization system. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when video was created. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of last video update. 
labels | **map<string,string>**<br>Custom labels as `` key:value `` pairs. Maximum 64 per resource. 


### VideoTUSDSource {#VideoTUSDSource4}

Field | Description
--- | ---
url | **string**<br>URL for uploading video via the tus protocol. 


### VideoPublicAccessRights {#VideoPublicAccessRights4}

Empty.

### VideoAuthSystemAccessRights {#VideoAuthSystemAccessRights4}

Empty.

## GetPlayerURL {#GetPlayerURL}

Returns url to the player.

**rpc GetPlayerURL ([GetVideoPlayerURLRequest](#GetVideoPlayerURLRequest)) returns ([GetVideoPlayerURLResponse](#GetVideoPlayerURLResponse))**

### GetVideoPlayerURLRequest {#GetVideoPlayerURLRequest}

Field | Description
--- | ---
video_id | **string**<br>ID of the video. 
params | **[VideoPlayerParams](#VideoPlayerParams)**<br> 


### VideoPlayerParams {#VideoPlayerParams}

Field | Description
--- | ---
mute | **bool**<br>If true, a player will be muted by default. 
autoplay | **bool**<br>If true, playback will start automatically. 
hidden | **bool**<br>If true, a player interface will be hidden by default. 


### GetVideoPlayerURLResponse {#GetVideoPlayerURLResponse}

Field | Description
--- | ---
player_url | **string**<br>Direct link to the video. 
html | **string**<br>HTML embed code in Iframe format. 


