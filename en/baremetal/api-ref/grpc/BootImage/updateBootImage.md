---
editable: false
---

# BareMetal API, gRPC: BootImageService.UpdateBootImage

Updates the specified boot image.


## gRPC request

**rpc UpdateBootImage ([UpdateBootImageRequest](#yandex.cloud.baremetal.v2.UpdateBootImageRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateBootImageRequest {#yandex.cloud.baremetal.v2.UpdateBootImageRequest}

```json
{
  "boot_image": {
    "boot_image_id": "string",
    "cloud_id": "string",
    "folder_id": "string",
    "name": "string",
    "description": "string",
    "uri": "string",
    "checksum": "string",
    "state": "State",
    "create_time": "google.protobuf.Timestamp",
    "update_time": "google.protobuf.Timestamp",
    "annotations": "map<string, string>"
  },
  "update_mask": "google.protobuf.FieldMask"
}
```

#|
||Field | Description ||
|| boot_image | **[BootImage](#yandex.cloud.baremetal.v2.BootImage)**

The boot image object to be updated. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask that specifies which fields of the Image resource are going to be updated. ||
|#

## BootImage {#yandex.cloud.baremetal.v2.BootImage}

An BootImage resource.

#|
||Field | Description ||
|| boot_image_id | **string**

ID of the image. ||
|| cloud_id | **string**

ID of the cloud that the image belongs to. ||
|| folder_id | **string**

ID of the folder that the image belongs to. ||
|| name | **string**

Name of the image.
The name is unique within the folder.

The string length in characters must be 2-63. Value must match the regular expression ` [a-z]([-a-z0-9]*[a-z0-9])? `. ||
|| description | **string**

Description of the image.

The maximum string length in characters is 1024. ||
|| uri | **string**

URI of the source image to create the new image from.
Currently only supports links to images that are stored in Object Storage.
Currently only supports ISO formats.

The maximum string length in characters is 1024. ||
|| checksum | **string**

MD5 checksum of the image. ||
|| state | enum **State**

State of the image.

- `CREATING`: Image is being created.
- `READY`: Image is ready to use.
- `ERROR`: Image encountered an error.
- `DELETING`: Image is being deleted.
- `UPDATING`: Image is being updated. ||
|| create_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| update_time | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Updafe timestamp. ||
|| annotations | **object** (map<**string**, **string**>)

Resource annotations as `key:value` pairs.

The maximum string length in characters for each value is 63. The string length in characters for each key must be 1-63. Each key must match the regular expression ` [a-z][-_0-9a-z]* `. Each value must match the regular expression ` [-_0-9a-z]* `. No more than 64 per resource. ||
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
  "response": "google.protobuf.Any"
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
|| response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**

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