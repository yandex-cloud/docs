---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Channel/update.md
---

# Video API, gRPC: ChannelService.Update

Updates an existing channel's metadata and settings.
Only fields specified in the field_mask will be updated.

## gRPC request

**rpc Update ([UpdateChannelRequest](#yandex.cloud.video.v1.UpdateChannelRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateChannelRequest {#yandex.cloud.video.v1.UpdateChannelRequest}

```json
{
  "channel_id": "string",
  "field_mask": "google.protobuf.FieldMask",
  "title": "string",
  "description": "string",
  "default_style_preset_id": "string",
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

#|
||Field | Description ||
|| channel_id | **string**

Required field. ID of the channel to update. ||
|| field_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Required field. Field mask specifying which fields of the channel should be updated.
Only fields specified in this mask will be modified;
all other fields will retain their current values.
This allows for partial updates. ||
|| title | **string**

New title for the channel. ||
|| description | **string**

New description for the channel. ||
|| default_style_preset_id | **string**

New default style preset ID for the channel.
This preset will be applied to new videos created in this channel unless explicitly overridden. ||
|| labels | **object** (map<**string**, **string**>)

New custom labels for the channel as `key:value` pairs.
Maximum 64 labels per channel.
If provided, replaces all existing labels. ||
|| settings | **[ChannelSettings](#yandex.cloud.video.v1.ChannelSettings)**

New configuration settings for the channel's behavior and features. ||
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

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "created_at": "google.protobuf.Timestamp",
  "created_by": "string",
  "modified_at": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "channel_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
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
  // end of the list of possible fields
}
```

An Operation resource. For more information, see [Operation](/docs/api-design-guide/concepts/operation).

#|
||Field | Description ||
|| id | **string**

ID of the operation. ||
|| description | **string**

Description of the operation. 0-256 characters long. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[UpdateChannelMetadata](#yandex.cloud.video.v1.UpdateChannelMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**

The error result of the operation in case of failure or cancellation.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|| response | **[Channel](#yandex.cloud.video.v1.Channel)**

The normal response of the operation in case of success.
If the original method returns no data on success, such as Delete,
the response is [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty).
If the original method is the standard Create/Update,
the response should be the target resource of the operation.
Any method that returns a long-running operation should document the response type, if any.

Includes only one of the fields `error`, `response`.

The operation result.
If `done == false` and there was no failure detected, neither `error` nor `response` is set.
If `done == false` and there was a failure detected, `error` is set.
If `done == true`, exactly one of `error` or `response` is set. ||
|#

## UpdateChannelMetadata {#yandex.cloud.video.v1.UpdateChannelMetadata}

#|
||Field | Description ||
|| channel_id | **string**

ID of the channel being updated. ||
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
|| settings | **[ChannelSettings](#yandex.cloud.video.v1.ChannelSettings2)**

Configuration settings for the channel's behavior and features.
These settings control advertisements, content cleanup policies,
and embedding restrictions for all content in the channel. ||
|#

## ChannelSettings {#yandex.cloud.video.v1.ChannelSettings2}

Configuration settings for the channel's behavior and features.
These settings apply to all content in the channel and control
various aspects of how the channel and its content behave.

#|
||Field | Description ||
|| advertisement | **[AdvertisementSettings](#yandex.cloud.video.v1.AdvertisementSettings2)**

Settings for advertisement display and behavior.
Controls whether and how advertisements are shown with content in this channel.
If not specified, default advertisement settings are applied. ||
|| referer_verification | **[RefererVerificationSettings](#yandex.cloud.video.v1.RefererVerificationSettings2)**

Settings for HTTP Referer verification to control content embedding.
Restricts which domains can embed content from this channel.
If not specified or disabled, content can be embedded on any domain. ||
|#

## AdvertisementSettings {#yandex.cloud.video.v1.AdvertisementSettings2}

Settings for advertisement display and behavior in the channel.
These settings control whether and how advertisements are shown
with content in this channel, including both videos and streams.

#|
||Field | Description ||
|| yandex_direct | **[YandexDirect](#yandex.cloud.video.v1.AdvertisementSettings.YandexDirect2)**

Yandex.Direct advertisement provider settings.
When specified, advertisements will be served through Yandex.Direct.

Includes only one of the fields `yandex_direct`.

Specifies the advertisement provider to use.
Only one provider can be active at a time. ||
|#

## YandexDirect {#yandex.cloud.video.v1.AdvertisementSettings.YandexDirect2}

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

## RefererVerificationSettings {#yandex.cloud.video.v1.RefererVerificationSettings2}

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