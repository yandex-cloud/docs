---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Episode/index.md
---

# Video API, gRPC: EpisodeService

Episode management service.
Provides methods for creating, retrieving, updating, and deleting episodes,
which represent specific time segments of streams
that can be individually accessed, managed, and published.

## Methods

#|
||Method | Description ||
|| [Get](get.md) | Retrieves detailed information about a specific episode by its ID. ||
|| [List](list.md) | Lists all episodes associated with a specific stream or stream line with pagination support. ||
|| [BatchGet](batchGet.md) | Retrieves multiple episodes by their IDs in a specific channel in a single request. ||
|| [Create](create.md) | Creates a new episode associated with a stream or stream line. ||
|| [Update](update.md) | Updates an existing episode's metadata and settings. ||
|| [Delete](delete.md) | Deletes a specific episode by its ID. ||
|| [BatchDelete](batchDelete.md) | Deletes multiple episodes associated with a specific stream or stream line in a single request. ||
|| [PerformAction](performAction.md) | Performs a specific action on an episode, such as publishing or unpublishing. ||
|| [GetPlayerURL](getPlayerURL.md) | Generates a player URL for watching the episode. ||
|| [GetManifests](getManifests.md) | Retrieves the manifest URLs for the episode's media content. ||
|#