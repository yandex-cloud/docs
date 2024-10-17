---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Thumbnail/list.md
---

# Video API, gRPC: ThumbnailService.List {#List}

List thumbnails for channel.

## gRPC request

**rpc List ([ListThumbnailRequest](#yandex.cloud.video.v1.ListThumbnailRequest)) returns ([ListThumbnailResponse](#yandex.cloud.video.v1.ListThumbnailResponse))**

## ListThumbnailRequest {#yandex.cloud.video.v1.ListThumbnailRequest}

```json
{
  "channelId": "string",
  "pageSize": "int64",
  "pageToken": "string"
}
```

#|
||Field | Description ||
|| channelId | **string**

ID of the channel. ||
|| pageSize | **int64**

The maximum number of the results per page to return. Default value: 100. ||
|| pageToken | **string**

Page token for getting the next page of the result. ||
|#

## ListThumbnailResponse {#yandex.cloud.video.v1.ListThumbnailResponse}

```json
{
  "thumbnails": [
    {
      "id": "string",
      "channelId": "string",
      "createdAt": "google.protobuf.Timestamp"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| thumbnails[] | **[Thumbnail](#yandex.cloud.video.v1.Thumbnail)**

List of thumbnails. ||
|| nextPageToken | **string**

Token for getting the next page. ||
|#

## Thumbnail {#yandex.cloud.video.v1.Thumbnail}

#|
||Field | Description ||
|| id | **string**

ID of the thumbnail. ||
|| channelId | **string**

ID of the channel where the thumbnail was created. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when thumbnail was created. ||
|#