---
editable: false
sourcePath: en/_api-ref-grpc/video/api-ref/grpc/episode_service.md
---

# Video API, gRPC: EpisodeService

Episode management service.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specific channel. |
| [List](#List) | List episodes for stream or line. |
| [Create](#Create) | Create episode. |
| [Update](#Update) | Update episode. |
| [Delete](#Delete) | Delete episode. |
| [PerformAction](#PerformAction) | Perform an action on the episode. |
| [GetPlayerURL](#GetPlayerURL) | Returns url to the player. |

## Calls EpisodeService {#calls}

## Get {#Get}

Returns the specific channel.

**rpc Get ([GetEpisodeRequest](#GetEpisodeRequest)) returns ([Episode](#Episode))**

### GetEpisodeRequest {#GetEpisodeRequest}

Field | Description
--- | ---
episode_id | **string**<br>ID of the episode. 


### Episode {#Episode}

Field | Description
--- | ---
id | **string**<br>ID of the episode. 
stream_id | **string**<br>ID of the stream. Optional, empty if the episode is linked to the line 
line_id | **string**<br>ID of the line. Optional, empty if the episode is linked to the stream 
title | **string**<br>Channel title. 
description | **string**<br>Channel description. 
thumbnail_id | **string**<br>ID of the thumbnail. 
start_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Episode start time. 
finish_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Episode finish time. 
dvr_seconds | **int64**<br>Enables episode DVR mode. DVR seconds determines how many last seconds of the stream are available. <br>possible values: <ul><li>`0`: infinite dvr size, the full length of the stream allowed to display </li><li>`>0`: size of dvr window in seconds, the minimum value is 30s</li></ul> 
visibility_status | enum **VisibilityStatus**<br> 
access_rights | **oneof:** `public_access` or `auth_system_access`<br>Episode access rights.
&nbsp;&nbsp;public_access | **[EpisodePublicAccessRights](#EpisodePublicAccessRights)**<br>Episode is available to everyone. 
&nbsp;&nbsp;auth_system_access | **[EpisodeAuthSystemAccessRights](#EpisodeAuthSystemAccessRights)**<br>Checking access rights using the authorization system. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when episode was created. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of last episode update. 


### EpisodePublicAccessRights {#EpisodePublicAccessRights}

Empty.

### EpisodeAuthSystemAccessRights {#EpisodeAuthSystemAccessRights}

Empty.

## List {#List}

List episodes for stream or line.

**rpc List ([ListEpisodesRequest](#ListEpisodesRequest)) returns ([ListEpisodesResponse](#ListEpisodesResponse))**

### ListEpisodesRequest {#ListEpisodesRequest}

Field | Description
--- | ---
parent_id | **oneof:** `stream_id` or `line_id`<br>
&nbsp;&nbsp;stream_id | **string**<br>ID of the stream. 
&nbsp;&nbsp;line_id | **string**<br>ID of the line. 
page_size | **int64**<br>The maximum number of the results per page to return. Default value: 100. 
page_token | **string**<br>Page token for getting the next page of the result. 
order_by | **string**<br>By which column the listing should be ordered and in which direction, format is "createdAt desc". "id asc" if omitted. Possible fields: ["id", "createdAt", "updatedAt"] Both snake_case and camelCase are supported for fields. 
filter | **string**<br>Filter expression that filters resources listed in the response. Expressions are composed of terms connected by logic operators. Value in quotes: `'` or `"` Example: "key1='value' AND key2='value'" Supported operators: ["AND"]. Supported fields: ["title"] Both snake_case and camelCase are supported for fields. 


### ListEpisodesResponse {#ListEpisodesResponse}

Field | Description
--- | ---
episodes[] | **[Episode](#Episode1)**<br>List of episodes for specific parent_id. 
next_page_token | **string**<br>Token for getting the next page. 


### Episode {#Episode1}

Field | Description
--- | ---
id | **string**<br>ID of the episode. 
stream_id | **string**<br>ID of the stream. Optional, empty if the episode is linked to the line 
line_id | **string**<br>ID of the line. Optional, empty if the episode is linked to the stream 
title | **string**<br>Channel title. 
description | **string**<br>Channel description. 
thumbnail_id | **string**<br>ID of the thumbnail. 
start_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Episode start time. 
finish_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Episode finish time. 
dvr_seconds | **int64**<br>Enables episode DVR mode. DVR seconds determines how many last seconds of the stream are available. <br>possible values: <ul><li>`0`: infinite dvr size, the full length of the stream allowed to display </li><li>`>0`: size of dvr window in seconds, the minimum value is 30s</li></ul> 
visibility_status | enum **VisibilityStatus**<br> 
access_rights | **oneof:** `public_access` or `auth_system_access`<br>Episode access rights.
&nbsp;&nbsp;public_access | **[EpisodePublicAccessRights](#EpisodePublicAccessRights1)**<br>Episode is available to everyone. 
&nbsp;&nbsp;auth_system_access | **[EpisodeAuthSystemAccessRights](#EpisodeAuthSystemAccessRights1)**<br>Checking access rights using the authorization system. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when episode was created. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of last episode update. 


### EpisodePublicAccessRights {#EpisodePublicAccessRights1}

Empty.

### EpisodeAuthSystemAccessRights {#EpisodeAuthSystemAccessRights1}

Empty.

## Create {#Create}

Create episode.

**rpc Create ([CreateEpisodeRequest](#CreateEpisodeRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateEpisodeMetadata](#CreateEpisodeMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Episode](#Episode2)<br>

### CreateEpisodeRequest {#CreateEpisodeRequest}

Field | Description
--- | ---
parent_id | **oneof:** `stream_id` or `line_id`<br>
&nbsp;&nbsp;stream_id | **string**<br>ID of the stream. 
&nbsp;&nbsp;line_id | **string**<br>ID of the line. 
title | **string**<br>Episode title. 
description | **string**<br>Episode description. 
thumbnail_id | **string**<br>ID of the thumbnail. 
start_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Episode start time. 
finish_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Episode finish time. 
dvr_seconds | **int64**<br>Enables episode DVR mode. DVR seconds determines how many last seconds of the stream are available. <br>possible values: <ul><li>`0`: infinite dvr size, the full length of the stream allowed to display </li><li>`>0`: size of dvr window in seconds, the minimum value is 30s</li></ul> 
access_rights | **oneof:** `public_access` or `auth_system_access`<br>Episode access rights.
&nbsp;&nbsp;public_access | **[EpisodePublicAccessParams](#EpisodePublicAccessParams)**<br>Episode is available to everyone. 
&nbsp;&nbsp;auth_system_access | **[EpisodeAuthSystemAccessParams](#EpisodeAuthSystemAccessParams)**<br>Checking access rights using the authorization system. 


### EpisodePublicAccessParams {#EpisodePublicAccessParams}

Empty.

### EpisodeAuthSystemAccessParams {#EpisodeAuthSystemAccessParams}

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
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateEpisodeMetadata](#CreateEpisodeMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Episode](#Episode2)>**<br>if operation finished successfully. 


### CreateEpisodeMetadata {#CreateEpisodeMetadata}

Field | Description
--- | ---
episode_id | **string**<br>ID of the episode. 


### Episode {#Episode2}

Field | Description
--- | ---
id | **string**<br>ID of the episode. 
stream_id | **string**<br>ID of the stream. Optional, empty if the episode is linked to the line 
line_id | **string**<br>ID of the line. Optional, empty if the episode is linked to the stream 
title | **string**<br>Channel title. 
description | **string**<br>Channel description. 
thumbnail_id | **string**<br>ID of the thumbnail. 
start_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Episode start time. 
finish_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Episode finish time. 
dvr_seconds | **int64**<br>Enables episode DVR mode. DVR seconds determines how many last seconds of the stream are available. <br>possible values: <ul><li>`0`: infinite dvr size, the full length of the stream allowed to display </li><li>`>0`: size of dvr window in seconds, the minimum value is 30s</li></ul> 
visibility_status | enum **VisibilityStatus**<br> 
access_rights | **oneof:** `public_access` or `auth_system_access`<br>Episode access rights.
&nbsp;&nbsp;public_access | **[EpisodePublicAccessRights](#EpisodePublicAccessRights2)**<br>Episode is available to everyone. 
&nbsp;&nbsp;auth_system_access | **[EpisodeAuthSystemAccessRights](#EpisodeAuthSystemAccessRights2)**<br>Checking access rights using the authorization system. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when episode was created. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of last episode update. 


### EpisodePublicAccessRights {#EpisodePublicAccessRights2}

Empty.

### EpisodeAuthSystemAccessRights {#EpisodeAuthSystemAccessRights2}

Empty.

## Update {#Update}

Update episode.

**rpc Update ([UpdateEpisodeRequest](#UpdateEpisodeRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateEpisodeMetadata](#UpdateEpisodeMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Episode](#Episode3)<br>

### UpdateEpisodeRequest {#UpdateEpisodeRequest}

Field | Description
--- | ---
episode_id | **string**<br>ID of the episode. 
field_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the episode are going to be updated. 
title | **string**<br>Episode title. 
description | **string**<br>Episode description. 
thumbnail_id | **string**<br>ID of the thumbnail. 
start_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
finish_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Episode finish time. 
dvr_seconds | **int64**<br>Enables episode DVR mode. DVR seconds determines how many last seconds of the stream are available. <br>possible values: <ul><li>`0`: infinite dvr size, the full length of the stream allowed to display </li><li>`>0`: size of dvr window in seconds, the minimum value is 30s</li></ul> 
access_rights | **oneof:** `public_access` or `auth_system_access`<br>Episode access rights.
&nbsp;&nbsp;public_access | **[EpisodePublicAccessParams](#EpisodePublicAccessParams)**<br>Episode is available to everyone. 
&nbsp;&nbsp;auth_system_access | **[EpisodeAuthSystemAccessParams](#EpisodeAuthSystemAccessParams)**<br>Checking access rights using the authorization system. 


### EpisodePublicAccessParams {#EpisodePublicAccessParams1}

Empty.

### EpisodeAuthSystemAccessParams {#EpisodeAuthSystemAccessParams1}

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
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateEpisodeMetadata](#UpdateEpisodeMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Episode](#Episode3)>**<br>if operation finished successfully. 


### UpdateEpisodeMetadata {#UpdateEpisodeMetadata}

Field | Description
--- | ---
episode_id | **string**<br>ID of the episode. 


### Episode {#Episode3}

Field | Description
--- | ---
id | **string**<br>ID of the episode. 
stream_id | **string**<br>ID of the stream. Optional, empty if the episode is linked to the line 
line_id | **string**<br>ID of the line. Optional, empty if the episode is linked to the stream 
title | **string**<br>Channel title. 
description | **string**<br>Channel description. 
thumbnail_id | **string**<br>ID of the thumbnail. 
start_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Episode start time. 
finish_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Episode finish time. 
dvr_seconds | **int64**<br>Enables episode DVR mode. DVR seconds determines how many last seconds of the stream are available. <br>possible values: <ul><li>`0`: infinite dvr size, the full length of the stream allowed to display </li><li>`>0`: size of dvr window in seconds, the minimum value is 30s</li></ul> 
visibility_status | enum **VisibilityStatus**<br> 
access_rights | **oneof:** `public_access` or `auth_system_access`<br>Episode access rights.
&nbsp;&nbsp;public_access | **[EpisodePublicAccessRights](#EpisodePublicAccessRights3)**<br>Episode is available to everyone. 
&nbsp;&nbsp;auth_system_access | **[EpisodeAuthSystemAccessRights](#EpisodeAuthSystemAccessRights3)**<br>Checking access rights using the authorization system. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when episode was created. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of last episode update. 


### EpisodePublicAccessRights {#EpisodePublicAccessRights3}

Empty.

### EpisodeAuthSystemAccessRights {#EpisodeAuthSystemAccessRights3}

Empty.

## Delete {#Delete}

Delete episode.

**rpc Delete ([DeleteEpisodeRequest](#DeleteEpisodeRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteEpisodeMetadata](#DeleteEpisodeMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteEpisodeRequest {#DeleteEpisodeRequest}

Field | Description
--- | ---
episode_id | **string**<br>ID of the episode. 


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteEpisodeMetadata](#DeleteEpisodeMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteEpisodeMetadata {#DeleteEpisodeMetadata}

Field | Description
--- | ---
episode_id | **string**<br>ID of the episode. 


## PerformAction {#PerformAction}

Perform an action on the episode.

**rpc PerformAction ([PerformEpisodeActionRequest](#PerformEpisodeActionRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[PerformEpisodeActionMetadata](#PerformEpisodeActionMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Episode](#Episode4)<br>

### PerformEpisodeActionRequest {#PerformEpisodeActionRequest}

Field | Description
--- | ---
episode_id | **string**<br>ID of the episode. 
action | **oneof:** `publish` or `unpublish`<br>
&nbsp;&nbsp;publish | **[PublishEpisodeAction](#PublishEpisodeAction)**<br> 
&nbsp;&nbsp;unpublish | **[UnpublishEpisodeAction](#UnpublishEpisodeAction)**<br> 


### PublishEpisodeAction {#PublishEpisodeAction}

Empty.

### UnpublishEpisodeAction {#UnpublishEpisodeAction}

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
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[PerformEpisodeActionMetadata](#PerformEpisodeActionMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Episode](#Episode4)>**<br>if operation finished successfully. 


### PerformEpisodeActionMetadata {#PerformEpisodeActionMetadata}

Field | Description
--- | ---
episode_id | **string**<br>ID of the episode. 


### Episode {#Episode4}

Field | Description
--- | ---
id | **string**<br>ID of the episode. 
stream_id | **string**<br>ID of the stream. Optional, empty if the episode is linked to the line 
line_id | **string**<br>ID of the line. Optional, empty if the episode is linked to the stream 
title | **string**<br>Channel title. 
description | **string**<br>Channel description. 
thumbnail_id | **string**<br>ID of the thumbnail. 
start_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Episode start time. 
finish_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Episode finish time. 
dvr_seconds | **int64**<br>Enables episode DVR mode. DVR seconds determines how many last seconds of the stream are available. <br>possible values: <ul><li>`0`: infinite dvr size, the full length of the stream allowed to display </li><li>`>0`: size of dvr window in seconds, the minimum value is 30s</li></ul> 
visibility_status | enum **VisibilityStatus**<br> 
access_rights | **oneof:** `public_access` or `auth_system_access`<br>Episode access rights.
&nbsp;&nbsp;public_access | **[EpisodePublicAccessRights](#EpisodePublicAccessRights4)**<br>Episode is available to everyone. 
&nbsp;&nbsp;auth_system_access | **[EpisodeAuthSystemAccessRights](#EpisodeAuthSystemAccessRights4)**<br>Checking access rights using the authorization system. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time when episode was created. 
updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Time of last episode update. 


### EpisodePublicAccessRights {#EpisodePublicAccessRights4}

Empty.

### EpisodeAuthSystemAccessRights {#EpisodeAuthSystemAccessRights4}

Empty.

## GetPlayerURL {#GetPlayerURL}

Returns url to the player.

**rpc GetPlayerURL ([GetEpisodePlayerURLRequest](#GetEpisodePlayerURLRequest)) returns ([GetEpisodePlayerURLResponse](#GetEpisodePlayerURLResponse))**

### GetEpisodePlayerURLRequest {#GetEpisodePlayerURLRequest}

Field | Description
--- | ---
episode_id | **string**<br>ID of the episode. 
params | **[EpisodePlayerParams](#EpisodePlayerParams)**<br> 


### EpisodePlayerParams {#EpisodePlayerParams}

Field | Description
--- | ---
mute | **bool**<br>If true, a player will be muted by default. 
autoplay | **bool**<br>If true, playback will start automatically. 
hidden | **bool**<br>If true, a player interface will be hidden by default. 


### GetEpisodePlayerURLResponse {#GetEpisodePlayerURLResponse}

Field | Description
--- | ---
player_url | **string**<br>Direct link to the video. 
html | **string**<br>HTML embed code in Iframe format. 


