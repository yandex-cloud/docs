---
editable: false
sourcePath: en/_api-ref/video/v1/api-ref/Channel/get.md
---

# Video API, REST: Channel.Get

Get the specific channel.

## HTTP request

```
GET https://video.{{ api-host }}/video/v1/channels/{channelId}
```

## Path parameters

#|
||Field | Description ||
|| channelId | **string**

Required field. ID of the channel. ||
|#

## Response {#yandex.cloud.video.v1.Channel}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "organizationId": "string",
  "title": "string",
  "description": "string",
  "createdAt": "string",
  "updatedAt": "string",
  "labels": "object",
  "settings": {
    "advertisement": {
      // Includes only one of the fields `yandexDirect`
      "yandexDirect": {
        "enable": "boolean",
        "pageId": "string",
        "category": "string"
      }
      // end of the list of possible fields
    },
    "refererVerification": {
      "enable": "boolean",
      "allowedDomains": [
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
|| organizationId | **string**

ID of the organization where channel should be created. ||
|| title | **string**

Channel title. ||
|| description | **string**

Channel description. ||
|| createdAt | **string** (date-time)

Time when channel was created.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updatedAt | **string** (date-time)

Time of last channel update.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
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
|| refererVerification | **[RefererVerificationSettings](#yandex.cloud.video.v1.RefererVerificationSettings)**

Referer verification settings ||
|#

## AdvertisementSettings {#yandex.cloud.video.v1.AdvertisementSettings}

Advertisement settings.

#|
||Field | Description ||
|| yandexDirect | **[YandexDirect](#yandex.cloud.video.v1.AdvertisementSettings.YandexDirect)**

Includes only one of the fields `yandexDirect`.

Advertisement provider. ||
|#

## YandexDirect {#yandex.cloud.video.v1.AdvertisementSettings.YandexDirect}

YandexDirect provider settings.

#|
||Field | Description ||
|| enable | **boolean**

Enable Partner Ad for Live and VOD content. ||
|| pageId | **string** (int64)

Advertisement page ID. ||
|| category | **string** (int64)

Advertisement category. ||
|#

## RefererVerificationSettings {#yandex.cloud.video.v1.RefererVerificationSettings}

Referer verification settings.

#|
||Field | Description ||
|| enable | **boolean**

Enable verification ||
|| allowedDomains[] | **string**

List of available domains ||
|#