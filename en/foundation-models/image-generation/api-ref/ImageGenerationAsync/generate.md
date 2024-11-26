---
editable: false
sourcePath: en/_api-ref/ai/foundation_models/v1/image_generation/image-generation/api-ref/ImageGenerationAsync/generate.md
---

# Foundation Models Image Generation API, REST: ImageGenerationAsync.Generate

A method for generating an image based on a textual description.

## HTTP request

```
POST https://llm.{{ api-host }}/foundationModels/v1/imageGenerationAsync
```

## Body parameters {#yandex.cloud.ai.foundation_models.v1.image_generation.ImageGenerationRequest}

```json
{
  "modelUri": "string",
  "messages": [
    {
      "text": "string",
      "weight": "string"
    }
  ],
  "generationOptions": {
    "mimeType": "string",
    "seed": "string",
    "aspectRatio": {
      "widthRatio": "string",
      "heightRatio": "string"
    }
  }
}
```

Request for the service to generate an image.

For examples of usage, see [step-by-step guide](/docs/foundation-models/operations/yandexart/request).

#|
||Field | Description ||
|| modelUri | **string**

The [model URI](/docs/foundation-models/concepts/yandexart/models) to be used for image generation. ||
|| messages[] | **[Message](#yandex.cloud.ai.foundation_models.v1.image_generation.Message)**

A list of messages representing the context for the image generation model. ||
|| generationOptions | **[ImageGenerationOptions](#yandex.cloud.ai.foundation_models.v1.image_generation.ImageGenerationOptions)**

Image generation options. ||
|#

## Message {#yandex.cloud.ai.foundation_models.v1.image_generation.Message}

The text descriptions and weights that the model uses to generate an image.

#|
||Field | Description ||
|| text | **string**

Text describing the image. ||
|| weight | **string**

Message weight. Negative values indicate negative messages. ||
|#

## ImageGenerationOptions {#yandex.cloud.ai.foundation_models.v1.image_generation.ImageGenerationOptions}

#|
||Field | Description ||
|| mimeType | **string**

The [MIME type](https://en.wikipedia.org/wiki/Media_type) of generated image format.
For possible specifications, see [documentation](/docs/foundation-models/concepts). ||
|| seed | **string** (int64)

Seed for image generation. It serves as a starting point for image generation from noise. ||
|| aspectRatio | **[AspectRatio](#yandex.cloud.ai.foundation_models.v1.image_generation.AspectRatio)**

Aspect ratio of generated image. ||
|#

## AspectRatio {#yandex.cloud.ai.foundation_models.v1.image_generation.AspectRatio}

#|
||Field | Description ||
|| widthRatio | **string** (int64)

Weight of width in image. ||
|| heightRatio | **string** (int64)

Weight of height in image. ||
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
  "metadata": "object",
  // Includes only one of the fields `error`, `response`
  "error": {
    "code": "integer",
    "message": "string",
    "details": [
      "object"
    ]
  },
  "response": {
    "image": "string",
    "modelVersion": "string"
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
|| metadata | **object**

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
|| response | **[ImageGenerationResponse](#yandex.cloud.ai.foundation_models.v1.image_generation.ImageGenerationResponse)**

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

## ImageGenerationResponse {#yandex.cloud.ai.foundation_models.v1.image_generation.ImageGenerationResponse}

Response containing generated image.

#|
||Field | Description ||
|| image | **string** (bytes)

The image is serialized as an array of bytes encoded in [Base64](https://en.wikipedia.org/wiki/Base64). ||
|| modelVersion | **string**

The model version changes with each new releases. ||
|#