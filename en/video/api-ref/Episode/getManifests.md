---
editable: false
apiPlayground:
  - url: https://video.{{ api-host }}/video/v1/episodes/{episodeId}:getManifests
    method: get
    path:
      type: object
      properties:
        episodeId:
          description: |-
            **string**
            Required field. ID of the episode for which to retrieve manifest URLs.
          type: string
      required:
        - episodeId
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/video/v1/api-ref/Episode/getManifests.md
---

# Video API, REST: Episode.GetManifests

Retrieves the manifest URLs for the episode's media content.
Manifests provide players with necessary information
for streaming the content with different quality levels and formats.

## HTTP request

```
GET https://video.{{ api-host }}/video/v1/episodes/{episodeId}:getManifests
```

## Path parameters

#|
||Field | Description ||
|| episodeId | **string**

Required field. ID of the episode for which to retrieve manifest URLs. ||
|#

## Response {#yandex.cloud.video.v1.GetEpisodeManifestsResponse}

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
|| type | **enum** (ManifestType)

Format of the manifest file.

- `MANIFEST_TYPE_UNSPECIFIED`: The manifest type is not specified.
- `DASH`: Dynamic Adaptive Streaming over HTTP (DASH) format.
@see https://en.wikipedia.org/wiki/Dynamic_Adaptive_Streaming_over_HTTP
- `HLS`: HTTP Live Streaming (HLS) format.
@see https://en.wikipedia.org/wiki/HTTP_Live_Streaming ||
|#