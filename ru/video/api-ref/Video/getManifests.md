---
editable: false
sourcePath: en/_api-ref/video/v1/api-ref/Video/getManifests.md
---

# Video API, REST: Video.GetManifests

Get manifest urls.

## HTTP request

```
GET https://video.{{ api-host }}/video/v1/videos/{videoId}:getManifests
```

## Path parameters

#|
||Field | Description ||
|| videoId | **string**

Required field. ID of the video. ||
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