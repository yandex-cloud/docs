---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/StreamLine/index.md
---

# Video API, gRPC: StreamLineService

Stream line management service.
Provides methods for creating, retrieving, updating, and deleting stream lines,
which define the technical configuration for receiving and processing video signals.

## Methods

#|
||Method | Description ||
|| [Get](get.md) | Retrieves detailed information about a specific stream line by its ID. ||
|| [List](list.md) | Lists all stream lines in a specific channel with pagination support. ||
|| [BatchGet](batchGet.md) | Retrieves multiple stream lines by their IDs in a specific channel in a single request. ||
|| [Create](create.md) | Creates a new stream line in the specified channel with the provided configuration. ||
|| [Update](update.md) | Updates an existing stream line's metadata and configuration. ||
|| [Delete](delete.md) | Deletes a specific stream line by its ID. ||
|| [BatchDelete](batchDelete.md) | Deletes multiple stream lines in a specific channel in a single request. ||
|| [PerformAction](performAction.md) | Performs a specific action on a stream line, such as activation or deactivation. ||
|| [GetStreamKey](getStreamKey.md) | Retrieves the unique stream key for a push-type stream line. ||
|| [UpdateStreamKey](updateStreamKey.md) | Regenerates and updates the stream key for a push-type stream line. ||
|#