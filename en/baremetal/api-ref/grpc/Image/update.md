---
editable: false
sourcePath: en/_api-ref-grpc/baremetal/v1alpha/api-ref/grpc/Image/update.md
---

# BareMetal API, gRPC: ImageService.Update

Updates the specified image.

## gRPC request

**rpc Update ([UpdateImageRequest](#yandex.cloud.baremetal.v1alpha.UpdateImageRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateImageRequest {#yandex.cloud.baremetal.v1alpha.UpdateImageRequest}

```json
{
  "image_id": "string",
  "update_mask": "google.protobuf.FieldMask",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>"
}
```

#|
||Field | Description ||
|| image_id | **string**

ID of the Image resource to update.

To get the image ID, use a [ImageService.List](/docs/baremetal/api-ref/grpc/Image/list#List) request. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask that specifies which fields of the Image resource are going to be updated. ||
|| name | **string**

Name of the image.
The name must be unique within the folder. ||
|| description | **string**

Description of the image. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs.

Existing set of `labels` is completely replaced by the provided set. ||
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
    "image_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "folder_id": "string",
    "name": "string",
    "description": "string",
    "checksum": "string",
    "status": "Status",
    "created_at": "google.protobuf.Timestamp",
    "labels": "map<string, string>"
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
|| metadata | **[UpdateImageMetadata](#yandex.cloud.baremetal.v1alpha.UpdateImageMetadata)**

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
|| response | **[Image](#yandex.cloud.baremetal.v1alpha.Image)**

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

## UpdateImageMetadata {#yandex.cloud.baremetal.v1alpha.UpdateImageMetadata}

#|
||Field | Description ||
|| image_id | **string**

ID of the Image resource that is being updated. ||
|#

## Image {#yandex.cloud.baremetal.v1alpha.Image}

An Image resource.

#|
||Field | Description ||
|| id | **string**

ID of the image. ||
|| folder_id | **string**

ID of the folder that the image belongs to. ||
|| name | **string**

Name of the image.
The name is unique within the folder. ||
|| description | **string**

Description of the image. ||
|| checksum | **string**

MD5 checksum of the image. ||
|| status | enum **Status**

Status of the image.

- `STATUS_UNSPECIFIED`: Unspecified image status.
- `CREATING`: Image is being created.
- `READY`: Image is ready to use.
- `ERROR`: Image encountered an error.
- `DELETING`: Image is being deleted.
- `UPDATING`: Image is being updated. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|#