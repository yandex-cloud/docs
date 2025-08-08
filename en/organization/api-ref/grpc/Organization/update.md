---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/api-ref/grpc/Organization/update.md
---

# Identity Hub API, gRPC: OrganizationService.Update

Updates the specified organization.

## gRPC request

**rpc Update ([UpdateOrganizationRequest](#yandex.cloud.organizationmanager.v1.UpdateOrganizationRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateOrganizationRequest {#yandex.cloud.organizationmanager.v1.UpdateOrganizationRequest}

```json
{
  "organization_id": "string",
  "update_mask": "google.protobuf.FieldMask",
  "name": "string",
  "description": "string",
  "title": "string",
  "labels": "map<string, string>"
}
```

#|
||Field | Description ||
|| organization_id | **string**

Required field. ID of the organization to update.
To get the organization ID, use a [OrganizationService.List](/docs/organization/api-ref/grpc/Organization/list#List) request. ||
|| update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

Field mask that specifies which fields of the organization are going to be updated. ||
|| name | **string**

Name of the organization. ||
|| description | **string**

Description of the organization. ||
|| title | **string**

Display name of the organization. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `` key:value `` pairs. ||
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
    "organization_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "created_at": "google.protobuf.Timestamp",
    "name": "string",
    "description": "string",
    "title": "string",
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
|| metadata | **[UpdateOrganizationMetadata](#yandex.cloud.organizationmanager.v1.UpdateOrganizationMetadata)**

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
|| response | **[Organization](#yandex.cloud.organizationmanager.v1.Organization)**

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

## UpdateOrganizationMetadata {#yandex.cloud.organizationmanager.v1.UpdateOrganizationMetadata}

#|
||Field | Description ||
|| organization_id | **string**

ID of the organization that is being updated. ||
|#

## Organization {#yandex.cloud.organizationmanager.v1.Organization}

An Organization resource. For more information, see [Organization](/docs/organization/enable-org).

#|
||Field | Description ||
|| id | **string**

ID of the organization. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| name | **string**

Name of the organization. 3-63 characters long. ||
|| description | **string**

Description of the organization. 0-256 characters long. ||
|| title | **string**

Display name of the organization. 0-256 characters long. ||
|| labels | **object** (map<**string**, **string**>)

Resource labels as `` key:value `` pairs. Maximum of 64 per resource. ||
|#