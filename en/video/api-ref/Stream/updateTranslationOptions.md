---
editable: false
apiPlayground:
  - url: https://video.{{ api-host }}/video/v1/streams/{streamId}:updateTranslationOptions
    method: patch
    path:
      type: object
      properties:
        streamId:
          description: |-
            **string**
            Required field. ID of the stream for which to set an option.
            The maximum string length in characters is 50.
          type: string
      required:
        - streamId
      additionalProperties: false
    query: null
    body:
      type: object
      properties:
        enableTranslation:
          description: |-
            **object**
            Enable neurotranslations for the stream.
            Includes only one of the fields `enableTranslation`, `disableTranslation`.
            Specifies which option to set for the stream.
          $ref: '#/definitions/EnableTranslationOption'
        disableTranslation:
          description: |-
            **object**
            Disable neurotranslations for the stream.
            Includes only one of the fields `enableTranslation`, `disableTranslation`.
            Specifies which option to set for the stream.
          $ref: '#/definitions/DisableTranslationOption'
      additionalProperties: false
      oneOf:
        - required:
            - enableTranslation
        - required:
            - disableTranslation
    definitions:
      EnableTranslationOption:
        type: object
        properties: {}
      DisableTranslationOption:
        type: object
        properties: {}
---

# Video API, REST: Stream.UpdateTranslationOptions

Update translation options for the onair stream.
Only works with streams created on stream lines with enabled neurotranslation.


## HTTP request

```
PATCH https://video.{{ api-host }}/video/v1/streams/{streamId}:updateTranslationOptions
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