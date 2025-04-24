---
editable: false
sourcePath: en/_api-ref-grpc/video/v1/api-ref/grpc/Channel/create.md
---

# Video API, gRPC: ChannelService.Create

Create channel.

## gRPC request

**rpc Create ([CreateChannelRequest](#yandex.cloud.video.v1.CreateChannelRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateChannelRequest {#yandex.cloud.video.v1.CreateChannelRequest}

```json
{
  "organization_id": "string",
  "title": "string",
  "description": "string",
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
|| organization_id | **string**

Required field. ID of the organization. ||
|| title | **string**

Required field. Channel title. ||
|| description | **string**

Channel description. ||
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
|| metadata | **[CreateChannelMetadata](#yandex.cloud.video.v1.CreateChannelMetadata)**

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

## CreateChannelMetadata {#yandex.cloud.video.v1.CreateChannelMetadata}

#|
||Field | Description ||
|| channel_id | **string**

ID of the channel. ||
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
|| settings | **[ChannelSettings](#yandex.cloud.video.v1.ChannelSettings2)**

Channel settings. ||
|#

## ChannelSettings {#yandex.cloud.video.v1.ChannelSettings2}

Channel settings.

#|
||Field | Description ||
|| advertisement | **[AdvertisementSettings](#yandex.cloud.video.v1.AdvertisementSettings2)**

Advertisement settings. ||
|| referer_verification | **[RefererVerificationSettings](#yandex.cloud.video.v1.RefererVerificationSettings2)**

Referer verification settings ||
|#

## AdvertisementSettings {#yandex.cloud.video.v1.AdvertisementSettings2}

Advertisement settings.

#|
||Field | Description ||
|| yandex_direct | **[YandexDirect](#yandex.cloud.video.v1.AdvertisementSettings.YandexDirect2)**

Includes only one of the fields `yandex_direct`.

Advertisement provider. ||
|#

## YandexDirect {#yandex.cloud.video.v1.AdvertisementSettings.YandexDirect2}

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

## RefererVerificationSettings {#yandex.cloud.video.v1.RefererVerificationSettings2}

Referer verification settings.

#|
||Field | Description ||
|| enable | **bool**

Enable verification ||
|| allowed_domains[] | **string**

List of available domains ||
|#