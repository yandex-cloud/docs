---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Thumbnail/list.md
---

# Video API, gRPC: ThumbnailService.List

List thumbnails for channel.

## gRPC request

**rpc List ([ListThumbnailRequest](#yandex.cloud.video.v1.ListThumbnailRequest)) returns ([ListThumbnailResponse](#yandex.cloud.video.v1.ListThumbnailResponse))**

## ListThumbnailRequest {#yandex.cloud.video.v1.ListThumbnailRequest}

```json
{
  "channel_id": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| channel_id | **string**

ID of the channel. ||
|| page_size | **int64**

The maximum number of the results per page to return.
Default value: 100. ||
|| page_token | **string**

Page token for getting the next page of the result. ||
|#

## ListThumbnailResponse {#yandex.cloud.video.v1.ListThumbnailResponse}

```json
{
  "thumbnails": [
    {
      "id": "string",
      "channel_id": "string",
      "created_at": "google.protobuf.Timestamp"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| thumbnails[] | **[Thumbnail](#yandex.cloud.video.v1.Thumbnail)**

List of thumbnails. ||
|| next_page_token | **string**

Token for getting the next page. ||
|#

## Thumbnail {#yandex.cloud.video.v1.Thumbnail}

#|
||Field | Description ||
|| id | **string**

ID of the thumbnail. ||
|| channel_id | **string**

ID of the channel where the thumbnail was created. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when thumbnail was created. ||
|#