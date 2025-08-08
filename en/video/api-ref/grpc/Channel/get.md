---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Channel/get.md
---

# Video API, gRPC: ChannelService.Get

Retrieves detailed information about a specific channel by its ID.
Returns all channel metadata, settings, and related information.

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

Required field. ID of the channel to retrieve. ||
|#

## Channel {#yandex.cloud.video.v1.Channel}

```json
{
  "id": "string",
  "organization_id": "string",
  "title": "string",
  "description": "string",
  "default_style_preset_id": "string",
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
|| organization_id | **string**

Identifier of the organization to which this channel belongs.
Each channel must be associated with exactly one organization. ||
|| title | **string**

Title of the channel displayed in interfaces.
This is the primary display name shown to users. ||
|| description | **string**

Detailed description of the channel's purpose and content.
This optional field provides additional context about the channel. ||
|| default_style_preset_id | **string**

Identifier of the default style preset applied to videos in this channel.
Videos, episodes, and playlists created in this channel
inherit this preset unless explicitly overridden. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp when the channel was initially created.
This value is set automatically by the system and cannot be modified. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp of the last modification to the channel or its settings.
This value is updated automatically whenever the channel is modified. ||
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
|| referer_verification | **[RefererVerificationSettings](#yandex.cloud.video.v1.RefererVerificationSettings)**

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
|| yandex_direct | **[YandexDirect](#yandex.cloud.video.v1.AdvertisementSettings.YandexDirect)**

Yandex.Direct advertisement provider settings.
When specified, advertisements will be served through Yandex.Direct.

Includes only one of the fields `yandex_direct`.

Specifies the advertisement provider to use.
Only one provider can be active at a time. ||
|#

## YandexDirect {#yandex.cloud.video.v1.AdvertisementSettings.YandexDirect}

Configuration for the Yandex.Direct advertisement provider.
These settings are specific to the Yandex.Direct advertising platform.

#|
||Field | Description ||
|| enable | **bool**

Enables or disables Partner Ad for both Live and VOD content.
When set to true, advertisements will be shown with content.
When set to false, no advertisements will be shown. ||
|| page_id | **int64**

Yandex.Direct page identifier.
This ID is used to associate the channel with a specific page
in the Yandex.Direct system for targeting and reporting. ||
|| category | **int64**

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
|| enable | **bool**

Enables or disables Referer verification for this channel.
When set to true, only requests from allowed domains will be permitted.
When set to false, content can be embedded on any domain. ||
|| allowed_domains[] | **string**

List of domains allowed to embed content from this channel.
Only relevant when enable is set to true.
Supports wildcard notation (e.g., "*.example.com") to allow all subdomains. ||
|#