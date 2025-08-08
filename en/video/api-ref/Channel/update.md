---
editable: false
apiPlayground:
  - url: https://video.{{ api-host }}/video/v1/channels/{channelId}
    method: patch
    path:
      type: object
      properties:
        channelId:
          description: |-
            **string**
            Required field. ID of the channel to update.
          type: string
      required:
        - channelId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        fieldMask:
          description: |-
            **string** (field-mask)
            Required field. A comma-separated names off ALL fields to be updated.
            Only the specified fields will be changed. The others will be left untouched.
            If the field is specified in `` updateMask `` and no value for that field was sent in the request,
            the field's value will be reset to the default. The default value for most fields is null or 0.
            If `` updateMask `` is not sent in the request, all fields' values will be updated.
            Fields specified in the request will be updated to provided values.
            The rest of the fields will be reset to the default.
          type: string
          format: field-mask
        title:
          description: |-
            **string**
            New title for the channel.
          type: string
        description:
          description: |-
            **string**
            New description for the channel.
          type: string
        defaultStylePresetId:
          description: |-
            **string**
            New default style preset ID for the channel.
            This preset will be applied to new videos created in this channel unless explicitly overridden.
          type: string
        labels:
          description: |-
            **object** (map<**string**, **string**>)
            New custom labels for the channel as `key:value` pairs.
            Maximum 64 labels per channel.
            If provided, replaces all existing labels.
          pattern: '[a-z][-_0-9a-z]*'
          type: string
        settings:
          description: |-
            **[ChannelSettings](/docs/video/api-ref/Channel/get#yandex.cloud.video.v1.ChannelSettings)**
            New configuration settings for the channel's behavior and features.
          $ref: '#/definitions/ChannelSettings'
      required:
        - fieldMask
      additionalProperties: false
    definitions:
      YandexDirect:
        type: object
        properties:
          enable:
            description: |-
              **boolean**
              Enables or disables Partner Ad for both Live and VOD content.
              When set to true, advertisements will be shown with content.
              When set to false, no advertisements will be shown.
            type: boolean
          pageId:
            description: |-
              **string** (int64)
              Yandex.Direct page identifier.
              This ID is used to associate the channel with a specific page
              in the Yandex.Direct system for targeting and reporting.
            type: string
            format: int64
          category:
            description: |-
              **string** (int64)
              Yandex.Direct category identifier.
              This ID is used to categorize the channel's content for
              appropriate advertisement targeting and compliance.
            type: string
            format: int64
      RefererVerificationSettings:
        type: object
        properties:
          enable:
            description: |-
              **boolean**
              Enables or disables Referer verification for this channel.
              When set to true, only requests from allowed domains will be permitted.
              When set to false, content can be embedded on any domain.
            type: boolean
          allowedDomains:
            description: |-
              **string**
              List of domains allowed to embed content from this channel.
              Only relevant when enable is set to true.
              Supports wildcard notation (e.g., "*.example.com") to allow all subdomains.
            pattern: ^(?:\*\.)?(?:[a-zA-Z0-9-]*\.)+[a-zA-Z]{2,}$|^\*\.[a-zA-Z]{2,}$
            type: array
            items:
              type: string
      ChannelSettings:
        type: object
        properties:
          advertisement:
            description: |-
              **[AdvertisementSettings](/docs/video/api-ref/Channel/get#yandex.cloud.video.v1.AdvertisementSettings)**
              Settings for advertisement display and behavior.
              Controls whether and how advertisements are shown with content in this channel.
              If not specified, default advertisement settings are applied.
            oneOf:
              - type: object
                properties:
                  yandexDirect:
                    description: |-
                      **[YandexDirect](/docs/video/api-ref/Channel/get#yandex.cloud.video.v1.AdvertisementSettings.YandexDirect)**
                      Yandex.Direct advertisement provider settings.
                      When specified, advertisements will be served through Yandex.Direct.
                      Includes only one of the fields `yandexDirect`.
                      Specifies the advertisement provider to use.
                      Only one provider can be active at a time.
                    $ref: '#/definitions/YandexDirect'
          refererVerification:
            description: |-
              **[RefererVerificationSettings](/docs/video/api-ref/Channel/get#yandex.cloud.video.v1.RefererVerificationSettings)**
              Settings for HTTP Referer verification to control content embedding.
              Restricts which domains can embed content from this channel.
              If not specified or disabled, content can be embedded on any domain.
            $ref: '#/definitions/RefererVerificationSettings'
sourcePath: en/_api-ref/video/v1/api-ref/Channel/update.md
---

# Video API, REST: Channel.Update

Updates an existing channel's metadata and settings.
Only fields specified in the field_mask will be updated.

## HTTP request

```
PATCH https://video.{{ api-host }}/video/v1/channels/{channelId}
```

## Path parameters

#|
||Field | Description ||
|| channelId | **string**

Required field. ID of the channel to update. ||
|#

## Body parameters {#yandex.cloud.video.v1.UpdateChannelRequest}

```json
{
  "fieldMask": "string",
  "title": "string",
  "description": "string",
  "defaultStylePresetId": "string",
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

#|
||Field | Description ||
|| fieldMask | **string** (field-mask)

Required field. A comma-separated names off ALL fields to be updated.
Only the specified fields will be changed. The others will be left untouched.
If the field is specified in `` updateMask `` and no value for that field was sent in the request,
the field's value will be reset to the default. The default value for most fields is null or 0.

If `` updateMask `` is not sent in the request, all fields' values will be updated.
Fields specified in the request will be updated to provided values.
The rest of the fields will be reset to the default. ||
|| title | **string**

New title for the channel. ||
|| description | **string**

New description for the channel. ||
|| defaultStylePresetId | **string**

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

## Response {#yandex.cloud.operation.Operation}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "string",
  "createdBy": "string",
  "modifiedAt": "string",
  "done": "boolean",
  "metadata": {
    "channelId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
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
|| createdAt | **string** (date-time)

Creation timestamp.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **string** (date-time)

The time when the Operation resource was last modified.

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| done | **boolean**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[UpdateChannelMetadata](#yandex.cloud.video.v1.UpdateChannelMetadata)**

Service-specific metadata associated with the operation.
It typically contains the ID of the target resource that the operation is performed on.
Any method that returns a long-running operation should document the metadata type, if any. ||
|| error | **[Status](#google.rpc.Status)**

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
|| channelId | **string**

ID of the channel being updated. ||
|#

## Status {#google.rpc.Status}

The error result of the operation in case of failure or cancellation.

#|
||Field | Description ||
|| code | **integer** (int32)

Error code. An enum value of [google.rpc.Code](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto). ||
|| message | **string**

An error message. ||
|| details[] | **object**

A list of messages that carry the error details. ||
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
|| refererVerification | **[RefererVerificationSettings](#yandex.cloud.video.v1.RefererVerificationSettings2)**

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
|| yandexDirect | **[YandexDirect](#yandex.cloud.video.v1.AdvertisementSettings.YandexDirect2)**

Yandex.Direct advertisement provider settings.
When specified, advertisements will be served through Yandex.Direct.

Includes only one of the fields `yandexDirect`.

Specifies the advertisement provider to use.
Only one provider can be active at a time. ||
|#

## YandexDirect {#yandex.cloud.video.v1.AdvertisementSettings.YandexDirect2}

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

## RefererVerificationSettings {#yandex.cloud.video.v1.RefererVerificationSettings2}

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