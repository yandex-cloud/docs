---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Channel/get.md
---

# Video API, gRPC: ChannelService.Get

Get the specific channel.

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
  "labels": "map<string, string>",
  "settings": {
    "advertisement": {
      // Includes only one of the fields `yandex_direct`
      "yandex_direct": {
        "enable": "bool",
        "page_id": "int64",
        "category": "int64"
      }
      // end of the list of possible fields
    },
    "referer_verification": {
      "enable": "bool",
      "allowed_domains": [
        "string"
      ]
    }
  }
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
|| settings | **[ChannelSettings](#yandex.cloud.video.v1.ChannelSettings)**

Channel settings. ||
|#

## ChannelSettings {#yandex.cloud.video.v1.ChannelSettings}

Channel settings.

#|
||Field | Description ||
|| advertisement | **[AdvertisementSettings](#yandex.cloud.video.v1.AdvertisementSettings)**

Advertisement settings. ||
|| referer_verification | **[RefererVerificationSettings](#yandex.cloud.video.v1.RefererVerificationSettings)**

Referer verification settings ||
|#

## AdvertisementSettings {#yandex.cloud.video.v1.AdvertisementSettings}

Advertisement settings.

#|
||Field | Description ||
|| yandex_direct | **[YandexDirect](#yandex.cloud.video.v1.AdvertisementSettings.YandexDirect)**

Includes only one of the fields `yandex_direct`.

Advertisement provider. ||
|#

## YandexDirect {#yandex.cloud.video.v1.AdvertisementSettings.YandexDirect}

YandexDirect provider settings.

#|
||Field | Description ||
|| enable | **bool**

Enable Partner Ad for Live and VOD content. ||
|| page_id | **int64**

Advertisement page ID. ||
|| category | **int64**

Advertisement category. ||
|#

## RefererVerificationSettings {#yandex.cloud.video.v1.RefererVerificationSettings}

Referer verification settings.

#|
||Field | Description ||
|| enable | **bool**

Enable verification ||
|| allowed_domains[] | **string**

List of available domains ||
|#