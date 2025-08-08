---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Episode/get.md
---

# Video API, gRPC: EpisodeService.Get

Retrieves detailed information about a specific episode by its ID.
Returns all episode metadata, status, and related information.

## gRPC request

**rpc Get ([GetEpisodeRequest](#yandex.cloud.video.v1.GetEpisodeRequest)) returns ([Episode](#yandex.cloud.video.v1.Episode))**

## GetEpisodeRequest {#yandex.cloud.video.v1.GetEpisodeRequest}

```json
{
  "episode_id": "string"
}
```

#|
||Field | Description ||
|| episode_id | **string**

Required field. ID of the episode to retrieve. ||
|#

## Episode {#yandex.cloud.video.v1.Episode}

```json
{
  "id": "string",
  "stream_id": "string",
  "line_id": "string",
  "title": "string",
  "description": "string",
  "thumbnail_id": "string",
  "start_time": "google.protobuf.Timestamp",
  "finish_time": "google.protobuf.Timestamp",
  "dvr_seconds": "int64",
  "visibility_status": "VisibilityStatus",
  "style_preset_id": "string",
  // Includes only one of the fields `public_access`, `sign_url_access`
  "public_access": "EpisodePublicAccessRights",
  "sign_url_access": "EpisodeSignURLAccessRights",
  // end of the list of possible fields
  "created_at": "google.protobuf.Timestamp",
  "updated_at": "google.protobuf.Timestamp"
}
```

Entity representing a stream fragment that can be accessed independently.
Episodes can be linked to either a stream or a line
and provide a way to reference specific portions of the corresponding content.

#|
||Field | Description ||
|| id | **string**

Unique identifier of the episode. ||
|| stream_id | **string**

Identifier of the stream this episode is linked to.
Optional, empty if the episode is linked to a line. ||
|| line_id | **string**

Identifier of the line this episode is linked to.
Optional, empty if the episode is linked to a stream. ||
|| title | **string**

Title of the episode displayed in interfaces and players. ||
|| description | **string**

Detailed description of the episode content and context. ||
|| thumbnail_id | **string**

Identifier of the thumbnail image used to represent the episode visually. ||
|| start_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp marking the beginning of the episode content. ||
|| finish_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp marking the end of the episode content. ||
|| dvr_seconds | **int64**

Controls the Digital Video Recording (DVR) functionality for the episode.
Determines how many seconds of the stream are available for time-shifted viewing.

Possible values:
* `0`: Infinite DVR size, the full length of the stream is available for viewing.
* `>0`: Size of DVR window in seconds, the minimum value is 30s. ||
|| visibility_status | enum **VisibilityStatus**

Current visibility status controlling whether the episode is publicly available.

- `VISIBILITY_STATUS_UNSPECIFIED`: The visibility status is not specified.
- `PUBLISHED`: The episode is publicly available, subject to its access permission settings.
- `UNPUBLISHED`: The episode is available only to administrators. ||
|| style_preset_id | **string**

Identifier of the style preset used in the player during episode playback. ||
|| public_access | **[EpisodePublicAccessRights](#yandex.cloud.video.v1.EpisodePublicAccessRights)**

Allows unrestricted public access to the episode via direct link.
No additional authorization or access control is applied.

Includes only one of the fields `public_access`, `sign_url_access`.

Specifies the episode access permission settings. ||
|| sign_url_access | **[EpisodeSignURLAccessRights](#yandex.cloud.video.v1.EpisodeSignURLAccessRights)**

Restricts episode access using URL signatures for secure time-limited access.

Includes only one of the fields `public_access`, `sign_url_access`.

Specifies the episode access permission settings. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp when the episode was initially created in the system. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp of the last modification to the episode or its metadata. ||
|#

## EpisodePublicAccessRights {#yandex.cloud.video.v1.EpisodePublicAccessRights}

Represents public access rights for an episode.
When this access type is set, the episode is publicly accessible via direct link.

#|
||Field | Description ||
|| Empty | > ||
|#

## EpisodeSignURLAccessRights {#yandex.cloud.video.v1.EpisodeSignURLAccessRights}

Represents access rights controlled by URL signatures.
When this access type is set, the episode is accessible only via properly signed temporary link.

#|
||Field | Description ||
|| Empty | > ||
|#