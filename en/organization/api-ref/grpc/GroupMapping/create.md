---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/api-ref/grpc/GroupMapping/create.md
---

# Cloud Organization API, gRPC: GroupMappingService.Create

Adds a group mapping for a federation
If mapping already exist, ALREADY_EXISTS will be returned

## gRPC request

**rpc Create ([CreateGroupMappingRequest](#yandex.cloud.organizationmanager.v1.CreateGroupMappingRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateGroupMappingRequest {#yandex.cloud.organizationmanager.v1.CreateGroupMappingRequest}

```json
{
  "federation_id": "string",
  "enabled": "bool"
}
```

#|
||Field | Description ||
|| federation_id | **string**

Required field. Federation the group mapping will be created for ||
|| enabled | **bool**

Synchronization status. ||
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
    "federation_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "federation_id": "string",
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
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| created_by | **string**

ID of the user or service account who initiated the operation. ||
|| modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

The time when the Operation resource was last modified. ||
|| done | **bool**

If the value is `false`, it means the operation is still in progress.
If `true`, the operation is completed, and either `error` or `response` is available. ||
|| metadata | **[CreateGroupMappingMetadata](#yandex.cloud.organizationmanager.v1.CreateGroupMappingMetadata)**

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

## CreateGroupMappingMetadata {#yandex.cloud.organizationmanager.v1.CreateGroupMappingMetadata}

#|
||Field | Description ||
|| federation_id | **string** ||
|#

## GroupMapping {#yandex.cloud.organizationmanager.v1.GroupMapping}

Group synchronization status for a specific federation
Absence of this object for a federation means that there is no group synchronization set of for the federation.

#|
||Field | Description ||
|| federation_id | **string**

Federation id ||
|| enabled | **bool**

Flag to show whether group synchronization should be enabled for this federation. ||
|#