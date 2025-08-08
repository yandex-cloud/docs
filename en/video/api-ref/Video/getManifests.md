---
editable: false
apiPlayground:
  - url: https://video.{{ api-host }}/video/v1/videos/{videoId}:getManifests
    method: get
    path:
      type: object
      properties:
        videoId:
          description: |-
            **string**
            Required field. ID of the video for which to retrieve manifest URLs.
          type: string
      required:
        - videoId
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/video/v1/api-ref/Video/getManifests.md
---

# Video API, REST: Video.GetManifests

Retrieves the manifest URLs for a specific video.
Manifests are used by video players to access the video content with adaptive bitrate streaming.
Supports different manifest types (HLS, DASH) and configuration parameters.

## HTTP request

```
GET https://video.{{ api-host }}/video/v1/videos/{videoId}:getManifests
```

## Path parameters

#|
||Field | Description ||
|| videoId | **string**

Required field. ID of the video for which to retrieve manifest URLs. ||
|#

## Response {#yandex.cloud.video.v1.GetVideoManifestsResponse}

**HTTP Code: 200 - OK**

```json
{
  "manifests": [
    {
      "url": "string",
      "type": "string"
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
|| type | **enum** (ManifestType)

Format of the manifest file.

- `MANIFEST_TYPE_UNSPECIFIED`: The manifest type is not specified.
- `DASH`: Dynamic Adaptive Streaming over HTTP (DASH) format.
@see https://en.wikipedia.org/wiki/Dynamic_Adaptive_Streaming_over_HTTP
- `HLS`: HTTP Live Streaming (HLS) format.
@see https://en.wikipedia.org/wiki/HTTP_Live_Streaming ||
|#