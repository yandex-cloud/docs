---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Episode/getManifests.md
---

# Video API, gRPC: EpisodeService.GetManifests

Retrieves the manifest URLs for the episode's media content.
Manifests provide players with necessary information
for streaming the content with different quality levels and formats.

## gRPC request

**rpc GetManifests ([GetEpisodeManifestsRequest](#yandex.cloud.video.v1.GetEpisodeManifestsRequest)) returns ([GetEpisodeManifestsResponse](#yandex.cloud.video.v1.GetEpisodeManifestsResponse))**

## GetEpisodeManifestsRequest {#yandex.cloud.video.v1.GetEpisodeManifestsRequest}

```json
{
  "episode_id": "string"
}
```

#|
||Field | Description ||
|| episode_id | **string**

Required field. ID of the episode for which to retrieve manifest URLs. ||
|#

## GetEpisodeManifestsResponse {#yandex.cloud.video.v1.GetEpisodeManifestsResponse}

```json
{
  "manifests": [
    {
      "url": "string",
      "type": "ManifestType"
    }
  ]
}
```

#|
||Field | Description ||
|| manifests[] | **[Manifest](#yandex.cloud.video.v1.Manifest)**

List of manifests available for the episode.
Different manifests may represent different streaming formats (e.g., HLS, DASH) ||
|#

## Manifest {#yandex.cloud.video.v1.Manifest}

Represents a streaming manifest file that defines how video content is delivered.
Manifests contain information about available video qualities, audio tracks,
and other metadata needed by video players to stream content efficiently.

#|
||Field | Description ||
|| url | **string**

URL where the manifest file can be accessed. ||
|| type | enum **ManifestType**

Format of the manifest file.

- `MANIFEST_TYPE_UNSPECIFIED`: The manifest type is not specified.
- `DASH`: Dynamic Adaptive Streaming over HTTP (DASH) format.
@see https://en.wikipedia.org/wiki/Dynamic_Adaptive_Streaming_over_HTTP
- `HLS`: HTTP Live Streaming (HLS) format.
@see https://en.wikipedia.org/wiki/HTTP_Live_Streaming ||
|#