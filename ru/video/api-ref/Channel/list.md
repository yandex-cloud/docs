---
editable: false
sourcePath: en/_api-ref/video/v1/api-ref/Channel/list.md
---

# Video API, REST: Channel.List

List channels for organization.

## HTTP request

```
GET https://video.{{ api-host }}/video/v1/channels
```

## Query parameters {#yandex.cloud.video.v1.ListChannelsRequest}

#|
||Field | Description ||
|| organizationId | **string**

Required field. ID of the organization. ||
|| pageSize | **string** (int64)

The maximum number of the results per page to return.
Default value: 100. ||
|| pageToken | **string**

Page token for getting the next page of the result. ||
|| orderBy | **string**

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

## Response {#yandex.cloud.video.v1.ListChannelsResponse}

**HTTP Code: 200 - OK**

```json
{
  "channels": [
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
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| channels[] | **[Channel](#yandex.cloud.video.v1.Channel)**

List of channels for specific organization. ||
|| nextPageToken | **string**

Token for getting the next page. ||
|#

## Channel {#yandex.cloud.video.v1.Channel}

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