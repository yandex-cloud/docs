---
editable: false
sourcePath: en/_api-ref-grpc/datasphere/v2/api-ref/grpc/Community/create.md
---

# DataSphere API v2, gRPC: CommunityService.Create

Creates community in specified organization.

## gRPC request

**rpc Create ([CreateCommunityRequest](#yandex.cloud.datasphere.v2.CreateCommunityRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateCommunityRequest {#yandex.cloud.datasphere.v2.CreateCommunityRequest}

```json
{
  "name": "string",
  "description": "string",
  "organization_id": "string",
  "billing_account_id": "string",
  "labels": "string",
  "zone_id": "string"
}
```

#|
||Field | Description ||
|| name | **string**

Name of the community. ||
|| description | **string**

Description of the community. ||
|| organization_id | **string**

Required field. ID of the organization where community should be created. ||
|| billing_account_id | **string**

ID of the billing account for the created community. Optional, billing account could be bound to community later. ||
|| labels | **string**

Labels of the community. ||
|| zone_id | **string**

Required field. ID of the zone where community will be created (all projects and other resources will be in this zone) ||
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
    "community_id": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "created_at": "google.protobuf.Timestamp",
    "name": "string",
    "description": "string",
    "labels": "string",
    "created_by_id": "string",
    "organization_id": "string",
    "zone_id": "string"
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
|| metadata | **[CreateCommunityMetadata](#yandex.cloud.datasphere.v2.CreateCommunityMetadata)**

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
|| response | **[Community](#yandex.cloud.datasphere.v2.Community)**

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

## CreateCommunityMetadata {#yandex.cloud.datasphere.v2.CreateCommunityMetadata}

#|
||Field | Description ||
|| community_id | **string**

ID of the community that is being created. ||
|#

## Community {#yandex.cloud.datasphere.v2.Community}

#|
||Field | Description ||
|| id | **string**

ID of the community. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when community was created. ||
|| name | **string**

Name of the community. ||
|| description | **string**

Description of the comminuty. ||
|| labels | **string**

Labels of the community. ||
|| created_by_id | **string**

ID of the user who created the community. ||
|| organization_id | **string**

ID of the organization to which community belongs. ||
|| zone_id | **string**

ID of the zone where this community was created ||
|#