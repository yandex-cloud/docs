---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/api-ref/grpc/GroupMapping/update.md
---

# Cloud Organization API, gRPC: GroupMappingService.Update {#Update}

Updates an existing group mapping for a federation
Errors:
- if federation is not found
In case of any error, no changes are applied to existing group mapping

This call is idempotent. The following actions do nothing:
- enabling when already enabled
- disabling when disabled
Such parts of request will be ignored. Others will be applied.

## gRPC request

**rpc Update ([UpdateGroupMappingRequest](#yandex.cloud.organizationmanager.v1.UpdateGroupMappingRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## UpdateGroupMappingRequest {#yandex.cloud.organizationmanager.v1.UpdateGroupMappingRequest}

```json
{
  "federationId": "string",
  "updateMask": "google.protobuf.FieldMask",
  "enabled": "bool"
}
```

Request for updating group mapping configuration

#|
||Field | Description ||
|| federationId | **string**

Required field. Federation the group mapping update is requested ||
|| updateMask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**

A set of fields that should be updated ||
|| enabled | **bool**

A new state of synchronization to update (if mentioned in update_mask). ||
|#

## operation.Operation {#yandex.cloud.operation.Operation}

```json
{
  "id": "string",
  "description": "string",
  "createdAt": "google.protobuf.Timestamp",
  "createdBy": "string",
  "modifiedAt": "google.protobuf.Timestamp",
  "done": "bool",
  "metadata": {
    "federationId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "federationId": "string",
    "enabled": "bool"
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
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| createdBy | **string**

ID of the user or service account who initiated the operation. ||
|| modifiedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[UpdateGroupMappingMetadata](#yandex.cloud.organizationmanager.v1.UpdateGroupMappingMetadata)**

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
|| response | **[GroupMapping](#yandex.cloud.organizationmanager.v1.GroupMapping)**

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

## UpdateGroupMappingMetadata {#yandex.cloud.organizationmanager.v1.UpdateGroupMappingMetadata}

#|
||Field | Description ||
|| federationId | **string** ||
|#

## GroupMapping {#yandex.cloud.organizationmanager.v1.GroupMapping}

Group synchronization status for a specific federation
Absence of this object for a federation means that there is no group synchronization set of for the federation.

#|
||Field | Description ||
|| federationId | **string**

Federation id ||
|| enabled | **bool**

Flag to show whether group synchronization should be enabled for this federation. ||
|#