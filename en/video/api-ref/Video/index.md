---
editable: false
sourcePath: en/_api-ref/video/v1/api-ref/Video/index.md
---

# Video API, REST: Video

Video management service.
Provides methods for creating, retrieving, updating, and deleting videos,
as well as managing video-related operations such as transcoding, publishing,
and generating playback URLs.

## Methods

#|
||Method | Description ||
|| [Get](get.md) | Retrieves detailed information about a specific video by its ID. ||
|| [List](list.md) | Lists all videos in a specific channel with pagination support. ||
|| [BatchGet](batchGet.md) | Retrieves multiple videos by their IDs in a specific channel in a single request. ||
|| [Create](create.md) | Creates a new video in the specified channel. ||
|| [Update](update.md) | Updates an existing video's metadata and settings. ||
|| [Transcode](transcode.md) | Initiates or updates video transcoding with specified parameters. ||
|| [Delete](delete.md) | Deletes a specific video by its ID. ||
|| [BatchDelete](batchDelete.md) | Deletes multiple videos in a specific channel in a single request. ||
|| [PerformAction](performAction.md) | Performs a specific action on a video, such as publishing or unpublishing. ||
|| [GetPlayerURL](getPlayerURL.md) | Generates a standard player URL for watching the video. ||
|| [BatchGetPlayerURLs](batchGetPlayerURLs.md) | Generates multiple player URLs for a list of videos in a specific channel in a single request. ||
|| [GetManifests](getManifests.md) | Retrieves the manifest URLs for a specific video. ||
|#