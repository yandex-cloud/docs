---
editable: false
sourcePath: en/_api-ref-grpc/serverless/containers/v1/containers/api-ref/grpc/Container/create.md
---

# Serverless Containers Service, gRPC: ContainerService.Create {#Create}

Creates a container in the specified folder.

## gRPC request

**rpc Create ([CreateContainerRequest](#yandex.cloud.serverless.containers.v1.CreateContainerRequest)) returns ([operation.Operation](#yandex.cloud.operation.Operation))**

## CreateContainerRequest {#yandex.cloud.serverless.containers.v1.CreateContainerRequest}

```json
{
  "folderId": "string",
  "name": "string",
  "description": "string",
  "labels": "string"
}
```

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to create a container in.

To get a folder ID make a [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/Folder/list#List) request. ||
|| name | **string**

Name of the container.
The name must be unique within the folder. ||
|| description | **string**

Description of the container. ||
|| labels | **string**

Resource labels as `key:value` pairs. ||
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
    "containerId": "string"
  },
  // Includes only one of the fields `error`, `response`
  "error": "google.rpc.Status",
  "response": {
    "id": "string",
    "folderId": "string",
    "createdAt": "google.protobuf.Timestamp",
    "name": "string",
    "description": "string",
    "labels": "string",
    "url": "string",
    "status": "Status"
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
|| metadata | **[CreateContainerMetadata](#yandex.cloud.serverless.containers.v1.CreateContainerMetadata)**

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
|| response | **[Container](#yandex.cloud.serverless.containers.v1.Container)**

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

## CreateContainerMetadata {#yandex.cloud.serverless.containers.v1.CreateContainerMetadata}

#|
||Field | Description ||
|| containerId | **string**

ID of the container that is being created. ||
|#

## Container {#yandex.cloud.serverless.containers.v1.Container}

#|
||Field | Description ||
|| id | **string**

ID of the container. Generated at creation time. ||
|| folderId | **string**

ID of the folder that the container belongs to. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp for the container. ||
|| name | **string**

Name of the container. The name is unique within the folder. ||
|| description | **string**

Description of the container. ||
|| labels | **string**

Container labels as `key:value` pairs. ||
|| url | **string**

URL that needs to be requested to call the container. ||
|| status | enum **Status**

Status of the container.

- `STATUS_UNSPECIFIED`
- `CREATING`: Container is being created.
- `ACTIVE`: Container is ready for use.
- `DELETING`: Container is being deleted.
- `ERROR`: Container failed. The only allowed action is delete. ||
|#