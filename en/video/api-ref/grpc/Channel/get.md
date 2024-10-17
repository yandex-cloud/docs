---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Channel/get.md
---

# Video API, gRPC: ChannelService.Get {#Get}

Returns the specific channel.

## gRPC request

**rpc Get ([GetChannelRequest](#yandex.cloud.video.v1.GetChannelRequest)) returns ([Channel](#yandex.cloud.video.v1.Channel))**

## GetChannelRequest {#yandex.cloud.video.v1.GetChannelRequest}

```json
{
  "channelId": "string"
}
```

#|
||Field | Description ||
|| channelId | **string**

ID of the channel. ||
|#

## Channel {#yandex.cloud.video.v1.Channel}

```json
{
  "id": "string",
  "organizationId": "string",
  "title": "string",
  "description": "string",
  "createdAt": "google.protobuf.Timestamp",
  "updatedAt": "google.protobuf.Timestamp",
  "labels": "string"
}
```

Root entity for content separation.

#|
||Field | Description ||
|| id | **string**

ID of the channel. ||
|| organizationId | **string**

ID of the organization where channel should be created. ||
|| title | **string**

Channel title. ||
|| description | **string**

Channel description. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when channel was created. ||
|| updatedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time of last channel update. ||
|| labels | **string**

Custom labels as `` key:value `` pairs. Maximum 64 per resource. ||
|#