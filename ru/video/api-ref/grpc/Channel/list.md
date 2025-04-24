---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Channel/list.md
---

# Video API, gRPC: ChannelService.List

List channels for organization.

## gRPC request

**rpc List ([ListChannelsRequest](#yandex.cloud.video.v1.ListChannelsRequest)) returns ([ListChannelsResponse](#yandex.cloud.video.v1.ListChannelsResponse))**

## ListChannelsRequest {#yandex.cloud.video.v1.ListChannelsRequest}

```json
{
  "organization_id": "string",
  "page_size": "int64",
  "page_token": "string",
  "order_by": "string",
  "filter": "string"
}
```

#|
||Field | Description ||
|| organization_id | **string**

Required field. ID of the organization. ||
|| page_size | **int64**

The maximum number of the results per page to return.
Default value: 100. ||
|| page_token | **string**

Page token for getting the next page of the result. ||
|| order_by | **string**

By which column the listing should be ordered and in which direction,
format is "<field> <order>" (e.g. "createdAt desc").
Default: "id asc".
Possible fields: ["id", "title", "createdAt", "updatedAt"].
Both snake_case and camelCase are supported for fields. ||
|| filter | **string**

Filter expression that filters resources listed in the response.
Expressions are composed of terms connected by logic operators.
If value contains spaces or quotes,
it should be in quotes (`'` or `"`) with the inner quotes being backslash escaped.
Supported logical operators: ["AND", "OR"].
Supported string match operators: ["=", "!=", ":"].
Operator ":" stands for substring matching.
Filter expressions may also contain parentheses to group logical operands.
Example: `key1='value' AND (key2!='\'value\'' OR key2:"\"value\"")`
Supported fields: ["id", "title"].
Both snake_case and camelCase are supported for fields. ||
|#

## ListChannelsResponse {#yandex.cloud.video.v1.ListChannelsResponse}

```json
{
  "channels": [
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
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| channels[] | **[Channel](#yandex.cloud.video.v1.Channel)**

List of channels for specific organization. ||
|| next_page_token | **string**

Token for getting the next page. ||
|#

## Channel {#yandex.cloud.video.v1.Channel}

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