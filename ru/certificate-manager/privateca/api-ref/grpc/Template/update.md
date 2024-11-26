---
editable: false
sourcePath: en/_api-ref-grpc/certificatemanager/v1/privateca/api-ref/grpc/Template/update.md
---

# Certificate Manager Private CA API, gRPC: TemplateService.Update

Updates an existing certificate template.
You can modify one or more fields like name or data by specifying them in the update mask.

## gRPC request

**rpc Update ([UpdateTemplateRequest](#yandex.cloud.priv.certificatemanager.v1.privateca.UpdateTemplateRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateTemplateRequest {#yandex.cloud.priv.certificatemanager.v1.privateca.UpdateTemplateRequest}

```json
{
  "id": "string",
  "update_mask": "google.protobuf.FieldMask",
  "name": "string",
  "data": "string"
}
```

Request message to update an existing template's fields.

#|
||Field | Description ||
|| id | **string**

Required field. ID of the template to update. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask specifying which fields of the template will be updated. ||
|| name | **string**

Updated name for the template (if applicable). ||
|| data | **string**

Updated data for the certificate template (if applicable). ||
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
    "id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "folder_id": "string",
    "name": "string",
    "data": "string",
    "created_at": "google.protobuf.Timestamp",
    "updated_at": "google.protobuf.Timestamp"
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
|| metadata | **[UpdateTemplateMetadata](#yandex.cloud.priv.certificatemanager.v1.privateca.UpdateTemplateMetadata)**

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
|| response | **[Template](#yandex.cloud.priv.certificatemanager.v1.privateca.Template)**

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

## UpdateTemplateMetadata {#yandex.cloud.priv.certificatemanager.v1.privateca.UpdateTemplateMetadata}

Metadata returned in the response of the template update operation.

#|
||Field | Description ||
|| id | **string**

ID of the updated template. ||
|#

## Template {#yandex.cloud.priv.certificatemanager.v1.privateca.Template}

Json or yaml template for easier certificate issuing. If used while certificate creation, certificate would take all fields from template.

#|
||Field | Description ||
|| id | **string**

ID of the template. Generated at creation time. ||
|| folder_id | **string**

ID of the folder that the template belongs to. ||
|| name | **string**

Name of the template. ||
|| data | **string**

Json representation of template. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp when the template was created. ||
|| updated_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp when the template was last updated. ||
|#