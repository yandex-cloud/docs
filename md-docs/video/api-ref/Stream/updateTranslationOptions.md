[Документация Yandex Cloud](../../../index.md) > [Yandex Cloud Video](../../index.md) > Справочник API > [REST (англ.)](../index.md) > [Stream](index.md) > UpdateTranslationOptions

# Video API, REST: Stream.UpdateTranslationOptions

Update translation options for the onair stream.
Only works with streams created on stream lines with enabled neurotranslation.


## HTTP request

```
PATCH https://video.api.cloud.yandex.net/video/v1/streams/{streamId}:updateTranslationOptions
```

## Path parameters

#|
||Field | Description ||
|| streamId | **string**

Required field. ID of the stream for which to set an option.

The maximum string length in characters is 50. ||
|#

## Body parameters {#yandex.cloud.video.v1.UpdateTranslationOptionsRequest}

```json
{
  // Includes only one of the fields `enableTranslation`, `disableTranslation`
  "enableTranslation": "object",
  "disableTranslation": "object"
  // end of the list of possible fields
}
```

#|
||Field | Description ||
|| enableTranslation | **object**

Enable neurotranslations for the stream.

Includes only one of the fields `enableTranslation`, `disableTranslation`.

Specifies which option to set for the stream. ||
|| disableTranslation | **object**

Disable neurotranslations for the stream.

Includes only one of the fields `enableTranslation`, `disableTranslation`.

Specifies which option to set for the stream. ||
|#

## Response {#google.protobuf.Empty}

**HTTP Code: 200 - OK**