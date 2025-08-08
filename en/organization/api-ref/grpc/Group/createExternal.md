---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/api-ref/grpc/Group/createExternal.md
---

# Identity Hub API, gRPC: GroupService.CreateExternal

Creates an external group.

## gRPC request

**rpc CreateExternal ([CreateExternalGroupRequest](#yandex.cloud.organizationmanager.v1.CreateExternalGroupRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateExternalGroupRequest {#yandex.cloud.organizationmanager.v1.CreateExternalGroupRequest}

```json
{
  "organization_id": "string",
  "name": "string",
  "description": "string",
  "subject_container_id": "string",
  "external_id": "string",
  "make_editor": "bool"
}
```

#|
||Field | Description ||
|| organization_id | **string**

Required field. ID of the organization to create a group in.
To get the organization ID, use a [yandex.cloud.organizationmanager.v1.OrganizationService.List](/docs/organization/api-ref/grpc/Organization/list#List) request. ||
|| name | **string**

Required field. Name of the group.
The name must be unique within the organization. ||
|| description | **string**

Description of the group. ||
|| subject_container_id | **string**

Required field. Id of the subject container that external group belongs to.
Combination of subject_container_id and external_id must be unique.
To get subject container, use a [yandex.cloud.organizationmanager.v1.saml.FederationService.List](/docs/organization/saml/api-ref/grpc/Federation/list#List) request
or [yandex.cloud.organizationmanager.v1.idp.UserpoolService.List](/docs/organization/idp/api-ref/grpc/Userpool/list#List) request. ||
|| external_id | **string**

Required field. Id of the group from external system.
Combination of subject_container_id and external_id must be unique ||
|| make_editor | **bool**

If true, then creator of group will be assigned to role that allows modification of group as external group. ||
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
    "group_id": "string",
    "organization_id": "string",
    "group_name": "string",
    "subject_container_id": "string",
    "external_id": "string",
    "make_editor": "bool"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "organization_id": "string",
    "created_at": "google.protobuf.Timestamp",
    "name": "string",
    "description": "string",
    "subject_container_id": "string",
    "external_id": "string"
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
|| metadata | **[CreateExternalGroupMetadata](#yandex.cloud.organizationmanager.v1.CreateExternalGroupMetadata)**

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

## CreateExternalGroupMetadata {#yandex.cloud.organizationmanager.v1.CreateExternalGroupMetadata}

#|
||Field | Description ||
|| group_id | **string**

ID of the group that is being created. ||
|| organization_id | **string**

ID of the organization that the group belongs to. ||
|| group_name | **string**

Name of the group. ||
|| subject_container_id | **string**

Id of the subject container that created external group belongs to. ||
|| external_id | **string**

Id of the created group from external system. ||
|| make_editor | **bool**

If true, then creator of group was assigned to role that allows modification of group as external group. ||
|#

## Group {#yandex.cloud.organizationmanager.v1.Group}

A Group resource.
For more information, see [Groups](/docs/organization/operations/manage-groups).

#|
||Field | Description ||
|| id | **string**

ID of the group. ||
|| organization_id | **string**

ID of the organization that the group belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| name | **string**

Name of the group. ||
|| description | **string**

Description of the group. ||
|| subject_container_id | **string**

Id of the subject container that external group belongs to. It is set if group is external. ||
|| external_id | **string**

Id of the group from external system. It is set if group is external. ||
|#