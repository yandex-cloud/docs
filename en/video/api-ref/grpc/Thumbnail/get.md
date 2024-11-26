---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Thumbnail/get.md
---

# Video API, gRPC: ThumbnailService.Get

Returns the specific thumbnail.

## gRPC request

**rpc Get ([GetThumbnailRequest](#yandex.cloud.video.v1.GetThumbnailRequest)) returns ([Thumbnail](#yandex.cloud.video.v1.Thumbnail))**

## GetThumbnailRequest {#yandex.cloud.video.v1.GetThumbnailRequest}

```json
{
  "thumbnail_id": "string"
}
```

#|
||Field | Description ||
|| thumbnail_id | **string**

Required field. ID of the thumbnail. ||
|#

## Thumbnail {#yandex.cloud.video.v1.Thumbnail}

```json
{
  "id": "string",
  "channel_id": "string",
  "created_at": "google.protobuf.Timestamp"
}
```

#|
||Field | Description ||
|| id | **string**

ID of the thumbnail. ||
|| channel_id | **string**

ID of the channel where the thumbnail was created. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when thumbnail was created. ||
|#