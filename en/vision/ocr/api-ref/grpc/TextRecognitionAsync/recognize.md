---
editable: false
sourcePath: en/_api-ref-grpc/ai/ocr/v1/ocr/api-ref/grpc/TextRecognitionAsync/recognize.md
---

# Vision OCR API, gRPC: TextRecognitionAsyncService.Recognize

To send the image for asynchronous text recognition.

## gRPC request

**rpc Recognize ([RecognizeTextRequest](#yandex.cloud.ai.ocr.v1.RecognizeTextRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## RecognizeTextRequest {#yandex.cloud.ai.ocr.v1.RecognizeTextRequest}

```json
{
  // Includes only one of the fields `content`
  "content": "bytes",
  // end of the list of possible fields
  "mime_type": "string",
  "language_codes": [
    "string"
  ],
  "model": "string"
}
```

#|
||Field | Description ||
|| content | **bytes**

Bytes with data

Includes only one of the fields `content`. ||
|| mime_type | **string**

Specifications of the ([MIME type](https://en.wikipedia.org/wiki/Media_type)). Each specification contains the file to analyze and features to use for analysis. Restrictions:
* Supported file formats: `JPEG`, `PNG`, `PDF`.
* Maximum file size: see [documentation](/docs/vision/concepts/limits).
* Image size should not exceed 20M pixels (length x width).
* The number of pages in a PDF file should not exceed 1. ||
|| language_codes[] | **string**

[List of the languages](/docs/vision/concepts/ocr/supported-languages) to recognize text.
Specified in [ISO 639-1](https://en.wikipedia.org/wiki/ISO_639-1) format (for example, `ru`). ||
|| model | **string**

[Model](/docs/vision/concepts/ocr/template-recognition#models) to use for text detection. ||
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
  "response": "google.protobuf.Empty"
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
|| response | **[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)**

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