---
editable: false
sourcePath: en/_api-ref-grpc/datasphere/v2/api-ref/grpc/Project/open.md
---

# DataSphere API v2, gRPC: ProjectService.Open {#Open}

Opens the specified project.

## gRPC request

**rpc Open ([OpenProjectRequest](#yandex.cloud.datasphere.v2.OpenProjectRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## OpenProjectRequest {#yandex.cloud.datasphere.v2.OpenProjectRequest}

```json
{
  "projectId": "string"
}
```

#|
||Field | Description ||
|| projectId | **string**

Required field. ID of the Project resource to open.
To get the project ID use a [ProjectService.List](/docs/datasphere/api-ref/v2/grpc/Project/list#List) request. ||
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
    "projectId": "string",
    "status": "OpenProjectStatus"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "projectUrl": "string",
    "sessionToken": "string"
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
|| metadata | **[OpenProjectMetadata](#yandex.cloud.datasphere.v2.OpenProjectMetadata)**

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
|| response | **[OpenProjectResponse](#yandex.cloud.datasphere.v2.OpenProjectResponse)**

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

## OpenProjectMetadata {#yandex.cloud.datasphere.v2.OpenProjectMetadata}

#|
||Field | Description ||
|| projectId | **string**

ID of the project that is being opened. ||
|| status | enum **OpenProjectStatus**

Project opening status.

- `OPEN_PROJECT_STATUS_UNSPECIFIED`
- `OPEN_PROJECT_STATUS_CLOSING_IDE`: Closing previous IDE instance.
- `OPEN_PROJECT_STATUS_UNZIPPING_PROJECT`: Unzipping project.
- `OPEN_PROJECT_STATUS_ALLOCATING_VM`: Allocating VM for the project.
- `OPEN_PROJECT_STATUS_ALLOCATING_RESOURCES`: Allocating resources for the project.
- `OPEN_PROJECT_STATUS_STARTING_IDE`: Starting IDE.
- `OPEN_PROJECT_STATUS_UNKNOWN`: Unknown open project status. ||
|#

## OpenProjectResponse {#yandex.cloud.datasphere.v2.OpenProjectResponse}

#|
||Field | Description ||
|| projectUrl | **string**

URL of the project that is being opened.
Make GET request to `projectUrl` with sessionToken query parameter equals to `sessionToken`
or POST request to `projectUrl` with sessionToken body parameter equals to `sessionToken`
to fetch DataSphere web interface. ||
|| sessionToken | **string**

Session token of the project that is being opened. ||
|#