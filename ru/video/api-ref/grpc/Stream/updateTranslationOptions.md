---
editable: false
---

# Video API, gRPC: StreamService.UpdateTranslationOptions

Update translation options for the onair stream.
Only works with streams created on stream lines with enabled neurotranslation.


## gRPC request

**rpc UpdateTranslationOptions ([UpdateTranslationOptionsRequest](#yandex.cloud.video.v1.UpdateTranslationOptionsRequest)) returns ([google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty))**

## UpdateTranslationOptionsRequest {#yandex.cloud.video.v1.UpdateTranslationOptionsRequest}

```json
{
  "stream_id": "string",
  // Includes only one of the fields `enable_translation`, `disable_translation`
  "enable_translation": "EnableTranslationOption",
  "disable_translation": "DisableTranslationOption"
  // end of the list of possible fields
}
```

#|
||Field | Description ||
|| stream_id | **string**

Required field. ID of the stream for which to set an option.

The maximum string length in characters is 50. ||
|| enable_translation | **[EnableTranslationOption](#yandex.cloud.video.v1.EnableTranslationOption)**

Enable neurotranslations for the stream.

Includes only one of the fields `enable_translation`, `disable_translation`.

Specifies which option to set for the stream. ||
|| disable_translation | **[DisableTranslationOption](#yandex.cloud.video.v1.DisableTranslationOption)**

Disable neurotranslations for the stream.

Includes only one of the fields `enable_translation`, `disable_translation`.

Specifies which option to set for the stream. ||
|#

## EnableTranslationOption {#yandex.cloud.video.v1.EnableTranslationOption}

Parameters for the enable translation option.

#|
||Field | Description ||
|| Empty | > ||
|#

## DisableTranslationOption {#yandex.cloud.video.v1.DisableTranslationOption}

Parameters for the disable translation option.

#|
||Field | Description ||
|| Empty | > ||
|#

## google.protobuf.Empty {#google.protobuf.Empty}

```json
{}
```

#|
||Field | Description ||
|| Empty | > ||
|#