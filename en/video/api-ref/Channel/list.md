---
editable: false
apiPlayground:
  - url: https://video.{{ api-host }}/video/v1/channels
    method: get
    path: null
    query:
      type: object
      properties:
        organizationId:
          description: |-
            **string**
            Required field. ID of the organization containing the channels to list.
          type: string
        pageSize:
          description: |-
            **string** (int64)
            The maximum number of channels to return per page.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            Page token for retrieving the next page of results.
            This token is obtained from the next_page_token field in the previous ListChannelsResponse.
          type: string
        orderBy:
          description: |-
            **string**
            Specifies the ordering of results.
            Format is "<field> <order>" (e.g., "createdAt desc").
            Default: "id asc".
            Supported fields: ["id", "title", "createdAt", "updatedAt"].
            Both snake_case and camelCase field names are supported.
          type: string
        filter:
          description: |-
            **string**
            Filter expression to narrow down the list of returned channels.
            Expressions consist of terms connected by logical operators.
            Values containing spaces or quotes must be enclosed in quotes (`'` or `"`)
            with inner quotes being backslash-escaped.
            Supported logical operators: ["AND", "OR"].
            Supported comparison operators: ["=", "!=", ":"] where ":" enables substring matching.
            Parentheses can be used to group logical expressions.
            Example: `title:'news' AND id!='channel-123'`
            Filterable fields: ["id", "title"].
            Both snake_case and camelCase field names are supported.
          type: string
      required:
        - organizationId
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/video/v1/api-ref/Channel/list.md
---

# Video API, REST: Channel.List

Lists all channels in a specific organization with pagination support.
Results can be filtered and sorted using the provided parameters.

## HTTP request

```
GET https://video.{{ api-host }}/video/v1/channels
```

## Query parameters {#yandex.cloud.video.v1.ListChannelsRequest}

#|
||Field | Description ||
|| organizationId | **string**

Required field. ID of the organization containing the channels to list. ||
|| pageSize | **string** (int64)

The maximum number of channels to return per page. ||
|| pageToken | **string**

Page token for retrieving the next page of results.
This token is obtained from the next_page_token field in the previous ListChannelsResponse. ||
|| orderBy | **string**

Specifies the ordering of results.
Format is "<field> <order>" (e.g., "createdAt desc").
Default: "id asc".
Supported fields: ["id", "title", "createdAt", "updatedAt"].
Both snake_case and camelCase field names are supported. ||
|| filter | **string**

Filter expression to narrow down the list of returned channels.
Expressions consist of terms connected by logical operators.
Values containing spaces or quotes must be enclosed in quotes (`'` or `"`)
with inner quotes being backslash-escaped.

Supported logical operators: ["AND", "OR"].
Supported comparison operators: ["=", "!=", ":"] where ":" enables substring matching.
Parentheses can be used to group logical expressions.

Example: `title:'news' AND id!='channel-123'`

Filterable fields: ["id", "title"].
Both snake_case and camelCase field names are supported. ||
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
      "defaultStylePresetId": "string",
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

List of channels matching the request criteria.
May be empty if no channels match the criteria or if the organization has no channels. ||
|| nextPageToken | **string**

Token for retrieving the next page of results.
Empty if there are no more results available. ||
|#

## Channel {#yandex.cloud.video.v1.Channel}

Root entity for content organization and separation within the video platform.
A channel serves as a container for videos and streams, providing a way to
group related content and apply common settings and access controls.
Each channel belongs to a specific organization and can have its own
configuration for advertisements, content cleanup, and embedding restrictions.

#|
||Field | Description ||
|| id | **string**

Unique identifier of the channel.
This ID is used to reference the channel in API calls and URLs. ||
|| organizationId | **string**

Identifier of the organization to which this channel belongs.
Each channel must be associated with exactly one organization. ||
|| title | **string**

Title of the channel displayed in interfaces.
This is the primary display name shown to users. ||
|| description | **string**

Detailed description of the channel's purpose and content.
This optional field provides additional context about the channel. ||
|| defaultStylePresetId | **string**

Identifier of the default style preset applied to videos in this channel.
Videos, episodes, and playlists created in this channel
inherit this preset unless explicitly overridden. ||
|| createdAt | **string** (date-time)

Timestamp when the channel was initially created.
This value is set automatically by the system and cannot be modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| updatedAt | **string** (date-time)

Timestamp of the last modification to the channel or its settings.
This value is updated automatically whenever the channel is modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| labels | **object** (map<**string**, **string**>)

Custom user-defined labels as `key:value` pairs.
Maximum 64 labels per channel.
Labels can be used for organization, filtering, and metadata purposes. ||
|| settings | **[ChannelSettings](#yandex.cloud.video.v1.ChannelSettings)**

Configuration settings for the channel's behavior and features.
These settings control advertisements, content cleanup policies,
and embedding restrictions for all content in the channel. ||
|#

## ChannelSettings {#yandex.cloud.video.v1.ChannelSettings}

Configuration settings for the channel's behavior and features.
These settings apply to all content in the channel and control
various aspects of how the channel and its content behave.

#|
||Field | Description ||
|| advertisement | **[AdvertisementSettings](#yandex.cloud.video.v1.AdvertisementSettings)**

Settings for advertisement display and behavior.
Controls whether and how advertisements are shown with content in this channel.
If not specified, default advertisement settings are applied. ||
|| refererVerification | **[RefererVerificationSettings](#yandex.cloud.video.v1.RefererVerificationSettings)**

Settings for HTTP Referer verification to control content embedding.
Restricts which domains can embed content from this channel.
If not specified or disabled, content can be embedded on any domain. ||
|#

## AdvertisementSettings {#yandex.cloud.video.v1.AdvertisementSettings}

Settings for advertisement display and behavior in the channel.
These settings control whether and how advertisements are shown
with content in this channel, including both videos and streams.

#|
||Field | Description ||
|| yandexDirect | **[YandexDirect](#yandex.cloud.video.v1.AdvertisementSettings.YandexDirect)**

Yandex.Direct advertisement provider settings.
When specified, advertisements will be served through Yandex.Direct.

Includes only one of the fields `yandexDirect`.

Specifies the advertisement provider to use.
Only one provider can be active at a time. ||
|#

## YandexDirect {#yandex.cloud.video.v1.AdvertisementSettings.YandexDirect}

Configuration for the Yandex.Direct advertisement provider.
These settings are specific to the Yandex.Direct advertising platform.

#|
||Field | Description ||
|| enable | **boolean**

Enables or disables Partner Ad for both Live and VOD content.
When set to true, advertisements will be shown with content.
When set to false, no advertisements will be shown. ||
|| pageId | **string** (int64)

Yandex.Direct page identifier.
This ID is used to associate the channel with a specific page
in the Yandex.Direct system for targeting and reporting. ||
|| category | **string** (int64)

Yandex.Direct category identifier.
This ID is used to categorize the channel's content for
appropriate advertisement targeting and compliance. ||
|#

## RefererVerificationSettings {#yandex.cloud.video.v1.RefererVerificationSettings}

Settings for HTTP Referer verification to control where content can be embedded.
When enabled, the system checks the HTTP Referer request header to ensure
that content is only embedded on allowed domains.

#|
||Field | Description ||
|| enable | **boolean**

Enables or disables Referer verification for this channel.
When set to true, only requests from allowed domains will be permitted.
When set to false, content can be embedded on any domain. ||
|| allowedDomains[] | **string**

List of domains allowed to embed content from this channel.
Only relevant when enable is set to true.
Supports wildcard notation (e.g., "*.example.com") to allow all subdomains. ||
|#