---
editable: false
sourcePath: en/_api-ref/video/v1/api-ref/Episode/getManifests.md
---

# Video API, REST: Episode.GetManifests {#GetManifests}

Returns manifest urls.

## HTTP request

```
GET https://video.{{ api-host }}/video/v1/episodes/{episodeId}:getManifests
```

## Path parameters

#|
||Field | Description ||
|| episodeId | **string**

Required field. ID of the episode. ||
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
|| manifests[] | **[Manifest](#yandex.cloud.video.v1.Manifest)** ||
|#

## Manifest {#yandex.cloud.video.v1.Manifest}

#|
||Field | Description ||
|| url | **string** ||
|| type | **enum** (ManifestType)

- `MANIFEST_TYPE_UNSPECIFIED`
- `DASH`
- `HLS` ||
|#