---
editable: false
sourcePath: en/_api-ref-grpc/ai/foundation_models/v1/image_generation/image-generation/api-ref/grpc/ImageGenerationAsync/generate.md
---

# Foundation Models Image Generation API, gRPC: ImageGenerationAsyncService.Generate

A method for generating an image based on a textual description.

## gRPC request

**rpc Generate ([ImageGenerationRequest](#yandex.cloud.ai.foundation_models.v1.image_generation.ImageGenerationRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## ImageGenerationRequest {#yandex.cloud.ai.foundation_models.v1.image_generation.ImageGenerationRequest}

```json
{
  "model_uri": "string",
  "messages": [
    {
      "text": "string",
      "weight": "double"
    }
  ],
  "generation_options": {
    "mime_type": "string",
    "seed": "int64",
    "aspect_ratio": {
      "width_ratio": "int64",
      "height_ratio": "int64"
    }
  }
}
```

Request for the service to generate an image.

For examples of usage, see [step-by-step guide](/docs/foundation-models/operations/yandexart/request).

#|
||Field | Description ||
|| model_uri | **string**

The [model URI](/docs/foundation-models/concepts/yandexart/models) to be used for image generation. ||
|| messages[] | **[Message](#yandex.cloud.ai.foundation_models.v1.image_generation.Message)**

A list of messages representing the context for the image generation model. ||
|| generation_options | **[ImageGenerationOptions](#yandex.cloud.ai.foundation_models.v1.image_generation.ImageGenerationOptions)**

Image generation options. ||
|#

## Message {#yandex.cloud.ai.foundation_models.v1.image_generation.Message}

The text descriptions and weights that the model uses to generate an image.

#|
||Field | Description ||
|| text | **string**

Text describing the image. ||
|| weight | **double**

Message weight. Negative values indicate negative messages. ||
|#

## ImageGenerationOptions {#yandex.cloud.ai.foundation_models.v1.image_generation.ImageGenerationOptions}

#|
||Field | Description ||
|| mime_type | **string**

The [MIME type](https://en.wikipedia.org/wiki/Media_type) of generated image format.
For possible specifications, see [documentation](/docs/foundation-models/concepts). ||
|| seed | **int64**

Seed for image generation. It serves as a starting point for image generation from noise. ||
|| aspect_ratio | **[AspectRatio](#yandex.cloud.ai.foundation_models.v1.image_generation.AspectRatio)**

Aspect ratio of generated image. ||
|#

## AspectRatio {#yandex.cloud.ai.foundation_models.v1.image_generation.AspectRatio}

#|
||Field | Description ||
|| width_ratio | **int64**

Weight of width in image. ||
|| height_ratio | **int64**

Weight of height in image. ||
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
  "metadata": "google.protobuf.Any",
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "image": "bytes",
    "model_version": "string"
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
|| metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

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

## ImageGenerationResponse {#yandex.cloud.ai.foundation_models.v1.image_generation.ImageGenerationResponse}

Response containing generated image.

#|
||Field | Description ||
|| image | **bytes**

The image is serialized as an array of bytes encoded in [Base64](https://en.wikipedia.org/wiki/Base64). ||
|| model_version | **string**

The model version changes with each new releases. ||
|#