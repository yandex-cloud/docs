---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/api-ref/grpc/User/deleteMembership.md
---

# Cloud Organization API, gRPC: UserService.DeleteMembership {#DeleteMembership}

Delete user membership.

## gRPC request

**rpc DeleteMembership ([DeleteMembershipRequest](#yandex.cloud.organizationmanager.v1.DeleteMembershipRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## DeleteMembershipRequest {#yandex.cloud.organizationmanager.v1.DeleteMembershipRequest}

```json
{
  "organizationId": "string",
  "subjectId": "string"
}
```

#|
||Field | Description ||
|| organizationId | **string**

Required field. ID of the organization to delete membership. ||
|| subjectId | **string**

ID of the subject that is being deleted from organization.
By default equals to authenticated subject. ||
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
    "organizationId": "string",
    "subjectId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "organizationId": "string",
    "subjectId": "string"
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
|| metadata | **[DeleteMembershipMetadata](#yandex.cloud.organizationmanager.v1.DeleteMembershipMetadata)**

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
|| response | **[DeleteMembershipResponse](#yandex.cloud.organizationmanager.v1.DeleteMembershipResponse)**

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

## DeleteMembershipMetadata {#yandex.cloud.organizationmanager.v1.DeleteMembershipMetadata}

#|
||Field | Description ||
|| organizationId | **string**

Required field. ID of the organization to delete membership. ||
|| subjectId | **string**

Required field. ID of the subject that is being deleted from organization. ||
|#

## DeleteMembershipResponse {#yandex.cloud.organizationmanager.v1.DeleteMembershipResponse}

#|
||Field | Description ||
|| organizationId | **string**

Required field. ID of the organization to delete membership. ||
|| subjectId | **string**

Required field. ID of the subject that is being deleted from organization. ||
|#