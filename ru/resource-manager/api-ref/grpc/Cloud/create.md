---
editable: false
sourcePath: en/_api-ref-grpc/resourcemanager/v1/api-ref/grpc/Cloud/create.md
---

# Resource Manager API, gRPC: CloudService.Create {#Create}

Creates a cloud in the specified organization.

## gRPC request

**rpc Create ([CreateCloudRequest](#yandex.cloud.resourcemanager.v1.CreateCloudRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateCloudRequest {#yandex.cloud.resourcemanager.v1.CreateCloudRequest}

```json
{
  "organizationId": "string",
  "name": "string",
  "description": "string",
  "labels": "string"
}
```

#|
||Field | Description ||
|| organizationId | **string**

Required field. ID of the organization to create a cloud in.
To get the organization ID, use a [yandex.cloud.organizationmanager.v1.OrganizationService.List](/docs/organization/api-ref/grpc/Organization/list#List) request. ||
|| name | **string**

Required field. Name of the cloud. ||
|| description | **string**

Description of the cloud. ||
|| labels | **string**

Resource labels as `` key:value `` pairs. ||
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
    "cloudId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "createdAt": "google.protobuf.Timestamp",
    "name": "string",
    "description": "string",
    "organizationId": "string",
    "labels": "string"
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
|| metadata | **[CreateCloudMetadata](#yandex.cloud.resourcemanager.v1.CreateCloudMetadata)**

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
|| response | **[Cloud](#yandex.cloud.resourcemanager.v1.Cloud)**

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

## CreateCloudMetadata {#yandex.cloud.resourcemanager.v1.CreateCloudMetadata}

#|
||Field | Description ||
|| cloudId | **string**

ID of the cloud that is being created. ||
|#

## Cloud {#yandex.cloud.resourcemanager.v1.Cloud}

A Cloud resource. For more information, see [Cloud](/docs/resource-manager/concepts/resources-hierarchy#cloud).

#|
||Field | Description ||
|| id | **string**

ID of the cloud. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| name | **string**

Name of the cloud. 3-63 characters long. ||
|| description | **string**

Description of the cloud. 0-256 characters long. ||
|| organizationId | **string**

ID of the organization that the cloud belongs to. ||
|| labels | **string**

Resource labels as `` key:value `` pairs. Maximum of 64 per resource. ||
|#