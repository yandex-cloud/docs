---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Channel/get.md
---

# Video API, gRPC: ChannelService.Get

Returns the specific channel.

## gRPC request

**rpc Get ([GetChannelRequest](#yandex.cloud.video.v1.GetChannelRequest)) returns ([Channel](#yandex.cloud.video.v1.Channel))**

## GetChannelRequest {#yandex.cloud.video.v1.GetChannelRequest}

```json
{
  "channel_id": "string"
}
```

#|
||Field | Description ||
|| channel_id | **string**

Required field. ID of the channel. ||
|#

## Channel {#yandex.cloud.video.v1.Channel}

```json
{
  "id": "string",
  "organization_id": "string",
  "title": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "updated_at": "google.protobuf.Timestamp",
  "labels": "map<string, string>"
}
```

Root entity for content separation.

#|
||Field | Description ||
|| id | **string**

ID of the channel. ||
|| organization_id | **string**

ID of the organization where channel should be created. ||
|| title | **string**

Channel title. ||
|| description | **string**

Channel description. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when channel was created. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time of last channel update. ||
|| labels | **object** (map<**string**, **string**>)

Custom labels as `` key:value `` pairs. Maximum 64 per resource. ||
|#