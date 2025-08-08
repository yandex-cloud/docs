---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Video/getManifests.md
---

# Video API, gRPC: VideoService.GetManifests

Retrieves the manifest URLs for a specific video.
Manifests are used by video players to access the video content with adaptive bitrate streaming.
Supports different manifest types (HLS, DASH) and configuration parameters.

## gRPC request

**rpc GetManifests ([GetVideoManifestsRequest](#yandex.cloud.video.v1.GetVideoManifestsRequest)) returns ([GetVideoManifestsResponse](#yandex.cloud.video.v1.GetVideoManifestsResponse))**

## GetVideoManifestsRequest {#yandex.cloud.video.v1.GetVideoManifestsRequest}

```json
{
  "video_id": "string"
}
```

#|
||Field | Description ||
|| video_id | **string**

Required field. ID of the video for which to retrieve manifest URLs. ||
|#

## GetVideoManifestsResponse {#yandex.cloud.video.v1.GetVideoManifestsResponse}

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

List of manifests available for the video.
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