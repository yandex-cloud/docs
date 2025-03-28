---
editable: false
sourcePath: en/_api-ref-grpc/baremetal/v1alpha/api-ref/grpc/Vrf/update.md
---

# BareMetal API, gRPC: VrfService.Update

Updates the specified VRF resource.

## gRPC request

**rpc Update ([UpdateVrfRequest](#yandex.cloud.baremetal.v1alpha.UpdateVrfRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateVrfRequest {#yandex.cloud.baremetal.v1alpha.UpdateVrfRequest}

```json
{
  "vrf_id": "string",
  "update_mask": "google.protobuf.FieldMask",
  "name": "string",
  "description": "string",
  "labels": "map<string, string>"
}
```

#|
||Field | Description ||
|| vrf_id | **string**

ID of the VRF to update.

To get the VRF ID, use a [VrfService.List](/docs/baremetal/api-ref/grpc/Vrf/list#List) request. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask that specifies which attributes of the VRF should be updated. ||
|| name | **string**

Name of the VRF.
The name must be unique within the folder. ||
|| description | **string**

Description of the VRF. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs.

Existing set of labels is completely replaced by the provided set. ||
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
    "vrf_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "cloud_id": "string",
    "folder_id": "string",
    "name": "string",
    "description": "string",
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
|| metadata | **[UpdateVrfMetadata](#yandex.cloud.baremetal.v1alpha.UpdateVrfMetadata)**

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
|| response | **[Vrf](#yandex.cloud.baremetal.v1alpha.Vrf)**

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

## UpdateVrfMetadata {#yandex.cloud.baremetal.v1alpha.UpdateVrfMetadata}

#|
||Field | Description ||
|| vrf_id | **string**

ID of the VRF that is being updated. ||
|#

## Vrf {#yandex.cloud.baremetal.v1alpha.Vrf}

#|
||Field | Description ||
|| id | **string**

ID of the VRF. ||
|| cloud_id | **string**

ID of the cloud that the private subnet belongs to. ||
|| folder_id | **string**

ID of the folder that the private subnet belongs to. ||
|| name | **string**

Name of the VRF.
The name is unique within the folder. ||
|| description | **string**

Optional description of the VRF. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `key:value` pairs. ||
|#