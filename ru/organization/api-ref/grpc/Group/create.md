---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/api-ref/grpc/Group/create.md
---

# Cloud Organization API, gRPC: GroupService.Create {#Create}

Creates a group in the specified organization.

## gRPC request

**rpc Create ([CreateGroupRequest](#yandex.cloud.organizationmanager.v1.CreateGroupRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateGroupRequest {#yandex.cloud.organizationmanager.v1.CreateGroupRequest}

```json
{
  "organizationId": "string",
  "name": "string",
  "description": "string"
}
```

#|
||Field | Description ||
|| organizationId | **string**

Required field. ID of the organization to create a group in.
To get the organization ID, use a [yandex.cloud.organizationmanager.v1.OrganizationService.List](/docs/organization/api-ref/grpc/Organization/list#List) request. ||
|| name | **string**

Required field. Name of the group.
The name must be unique within the organization. ||
|| description | **string**

Description of the group. ||
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
    "groupId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "organizationId": "string",
    "createdAt": "google.protobuf.Timestamp",
    "name": "string",
    "description": "string"
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
|| metadata | **[CreateGroupMetadata](#yandex.cloud.organizationmanager.v1.CreateGroupMetadata)**

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
|| response | **[Group](#yandex.cloud.organizationmanager.v1.Group)**

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

## CreateGroupMetadata {#yandex.cloud.organizationmanager.v1.CreateGroupMetadata}

#|
||Field | Description ||
|| groupId | **string**

ID of the group that is being created. ||
|#

## Group {#yandex.cloud.organizationmanager.v1.Group}

A Group resource.
For more information, see [Groups](/docs/organization/operations/manage-groups).

#|
||Field | Description ||
|| id | **string**

ID of the group. ||
|| organizationId | **string**

ID of the organization that the group belongs to. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| name | **string**

Name of the group. ||
|| description | **string**

Description of the group. ||
|#