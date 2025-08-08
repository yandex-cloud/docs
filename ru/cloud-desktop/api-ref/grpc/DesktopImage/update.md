---
editable: false
sourcePath: en/_api-ref-grpc/clouddesktop/v1/api-ref/grpc/DesktopImage/update.md
---

# Cloud Desktop API, gRPC: DesktopImageService.Update

Updates desktop image properties.

## gRPC request

**rpc Update ([UpdateDesktopImageRequest](#yandex.cloud.clouddesktop.v1.api.UpdateDesktopImageRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateDesktopImageRequest {#yandex.cloud.clouddesktop.v1.api.UpdateDesktopImageRequest}

```json
{
  "image_id": "string",
  "update_mask": "google.protobuf.FieldMask",
  "name": "string",
  "labels": "map<string, string>"
}
```

#|
||Field | Description ||
|| image_id | **string**

Required field. Id of image to update. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Mask of fields that need to be update. ||
|| name | **string**

New desktop image name. ||
|| labels | **object** (map<**string**, **string**>)

New desktop image labels. ||
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
    "created_at": "google.protobuf.Timestamp",
    "status": "Status",
    "name": "string",
    "labels": "map<string, string>",
    "storage_size": "int64",
    "min_disk_size": "int64"
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
|| metadata | **[UpdateDesktopImageMetadata](#yandex.cloud.clouddesktop.v1.api.UpdateDesktopImageMetadata)**

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
|| response | **[DesktopImage](#yandex.cloud.clouddesktop.v1.api.DesktopImage)**

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

## UpdateDesktopImageMetadata {#yandex.cloud.clouddesktop.v1.api.UpdateDesktopImageMetadata}

#|
||Field | Description ||
|| image_id | **string**

Required field.  ||
|#

## DesktopImage {#yandex.cloud.clouddesktop.v1.api.DesktopImage}

A desktop image resource.

#|
||Field | Description ||
|| id | **string**

ID of the image. ||
|| folder_id | **string**

ID of the folder that the image belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. ||
|| status | enum **Status**

Status of the image.

- `STATUS_UNSPECIFIED`
- `CREATING`: Image is being created.
- `ACTIVE`: Image is ready to use.
- `DELETING`: Image is being deleted. ||
|| name | **string**

Name of the image. ||
|| labels | **object** (map<**string**, **string**>)

Description of the image. ||
|| storage_size | **int64**

Size of the image, specified in bytes. ||
|| min_disk_size | **int64**

Minimum disk size in bytes required to use the image. ||
|#