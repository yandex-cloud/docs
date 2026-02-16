---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Playlist/index.md
---

# Video API, gRPC: PlaylistService

Playlist management service.
Provides methods for creating, retrieving, updating, and deleting playlists,
which are collections of videos or episodes that can be played sequentially.

## Methods

#|
||Method | Description ||
|| [Get](get.md) | Retrieves detailed information about a specific playlist by its ID. ||
|| [List](list.md) | Lists all playlists in a specific channel with pagination support. ||
|| [Create](create.md) | Creates a new playlist in the specified channel with the provided items. ||
|| [Update](update.md) | Updates an existing playlist's metadata and items. ||
|| [Delete](delete.md) | Deletes a specific playlist by its ID. ||
|| [BatchDelete](batchDelete.md) | Deletes multiple playlists in a specific channel in a single request. ||
|| [GetPlayerURL](getPlayerURL.md) | Generates a player URL for watching the playlist. ||
|#