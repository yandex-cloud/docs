---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Video/getManifests.md
---

# Video API, gRPC: VideoService.GetManifests {#GetManifests}

Returns manifest urls.

## gRPC request

**rpc GetManifests ([GetVideoManifestsRequest](#yandex.cloud.video.v1.GetVideoManifestsRequest)) returns ([GetVideoManifestsResponse](#yandex.cloud.video.v1.GetVideoManifestsResponse))**

## GetVideoManifestsRequest {#yandex.cloud.video.v1.GetVideoManifestsRequest}

```json
{
  "videoId": "string"
}
```

#|
||Field | Description ||
|| videoId | **string**

ID of the video. ||
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
|| manifests[] | **[Manifest](#yandex.cloud.video.v1.Manifest)** ||
|#

## Manifest {#yandex.cloud.video.v1.Manifest}

#|
||Field | Description ||
|| url | **string** ||
|| type | enum **ManifestType**

- `MANIFEST_TYPE_UNSPECIFIED`
- `DASH`
- `HLS` ||
|#